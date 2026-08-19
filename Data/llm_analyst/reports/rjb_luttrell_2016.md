# Reproduction Report — Luttrell (2016), Ambivalence × Certainty Interaction Predicts Attitude Stability

**Paper:** Luttrell, A., Petty, R. E., & Briñol, P. (2016). Ambivalence and certainty can interact to predict attitude stability over time. *Journal of Experimental Social Psychology*, 63, 56–68. https://doi.org/10.1016/j.jesp.2015.11.008
**Paper IDs:** paper_id=rjb; claims=[rjb_m71nkm, rjb_bz1ddg, rjb_gl9nvg]
**Reproduction type:** Push Button (only environment-only edits — `setwd()` path and renamed `source()` filename due to space-in-filename)
**Headline verdict (unpatched):** precise

## Headline
All three claims reproduce precisely. Author's R scripts on author's OSF data (osf.io/5ukds) produce coefficients, t-statistics, p-values, sample sizes and confidence intervals matching the published paper to the printed precision. Study 1 interaction: B=0.0372 → .04, t(169)=2.282, p=.0237, CI [.005, .069], N=174. Study 2 interaction: B=0.0745 → .07, t(130)=3.418, p<.001, CI [.031, .118], N=135. Study 2 simple effect at high certainty (claim 3): B=0.130, t(130)=3.117, p=.002, CI [.048, .213], matches paper's [.05, .21] B=.13, t=3.12, p=.002. No deviations to report.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| rjb_m71nkm (S1) | coef (B) | .04 | 0.04 | 0.0372 → .04 | precise: rounds to .04 | precise |
| rjb_m71nkm (S1) | t stat | 2.28 | 2.28 | 2.282 → 2.28 | precise: rounds to 2.28 | precise |
| rjb_m71nkm (S1) | p (exact) | .02 | 0.02 | 0.0237 → .02 | precise: rounds to .02 | precise |
| rjb_m71nkm (S1) | sample size | 174 | 174 | 174 | precise | precise |
| rjb_bz1ddg (S2 interaction) | coef (B) | .07 | 0.07 | 0.0745 → .07 | precise: rounds to .07 | precise |
| rjb_bz1ddg (S2 interaction) | t stat | 3.42 | 3.42 | 3.418 → 3.42 | precise: rounds to 3.42 | precise |
| rjb_bz1ddg (S2 interaction) | p (threshold p<.001) | <.001 | 0.001 | 0.000844 ≤ .001 | precise (≤ threshold) | precise |
| rjb_bz1ddg (S2 interaction) | sample size | 135 | 135 | 135 | precise | precise |
| rjb_gl9nvg (S2 interaction stat) | coef (B) | .07 | 0.07 | 0.0745 → .07 | precise | precise |
| rjb_gl9nvg (S2 interaction stat) | t stat | 3.42 | 3.42 | 3.418 → 3.42 | precise | precise |
| rjb_gl9nvg (S2 interaction stat) | p (threshold p<.001) | <.001 | 0.001 | 0.000844 ≤ .001 | precise | precise |
| rjb_gl9nvg (S2 interaction stat) | sample size | 135 | 135 | 135 | precise | precise |

Claim 3's `claim_result_text` additionally narrates the high-certainty simple effect (B=.13, t(130)=3.12, p=.002, CI [.05, .21]). The reproduced simple-effect model returns B=0.130, t(130)=3.117, p=.0023, CI [.048, .213] — also precise to printed precision. The extracted `orig_*` columns target the interaction (B=.07/t=3.42), so the rubric is applied to those values.

**Overall verdict per claim:** all `precise`.

## What I did

1. **Set-up.** Created `independent_reproductions/rjb_luttrell_2016/`, copied `papers/rjb.pdf`, ran `pdftotext -layout` to `rjb.txt`.

2. **Extraction check.** Verified all `orig_*` values against the paper text:
   - Claim 1 (rjb_m71nkm): page 6, Study 1 results section: *"there was a significant certainty × objective ambivalence interaction, B = .04, t(169) = 2.28, p = .02, 95% CI: [.01, .07]"*. Sample size N=174 (T2 follow-up) is stated on page 6: *"sures (N = 174)"*. Matches extracted values exactly.
   - Claim 2 (rjb_bz1ddg): page 6, Study 2 results section: *"there was a significant certainty × objective ambivalence interaction, B = .07, t(130) = 3.42, p < .001, 95% CI: [.03, .12]"*. N=135 stated page 6. Matches.
   - Claim 3 (rjb_gl9nvg): identical interaction stats (B=.07, t(130)=3.42, p<.001) plus a simple effect at +1 SD certainty (B=.13, t(130)=3.12, p=.002, CI [.05, .21], page 7). Matches.

3. **Data/code source.** Found OSF project 5ukds via OSF API search. Downloaded via OSF download links: `Study1Data.csv`, `Study2Data.csv`, `Study1Analysis.R`, `Study2Analysis.R`, `display_lm function.R` (renamed locally to `display_lm_function.R` to remove the space).

4. **Reproduction commands.**
   ```
   Rscript run_study1.R > run_study1.log 2>&1
   Rscript run_study2.R > run_study2.log 2>&1
   ```
   Each `run_*.R` is a thin wrapper over the author's analysis script with two **environment-only** edits: (a) changed `setwd()` to the local path; (b) `source("display_lm function.R")` → `source("display_lm_function.R")` because the local file name was renamed (the space in the original filename can be problematic). No analysis logic was touched. Runtime <30s per script.

5. **Stochastic-method diagnostics.** Not applicable — purely OLS, deterministic.

6. **Classification.** Bounds applied to paper's printed precision per the rubric:
   - Coefficients printed to 2 decimals (.04, .07, .13): reproduced 0.037, 0.075, 0.130 round to .04, .07, .13 → precise.
   - t printed to 2 decimals (2.28, 3.42, 3.12): reproduced 2.282, 3.418, 3.117 round to 2.28, 3.42, 3.12 → precise.
   - p exact (.02): reproduced .024 rounds to .02 → precise. p threshold (<.001): reproduced .000844 ≤ .001 → precise. Simple-effect p (.002): reproduced .0023 rounds to .002 → precise.
   - N: 174 and 135 reproduce exactly.
   - 95% CIs all match to printed precision.

   All sub-outcomes precise → overall **precise** for every claim.

## Diagnostics — author-bug analysis
Diagnostics: none — unpatched run reproduces; no logic bug suspected. Author posted clean, well-documented R scripts with self-contained data; everything runs out of the box modulo `setwd()`.

## Files in this folder
- `rjb.pdf` — paper PDF (copied from `papers/`)
- `rjb.txt` — `pdftotext -layout` output
- `Study1Data.csv`, `Study2Data.csv` — author's data from OSF 5ukds
- `Study1Analysis.R`, `Study2Analysis.R` — author's original analysis scripts (unmodified)
- `display_lm_function.R` — author's helper function (renamed from `display_lm function.R`)
- `run_study1.R`, `run_study2.R` — thin wrappers (environment-only edits) used to drive the analyses
- `run_study1.log`, `run_study2.log` — Rscript output
- `REPRODUCTION_REPORT.md` — this file
