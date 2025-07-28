# Data Validation and Fact-Checking Instructions

## Purpose
Ensure all financial figures, market data, and quantitative metrics in equity research reports are accurate from initial creation, eliminating the need for extensive post-generation fact-checking.

## Mandatory Data Validation Protocol

### 1. Pre-Report Data Collection Phase
**BEFORE** writing any equity research report, ALWAYS:

1. **Fetch Current Market Data** - Use `fetch_webpage` tool to retrieve:
   - Yahoo Finance main quote page (`https://finance.yahoo.com/quote/{SYMBOL}/`)
   - Yahoo Finance key statistics (`https://finance.yahoo.com/quote/{SYMBOL}/key-statistics/`)
   - Yahoo Finance financials (`https://finance.yahoo.com/quote/{SYMBOL}/financials/`)

2. **Extract and Validate Core Metrics**:
   - Current stock price and change
   - Market capitalization
   - P/E ratio (TTM and Forward)
   - EV/EBITDA, EV/Revenue ratios
   - Revenue (TTM) and growth rates
   - Earnings per share (TTM)
   - Dividend yield and payout ratio
   - Debt-to-equity ratio
   - Current ratio and cash position
   - Free cash flow and operating cash flow
   - 52-week high/low range
   - Book value per share

3. **Cross-Reference Financial Statements**:
   - Verify revenue figures across multiple periods
   - Confirm balance sheet items (debt, cash, equity)
   - Validate cash flow metrics
   - Check profitability ratios and margins

### 2. Real-Time Data Integration Requirements

**Mandatory Data Sources** (in order of preference):
1. **Yahoo Finance** - Primary source for current market data
2. **SEC EDGAR** - For official financial statements
3. **Company IR pages** - For latest earnings releases
4. **Financial data APIs** - For specialized metrics

**Data Freshness Standards**:
- Stock prices: Must be current day or most recent trading day
- Financial statements: Must be from most recent quarterly/annual filing
- Market cap: Calculate using current share price × shares outstanding
- Ratios: Calculate using most recent financial data

### 3. Critical Metrics Validation Checklist

**Before Including ANY Numerical Data**:
- [ ] Stock price verified from live market data
- [ ] Market cap calculated using current price and verified shares outstanding
- [ ] P/E ratio calculated using current price and TTM earnings
- [ ] Revenue figures match latest quarterly/annual reports
- [ ] Debt figures reflect most recent balance sheet
- [ ] Cash flow data from most recent statement
- [ ] Dividend yield calculated using current price and annual dividend
- [ ] All percentage changes calculated correctly
- [ ] Currency units consistent throughout report

### 4. Estimation Guidelines

**When Official Data Not Available**:
- Clearly mark all estimates with "(Est.)" suffix
- Use conservative estimation methodology
- Provide estimation basis in footnotes
- Update estimates when actual data becomes available

**Acceptable Estimation Methods**:
- Linear extrapolation for near-term projections
- Industry averages for missing peer comparisons
- Historical ratio analysis for valuation estimates
- Analyst consensus for forward-looking metrics

### 5. Quality Assurance Process

**Pre-Publication Validation**:
1. **Cross-Check Key Figures**: Verify 5-10 most critical numbers against source
2. **Calculation Verification**: Ensure all derived metrics calculated correctly
3. **Period Consistency**: Confirm all data references same time periods
4. **Unit Consistency**: Verify billions/millions notation throughout
5. **Date Verification**: Ensure all data labeled with correct as-of dates

**Red Flag Indicators** (requiring immediate verification):
- P/E ratios below 5x or above 100x without explanation
- Market caps that seem dramatically off from expectations
- Negative cash flow for profitable companies
- Debt ratios exceeding 500% without context
- Dividend yields above 8% or below 0.1% for established companies

### 6. Data Source Documentation

**Required Documentation Format**:
```markdown
*Financial data sourced from Yahoo Finance as of [DATE]. 
Stock price: $XXX.XX as of [TIME] [TIMEZONE] on [DATE].
Financial statement data from [PERIOD] SEC filing dated [DATE].*
```

