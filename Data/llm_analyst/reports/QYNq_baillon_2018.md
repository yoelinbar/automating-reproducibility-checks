# Reproduction Report — Baillon, Huang, Selim, Wakker (2018), "Measuring Ambiguity Attitudes for All (Natural) Events"

**Paper:** Baillon, A., Huang, Z., Selim, A., & Wakker, P. P. (2018). Measuring Ambiguity Attitudes for All (Natural) Events. *Econometrica*, 86(5), 1839-1858. https://doi.org/10.3982/ECTA14370

**Paper IDs:** paper_id=QYNq; claims=[QYNq_single-trace]
**Reproduction type:** Source Data Reproduction (only raw `dataset.csv` + experimental stimuli were posted; no analysis code)
**Headline verdict (unpatched):** **precise**
**Verdict if patched (only if applicable):** N/A — no patch needed

## Headline

The reproduction matches the paper exactly to printed precision. Re-implementing the SUR/OLS analysis from the posted raw data on the 99-subject (198-observation) analytic sample yields the Table V Model 1 "Part 1 * TP treatment" coefficient of **0.1895** (paper: 0.19), clustered SE **0.089** (paper: 0.09), p = 0.034 (paper: p < 0.05), N = 198 (paper: 198). The descriptive statistics in Table III also match to printed precision (e.g. mean a Part 1 TP = 0.339 vs paper 0.34; mean a Part 1 control = 0.150 vs paper 0.15). The paper's Wald chi2 of 16.19 reproduces as 15.94 from clustered OLS (SUR without cluster gives 6.82; the paper combines SUR with cluster-robust SEs, which standard `sureg` does not natively expose — exact replication of this single chi2 would require a bootstrapped or system-cluster computation). This 1.5% gap on a non-focal joint test does not affect the headline verdict.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| QYNq_single-trace | Coefficient (Part 1 * TP) | 0.19 | 0.1894737 | 0.1895 (rounds to 0.19) | precise = 0.19; approx = [0.1615, 0.2185] | **precise** |
| QYNq_single-trace | Test stat (t) | — (paper prints "0.19*"; extracted from coef/SE) | 2.111111 | 2.12 (clustered OLS) / 2.15 (SUR clustered) | n/a — no t-stat printed for this row in paper text/table; extraction is derived | **non-outcome** (paper printed only "*" significance star) |
| QYNq_single-trace | p-value | p < 0.05 (one star) | 0.05 (less-than) | 0.034 (clustered OLS) / 0.032 (SUR) | precise: ≤ 0.05; approx: (0.05, 0.10] | **precise** |
| QYNq_single-trace | Sample size (N) | 198 | 198 | 198 | precise: 198; approx: [169, 227] | **precise** |
| QYNq_single-trace | Effect size | — | NaN | n/a | n/a | **non-outcome** |
| QYNq_single-trace | (Auxiliary) Standard error | 0.09 | 0.0885877 | 0.089 (rounds to 0.09) | precise: 0.09 | matches |

**Overall verdict (unpatched):** **precise** — every reported sub-outcome matches the paper to printed precision.

Note on the test-statistic row: the paper's Table V row reports only the coefficient (0.19) with the SE (0.09) in parentheses and a single significance star. The t-statistic is not numerically printed in the paper text or table; the extracted `orig_stat_value` of 2.111 was derived as 0.19/0.09 = 2.11. Per the rubric ("eligible original values are numeric in the paper's text/tables"), I treat this as a non-outcome for headline rubric purposes — but for completeness, the reproduced t (2.12 clustered OLS) is well within 15% of the derived 2.11.

## What I did

1. **Set-up.** Created `independent_reproductions/QYNq_baillon_2018/`. Copied `papers/QYNq.pdf` in. Ran `pdftotext -layout` for searchable text.

2. **Extraction check.** The claim references Table V, Model 1, "Part 1 * TP treatment" row (paper p. 1849, line 514 of `QYNq.txt`). Paper prints: 0.19* with SE (0.09) in parentheses. Stars footnote: "* p < 0.05". N row prints 198. Chi2 row prints 16.19***. Extracted values: coef 0.1895 (=19/100 = 0.19 reported), SE 0.0886 (≈0.09), p<0.05, N 198. Coefficient 0.1894737 in CSV is more precision than printed; this matches my reproduced 0.18947368... exactly to 5 decimals — strongly suggesting whoever extracted it back-computed from the regression. Headline rubric uses the paper's printed value 0.19.

