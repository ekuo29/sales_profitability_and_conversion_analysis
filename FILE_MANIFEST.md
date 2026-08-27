# File manifest

The original files were copied from the course working folder. Descriptive repository filenames replace inconsistent spacing and punctuation. Except for the explicitly identified portable Stata file, the organized copies remain byte-identical to their originals.

| Original file | Organized path | Role | Git treatment |
| --- | --- | --- | --- |
| `case1.pdf` | `local-only/course-materials/Testing-Marketing-Hypotheses-at-WSES.pdf` | Assigned IIMB case, personalized for exclusive use | Ignored |
| `Instructions for Case 1 (WSES).docx` | `local-only/course-materials/Instructions-for-Case-1-WSES.docx` | Instructor questions and notes | Ignored |
| `case 1IMB695-XLS-ENG.xlsx` | `local-only/data/IMB695-WSES-Sales-Leads.xlsx` | Original 1,000-row case dataset | Ignored |
| `case 1 .xlsx` | `local-only/analysis/WSES-Case-Analysis.xlsx` | Expanded Excel analysis for Questions 9 and 10 | Ignored |
| `MFin604 Case 1 - Group 4.do` | `analysis/stata/MFin604-Case-1-Group-4.original.do` | Byte-identical archival Stata script | Tracked |
| `MFin604 Case 1 - Group 4.do` | `analysis/stata/MFin604-Case-1-Group-4.do` | Portable Stata script with repository-relative paths | Tracked |
| `MFin604_Case_1 Group 4.log` | `results/stata/MFin604-Case-1-Group-4.log` | Stata output used in the appendices | Tracked |
| `MFin604 Case 1 - Group 4.pdf` | `report/MFin604-Case-1-Group-4.pdf` | Final 15-page Group 4 report | Tracked |

## Intentional change to the portable Stata file

The portable copy removes the hard-coded `C:\\Users\\User\\Downloads` working directory, reads the source workbook from `local-only/data/`, writes its log to `results/stata/`, closes any previously open log, and clears imported data before loading. The analysis commands are otherwise preserved.
