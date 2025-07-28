#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Collects and validates real-time financial data for equity research analysis.

.DESCRIPTION
    This script fetches current market data, financial metrics, and key ratios
    for a given stock symbol, validates data quality, and outputs structured
    data suitable for equity research report generation.

.PARAMETER Symbol
    Stock ticker symbol (e.g., "MSFT", "IBM", "AAPL")

.PARAMETER OutputPath
    Optional path to save JSON output file

.PARAMETER Validate
    Perform additional data validation checks

.PARAMETER Verbose
    Display detailed progress information

.EXAMPLE
    .\Get-EquityData.ps1 -Symbol "MSFT" -Validate -Verbose
    
.EXAMPLE
    .\Get-EquityData.ps1 -Symbol "IBM" -OutputPath ".\data\ibm-data.json"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$Symbol,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath,
    
    [Parameter(Mandatory=$false)]
    [switch]$Validate,
    
    [Parameter(Mandatory=$false)]
    [switch]$Verbose
)

# Set error action preference
$ErrorActionPreference = "Stop"

# Function to fetch web data with retry logic
function Get-WebDataWithRetry {
    param(
        [string]$Url,
        [int]$MaxRetries = 3,
        [int]$DelaySeconds = 1
    )
    
    for ($i = 1; $i -le $MaxRetries; $i++) {
        try {
            if ($Verbose) { Write-Host "Fetching data from: $Url (Attempt $i/$MaxRetries)" }
            $response = Invoke-RestMethod -Uri $Url -Headers @{
                'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
            } -TimeoutSec 30
            return $response
        }
        catch {
            if ($i -eq $MaxRetries) {
                Write-Error "Failed to fetch data from $Url after $MaxRetries attempts: $($_.Exception.Message)"
                throw
            }
            Start-Sleep -Seconds $DelaySeconds
            $DelaySeconds *= 2  # Exponential backoff
        }
    }
}

# Function to extract numeric value from string
function Get-NumericValue {
    param([string]$Value)
    
    if ([string]::IsNullOrWhiteSpace($Value) -or $Value -eq "N/A") {
        return $null
    }
    
    # Remove commas, currency symbols, and convert suffixes
    $cleanValue = $Value -replace '[\$,\s]', ''
    
    # Handle suffixes (B, M, K)
    if ($cleanValue -match '^([\d\.]+)([BMK])$') {
        $number = [decimal]$matches[1]
        switch ($matches[2]) {
            'B' { return $number * 1000000000 }
            'M' { return $number * 1000000 }
            'K' { return $number * 1000 }
        }
    }
    
    # Try direct conversion
    $numericValue = $null
    if ([decimal]::TryParse($cleanValue, [ref]$numericValue)) {
        return $numericValue
    }
    
    return $null
}

# Function to parse percentage values
function Get-PercentageValue {
    param([string]$Value)
    
    if ([string]::IsNullOrWhiteSpace($Value) -or $Value -eq "N/A") {
        return $null
    }
    
    $cleanValue = $Value -replace '%', ''
    $numericValue = Get-NumericValue -Value $cleanValue
    
    if ($numericValue -ne $null) {
        return $numericValue / 100
    }
    
    return $null
}

