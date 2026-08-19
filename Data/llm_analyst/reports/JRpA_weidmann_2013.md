# Reproduction Report — Weidmann & Callen (2013), Violence and Election Fraud: Evidence from Afghanistan

**Paper:** Weidmann, Nils B. and Michael Callen. 2013. "Violence and Election Fraud: Evidence from Afghanistan." *British Journal of Political Science* 43(1): 53-75. DOI: 10.1017/S0007123412000191
**Paper IDs:** paper_id=JRpA; claims=JRpA_7oy1jv, JRpA_zxz13n, JRpA_l8j9xn, JRpA_6ryjx7, JRpA_3nyvwv, JRpA_w7j8zq
**Reproduction type:** Extended Push Button (single environment-only edit: `library(Design)` → `library(rms)`; `Design` package was renamed to `rms` with identical API for `lrm`, `ols`, `robcov`)
**Headline verdict (unpatched):** precise

## Headline
All six claims reproduce **precisely** to the printed precision of Tables 2 and 3 across coefficients, standard errors, sample sizes (N=375 for Models 1-5, N=363 for Model 6), and p-value significance bands. The only edit was an environment swap from the deprecated `Design` package to its successor `rms` (identical API for the functions used). No analysis logic was modified. No discrepancies, no diagnostics required.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| JRpA_7oy1jv (M1, Violence(election, sq)) | coef | -13.748 | -13.748 | -13.7477 → rounds to -13.748 | [-15.81, -11.69] | precise |
| | SE | 4.720 | – | 4.7197 → 4.720 | – | precise |
| | stat (Z) | -2.913 (computed) | -2.913 | -2.91 | [-3.35, -2.48] | precise |
| | p-value | "p<0.01" | 0.0036 | 0.0036 | (≤0.01 precise; (0.01,0.06] approx) | precise |
| | N | 375 | 375 | 375 | [319, 431] | precise |
| JRpA_zxz13n (M2, Violence(2-month, sq)) | coef | -0.488 | -0.488 | -0.4883 → -0.488 | [-0.561, -0.415] | precise |
| | SE | 0.122 | – | 0.1216 → 0.122 | – | precise |
| | stat (Z) | -4.0 (rep ext) | -4.0 | -4.02 | [-4.60, -3.40] | precise |
| | p-value | "p<0.01" | 6.3e-05 | <0.0001 | (≤0.01 precise) | precise |
| | N | 375 | 375 | 375 | [319, 431] | precise |
| JRpA_l8j9xn (M3, Violence(election, sq), OLS) | coef | -1.438 | -1.438 | -1.4376 → -1.438 | [-1.654, -1.222] | precise |
| | SE | 0.375 | – | 0.3752 → 0.375 | – | precise |
| | stat (t) | -3.83 (rep ext) | -3.835 | -3.83 | [-4.41, -3.26] | precise |
| | p-value | "p<0.01" | 0.000148 | 0.0001 | (≤0.01 precise) | precise |
| | N | 375 | 375 | 375 | [319, 431] | precise |
| JRpA_6ryjx7 (M4, Violence(2-month, sq), OLS) | coef | -0.077 | -0.077 | -0.0767 → -0.077 | [-0.0886, -0.0655] | precise |
| | SE | 0.025 | – | 0.0251 → 0.025 | – | precise |
| | stat (t) | -3.08 (rep ext) | -3.08 | -3.05 | [-3.54, -2.62] | precise |
| | p-value | "p<0.01" | 0.00223 | 0.0024 | (≤0.01 precise) | precise |
| | N | 375 | 375 | 375 | [319, 431] | precise |
| JRpA_3nyvwv (M5, Violence(election, adj), Karzai) | coef | 7.279 | 7.279 | 7.2789 → 7.279 | [6.187, 8.371] | precise |
| | SE | 4.576 | – | 4.5757 → 4.576 | – | precise |
| | p-value | not reported in paper | – | (Z=1.59, p=0.112) | n/a | non-outcome |
| | N | 375 | 375 | 375 | [319, 431] | precise |
| JRpA_w7j8zq (M6, Violence(election, adj), Abdullah) | coef | 5.239 | 5.239 | 5.2390 → 5.239 | [4.453, 6.025] | precise |
| | SE | 2.216 | – | 2.2156 → 2.216 | – | precise |
| | p-value | "p<0.05" | "less-than 0.05" | 0.0181 | (≤0.05 precise; (0.05,0.10] approx) | precise |
| | N | 363 | 363 | 363 | [309, 417] | precise |