**Source Hierarchy**:
1. Current market data (Yahoo Finance, Bloomberg)
2. Latest SEC filings (10-K, 10-Q)
3. Company earnings releases
4. Analyst consensus estimates (when clearly marked)

### 7. Error Prevention Protocols

**Common Error Sources to Avoid**:
- Using outdated stock prices from previous sessions
- Mixing quarterly vs. annual revenue figures
- Incorrect market cap calculations
- Currency conversion errors
- Stale dividend yield calculations
- Outdated debt/equity ratios

**Automated Checks**:
- Verify market cap = share price × shares outstanding
- Confirm P/E = share price ÷ earnings per share
- Validate dividend yield = annual dividend ÷ share price
- Check debt ratios against balance sheet totals

### 8. Report Generation Workflow

**Mandatory Sequence**:
1. **Data Collection** → Fetch all financial data first
2. **Data Validation** → Verify accuracy and freshness
3. **Calculation Review** → Confirm all derived metrics
4. **Executive Summary** → Lead with key findings and investment advice
5. **Report Writing** → Use validated data throughout detailed analysis
6. **Final Check** → Spot-check 10 key figures before completion

**Executive Summary Requirements (MANDATORY First Section)**:
- **Investment Recommendation**: Clear BUY/HOLD/SELL rating with conviction level
- **Price Target**: 12-month target with expected return percentage
- **Key Investment Thesis**: 3-4 bullet points of main value drivers
- **Primary Risks**: 2-3 most significant risk factors
- **Financial Highlights**: Current valuation metrics and financial health
- **Market Context**: Recent performance and analyst sentiment summary

**Executive Summary Template**:
```markdown
## Executive Summary

**Investment Recommendation:** [BUY/HOLD/SELL] | **Price Target:** $XXX | **Expected Return:** XX%

### Key Investment Thesis
• [Primary value driver - growth, profitability, market position]
• [Secondary thesis point - competitive advantage, transformation]
• [Tertiary support - financial strength, management execution]

### Primary Risk Factors
• [Highest impact risk - competitive, regulatory, economic]
• [Secondary risk - operational, financial, market-specific]

### Financial Overview
- **Current Price:** $XXX.XX (±X.X% today)
- **Market Cap:** $XXX.XB | **P/E Ratio:** XX.Xx
- **Revenue Growth:** XX% (TTM) | **Margins:** XX% operating
- **Financial Health:** [Strong/Adequate/Concerning] - [brief rationale]

### Bottom Line
[2-3 sentence summary of why investors should BUY/HOLD/SELL, with key catalyst or timeline]
```

**Never Begin Report Writing Without**:
- Current stock price and market cap
- Latest financial statement data
- Verified key ratios and metrics
- Clear data sourcing documentation

### 9. Post-Generation Monitoring

**Immediate Post-Generation**:
- Scan report for obvious numerical inconsistencies
- Verify market performance claims against current data
- Check that price targets align with current trading levels
- Ensure dividend yields reflect current market prices

**Periodic Updates Required**:
- Update reports if significant market moves occur (>5% price change)
- Refresh data if earnings released after report generation
- Revise estimates if major corporate events occur

### 10. Emergency Correction Protocol

**If Errors Discovered Post-Generation**:
1. **Immediate Assessment**: Determine scope and impact of errors
2. **Priority Correction**: Fix most material errors first (price, market cap, valuation)
3. **Systematic Review**: Check related metrics that might be affected
4. **Documentation**: Log what went wrong and how to prevent recurrence
5. **Process Improvement**: Update this instruction file with lessons learned

## Implementation Standards

- **Zero Tolerance** for outdated stock prices in new reports
- **Mandatory Verification** of top 10 financial metrics before report completion
- **Real-Time Data** requirement for all market-sensitive figures
- **Clear Attribution** for all data sources and calculation methods
- **Conservative Approach** when data certainty is questionable

This protocol ensures institutional-grade accuracy in all equity research deliverables while eliminating the need for extensive post-generation fact-checking procedures.