3. **Data/code source.** The Econometrica web page for the paper has no supplementary materials link; Wiley's page is behind Cloudflare 403. The data and code are hosted on **Peter Wakker's personal website** at Erasmus Rotterdam: `http://personal.eur.nl/wakker/data/18.1amb.natural/links.htm`. Downloaded `amb.natural.dataset.zip` (raw CSV + codebook PDF) and `amb.natural.stimuli.zip` (PHP experiment files). **No analysis script (Stata/R/SAS) was archived** — only the raw subject-by-subject matching probabilities. Hence Source Data Reproduction.

4. **Reproduction.** Implemented in Python (`run_sourcedata.py`) and Stata (`run_pushbutton.do`). Both follow the paper's Section 3 "Analysis" verbatim:
   - Drop 5 subjects in the TP treatment with any `partXmYmissing == 1`. After exclusion: 99 subjects (42 control + 57 TP), 198 observations long.
   - Compute `ms = (m1+m2+m3)/3`, `mc = (m12+m13+m23)/3` (Definition 2.1 / 2.2; matching probabilities divided by 100 since stored as percentages).
   - Compute index `a = 3*(1/3 − (mc − ms))` for each part.
   - Reshape to long (one row per subject × part, 198 rows).
   - Reference group: Part 1 control. Three dummies: `p1_tp`, `p2_ctrl`, `p2_tp`.
   - Estimate OLS / SUR with cluster-robust SE at SubjectId.
   - Commands run: `python3 run_sourcedata.py` and `stata-mp -b do run_pushbutton.do`. Runtime <10 s each.

5. **Stochastic-method diagnostics.** None — the analysis is deterministic OLS/SUR.

6. **Classification.** Reproduced coef 0.1895 → rounds to 0.19 → matches paper 0.19 exactly → **precise**. SE 0.089 → rounds to 0.09 → matches 0.09 → **precise**. p = 0.034 ≤ 0.05 → **precise** (threshold rule, more significant is fine). N = 198 → matches → **precise**. Overall: **precise**.

## Diagnostics — author-bug analysis

**Diagnostics: none — unpatched run reproduces exactly. No logic bug suspected.**

The only minor numeric discrepancy is the joint Wald chi2 for Model 1: paper reports 16.19, my clustered-OLS Wald gives 15.94 (1.5% difference). This is on the joint test of all three dummies, not on the focal "Part 1 * TP" coefficient. The discrepancy likely stems from how SUR-with-clustering computes the joint Wald: standard Stata `sureg` does not support `vce(cluster)` natively (its non-clustered SUR gives chi2 = 6.82, which is wrong). The paper presumably used a bootstrapped or system-clustered chi2. Replicating this exact statistic would require a bootstrap (~1000 reps), which does not change the focal coefficient/SE/p-value reproduction and so is not pursued here. **Not a bug — just a non-standard combination of estimator and cov estimator that needs hand-computation.**

Also reproduced (sanity check) — Table III descriptive statistics:

| Stat | Paper | Reproduced |
|---|---|---|
| a Part 1 control mean | 0.15 | 0.150 |
| a Part 1 TP mean | 0.34 | 0.339 |
| a Part 2 control mean | 0.17 | 0.170 |
| a Part 2 TP mean | 0.17 | 0.168 |
| b Part 1 control mean | -0.07 | -0.066 |
| b Part 1 TP mean | -0.09 | -0.089 |

All match to printed precision.

## Files in this folder

**Source data and stimuli (downloaded from Wakker's site):**
- `amb.natural.dataset.zip` — raw data zip
- `dataset.csv` — 104 subjects × 100 columns (matching probabilities, times, ranks, missing flags)
- `codebook.pdf`, `codebook.txt` — variable codebook
- `amb.natural.stimuli.zip` — experimental PHP files
- `TP stimuli/` — unzipped PHP experiment files (not used in analysis)

**Reproduction artifacts (unpatched):**
- `run_sourcedata.py` — Python re-implementation (statsmodels OLS clustered + linearmodels SUR clustered)
- `run_sourcedata.log` — Python output (full Table V Model 1 & Model 2; Table III descriptives; SUR system)
- `run_pushbutton.do` — Stata re-implementation (`sureg`, `regress ..., vce(cluster sid)`)
- `run_pushbutton.log` — Stata output

**Paper artifacts:**
- `QYNq.pdf` — paper PDF
- `QYNq.txt` — pdftotext output

**Diagnostic artifacts:** None (no patch tried).
