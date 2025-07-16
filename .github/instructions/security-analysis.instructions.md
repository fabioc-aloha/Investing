---
applyTo: "**/*equity*,**/*bond*,**/*security*,**/research/security-analysis/**"
description: "Security analysis methodology and valuation standards"
---

# Security Analysis Procedural Memory

## Document Presentation Standards

### Company Logo Integration (Required for All Equity Analysis)
- **Centered Header Layout**: Center both the document title and logo for professional alignment
- **Single Logo Placement**: Include company logo ONLY at the top of the document header, below the centered title
- **No Duplicate Logos**: Do not repeat the logo in separate "Company Logo" sections within the document body
- **High-Resolution Source**: Always fetch logos in maximum available resolution for crisp display
- **HTML Format Requirements**: Use HTML for both title and logo to ensure proper centering
  ```html
  <div align="center">
  <h1>Company Name (TICKER) - Investment Research</h1>
  <img src="logo_url" alt="Company Name Logo" width="200" height="auto" style="max-width: 200px; height: auto;"/>
  </div>
  ```
- **Size Standards**: 
  - **Source Resolution**: Fetch highest resolution available from logo provider
  - **Display Width**: Scale down to 200px for optimal document readability
  - **Height**: Auto-scale to maintain aspect ratio and prevent distortion
  - **Alignment**: Center-aligned title and logo for professional presentation
  - **CSS Control**: Use inline styles for precise size control regardless of source resolution
- **Source Standards**: Use Finnhub API for reliable, high-resolution company logos:
  - Primary Source: `https://finnhub.io/api/logo?symbol=TICKER` (fetches highest available resolution)
  - Quality: High-resolution PNG/SVG format optimized for financial documents
  - Fallback: Company's official website investor relations page
  - Alternative: SEC filings (10-K, 10-Q) with embedded logos
- **Resolution Priority**: Always prioritize image quality over file size for professional presentation
- **Consistency**: Maintain logo aspect ratio and professional appearance across all analyses
- **Legal Compliance**: Logo usage under fair use for financial analysis purposes
- **Professional Presentation**: Logo should enhance document credibility and visual appeal without dominating content

## Research Structure and Methodology

### Phase 1: Company Background and Context (25% of analysis time)
- **Business Overview**: Comprehensive description of business model, revenue streams, and value proposition
- **Product Portfolio**: Detailed analysis of products/services, market positioning, and competitive advantages
- **Industry Analysis**: Market size, growth trends, regulatory environment, and industry dynamics
- **Competitive Landscape**: Major competitors, market share analysis, competitive positioning, and differentiation factors
- **Corporate Strategy**: Management's strategic vision, capital allocation priorities, and execution track record
- **Geographic Presence**: Revenue breakdown by region, international exposure, and local market dynamics
- **Historical Context**: Company evolution, major milestones, acquisitions, and strategic pivots

### Phase 2: Current Developments and News Analysis (15% of analysis time)
- **Latest Earnings**: Most recent quarterly results with detailed analysis of key metrics and guidance
- **Recent News Flow**: Significant developments in past 3-6 months affecting investment thesis
- **Management Commentary**: Recent conference calls, investor presentations, and strategic announcements
- **Regulatory Developments**: Industry regulations, compliance issues, or policy changes affecting the company
- **Market Events**: Major market developments, supply chain issues, or macroeconomic factors impacting operations
- **Analyst Coverage**: Recent analyst upgrades/downgrades and consensus estimate changes
- **Source Documentation**: All news items must include specific dates and credible sources (SEC filings, company press releases, reputable financial media)

### Phase 3: Fundamental Analysis (60% of analysis time)
#### Financial Statement Analysis
- **Revenue Analysis**: Growth trends, seasonality, segment performance, and revenue quality assessment
- **Profitability Metrics**: Gross margins, operating margins, net margins, and margin trend analysis
- **Balance Sheet Strength**: Asset quality, debt levels, working capital management, and capital structure
- **Cash Flow Analysis**: Operating cash flow, free cash flow, capital expenditure trends, and cash conversion
- **Financial Ratios**: ROE, ROA, ROIC, debt ratios, liquidity ratios, and efficiency metrics
- **Data Sources**: Specify exact dates and sources for all financial data (10-K, 10-Q, 8-K filings, company websites, Bloomberg, FactSet)

