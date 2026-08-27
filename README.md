# Sales and Marketing Analysis

Analysis of 1,000 historical sales leads for a software-services company. The project uses Stata and Excel to test marketing hypotheses, evaluate product and regional performance, and turn the results into business recommendations.

## What the analysis covers

- Profitability by product line and region
- Market revenue, profit, and conversion-rate comparisons
- Customer profit versus deal size
- India-versus-UK mean comparisons using t-tests
- Region and product associations using chi-square tests and ANOVA
- Conversion rates for majority versus minority WSES ownership
- Sales-team confidence classes versus actual outcomes
- Marketing expense versus deal profitability

## Main findings

- GTMSys contributed the largest total profit among successful deals.
- The UK was the largest market by opportunity count and remained strategically important despite an approximately average conversion rate.
- Conversion rates varied significantly across regions, while average sales values did not show a statistically significant regional difference.
- India and the UK were not statistically distinguishable on the four tested dimensions.
- WSES ownership above 50% was associated with a higher conversion rate than ownership at or below 50%.
- The sales team's confidence class was not a reliable predictor of the actual sales outcome in this sample.

See the [analysis report](sales-and-marketing-analysis-report.pdf) for the full interpretation, exhibits, and recommendations.

## Repository files

```text
README.md                                  Project overview
sales-and-marketing-analysis-report.pdf   Final analysis report
sales-and-marketing-analysis.do           Stata analysis code
```

## Reproduce the Stata analysis

The licensed source workbook is not distributed with this repository. With authorized access to the original data:

1. Save a local copy beside the Stata file as `WSES-sales-leads.xlsx`.
2. Open Stata and set its working directory to this folder.
3. Run:

   ```stata
   do "sales-and-marketing-analysis.do"
   ```

The Stata file covers the core statistical analysis through Question 8. Additional analysis for Questions 9 and 10 was completed in Excel and is presented in the report.

## Publication and licensing

The assigned case, instructions, and source dataset are intentionally excluded because they are third-party course materials. Confirm instructor or publisher permission and agreement from all group contributors before making the repository public.

No open-source license has been applied. The repository does not grant redistribution rights for the underlying course materials or data.
