# Automated Financial Data Collection Tool

## Purpose
PowerShell script to collect and validate financial data for equity research reports, ensuring accuracy and consistency from the start.

## Usage
```powershell
.\Get-EquityData.ps1 -Symbol "MSFT" -OutputPath ".\data\msft-data.json"
```

## Parameters
- **Symbol**: Stock ticker symbol (required)
- **OutputPath**: Path to save collected data (optional, defaults to console output)
- **Validate**: Switch to perform additional validation checks
- **Format**: Output format (JSON, CSV, or Console)

## Data Collection Functions

### Primary Market Data
- Current stock price and change
- Market capitalization
- Trading volume and averages
- 52-week high/low range
- Beta coefficient

### Valuation Metrics
- P/E ratio (TTM and Forward)
- EV/EBITDA and EV/Revenue
- Price/Book and Price/Sales
- PEG ratio
- Dividend yield and payout ratio

### Financial Statement Data
- Revenue (quarterly and annual)
- Earnings per share (TTM)
- Operating and net margins
- Return on equity and assets
- Debt-to-equity ratio
- Current ratio and quick ratio

### Cash Flow Metrics
- Operating cash flow (TTM)
- Free cash flow (TTM)
- Capital expenditures
- Dividend payments
- Share buybacks

### Balance Sheet Items
- Total cash and equivalents
- Total debt (short-term and long-term)
- Total equity
- Book value per share
- Working capital

## Validation Rules

### Data Quality Checks
```powershell
# Market Cap Validation
$CalculatedMarketCap = $StockPrice * $SharesOutstanding
if ([Math]::Abs($MarketCap - $CalculatedMarketCap) / $MarketCap -gt 0.05) {
    Write-Warning "Market cap discrepancy detected"
}

# P/E Ratio Validation
$CalculatedPE = $StockPrice / $EPS_TTM
if ([Math]::Abs($PE_Ratio - $CalculatedPE) / $PE_Ratio -gt 0.05) {
    Write-Warning "P/E ratio calculation error"
}

# Dividend Yield Validation
$CalculatedYield = ($AnnualDividend / $StockPrice) * 100
if ([Math]::Abs($DividendYield - $CalculatedYield) / $DividendYield -gt 0.05) {
    Write-Warning "Dividend yield calculation error"
}
```

### Data Freshness Validation
```powershell
# Price Data Age Check
$PriceAge = (Get-Date) - $LastTradeTime
if ($PriceAge.TotalHours -gt 24 -and (Get-Date).DayOfWeek -notin @('Saturday','Sunday')) {
    Write-Warning "Stock price data may be stale"
}

# Financial Statement Age Check
$StatementAge = (Get-Date) - $LastFilingDate
if ($StatementAge.TotalDays -gt 120) {
    Write-Warning "Financial statement data is over 4 months old"
}
```

## Output Format

### JSON Structure
```json
{
    "symbol": "MSFT",
    "dataDate": "2025-07-28T14:30:00Z",
    "marketData": {
        "currentPrice": 512.20,
        "priceChange": -1.51,
        "percentChange": -0.29,
        "marketCap": 3800000000000,
        "volume": 25000000,
        "avgVolume": 28000000,
        "weekHigh52": 568.50,
        "weekLow52": 384.30,
        "beta": 0.85
    },
    "valuation": {
        "peRatioTTM": 39.6,
        "peRatioForward": 27.8,
        "evEbitda": 25.3,
        "evRevenue": 12.1,
        "priceBook": 8.9,
        "priceSales": 11.2,
        "pegRatio": 2.1,
        "dividendYield": 0.68,
        "payoutRatio": 27.0
    },
    "financials": {
        "revenueTTM": 270000000000,
        "revenueGrowthTTM": 0.16,
        "epsTTM": 12.93,
        "operatingMargin": 0.42,
        "netMargin": 0.36,
        "roe": 0.36,
        "roa": 0.18,
        "debtToEquity": 0.35,
        "currentRatio": 1.7,
        "quickRatio": 1.6
    },
    "cashFlow": {
        "operatingCashFlowTTM": 87600000000,
        "freeCashFlowTTM": 71300000000,
        "capexTTM": 16300000000,
        "dividendsTTM": 22700000000,
        "shareRepurchasesTTM": 8400000000
    },
    "balanceSheet": {
        "totalCash": 75500000000,
        "totalDebt": 97700000000,
        "totalEquity": 296500000000,
        "bookValuePerShare": 31.85,
        "workingCapital": 89200000000,
        "sharesOutstanding": 7420000000
    },
    "dataQuality": {
        "priceDataAge": "0 hours",
        "financialDataAge": "30 days",
        "validationsPassed": 15,
        "validationsFailed": 0,
        "dataCompleteness": 0.98
    }
}
```

### Report Template Integration
```markdown
## Executive Summary

{CompanyName} ({Symbol}) is trading at ${CurrentPrice:F2} with a market capitalization of ${MarketCap:C0}.
The stock has {PerformanceDescription} over the past year, with a trailing P/E ratio of {PE_TTM:F1}x.

### Key Financial Metrics
- **Revenue (TTM):** ${RevenueTTM:C0} ({RevenueGrowth:P1} YoY growth)
- **Earnings Per Share:** ${EPS_TTM:F2}
- **Free Cash Flow:** ${FreeCashFlowTTM:C0}
- **Debt-to-Equity:** {DebtToEquity:F1}x
- **Dividend Yield:** {DividendYield:P2}

*Data as of {DataDate:yyyy-MM-dd HH:mm} ET*
```

## Implementation Notes

### Data Sources Priority
1. **Yahoo Finance API** - Primary source for real-time market data
2. **Alpha Vantage** - Backup source for financial statements
3. **EDGAR SEC Database** - Official source for regulatory filings
4. **Company Investor Relations** - Latest earnings releases

### Error Handling
- Graceful degradation when data sources unavailable
- Clear marking of estimated vs. actual figures
- Automatic retry logic for temporary failures
- Comprehensive logging of data collection issues

### Performance Optimization
- Parallel data collection from multiple sources
- Caching of recent data to avoid redundant API calls
- Incremental updates for frequently accessed symbols
- Efficient JSON parsing and data transformation

## Usage Examples

### Basic Data Collection
```powershell
# Collect MSFT data
$MSFTData = .\Get-EquityData.ps1 -Symbol "MSFT"

# Validate data quality
if ($MSFTData.dataQuality.validationsFailed -eq 0) {
    Write-Host "Data validation passed - ready for analysis"
} else {
    Write-Warning "Data validation issues detected"
}
```

### Batch Processing
```powershell
# Collect data for multiple symbols
$Symbols = @("MSFT", "AAPL", "GOOGL", "AMZN")
$PortfolioData = @{}

foreach ($Symbol in $Symbols) {
    $PortfolioData[$Symbol] = .\Get-EquityData.ps1 -Symbol $Symbol -Validate
}
```

### Report Generation Integration
```powershell
# Collect data and generate report
$CompanyData = .\Get-EquityData.ps1 -Symbol "IBM" -Validate
$ReportTemplate = Get-Content ".\templates\equity-analysis-template.md"
$Report = $ReportTemplate -replace '{(\w+)}', { $CompanyData.$($_.Groups[1].Value) }
$Report | Out-File ".\reports\IBM-analysis.md"
```

This automated data collection tool ensures all financial figures are current, accurate, and validated before report generation begins, eliminating the need for extensive post-generation fact-checking.