#### Altman Z-Score Financial Distress Analysis
**Mandatory Component for All Equity Analysis - Model Selection Based on Company Characteristics**

##### Model Selection Criteria (Critical - Must Determine First)
- **Original Z-Score (1968)**: Public manufacturing companies, assets >$1M
- **Z'-Score (Private Companies)**: Private manufacturing companies
- **Z"-Score (Non-Manufacturing)**: Public service/non-manufacturing companies
- **Emerging Markets Z-Score**: Companies in developing economies
- **Industry Considerations**: Financial companies NOT recommended (use alternative models)

##### Original Z-Score Model (Public Manufacturing Companies)
**Formula**: Z = 1.2A + 1.4B + 3.3C + 0.6D + 1.0E
- **A** = Working Capital / Total Assets
- **B** = Retained Earnings / Total Assets  
- **C** = EBIT / Total Assets
- **D** = Market Value of Equity / Total Liabilities
- **E** = Sales / Total Assets
**Interpretation Zones**:
- Z > 2.99: Safe zone (low bankruptcy risk)
- 1.8 < Z < 2.99: Gray zone (moderate risk) 
- Z < 1.8: Distress zone (high bankruptcy risk)

##### Z'-Score Model (Private Companies)
**Formula**: Z' = 0.717A + 0.847B + 3.107C + 0.420D + 0.998E
- **A** = Working Capital / Total Assets
- **B** = Retained Earnings / Total Assets
- **C** = EBIT / Total Assets
- **D** = Book Value of Equity / Total Liabilities (Note: Book value, not market value)
- **E** = Sales / Total Assets
**Interpretation Zones**:
- Z' > 2.9: Safe zone
- 1.23 < Z' < 2.9: Gray zone
- Z' < 1.23: Distress zone

##### Z"-Score Model (Non-Manufacturing/Service Companies)
**Formula**: Z" = 6.56X1 + 3.26X2 + 6.72X3 + 1.05X4
- **X1** = Working Capital / Total Assets
- **X2** = Retained Earnings / Total Assets
- **X3** = EBIT / Total Assets
- **X4** = Book Value of Equity / Total Liabilities
**Interpretation Zones**:
- Z" > 2.6: Safe zone
- 1.1 < Z" < 2.6: Gray zone
- Z" < 1.1: Distress zone

##### Emerging Markets Z-Score Model
**Formula**: Z-EM = 3.25 + 6.56X1 + 3.26X2 + 6.72X3 + 1.05X4
- **X1** = Working Capital / Total Assets
- **X2** = Retained Earnings / Total Assets
- **X3** = EBIT / Total Assets
- **X4** = Book Value of Equity / Total Liabilities
**Interpretation Zones**: Same as Z"-Score model

##### Implementation Requirements
- **Model Justification**: Document why specific Z-Score model was selected based on company characteristics
- **Data Sources**: Specify exact financial statement dates and sources for all components
- **Alternative Models**: For financial companies, use Ohlson O-Score, Beneish M-Score, or industry-specific models
- **Sensitivity Analysis**: Test impact of key assumption changes on Z-Score results
- **Trend Analysis**: Calculate Z-Score for 3-5 year historical period to assess trajectory
- **Peer Comparison**: Compare Z-Score to industry benchmarks and direct competitors
- **Balance Sheet Assumptions**: Document all assumptions used for missing data with clear rationale
- **Risk Integration**: Integrate Z-Score results into overall investment recommendation and risk rating

##### Special Considerations
- **Industry Limitations**: Z-Score less reliable for utilities, REITs, and capital-intensive industries
- **Economic Cycles**: Z-Score accuracy varies across business cycles and economic conditions
- **Company Life Stage**: Model effectiveness differs for mature vs. growth-stage companies
- **Recent Updates**: As of 2019, Professor Altman noted Z-Score closer to 0 (not 1.8) indicates heightened distress risk
- **Complementary Analysis**: Always use Z-Score alongside other financial distress models for comprehensive assessment

#### Piotroski F-Score Analysis
**Mandatory Component for All Equity Analysis - Fundamental Quality Assessment**

