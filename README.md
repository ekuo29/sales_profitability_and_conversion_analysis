# MFIN604 Case 1: WSES Marketing Hypotheses

Private-by-default repository for Group 4's analysis of the WSES case. The project uses Stata and Excel to study 1,000 historical sales leads, test marketing hypotheses, and turn the results into recommendations.

> **Repository status:** GitHub-ready, but not cleared for public release. The assigned case is personalized for exclusive use and the supplied workbook carries IIMB copyright. Those files are kept in `local-only/` and excluded from Git.

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

See the [final report](report/MFin604-Case-1-Group-4.pdf) for the full interpretation, exhibits, and recommendations.

## Repository layout

```text
analysis/
  stata/
    MFin604-Case-1-Group-4.do           Portable Stata analysis
    MFin604-Case-1-Group-4.original.do  Byte-identical archival copy
local-only/
  analysis/                             Excel analysis; not tracked
  course-materials/                     Assigned case and instructions; not tracked
  data/                                 Copyrighted source workbook; not tracked
report/
  MFin604-Case-1-Group-4.pdf            Final Group 4 submission
results/
  stata/
    MFin604-Case-1-Group-4.log          Saved Stata output
```

The complete file map is in [FILE_MANIFEST.md](FILE_MANIFEST.md). File-integrity hashes are in [CHECKSUMS.sha256](CHECKSUMS.sha256).

## Reproduce the Stata analysis

1. Keep the licensed workbook at `local-only/data/IMB695-WSES-Sales-Leads.xlsx`.
2. Open Stata and set its working directory to the repository root.
3. Run:

   ```stata
   do "analysis/stata/MFin604-Case-1-Group-4.do"
   ```

4. Stata will write the log to `results/stata/MFin604-Case-1-Group-4.log`.

The Stata file covers the core statistical analysis through Question 8. The supplementary Excel workbook contains additional work for Questions 9 and 10.

## Publication and licensing

Start with a **private GitHub repository**. Before making it public, follow [PUBLIC_RELEASE_CHECKLIST.md](PUBLIC_RELEASE_CHECKLIST.md), obtain any required instructor or publisher permission, and confirm that all Group 4 contributors agree.

No open-source license has been applied. Third-party course materials and data are not offered for redistribution; see [NOTICE.md](NOTICE.md).