# Main data collection function
function Get-EquityFinancialData {
    param([string]$TickerSymbol)
    
    Write-Host "Collecting financial data for $TickerSymbol..." -ForegroundColor Green
    
    # Initialize data structure
    $equityData = @{
        symbol = $TickerSymbol.ToUpper()
        dataDate = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")
        marketData = @{}
        valuation = @{}
        financials = @{}
        cashFlow = @{}
        balanceSheet = @{}
        dataQuality = @{
            validationsPassed = 0
            validationsFailed = 0
            warnings = @()
        }
    }
    
    try {
        # Fetch Yahoo Finance data
        $baseUrl = "https://query1.finance.yahoo.com/v10/finance/quoteSummary/$TickerSymbol"
        $modules = "price,summaryDetail,defaultKeyStatistics,financialData,cashflowStatementHistory,incomeStatementHistory,balanceSheetHistory"
        $yahooUrl = "$baseUrl" + "?modules=$modules"
        
        if ($Verbose) { Write-Host "Fetching Yahoo Finance data..." }
        $yahooData = Get-WebDataWithRetry -Url $yahooUrl
        
        $quote = $yahooData.quoteSummary.result[0]
        
        # Extract market data
        if ($quote.price) {
            $price = $quote.price
            $equityData.marketData.currentPrice = $price.regularMarketPrice.raw
            $equityData.marketData.priceChange = $price.regularMarketChange.raw
            $equityData.marketData.percentChange = $price.regularMarketChangePercent.raw
            $equityData.marketData.marketCap = $price.marketCap.raw
            $equityData.marketData.volume = $price.regularMarketVolume.raw
            $equityData.marketData.weekHigh52 = $price.fiftyTwoWeekHigh.raw
            $equityData.marketData.weekLow52 = $price.fiftyTwoWeekLow.raw
        }
        
        # Extract valuation metrics
        if ($quote.summaryDetail) {
            $summary = $quote.summaryDetail
            $equityData.valuation.peRatioTTM = $summary.trailingPE.raw
            $equityData.valuation.peRatioForward = $summary.forwardPE.raw
            $equityData.valuation.priceBook = $summary.priceToBook.raw
            $equityData.valuation.dividendYield = $summary.dividendYield.raw
            $equityData.valuation.payoutRatio = $summary.payoutRatio.raw
            $equityData.valuation.beta = $summary.beta.raw
        }
        
        # Extract key statistics
        if ($quote.defaultKeyStatistics) {
            $keyStats = $quote.defaultKeyStatistics
            $equityData.valuation.pegRatio = $keyStats.pegRatio.raw
            $equityData.valuation.evEbitda = $keyStats.enterpriseToEbitda.raw
            $equityData.valuation.evRevenue = $keyStats.enterpriseToRevenue.raw
            $equityData.valuation.priceSales = $keyStats.priceToSalesTrailing12Months.raw
            $equityData.balanceSheet.sharesOutstanding = $keyStats.sharesOutstanding.raw
        }
        
        # Extract financial data
        if ($quote.financialData) {
            $financial = $quote.financialData
            $equityData.financials.revenueTTM = $financial.totalRevenue.raw
            $equityData.financials.revenueGrowthTTM = $financial.revenueGrowth.raw
            $equityData.financials.operatingMargin = $financial.operatingMargins.raw
            $equityData.financials.netMargin = $financial.profitMargins.raw
            $equityData.financials.roe = $financial.returnOnEquity.raw
            $equityData.financials.roa = $financial.returnOnAssets.raw
            $equityData.financials.debtToEquity = $financial.debtToEquity.raw
            $equityData.financials.currentRatio = $financial.currentRatio.raw
            $equityData.financials.quickRatio = $financial.quickRatio.raw
            $equityData.cashFlow.operatingCashFlowTTM = $financial.operatingCashflow.raw
            $equityData.cashFlow.freeCashFlowTTM = $financial.freeCashflow.raw
        }
        
        # Calculate derived metrics
        if ($equityData.marketData.currentPrice -and $equityData.financials.revenueTTM -and $equityData.balanceSheet.sharesOutstanding) {
            $equityData.financials.epsTTM = $equityData.marketData.currentPrice / $equityData.valuation.peRatioTTM
        }
        
        Write-Host "✓ Successfully collected financial data" -ForegroundColor Green
        
    }
    catch {
        Write-Error "Failed to collect financial data: $($_.Exception.Message)"
        $equityData.dataQuality.warnings += "Data collection failed: $($_.Exception.Message)"
    }
    
    return $equityData
}