The Piotroski F-Score complements the Altman Z-Score by evaluating fundamental business quality and financial strength through 9 binary criteria. Developed by Joseph Piotroski (2000), this score identifies financially strong companies with improving fundamentals.

**Important Note**: Unlike Altman Z-Score, the Piotroski F-Score uses a **single standardized formula** across all company types (public/private, manufacturing/service, developed/emerging markets). However, **interpretation benchmarks** vary by industry.

##### Piotroski F-Score Components (9 Criteria - 1 point each)

**Profitability Signals (4 criteria)**:
1. **Positive Net Income**: 1 point if current year net income > 0
2. **Positive Operating Cash Flow**: 1 point if current year operating cash flow > 0
3. **Increasing ROA**: 1 point if current year ROA > prior year ROA
4. **Quality Earnings**: 1 point if operating cash flow > net income (earnings quality)

**Leverage, Liquidity & Source of Funds (3 criteria)**:
5. **Decreasing Leverage**: 1 point if current year debt/assets < prior year debt/assets
6. **Increasing Liquidity**: 1 point if current year current ratio > prior year current ratio
7. **No Share Dilution**: 1 point if shares outstanding current year ≤ prior year

**Operating Efficiency (2 criteria)**:
8. **Increasing Gross Margin**: 1 point if current year gross margin > prior year gross margin
9. **Increasing Asset Turnover**: 1 point if current year asset turnover > prior year asset turnover

##### F-Score Calculation and Interpretation
**Total Score Range**: 0-9 points
**General Interpretation**:
- **F-Score 8-9**: Excellent fundamental quality (strong buy candidates)
- **F-Score 6-7**: Good fundamental quality (moderate buy candidates)
- **F-Score 4-5**: Average fundamental quality (hold/neutral)
- **F-Score 2-3**: Weak fundamental quality (caution/avoid)
- **F-Score 0-1**: Poor fundamental quality (strong avoid/short candidates)

##### Industry-Specific Benchmark Considerations
**Manufacturing Companies**: Typically score higher on efficiency metrics (asset turnover, margins)
**Service Companies**: May show different patterns in asset turnover due to lower asset intensity
**Financial Companies**: Limited applicability due to unique business model and regulatory requirements
**Technology Companies**: Growth-stage companies may score lower on profitability metrics initially
**Utilities/REITs**: Asset turnover expectations should be adjusted for industry characteristics

##### Implementation Requirements
- **Universal Formula**: Use same 9-criteria calculation regardless of company characteristics
- **Two-Year Comparison**: Requires current year and prior year financial data
- **Data Sources**: Use audited financial statements (10-K) for accuracy
- **Calculation Transparency**: Document each of the 9 criteria with specific values
- **Trend Analysis**: Calculate F-Score for 3-5 year period to assess trajectory
- **Industry Benchmarking**: Compare F-Score to industry peers for context
- **Share Count Adjustments**: Account for stock splits and spinoffs in dilution analysis

##### Integration with Z-Score Analysis
**Combined Scoring Matrix**:
- **High Z-Score (>2.99) + High F-Score (8-9)**: Optimal investment candidates
- **High Z-Score (>2.99) + Low F-Score (0-3)**: Financial stability but weak fundamentals
- **Low Z-Score (<1.8) + High F-Score (8-9)**: Turnaround candidates with strong fundamentals
- **Low Z-Score (<1.8) + Low F-Score (0-3)**: High-risk investments to avoid

##### Special Considerations
- **Universal Application**: Same formula works across all company types (key difference from Z-Score)
- **Growth vs. Value**: F-Score particularly effective for value investing strategies
- **Industry Context**: Interpret scores relative to industry averages rather than absolute thresholds
- **Economic Cycles**: F-Score effectiveness may vary across different market conditions
- **Company Life Stage**: More relevant for mature companies with established operations
- **Cyclical Limitations**: Year-over-year comparisons may be misleading during economic cycles

**Risk Assessment Integration**: Use both Z-Score (financial distress) and F-Score (fundamental quality) to create comprehensive financial health assessment supporting investment recommendations.

