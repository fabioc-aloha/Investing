---
applyTo: "**/*.risk,**/*.var,**/*.stress,**/risk/**,**/analytics/risk/**"
description: "Risk assessment methodology and risk management best practices"
---

# Risk Assessment Procedural Memory

## File Format and Documentation Requirements
- Always create risk assessment files with `.md` extension for comprehensive documentation
- Use `.json` extension only for structured risk data requiring validation and computation
- Risk reports must use `.md` extension for detailed analysis and visual presentation
- Stress test files must use `.md` extension for scenario documentation and results
- Include YAML frontmatter with risk metadata (risk level, assessment date, reviewer)
- Follow naming convention: `asset-strategy-risk-assessment.md`
- Ensure all risk documentation supports markdown tables, charts, and formatting
- Use emoji indicators (🔴🟡🟢) for visual risk level communication

## Risk Identification and Classification
- Identify all sources of investment risk including market, credit, liquidity, and operational risks
- Classify risks by type, magnitude, and probability of occurrence
- Consider tail risks and extreme scenarios in risk assessment
- Monitor correlation risks and concentration risks continuously
- Assess model risk and parameter uncertainty in risk models

## Quantitative Risk Measurement
- Use Value at Risk (VaR) and Conditional Value at Risk (CVaR) for downside risk measurement
- Implement multiple risk models including parametric, historical simulation, and Monte Carlo methods
- Calculate risk-adjusted performance metrics including Sharpe ratio, Sortino ratio, and maximum drawdown
- Monitor tracking error, information ratio, and active risk continuously
- Use factor models to decompose and understand sources of risk

## Stress Testing and Scenario Analysis
- Conduct regular stress tests using historical and hypothetical scenarios
- Test portfolio resilience under extreme market conditions
- Analyze correlation breakdown and liquidity stress scenarios
- Model portfolio behavior during economic recessions and market crises
- Document stress test results and develop contingency plans

## Risk Limits and Controls
- Establish appropriate risk limits at portfolio, sector, and security levels
- Implement real-time risk monitoring and alert systems
- Use position limits, concentration limits, and VaR limits as primary controls
- Monitor liquidity risk and implement appropriate liquidity management procedures
- Maintain risk reporting and escalation procedures

## Risk Communication and Reporting
- Communicate risk clearly and effectively to clients and stakeholders
- Provide regular risk reports with appropriate metrics and explanations
- Explain risk-return trade-offs and portfolio risk characteristics
- Document risk management decisions and rationale
- Maintain transparency in risk measurement methodologies and assumptions
