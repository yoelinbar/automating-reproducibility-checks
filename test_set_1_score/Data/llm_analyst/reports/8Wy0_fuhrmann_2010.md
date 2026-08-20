# Reproduction Report — Fuhrmann & Kreps (2010), Targeting Nuclear Programs

**Paper:** Fuhrmann, Matthew and Sarah E. Kreps. 2010. "Targeting Nuclear Programs in War and Peace: A Quantitative Empirical Analysis, 1941-2000." *Journal of Conflict Resolution* 54(6): 831-859. DOI: 10.1177/0022002710371671
**Paper IDs:** paper_id=8Wy0; claims=[8Wy0_single-trace]
**Reproduction type:** Extended Push Button (only environment-only edits: a `cd`/`use` wrapper plus `ssc install relogit` for the user-written `relogit` command King & Zeng's rare-events logit; no analysis logic touched)
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A — no patch needed

## Headline
The reproduction is exact. Running the archived author do-file (Model 5 of Table 4) on the archived `.dta` produces hostileMID (Violent conflict) coefficient = 2.844962, robust SE = 1.005768, z = 2.83, p = 0.005, N = 5,360. The paper prints 2.845 (1.006), N = 5,360, *** (p < 0.01) — every reported sub-outcome matches to the paper's printed precision.

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| 8Wy0_single-trace | Coefficient (hostileMID) | 2.845 | 2.845 | 2.844962 → rounds to 2.845 | precise band: rounds to 2.845; approx band [2.418, 3.272] | precise |
| 8Wy0_single-trace | p-value (focal) | < 0.01 (threshold) | 0.01 (less-than) | 0.005 | precise: p ≤ 0.01; approx: (0.01, 0.06]; not: > 0.06 | precise |
| 8Wy0_single-trace | Sample size | 5,360 | 5,360 | 5,360 | precise: 5,360; approx [4,556, 6,164] | precise |
| 8Wy0_single-trace | Test statistic | not reported (focal) | NaN | z = 2.83 (computed) | n/a | non-outcome |
| 8Wy0_single-trace | Effect size | not reported as a focal effect-size statistic for the coef itself (relative risk for considered = 7.06, attacks = 16.21 are reported separately) | NaN | n/a | n/a | non-outcome |

Overall verdict (unpatched): **precise**.

## What I did
1. **Set-up.** Created `independent_reproductions/8Wy0_fuhrmann_2010/`, copied the PDF, ran `pdftotext -layout` to produce `8Wy0.txt`.
2. **Extraction check.** Located Table 4 (PDF p. 845-846, txt lines 740-793). Model 5 column shows `Violent conflict 2.845*** (1.006)` with N = 5,360. The variable `Violent conflict` is the construct named `hostileMID` in the do-file (line 29). The paper's three-asterisk symbol means *significant at 1%* (table note). Paper-printed values match the `orig_*` extraction exactly.
3. **Data/code source.** Author's personal site, http://www.matthewfuhrmann.com/research.html, file `jcr_replication-1.zip` ("JCR Replication-1/Targeting Nuclear Programs.do" + matching `.dta`). Saved both into the reproduction directory.
4. **Reproduction commands.** Two do-files:
   - `install_relogit.do`: `ssc install relogit, replace` (King & Zeng rare-events logit; environment-only setup since the system Stata didn't have it).
   - `run_pushbutton.do`: wraps the relevant Model 5 line from the author's archived do-file (line 29 of `Targeting Nuclear Programs.do`) with a `cd` and `use`. The exact Stata command — `relogit attack1 hostileMID polity2 s_un_reg cap_2 pwrratio postArt56 postCW prgmyrs NCAnosafetodate cap_1 contig noattackyrs _spline1a _spline2a _spline3a if polrel==1, cluster(dyadid)` — is copied verbatim from the author's do-file.
   - Stata 16 MP, run via `/usr/local/bin/stata-mp -b do <file>`. Runtime <2 s.
   - Environment edits: only `cd` + `use` wrapper, plus installing the `relogit` package. No statistical specification changed.
5. **Stochastic-method diagnostics.** None — `relogit` is deterministic estimation.
6. **Classification.** Coef rounds to 2.845 (paper-precision = 3 decimals): precise. p (threshold, paper says < 0.01): reproduced p = 0.005 ≤ 0.01: precise. N (5,360 = 5,360): precise. Overall: **precise**.

## Diagnostics — author-bug analysis
Diagnostics: none — unpatched run reproduces the published values to printed precision; no logic bug suspected.

## Files in this folder
- `8Wy0.pdf`, `8Wy0.txt` — paper and pdftotext extraction
- `jcr_replication-1.zip` — author replication archive downloaded from matthewfuhrmann.com
- `JCR Replication-1/Targeting Nuclear Programs.do` — author's do-file (unmodified)
- `JCR Replication-1/Targeting Nuclear Programs.dta` — author's data (unmodified)
- `install_relogit.do`, `install_relogit.log` — environment setup (rare-events logit package)
- `run_pushbutton.do`, `run_pushbutton.log` — unpatched-run script and log (the headline verdict's evidence)
- `REPRODUCTION_REPORT.md` — this report
- `8Wy0_summary_rows.csv` — summary row(s) for aggregation