## Fundamental Equity Analysis
- Conduct comprehensive financial statement analysis including quality of earnings assessment
- Analyze business model, competitive positioning, and management quality
- Use multiple valuation methods including DCF, P/E, EV/EBITDA, and PEG ratios
- Assess company-specific risks including operational, financial, and strategic risks
- Monitor key performance indicators and business trends continuously

## Credit Analysis and Fixed Income
- Analyze credit quality using financial ratios and qualitative factors
- Assess default probability and recovery rates for credit securities
- Consider duration, convexity, and yield curve positioning in bond analysis
- Evaluate municipal bond credit quality and tax considerations
- Monitor credit spread movements and relative value opportunities

## Technical Analysis Integration
- Use chart patterns and technical indicators to supplement fundamental analysis
- Identify support and resistance levels for entry and exit timing
- Monitor volume patterns and momentum indicators
- Consider technical factors in position sizing and risk management
- Validate technical signals with fundamental analysis

## Quantitative Screening and Factor Analysis
- Use quantitative screens to identify investment opportunities
- Implement factor-based approaches including value, growth, quality, and momentum factors
- Analyze factor loadings and exposures in security selection
- Consider factor timing and rotation strategies
- Validate quantitative signals with fundamental research

## ESG and Sustainability Analysis
- Integrate environmental, social, and governance factors into security analysis
- Assess ESG risks and opportunities in investment decisions
- Use ESG ratings and scores appropriately with independent analysis
- Consider long-term sustainability and stakeholder capitalism trends
- Monitor ESG controversies and their potential impact on security values

## Valuation Methodology Standards

### Multiple Valuation Approaches (Required)
- **Discounted Cash Flow (DCF)**: 
  - 5-10 year explicit forecast period with terminal value calculation
  - Document WACC assumptions (risk-free rate, equity risk premium, beta, cost of debt)
  - Sensitivity analysis for key assumptions (growth rates, margins, terminal multiple)
  - Source: Company guidance, analyst estimates, economic forecasts with dates
- **Relative Valuation**:
  - P/E, EV/EBITDA, P/B, P/S multiples vs peers and historical ranges
  - Justify multiple selection based on business characteristics
  - Use forward-looking estimates where appropriate
- **Asset-Based Valuation**: For asset-heavy businesses or liquidation scenarios
- **Sum-of-the-Parts**: For diversified companies with multiple business segments

### Price Target and Rating Standards
- **Price Target**: 12-month forward-looking target with clear methodology
- **Rating Scale**: BUY (>15% upside), HOLD (-15% to +15%), SELL (<-15% downside)
- **Conviction Level**: High/Medium/Low based on analysis certainty and risk factors
- **Position Sizing Guidance**: Recommended portfolio allocation based on risk-adjusted returns

## Documentation and Source Standards

### Data Sources and Attribution
- **Primary Sources**: SEC filings (10-K, 10-Q, 8-K, proxy statements) with exact filing dates
- **Company Sources**: Earnings releases, investor presentations, conference calls with dates
- **Market Data**: Bloomberg, FactSet, Yahoo Finance, or similar with data pull timestamps
- **Industry Data**: Trade associations, government statistics, consulting reports with publication dates
- **News Sources**: Financial media (WSJ, FT, Reuters, Bloomberg News) with article dates and links
- **Analyst Research**: Third-party research reports with firm name, analyst, and publication date

### Quality Control Requirements
- **Fact Verification**: Cross-reference key data points across multiple sources
- **Assumption Documentation**: Clearly state and justify all modeling assumptions
- **Sensitivity Analysis**: Test key variables and document impact on valuation
- **Error Checking**: Verify mathematical calculations and formula accuracy
- **Peer Review**: Internal review process for significant recommendations

## Report Structure Template

### Executive Summary (10% of report)

#### Risk Assessment Matrix Table
**Mandatory Risk Consolidation Table - Place at Top of Executive Summary**

Create a comprehensive table consolidating all risk assessment criteria with clear formatting:

