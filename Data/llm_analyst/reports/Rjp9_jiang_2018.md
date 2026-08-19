# Reproduction Report — Jiang (2018), Making Bureaucracy Work

**Paper:** Jiang, Junyan. 2018. "Making Bureaucracy Work: Patronage Networks, Performance Incentives, and Economic Development in China." *American Journal of Political Science* 62(4): 982–999. DOI: 10.1111/ajps.12394
**Paper IDs:** paper_id=Rjp9; claims=[Rjp9_single-trace]
**Reproduction type:** Push Button (Extended — environment-only edits: `cd` path; renamed `.tab` → `.dta`; isolated focal model M3)
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A — no patch needed.

## Headline
The focal claim — Table 2 / Model 3, the regression of `F2.gdpidx` on `bin_mleader2currentsec` with city + year×province fixed effects, economic and career covariates, clustered SEs at the city level — reproduces **exactly** to the paper's printed precision. Coefficient = 0.3823 (paper 0.382), SE = 0.1262 (paper 0.126), N = 3,693 (paper 3,693), t = 3.03, p = 0.003 (paper "p < .01"). All four reported sub-outcomes are precise.

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| Rjp9_single-trace | Coefficient | 0.382 | 0.382 | 0.3823 → 0.382 | precise band: rounds to 0.382 (3 dp); approx [0.3247, 0.4393] | precise |
| Rjp9_single-trace | SE (reported alongside coef) | 0.126 | 0.126 | 0.1262 → 0.126 | precise: rounds to 0.126 | precise (informational; rubric covers coef/p/N/test) |
| Rjp9_single-trace | p-value | < .01 | 0.01 (less-than) | 0.00245 | one-sided threshold rule: p ≤ 0.01 = precise; (0.01, 0.06] approx | precise |
| Rjp9_single-trace | Sample size | 3,693 | 3,693 | 3,693 | precise: equal; approx [3139, 4247] | precise |
| Rjp9_single-trace | Test statistic | t = 3.03 (computed; paper does not print it) | NaN | t = 3.03 | non-outcome (paper does not print test stat) | non-outcome |
| Rjp9_single-trace | Effect size | "10% of a SD"; not extracted (NaN) | NaN | not recomputed | non-outcome | non-outcome |

**Overall verdict (unpatched):** **precise** (every reported sub-outcome is precise; non-outcomes excluded per the rubric).

## What I did
1. **Set-up.** Created `independent_reproductions/Rjp9_jiang_2018/`. Copied `papers/Rjp9.pdf` in, ran `pdftotext -layout` → `Rjp9.txt`.
2. **Extraction check.** Located the focal statistic at the regression table (Table 2 in the published article, captioned "Connection and City Economic Growth"; the extracted page is page 10 / `p_value_pg=10`). The `pdftotext` row reads:
   - `Connected to provincial secretary  0.389*  0.749**  0.382**  0.009  0.740*  0.210`
   - `(0.191)  (0.199)  (0.126)  (0.207)  (0.315)  (0.153)`
   - `Observations  3,907  3,891  3,693  3,691  3,691  3,691`
   Model 3 (third column) gives β = 0.382, SE = 0.126, N = 3,693, with `**` indicating p < .01. Extraction matches the paper to all reported digits.
3. **Data/code source.** Harvard Dataverse, `doi:10.7910/DVN/XZ0IZE` ("Replication Data for: Making Bureaucracy Work…"). Downloaded all data files via the Dataverse access API with `?format=original` (which returns the originally uploaded `.dta` even though the listing labels them `.tab`). Files saved into the reproduction directory; key code files: `DO14_main_analyses.do`, `DO14_process_before_main.do`, plus `expmat.ado`. Stata `.tab` files were copies of the original Stata `.dta`; I duplicated them to `.dta` so the do-file could use them.
4. **Reproduction.** Ran `run_pushbutton.do` via `stata-mp -b do run_pushbutton.do`. Environment-only edits: (a) replaced the author's `cd "D:\Users\jiang\..."` with the local path; (b) wrapped `ssc install egenmore` / `xtabond2` in `capture which` checks to avoid network during reruns; (c) ran only the three focal model fits (`m1`, `m2`, `m3`) for the headline; the do-file itself was not modified. All other downstream code (Table 2 panel B, robustness, IV, etc.) was not exercised because they are not needed for this single focal claim. Runtime ~3 minutes.
5. **Stochastic-method diagnostics.** None. The estimator is OLS-with-fixed-effects with cluster-robust SEs; deterministic given the data.
6. **Classification.**
   - Coef: paper prints to 3 decimals (0.382). Reproduced 0.38231602, rounds to 0.382 → **precise**.
   - p-value: paper reports threshold "p < .01" (the `**` superscript). Reproduced p = 0.00245 ≤ 0.01 → **precise** under the threshold rule.
   - N: paper prints 3,693. Reproduced 3,693 → **precise**.
   - Test statistic and effect size: not printed numerically in the paper for this claim → **non-outcome**.

   Overall: **precise**.

## Diagnostics — author-bug analysis
Diagnostics: none — the unpatched archived code reproduces the paper's printed values exactly. There is a cosmetic note that the do-file labels the regression block `Table 1` while the published article numbers it `Table 2`, but this is a label-only mismatch; the same numbers print.

## Files in this folder
- `Rjp9.pdf` — published-version-of-record paper
- `Rjp9.txt` — `pdftotext -layout` output of the paper
- `README.txt` — author's replication instructions
- `Codebook.pdf` — author's variable codebook
- `DO14_main_analyses.do`, `DO14_process_before_main.do`, `DO14_performance_and_promotion.do`, `DO14_validation.do`, `expmat.ado` — author's Stata code (unmodified)
- `*.tab` — author's data files (Stata-format despite extension)
- `*.dta` — copies renamed for use by the do-file (`citypanel_base.dta`, `econ_panel.dta`, `performance_and_promotion.dta`, `validation_data.dta`, `citypanel_forR.dta`, `distribution.dta`)
- `base1106.csv`, `fullbio1106.csv`, `cityyear_structure.csv` — auxiliary CPED-derived files
- `run_pushbutton.do` — runner I executed (calls the author's `DO14_process_before_main.do` and re-fits M1/M2/M3)
- `run_pushbutton.log` — Stata log of the unpatched run
- `REPRODUCTION_REPORT.md` — this report

No patched-diagnostic artifacts (none needed).
