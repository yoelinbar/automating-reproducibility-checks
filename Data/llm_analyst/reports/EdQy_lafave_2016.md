# Reproduction Report — LaFave & Thomas (2016), Farms, Families, and Markets

**Paper:** LaFave, D., & Thomas, D. (2016). Farms, Families, and Markets: New Evidence on Completeness of Markets in Agricultural Settings. *Econometrica*, 84(5), 1917–1960. https://doi.org/10.3982/ECTA12987

**Paper IDs:** paper_id=EdQy; claims=EdQy_l8kz8o, EdQy_6rd9rk, EdQy_ppk7pd, EdQy_j6k76k, EdQy_9xxwld, EdQy_single-trace

**Reproduction type:** Extended Push Button

**Headline verdict (unpatched):** precise

**Verdict if patched:** N/A — no logic-level patch applied; only environment-level edits.

## Headline
All six claims reproduce precisely. Each claim corresponds to a column of Table II (cols 1, 2, 3, 4, 5, 8) and the F-statistic for joint significance of the demographic block, its p-value, and the sample size all match the published values to the printed precision when the author's `LaFaveThomas.do` is run on the released `LaFaveThomas.dta`. The only edits required were environment-level: installing missing SSC packages (`ftools`, `require`, `moremata`) that newer `reghdfe` versions depend on, and swapping the deprecated `reghdfe …(endog = ivs)…` IV syntax for the now-canonical `ivreghdfe` command in column 7 (this affects no claim in the audit; it merely lets the do-file proceed past col 7 to col 8). No analysis-logic edits were made.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| EdQy_l8kz8o (Tbl II col 1) | F-stat | 37.27 | 37.27 | 37.27 | precise=37.27; approx [31.68, 42.86] | precise |
| EdQy_l8kz8o | p-value | 0.00 (exact, 2 dp) | 0.0 | <1e-15 → 0.00 | precise=0.00; approx [0,0.05] | precise |
| EdQy_l8kz8o | N | 38,189 | 38,189 | 38,189 | precise=38189 | precise |
| EdQy_6rd9rk (Tbl II col 2) | F-stat | 33.65 | 33.65 | 33.65 | precise=33.65; approx [28.60, 38.70] | precise |
| EdQy_6rd9rk | p-value | 0.00 | 0.0 | <1e-15 → 0.00 | precise=0.00 | precise |
| EdQy_6rd9rk | N | 38,189 | 38,189 | 38,189 | precise=38189 | precise |
| EdQy_ppk7pd (Tbl II col 3) | F-stat | 13.13 | 13.13 | 13.13 | precise=13.13; approx [11.16, 15.10] | precise |
| EdQy_ppk7pd | p-value | <0.005 (threshold) | 0.005 | ≪0.005 (text/table prints 0.00) | precise: reproduced ≤ 0.005 | precise |
| EdQy_ppk7pd | N | 38,189 | 38,189 | 38,189 | precise | precise |
| EdQy_j6k76k (Tbl II col 4) | F-stat | 2.53 | 2.53 | 2.527 → 2.53 | precise=2.53; approx [2.15, 2.91] | precise |
| EdQy_j6k76k | p-value | 0.005 (table) | 0.005 | 0.00514 → 0.005 (3 dp) | precise=0.005 | precise |
| EdQy_j6k76k | N | 11,594 | 11,594 | 11,594 | precise | precise |
| EdQy_9xxwld (Tbl II col 5) | F-stat | 5.01 | 5.01 | 5.008 → 5.01 | precise=5.01; approx [4.26, 5.76] | precise |
| EdQy_9xxwld | p-value | 0.00 (table) | 0.0 | 2.55e-08 → 0.00 | precise=0.00 | precise |
| EdQy_9xxwld | N | 33,737 | 33,737 | 33,737 | precise | precise |
| EdQy_single-trace (Tbl II col 8 = harvest) | F-stat | 6.19 | 6.19 | 6.186 → 6.19 | precise=6.19; approx [5.26, 7.12] | precise |
| EdQy_single-trace | p-value | 0.00 | 0.0 | 6.70e-11 → 0.00 | precise=0.00 | precise |
| EdQy_single-trace | N | 27,387 | 27,387 | 27,387 | precise | precise |

Overall verdict per claim: all six **precise**.

## What I did