```markdown
## Investment Risk Assessment Matrix

| **Risk Criteria** | **Score/Rating** | **Signal** | **Weight** | **Recommendation** | **Comments** |
|-------------------|------------------|------------|------------|-------------------|--------------|
| **Financial Distress Risk** |  |  |  |  |  |
| Altman Z-Score | [Score] | Safe/Gray/Distress | High | BUY/HOLD/SELL | [Model: Original/Z'/Z"] |
| **Fundamental Quality** |  |  |  |  |  |
| Piotroski F-Score | [0-9] | Strong/Weak | High | BUY/HOLD/SELL | [Industry context] |
| **Valuation Risk** |  |  |  |  |  |
| DCF Fair Value | $[Price] | Under/Over/Fair | High | BUY/HOLD/SELL | vs current $[Price] |
| P/E vs Historical | [Multiple] | Attractive/Expensive | Medium | BUY/HOLD/SELL | vs [X]-yr avg |
| EV/EBITDA vs Peers | [Multiple] | Discount/Premium | Medium | BUY/HOLD/SELL | vs industry avg |
| **Profitability Trends** |  |  |  |  |  |
| Revenue Growth (3yr) | [%] | Accelerating/Stable/Declining | Medium | BUY/HOLD/SELL | [Brief trend note] |
| Margin Trends | [Direction] | Expanding/Stable/Contracting | Medium | BUY/HOLD/SELL | [Key driver] |
| **Balance Sheet Strength** |  |  |  |  |  |
| Debt/Equity Ratio | [Ratio] | Conservative/Moderate/High | High | BUY/HOLD/SELL | [Brief assessment] |
| Current Ratio | [Ratio] | Strong/Adequate/Weak | Medium | BUY/HOLD/SELL | [Liquidity note] |
| **Cash Flow Quality** |  |  |  |  |  |
| FCF Growth (3yr) | [%] | Positive/Flat/Negative | High | BUY/HOLD/SELL | [Sustainability note] |
| OCF vs Net Income | [Ratio] | Quality/Mixed/Poor | Medium | BUY/HOLD/SELL | [Quality assessment] |
| **Market & Competitive Risk** |  |  |  |  |  |
| Market Share Trend | [Direction] | Gaining/Stable/Losing | Medium | BUY/HOLD/SELL | [Competitive note] |
| Competitive Position | [Assessment] | Strong/Moderate/Weak | High | BUY/HOLD/SELL | [Moat strength] |
| **Management & Governance** |  |  |  |  |  |
| Capital Allocation | [Assessment] | Excellent/Good/Poor | Medium | BUY/HOLD/SELL | [Track record] |
| ESG Rating | [Score] | Leader/Average/Laggard | Low | BUY/HOLD/SELL | [Material factors] |
| **Macroeconomic Sensitivity** |  |  |  |  |  |
| Economic Cycle Risk | [Level] | Low/Medium/High | Medium | BUY/HOLD/SELL | [Cyclical exposure] |
| Interest Rate Risk | [Level] | Low/Medium/High | Medium | BUY/HOLD/SELL | [Rate sensitivity] |

### **Overall Assessment Summary**
| **Metric** | **Value** |
|------------|-----------|
| **Total BUY Signals** | [Count] |
| **Total HOLD Signals** | [Count] |
| **Total SELL Signals** | [Count] |
| **Weighted Recommendation** | **BUY/HOLD/SELL** |
| **Confidence Level** | **High/Medium/Low** |
| **Position Size Guidance** | **[%] of portfolio** |
```

#### Implementation Guidelines for Risk Matrix:
- **Scoring Consistency**: Use standardized scales across all criteria
- **Weight Allocation**: High weight = 3 points, Medium = 2 points, Low = 1 point
- **Comment Length Limits**: Keep comments under 20 characters to prevent table rendering issues
- **Concise Language**: Use brief, clear phrases without hyphens or long compound words
- **Table Formatting**: Ensure proper Markdown table structure with consistent column alignment
- **Signal Aggregation**: Calculate weighted average of BUY(+1)/HOLD(0)/SELL(-1) signals
- **Color Coding**: Use green/yellow/red for visual clarity in actual reports
- **Update Frequency**: Refresh matrix quarterly or upon material changes

- Investment recommendation (BUY/HOLD/SELL) with price target
- Key investment thesis in 3-4 bullet points
- Primary risks and mitigating factors
- Recommended portfolio allocation

