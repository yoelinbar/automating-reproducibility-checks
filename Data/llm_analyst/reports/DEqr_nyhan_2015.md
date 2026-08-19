# Reproduction Report — Nyhan & Reifler (2015), "Displacing Misinformation about Events"

**Paper:** Nyhan, B., & Reifler, J. (2015). "Displacing Misinformation about Events: An Experimental Test of Causal Corrections." *Journal of Experimental Political Science*, 2(1), 81-93. DOI: 10.1017/xps.2014.22
**Paper IDs:** paper_id=DEqr; claims=DEqr_blw3kn, DEqr_m638d7, DEqr_g3p87v, DEqr_gwlq2q, DEqr_gpjxk5, DEqr_mqnzyy
**Reproduction type:** Push Button
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A — no patches needed

## Headline
All six claims reproduce precisely. Running Nyhan & Reifler's posted Stata do-file `nyhan-reifler-causal-corrections.do` against the posted dataset `causal-replication.dta` reproduces every Table 2 coefficient and `lincom` contrast cited in the results section to the paper's printed precision (2 decimals), with sample sizes exactly matching (987 / 986 / 764) and p-values satisfying every reported threshold. No environment edits, no logic patches.

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| DEqr_blw3kn (Model 1, denial vs control) | coef | -0.39 | -0.39 | -0.3895 → -0.39 | [-0.4485, -0.3315] (±15%) | precise |
| DEqr_blw3kn | p-value | <0.01 | 0.01 | 0.000 | precise if ≤0.01; approx (0.01,0.06]; not >0.06 | precise |
| DEqr_blw3kn | N | 987 | 987 | 987 | [839, 1135] (±15%) | precise |
| DEqr_m638d7 (Model 2, denial vs control, svy weights) | coef | -0.41 | -0.41 | -0.4098 → -0.41 | [-0.4715, -0.3485] | precise |
| DEqr_m638d7 | p-value | <0.01 | 0.01 | 0.006 | precise if ≤0.01 | precise |
| DEqr_m638d7 | N | 987 | 987 | 987 | [839, 1135] | precise |
| DEqr_g3p87v (Model 3, causal vs denial, lincom) | coef | -0.48 | -0.48 | -0.4813 → -0.48 | [-0.552, -0.408] | precise |
| DEqr_g3p87v | p-value | <0.01 | 0.01 | 0.000 | precise if ≤0.01 | precise |
| DEqr_g3p87v | N | 986 | 986 | 986 | [838, 1134] | precise |
| DEqr_gwlq2q (Model 4, causal vs denial, svy lincom) | coef | -0.36 | -0.36 | -0.3583 → -0.36 | [-0.414, -0.306] | precise |
| DEqr_gwlq2q | p-value | <0.05 | 0.05 | 0.012 | precise if ≤0.05 | precise |
| DEqr_gwlq2q | N | 986 | 986 | 986 | [838, 1134] | precise |
| DEqr_gpjxk5 (Model 5, causal vs denial, lincom) | coef | -0.34 | -0.34 | -0.3352 → -0.34 | [-0.391, -0.289] | precise |
| DEqr_gpjxk5 | p-value | <0.01 | 0.01 | 0.000 | precise if ≤0.01 | precise |
| DEqr_gpjxk5 | N | 764 | 764 | 764 | [649, 879] | precise |
| DEqr_mqnzyy (Model 6, causal vs denial, svy lincom) | coef | -0.16 | -0.16 | -0.1624 → -0.16 | [-0.184, -0.136] | precise |
| DEqr_mqnzyy | p-value | <0.12 | 0.12 | 0.112 | precise if ≤0.12 | precise |
| DEqr_mqnzyy | N | 764 | 764 | 764 | [649, 879] | precise |

All extracted values match the paper text exactly.

## What I did

1. **Set-up.** Created `independent_reproductions/DEqr_nyhan_2015/`, copied `papers/DEqr.pdf` in, ran `pdftotext -layout DEqr.pdf DEqr.txt`.

2. **Extraction check.** Re-read p. 7 (favorable outcome, Models 1–2) and pp. 9–10 (bribes outcome, Models 3–4; investigation outcome, Models 5–6). Table 2 (p. 8) gives Innuendo, Denial, Causal coefficients and N for each of the six models. The text quotes:
   - p. 7 (DEqr_blw3kn): "(−0.39 ... p < 0.01)" denial coef, Model 1, N=987 — confirmed in Table 2.
   - p. 7 (DEqr_m638d7): "(−0.41, p < 0.01)" denial coef, Model 2, N=987 — confirmed.
   - p. 9 (DEqr_g3p87v): "(-0.48, p < 0.01 using results from Model 3)" — this is the lincom causal–denial contrast on the bribes outcome (the paper reports it in text only; verified the Table 2 individual coefs are consistent).
   - p. 9 (DEqr_gwlq2q): "(-0.36, p < 0.05 using Model 4)" — lincom causal–denial, bribes outcome, survey weights.
   - p. 9–10 (DEqr_gpjxk5): "−0.34, p < 0.01 using results from Model 5" — lincom causal–denial, investigation outcome, IPW.
   - p. 10 (DEqr_mqnzyy): "−0.16, p < 0.12 using Model 6" — lincom causal–denial, investigation outcome, survey weights.
   All `orig_*` values in `paper_claims/DEqr.json` match the paper's printed text and Table 2 exactly.

3. **Data/code source.** Brendan Nyhan's Dartmouth publications page (`sites.dartmouth.edu/nyhan/publications/`) links the replication zip:
   `https://sites.dartmouth.edu/nyhan/files/2021/03/nyhan-reifler-jeps.zip`
   Contents: `causal-replication.dta`, `nyhan-reifler-causal-corrections.do`.

4. **Reproduction commands.**
   ```
   cd "JEPS replication"
   /usr/local/bin/stata-mp -b do nyhan-reifler-causal-corrections.do
   ```
   Runtime: a few seconds. The do-file completed all Table 2 regressions and `lincom` calls successfully under Stata/MP 16.0 with no environment edits. It later errored on a `putexcel ... using jepsbalance` call (Stata 13+ syntax issue with the destination) for the appendix balance tables, but the headline regressions had all completed before that point and are not affected. **No edits to the do-file were made; the failure is in code that does not produce any of the six claims' numbers.**

5. **Stochastic-method diagnostics.** None — all OLS, deterministic.

6. **Classification.** All six claims: every reported sub-outcome (coefficient, p-value threshold, sample size) is `precise`. Reproduced coefs round to the paper's 2-decimal value exactly; reproduced p-values are at or below every reported threshold; Ns exact. Overall verdict per claim: **precise**.

## Diagnostics — author-bug analysis
Diagnostics: none — unpatched Push Button reproduces all six claims precisely. The terminal `putexcel` failure is in the appendix balance-table generation and is unrelated to any of the six audited claims; no logic bug suspected in the headline analysis.

## Files in this folder
- `DEqr.pdf` — paper
- `DEqr.txt` — pdftotext output
- `nyhan-reifler-jeps.zip` — downloaded replication archive
- `JEPS replication/causal-replication.dta` — author's data
- `JEPS replication/nyhan-reifler-causal-corrections.do` — author's do-file (run unmodified)
- `JEPS replication/nyhan-reifler-causal-corrections.log` — Stata batch log of the unpatched run (contains all six claim numbers)
- `JEPS replication/fig1.eps`, `fig2.eps`, `fig3.eps` — figures generated by the do-file (incidental)
- `REPRODUCTION_REPORT.md` — this report
- `DEqr_summary_rows.csv` — per-claim summary (parent-directory deliverable)
