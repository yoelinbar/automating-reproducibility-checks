# Reproduction Report — Bigoni et al. (2015), Time Horizon and Cooperation in Continuous Time

**Paper:** Bigoni, M., Casari, M., Skrzypacz, A., & Spagnolo, G. (2015). "Time Horizon and Cooperation in Continuous Time." *Econometrica* 83(2): 587–616. DOI: 10.3982/ECTA11380.
**Paper IDs:** paper_id=VBx1; claims=[VBx1_single-trace]
**Reproduction type:** Push Button (used author's pre-built `subjects_data_ready.dta` and the verbatim Table III block from `data_analysis.do`, lines 207–223)
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A — no logic patch needed for the headline sub-outcomes.

## Headline
The headline regression reproduces precisely on every sub-outcome that is part of the SCORE rubric: the Short-Stochastic coefficient is -17.79899 (paper prints -17.799), the bootstrap p-value is 0.000 (paper "< 0.001"), and N is 192 (paper 192). One non-rubric quantity diverges noticeably and is flagged here for transparency: the bootstrap standard error is 3.415 vs the paper's 3.830 (~10.8% smaller). The author's posted bootstrap (`reps(100) seed(100) cluster(session)`) drops 38/100 replicates in modern Stata ("One or more parameters could not be estimated in 38 bootstrap replicates"), so the reported SE comes from only 62 effective replicates. This is consistent with a Stata-version-induced change in bootstrap behaviour rather than a data discrepancy. Since SE/test-statistic is not an extracted sub-outcome for this claim (`orig_stat_value` is NaN; `orig_coef_se` is auxiliary metadata), the headline verdict is unaffected.

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| VBx1_single-trace | Sample size (N) | 192 | 192 | 192 | precise = 192; approx = [164, 220] | precise |
| VBx1_single-trace | Coefficient (S_short) | -17.799 | -17.799 | -17.79899 | precise rounds to -17.799; approx = [-20.469, -15.129] | precise |
| VBx1_single-trace | p-value (S_short) | < 0.001 | 0.001 (less-than) | 0.000 (P>\|z\|) | threshold one-sided: precise = p ≤ 0.001 | precise |
| VBx1_single-trace | Effect size (ser_method) | -17.799 | -17.799 | -17.79899 | same as coefficient | precise |
| VBx1_single-trace | Test statistic | not reported | NaN | n/a | — | non-outcome |
| (auxiliary) | Bootstrap SE | 3.830 | 3.83 | 3.415 | not in rubric (informational) | n/a |

**Overall (unpatched): precise.**

## What I did

1. **Set-up.** Created `independent_reproductions/VBx1_bigoni_2015/`, copied PDF, generated `VBx1.txt` via `pdftotext -layout`.

2. **Extraction check.** Table III is on p. 10 of the article. The "Short-Stochastic" coefficient appears as `−17.799***  (3.830)` (col 1, full-controls bootstrapped specification). The text on p. 10 reads: *"By contrast, in the short duration treatments, cooperation rates are significantly higher with a deterministic horizon than with a stochastic horizon (p-value < 0.001; see Table III)."* Footnote / table note confirms N=192 and the bootstrap-SE specification. Extracted values match the paper exactly to all reported digits.

3. **Data/code source.** Downloaded the Econometrica replication archive `11380_Data_and_Programs.zip` (20 MB) from the Econometric Society publications page (correct URL had case-sensitive filename `11380_Data_and_Programs.zip`, not the lowercase variant the page first redirects from). The archive contains the author's full pipeline (`replication_files/`): raw Excel z-Tree exports under `originals/`, intermediate Stata datasets under `elaborations/` (`data.dta`, `graphs.dta`, `subjects_data_ready.dta`, `globals.dta`), the master analysis script `data_analysis.do`, the `prepare_dataset.do` utility called from inside it, plus strategy-estimation MATLAB code and z-Tree treatment files. README is `ReadMe.pdf`.

4. **Reproduction commands.** Wrote `run_pushbutton.do` containing the verbatim Table III block from `data_analysis.do` lines 207–223 (clustered OLS plus the bootstrap-SE re-estimation). It loads the author-shipped `subjects_data_ready.dta`, calls the author's `prepare_dataset.do` to build the controls macro and the dummy variables, restricts to `condition<5` (drops the variable-deterministic treatment, which is what the paper's Table III specification does), collapses by `Subject session`, then runs the regression. Command:
   `/usr/local/bin/stata-mp -b do run_pushbutton.do`
   Runtime: ~5 s. No analysis-logic edits — only the wrapper script removes unrelated do-file machinery (folder creation, other tables) and re-uses the dataset the author shipped. Counts as Push Button under the modification policy (no logic touched).

5. **Stochastic diagnostics.** The bootstrap is `reps(100) seed(100) cluster(session)`. Modern Stata reports "One or more parameters could not be estimated in 38 bootstrap replicates; standard-error estimates include only complete replications." So the SE printed in the paper (3.830) and the SE printed by my run (3.415) come from different effective replication counts. The 100-rep nominal MC SE on a regression coefficient is not directly relevant to the sub-outcomes graded by the rubric (coefficient and p<0.001 threshold), both of which reproduce precisely. The effective sample of 62 replicates can shift the bootstrap variance estimate noticeably, which is the most likely source of the paper-vs-reproduced SE gap.

6. **Classification.** Paper-precision rounding: -17.79899 rounds to -17.799 at 3 decimals → precise. p-value: posted code uses bootstrap with cluster, paper threshold "p<0.001" reproduced as p≈0.000 → precise (one-sided threshold, more-significant is fine). N: 192 → precise. ser_method effect size = the coefficient → precise. Overall: precise.

## Diagnostics — author-bug analysis

No logic-level bug identified. One environment/version note worth recording (does not affect the headline verdict, which is precise without any patching):

- **Behaviour observed:** modern Stata's `bootstrap` drops 38/100 replicates because the regressor matrix is occasionally rank-deficient when resampling 8 session-level clusters with 22 covariates. The author's posted seed (100) and rep count (100) thus produce a 62-replicate empirical SE today.
- **Likely explanation:** older Stata `bootstrap` may have either swallowed those replicates silently or produced different draws under a different RNG. Without the author's exact Stata version, the SE can't be matched.
- **No patch applied.** The headline coefficient and threshold p-value are insensitive to this; no fix would change the verdict.
- **Confidence:** medium. The replicate-drop message is unambiguous; the underlying RNG/version drift is the most parsimonious explanation for the SE gap.

## Files in this folder
- `VBx1.pdf` — paper PDF (copy)
- `VBx1.txt` — `pdftotext -layout` output
- `replication.zip` — original Econometrica replication archive
- `replication_files/` — extracted archive (Stata datasets, do-files, MATLAB, z-Tree, originals)
- `run_pushbutton.do` — wrapper that runs the verbatim Table III block on the author's `subjects_data_ready.dta`
- `run_pushbutton.log` — Stata batch log
- `REPRODUCTION_REPORT.md` — this report
- `VBx1_summary_rows.csv` — one-row summary