### Company Background Section (25% of report)
1. **Company Logo** (HTML embedded, 200px width, center-aligned)
2. **Business Overview** (5-7 paragraphs)
3. **Products and Services** (detailed breakdown)
4. **Industry and Market Analysis** (3-5 paragraphs)
5. **Competitive Landscape** (competitor analysis table + narrative)
6. **Corporate Strategy and Management** (2-3 paragraphs)
7. **Geographic and Segment Breakdown** (charts + analysis)

### Recent Developments Section (15% of report)
1. **Latest Quarterly Results** (detailed earnings analysis)
2. **Significant News and Events** (past 3-6 months with dates/sources)
3. **Management Guidance and Commentary** (recent calls/presentations)
4. **Industry and Regulatory Updates** (affecting company)
5. **Consensus Estimate Changes** (analyst revisions tracking)

### Financial Analysis Section (40% of report)
1. **Financial Metrics Overview** (5-year historical + projections)
2. **Revenue Analysis** (growth drivers, seasonality, segment performance)
3. **Profitability Analysis** (margin trends, cost structure)
4. **Balance Sheet Analysis** (debt, working capital, asset quality)
5. **Cash Flow Analysis** (operating, free cash flow, capital allocation)
6. **Altman Z-Score Analysis** (mandatory financial distress assessment)
7. **Financial Ratios** (profitability, efficiency, leverage, liquidity)
8. **Piotroski F-Score Analysis** (mandatory fundamental quality assessment)

### Valuation Section (20% of report)
1. **DCF Model** (assumptions, calculations, sensitivity analysis)
2. **Relative Valuation** (peer comparison, historical multiples)
3. **Alternative Methods** (asset-based, sum-of-parts if applicable)
4. **Price Target Derivation** (methodology and weighting)

### Risk Assessment and ESG (15% of report)
1. **Investment Risks** (company-specific, industry, macro)
2. **Risk Mitigation Factors**
3. **ESG Analysis** (material factors affecting valuation)
4. **Scenario Analysis** (bull/base/bear cases)

### Investment Conclusion (5% of report)
1. **Recommendation Summary**
2. **Key Catalysts and Timeline**
3. **Position Sizing and Risk Management**
4. **Monitoring Metrics and Review Schedule**

## Table Formatting Standards (CRITICAL for Markdown Rendering)

### Risk Assessment Matrix Formatting Requirements
- **Comment Length Limit**: All comment fields MUST be under 20 characters to prevent Markdown table rendering breaks
- **No Hyphens in Comments**: Avoid compound words like "revenue-growth" → use "revenue growth" or "growth" 
- **Concise Language**: Use abbreviations and shortened phrases:
  - "Strong fundamentals" → "Strong fund"
  - "High debt burden" → "High debt"
  - "Market leadership" → "Market lead"
  - "Competitive advantage" → "Comp adv"
- **Table Structure Consistency**: Always use standard 6-column format for risk matrices
- **Implementation Example**:
```markdown
| **Risk Criteria** | **Score/Rating** | **Signal** | **Weight** | **Recommendation** | **Comments** |
|-------------------|------------------|------------|------------|-------------------|--------------|
| Altman Z-Score | 2.45 | Safe | High | BUY | Above 2.99 thresh |
| Piotroski F-Score | 7/9 | Strong | High | BUY | Good quality |
| DCF Fair Value | $15.20 | Undervalued | High | BUY | vs current $12.50 |
```
- **Testing Protocol**: Preview all tables before finalizing to ensure proper rendering
- **Error Prevention**: Systematically check comment length during analysis creation

### Professional Document Standards Integration
- **Consistent Logo Sizing**: 200px width, auto-height scaling for all equity analyses
- **Header Standardization**: HTML formatting for title and logo centering
- **Quality Assurance**: Multi-point verification for presentation standards

## Risk Management Integration

### Risk-Adjusted Analysis
- Value-at-Risk (VaR) calculations for position sizing
- Correlation analysis with portfolio holdings
- Stress testing under various market scenarios
- Maximum position size limits based on volatility and correlation

### Monitoring and Review Protocols
- Quarterly earnings review and model updates
- Material news impact assessment within 24 hours
- Annual comprehensive analysis refresh
- Price target and rating review triggers (±20% from target)

---

*Security Analysis Procedural Memory - Comprehensive methodology ensuring thorough, evidence-based investment research with proper risk assessment and fiduciary standard compliance*