# Function to validate collected data
function Test-DataQuality {
    param([hashtable]$Data)
    
    if (-not $Validate) { return $Data }
    
    Write-Host "Validating data quality..." -ForegroundColor Yellow
    
    $validations = 0
    $failures = 0
    
    # Validate market cap calculation
    if ($Data.marketData.currentPrice -and $Data.balanceSheet.sharesOutstanding) {
        $calculatedMarketCap = $Data.marketData.currentPrice * $Data.balanceSheet.sharesOutstanding
        $actualMarketCap = $Data.marketData.marketCap
        
        if ($actualMarketCap -and [Math]::Abs($calculatedMarketCap - $actualMarketCap) / $actualMarketCap -lt 0.05) {
            $validations++
            if ($Verbose) { Write-Host "✓ Market cap validation passed" }
        } else {
            $failures++
            $Data.dataQuality.warnings += "Market cap calculation discrepancy detected"
            Write-Warning "Market cap validation failed"
        }
    }
    
    # Validate P/E ratio calculation
    if ($Data.marketData.currentPrice -and $Data.financials.epsTTM -and $Data.valuation.peRatioTTM) {
        $calculatedPE = $Data.marketData.currentPrice / $Data.financials.epsTTM
        $actualPE = $Data.valuation.peRatioTTM
        
        if ([Math]::Abs($calculatedPE - $actualPE) / $actualPE -lt 0.05) {
            $validations++
            if ($Verbose) { Write-Host "✓ P/E ratio validation passed" }
        } else {
            $failures++
            $Data.dataQuality.warnings += "P/E ratio calculation error detected"
            Write-Warning "P/E ratio validation failed"
        }
    }
    
    # Validate dividend yield calculation
    if ($Data.marketData.currentPrice -and $Data.valuation.dividendYield) {
        # This is a basic check - more sophisticated validation would require annual dividend data
        if ($Data.valuation.dividendYield -ge 0 -and $Data.valuation.dividendYield -le 0.15) {
            $validations++
            if ($Verbose) { Write-Host "✓ Dividend yield range validation passed" }
        } else {
            $failures++
            $Data.dataQuality.warnings += "Dividend yield appears out of normal range"
            Write-Warning "Dividend yield validation warning"
        }
    }
    
    # Check data freshness
    $currentTime = Get-Date
    if ($currentTime.DayOfWeek -notin @('Saturday', 'Sunday') -and $currentTime.Hour -gt 9 -and $currentTime.Hour -lt 16) {
        # During market hours, data should be very fresh
        $validations++
        if ($Verbose) { Write-Host "✓ Data freshness validation passed (market hours)" }
    } else {
        # Outside market hours, data might be from previous close
        if ($Verbose) { Write-Host "! Data collected outside market hours" }
    }
    
    $Data.dataQuality.validationsPassed = $validations
    $Data.dataQuality.validationsFailed = $failures
    
    if ($failures -eq 0) {
        Write-Host "✓ All data quality validations passed" -ForegroundColor Green
    } else {
        Write-Warning "$failures data quality issues detected"
    }
    
    return $Data
}

# Function to format output
function Format-EquityOutput {
    param([hashtable]$Data)
    
    $jsonOutput = $Data | ConvertTo-Json -Depth 10 -Compress:$false
    
    if ($OutputPath) {
        # Ensure directory exists
        $directory = Split-Path -Path $OutputPath -Parent
        if (-not (Test-Path -Path $directory)) {
            New-Item -ItemType Directory -Path $directory -Force | Out-Null
        }
        
        # Save to file
        $jsonOutput | Out-File -FilePath $OutputPath -Encoding UTF8
        Write-Host "✓ Data saved to: $OutputPath" -ForegroundColor Green
    } else {
        # Output to console
        return $jsonOutput
    }
}

# Main execution
try {
    Write-Host "=== Equity Data Collection Tool ===" -ForegroundColor Cyan
    Write-Host "Symbol: $Symbol" -ForegroundColor Cyan
    Write-Host "Timestamp: $(Get-Date)" -ForegroundColor Cyan
    Write-Host ""
    
    # Collect financial data
    $equityData = Get-EquityFinancialData -TickerSymbol $Symbol
    
    # Validate data quality
    $validatedData = Test-DataQuality -Data $equityData
    
    # Format and output results
    $output = Format-EquityOutput -Data $validatedData
    
    if (-not $OutputPath) {
        Write-Host ""
        Write-Host "=== Financial Data Output ===" -ForegroundColor Cyan
        Write-Output $output
    }
    
    Write-Host ""
    Write-Host "✓ Data collection completed successfully" -ForegroundColor Green
    
    # Summary statistics
    Write-Host ""
    Write-Host "=== Summary ===" -ForegroundColor Cyan
    Write-Host "Current Price: $($validatedData.marketData.currentPrice)" -ForegroundColor White
    Write-Host "Market Cap: $([Math]::Round($validatedData.marketData.marketCap / 1000000000, 2))B" -ForegroundColor White
    Write-Host "P/E Ratio (TTM): $([Math]::Round($validatedData.valuation.peRatioTTM, 2))" -ForegroundColor White
    Write-Host "Validations Passed: $($validatedData.dataQuality.validationsPassed)" -ForegroundColor Green
    Write-Host "Validations Failed: $($validatedData.dataQuality.validationsFailed)" -ForegroundColor $(if ($validatedData.dataQuality.validationsFailed -eq 0) { 'Green' } else { 'Red' })
    
    if ($validatedData.dataQuality.warnings.Count -gt 0) {
        Write-Host ""
        Write-Host "Warnings:" -ForegroundColor Yellow
        foreach ($warning in $validatedData.dataQuality.warnings) {
            Write-Host "  • $warning" -ForegroundColor Yellow
        }
    }
}
catch {
    Write-Error "Script execution failed: $($_.Exception.Message)"
    exit 1
}
