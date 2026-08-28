# Sales Profitability and Conversion Analysis

A finance- and data-driven analysis of 1,000 historical B2B sales opportunities. The project evaluates product profitability, regional conversion, deal economics, joint-bid ownership, and sales-confidence signals using Stata and Excel-derived source data.

## Executive snapshot

| Metric | Result |
|---|---:|
| Historical opportunities | 1,000 |
| Won opportunities | 481 |
| Overall conversion rate | 48.1% |
| Won-deal sales value | $3,894.0 million |
| Won-deal profit value | $1,804.2 million |

## Main findings

- **GTMSys is the profit engine**, contributing $844.0 million, or 46.8%, of total won-deal profit value.
- **The UK is the scale market in this sample**, representing 55.3% of observed opportunities and $1,014.0 million of won-deal profit value. This is opportunity concentration, not external market share.
- **Conversion differs across regions and products**, while average sales value does not differ significantly across regions.
- **India and the UK are not statistically distinguishable** on the four tested dimensions: average sales value, successful-deal margin, customer profitability, and conversion.
- **Majority WSES participation is associated with higher conversion**: 49.8% versus 39.6%, a 10.2 percentage-point difference (p = 0.016).
- **The broad sales-confidence grouping is not statistically reliable** in this sample (p = 0.190).
- **Marketing ROI cannot be inferred** from the reported correlation because the marketing-expense proxy and profit value both contain sales value.

Read the [full analysis report](sales_profitability_and_conversion-analysis.pdf) for the exhibits, statistical tests, limitations, and recommendations.

## Analytical methods

- Descriptive statistics by product and region
- Welch two-sample t-tests for India versus UK comparisons
- Chi-square tests for conversion differences by region, product, and confidence group
- One-way ANOVA for sales value across regions
- Two-sample proportion test for majority WSES ownership
- Pearson correlations for deal-economics relationships

## Repository files

```text
README.md                                           Project overview
sales_profitability_and_conversion-analysis.pdf    Revised portfolio report
sales_profitability_and_conversion-analysis.do     Reproducible Stata analysis
```

## Reproduce the analysis

The licensed source workbook is intentionally excluded. With authorized access to the original data:

1. Save a local copy beside the Stata file as `WSES-sales-leads.xlsx`.
2. Open Stata and set its working directory to this folder.
3. Run:

   ```stata
   do "sales_profitability_and_conversion-analysis.do"
   ```

The script covers the full analysis presented in the report, including ownership, confidence-class, and marketing-proxy tests.

## Data, publication, and rights

This repository contains only the group’s revised analysis report and analysis code. It does **not** include the assigned teaching case, assignment instructions, source workbook, or source data.

Underlying teaching material: U Dinesh Kumar, *Testing Marketing Hypotheses at WSES*, Indian Institute of Management Bangalore (2021), supplied under course access for MFin 604. The original materials remain the property of their respective rights holders.

No open-source `LICENSE` file is included. This is intentional: the report and code are presented for academic and portfolio viewing, and no additional permission to reuse, modify, distribute, or sell them is granted beyond GitHub’s Terms of Service and applicable law. Public posting should occur only after all group contributors agree and any required instructor or publisher permission is confirmed.

## Important limitations

- The data are historical and observational; the results do not establish causation.
- Small regional samples make some conversion estimates unstable.
- The marketing-expense measure is a formula-based proxy equal to 6% of sales value, not observed campaign spending.
- The repository cannot reproduce results without an authorized local copy of the excluded source workbook.