**Overall per-claim verdicts (unpatched):** all 6 claims = **precise**.

## What I did

1. **Set-up.** Created `independent_reproductions/JRpA_weidmann_2013/`. Copied PDF in, generated `JRpA.txt` via `pdftotext -layout`.

2. **Extraction check.** Re-read pp. 72-73 of the paper:
   - Table 2 (p. 72): Models 1-4 print N=375, R2=(0.251, 0.263, 0.212, 0.246). The four focal squared-violence rows print -13.748*** (SE 4.720), -0.488*** (SE 0.122), -1.438*** (SE 0.375), -0.077*** (SE 0.025). All match the extracted `orig_coef_value`/`orig_coef_se` in the JSON.
   - Table 3 (p. 73): Model 5 (Karzai) prints `Violence (election, adjacent districts)` 7.279 (SE 4.576), no significance stars (consistent with extraction having `orig_p_value=NaN` for this row); N=375. Model 6 (Abdullah) prints 5.239** (SE 2.216), N=363. All match.
   - PDF's "negative sign" renders in plain-text as a leading "2" (Unicode minus glyph issue) — values like "23.748" in `JRpA.txt` correspond to printed "-13.748" in the PDF; the printed PDF was the authoritative source.
   - **Extraction matches paper for all six claims to all reported digits.**

3. **Data/code source.** `pr_data_location` listed Publisher website / Online repository / Author website. Found at Harvard Dataverse: doi:10.7910/DVN/UQKU5T (Nils Weidmann Dataverse). Two files: `replicationdata.csv` (375 rows × 17 cols) and `replication.R` (35 lines, six `lrm`/`ols` calls + `robcov`). Downloaded both via Dataverse API (`/api/access/datafile/2414041` and `/2414042`).

4. **Reproduction commands.**
   ```
   Rscript run_pushbutton.R > run_pushbutton.log 2>&1
   ```
   Runtime: ~3 seconds. Environment-only edits to original `replication.R` (saved as `run_pushbutton.R`):
   - `library(Design)` → `library(rms)` — `Design` was officially superseded by `rms` (Frank Harrell, same author, identical exported API for `lrm`, `ols`, `robcov`). Allowed under Extended Push Button per the modification policy.
   - Removed the placeholder `setwd("/your/working/directory/here")` line — pure path edit.
   - Added section banners around the existing `print(m1)` ... `print(m6)` to make the log readable. No statistical edit.

5. **Stochastic-method diagnostics.** None — all six models are deterministic (logit / OLS with cluster-robust SEs).

6. **Classification.** All sub-outcomes round to the printed paper precision; all p-value thresholds are met (reproduced p-values are ≤ the printed threshold, which counts as precise per the one-sided rule). Overall verdict per claim = precise.

## Diagnostics — author-bug analysis
**Diagnostics: none.** Unpatched run reproduces all six claims precisely. No logic bug suspected. The only modification (`Design` → `rms`) is an environment-only package-rename swap permitted under the Extended Push Button modification policy and does not touch any analysis logic.

A minor note — not a bug: M1 emits a small `max |deriv| = 2e-06` (and similar in M2/M5/M6); these are within the lrm convergence tolerance and do not affect any reported coefficient, SE, or N.

## Files in this folder
- `JRpA.pdf` — paper (copied from `papers/`)
- `JRpA.txt` — `pdftotext -layout` output
- `replicationdata.csv` — author's data (Harvard Dataverse, file id 2414041)
- `replication.R` — author's original script (Harvard Dataverse, file id 2414042)
- `run_pushbutton.R` — author's script with env-only edits (`Design`→`rms`, `setwd` removed, banners added)
- `run_pushbutton.log` — output of the unpatched run
- `REPRODUCTION_REPORT.md` — this report
- `JRpA_summary_rows.csv` — per-claim summary rows