1. **Set-up.** Created `independent_reproductions/EdQy_lafave_2016/`, copied PDF, ran `pdftotext -layout` (note: the layout extraction collapsed decimal points in the F-stats row of Table II — e.g., the printed "37.27" appears as "3727" in the .txt; I verified the printed values directly in the PDF rendered view).
2. **Extraction check.** Table II appears on p. 1933 (numbering inside paper) of EdQy.pdf. The "All groups" F-statistics row reads (cols 1–10): 37.27, 33.65, 13.13, 2.53, 5.01, 4.21, 2.99, 6.19, 5.40, 4.89. The "Observations" row reads 38,189; 38,189; 38,189; 11,594; 33,737; 33,737; 25,739; 27,387; 33,166; 24,353. The in-text statement on p. 1934 says col 3 F=13.13 with "p-value < 0.005" (text uses threshold; table prints "0.00"). All six extracted `orig_*` values match the paper exactly.
3. **Data/code source.** Author replication archive at the Econometric Society supplement page: `https://www.econometricsociety.org/publications/econometrica/2016/09/01/farms-families-and-markets-new-evidence-completeness-markets/supp/12987-3_Data_and_Programs.zip` (≈1.16 MB). Contains `LaFaveThomas.do`, `LaFaveThomas.dta`, `readme.txt`, and pre-built `tab2.xls` / `tab3.xls`.
4. **Reproduction commands.**
   - `stata-mp -b do install_deps.do` (installed `ftools`, `require`, `moremata`).
   - `stata-mp -b do install_ivreghdfe.do` (installed `ivreghdfe`).
   - `stata-mp -b do run_pushbutton.do` (verbatim copy of the author's `LaFaveThomas.do`, with one edit at line 194: swap `reghdfe labor_d_log `rhs' (`hhcomp' = `ivs'), absorb(...) vce(cluster ...)` → `ivreghdfe labor_d_log `rhs' (`hhcomp' = `ivs'), absorb(...) cluster(...)`). Runtime ≈30 sec.
   - Output `tab2.xls` parsed with Python; F-stat / p-value / N for cols 1–8 extracted and shown above.
5. **Environment-only edits — explicit list.**
   - Installed required SSC packages (`ftools`, `require`, `moremata`) that the modern `reghdfe` requires but that aren't auto-installed by the do-file's existing `ssc install` block. Permitted under Push Button (missing packages).
   - Swapped `reghdfe ... (endog = iv) ...` → `ivreghdfe ...` in the col 7 IV regression. Modern `reghdfe` deprecated its built-in IV; `ivreghdfe` is the canonical successor with identical statistical behavior (it wraps `ivreg2` with `reghdfe`-style absorbed FE). Permitted under Extended Push Button (deprecated function name swap, unchanged behavior). This affects col 7 only; col 7 is not part of any claim in this audit. The fix was needed only so that the loop in section C (which produces col 8 — the `EdQy_single-trace` claim) could run.
6. **No stochastic methods** — all regressions are point estimates; no MC SE needed.
7. **Classification.** Bounds for each F-stat are ±15% of the paper value; reproduced rounds to paper precision in every case. For col 3 the paper uses a threshold p<0.005, and the reproduced p (effectively 0) trivially passes; for the other five claims the paper prints p=0.00 (or 0.005 for col 4) and the reproduced p rounds to that value. Sample sizes match exactly. Overall: precise on all six claims.

## Diagnostics — author-bug analysis

Diagnostics: none — unpatched run (after permitted environment-level edits) reproduces the published Table II values to the printed precision; no logic bug suspected.

## Files in this folder

Author archive (unmodified):
- `EdQy.pdf`, `EdQy.txt` — paper and pdftotext extraction
- `data_and_programs.zip` — downloaded supplement
- `LaFaveThomas.do`, `LaFaveThomas.dta`, `readme.txt`, `tab2.xls`, `tab3.xls` — unzipped author files (note: `tab2.xls` and `tab3.xls` are overwritten by my run; the originals were equivalent)

Reproduction scripts and logs:
- `install_ftools.do` / `install_ftools.log` — install ftools
- `install_deps.do` / `install_deps.log` — install require, moremata
- `install_ivreghdfe.do` / `install_ivreghdfe.log` — install ivreghdfe
- `run_pushbutton.do` — author do-file with one line edited (line 194: reghdfe→ivreghdfe IV syntax for col 7)
- `run_pushbutton.log` — final successful run log
- `run_pushbutton_partial.log`, `tab2_partial.xls` — earlier failed run that produced cols 1–6 before erroring on col 7

Reports:
- `REPRODUCTION_REPORT.md` — this file
- (summary CSV is written one level up as `EdQy_summary_rows.csv`)
