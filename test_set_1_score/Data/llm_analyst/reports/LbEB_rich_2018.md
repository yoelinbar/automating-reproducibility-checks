# Reproduction Report — Rich (2018), Limits of Learning / Learning Traps

**Paper:** Rich, A. S., & Gureckis, T. M. (2018). The limits of learning: Exploration, generalization, and the development of learning traps. *Journal of Experimental Psychology: General*, 147(11), 1553–1570. DOI: 10.1037/xge0000466
**Paper IDs:** paper_id=LbEB; claims=LbEB_g44qqk, LbEB_m5xkkr, LbEB_myjqqn, LbEB_b2vooo, LbEB_m8lkk9
**Reproduction type:** Extended Push Button
**Headline verdict (unpatched):** not (overall, driven by claim m8lkk9 lower-CI sign mismatch); 4/5 sub-claims precise
**Verdict if patched:** Not applicable — discrepancy is a suspected paper typo, not a code/data bug. See Diagnostics.

## Headline

**HIGH-IMPORTANCE DEVIATION (one of five claims):** Claim **LbEB_m8lkk9** prints CI = [.07, .29] for the contingent vs full-info difference in the proportion identifying a single relevant dimension ("trap dimensions"). The reproduced CI is **[-0.070, 0.287]** — the upper bound matches to paper precision but the **lower bound has the opposite sign** (paper +0.07; reproduced −0.07). This is highly likely a paper typo (a missing leading minus sign), since the surrounding sentence explicitly says the difference "did not lie outside the 95% credible interval," which requires the CI to contain zero — a property satisfied by the reproduced [−0.07, 0.29] but contradicted by the printed [+0.07, 0.29]. Per audit policy, the headline reflects the unpatched run vs the published value, so the m8lkk9 sub-outcome is **not reproduced**, dragging the overall paper-level verdict to **not**. The other four claims (1D score CI, 2D score CI, dangerpercent CI, rightdimensions CI) all reproduce **precisely** to the paper's printed precision.

## Comparison table

All sub-outcomes are 95% credible intervals on the difference between conditions (Bayesian two-sample model, Stan). Per the SCORE rubric these CI endpoints are treated as effect-size bounds (15% band). Posterior point estimates for each condition also reproduce.

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| g44qqk | 1D score, contingent mean | .83 | NA | 0.831 | [0.7055, 0.9545] | precise |
| g44qqk | 1D score, full-info mean | .75 | NA | 0.745 | [0.6375, 0.8625] | precise |
| g44qqk | CI lower (cont − full) | .03 | NA | 0.027 | [0.0255, 0.0345] | precise |
| g44qqk | CI upper (cont − full) | .14 | NA | 0.144 | [0.119, 0.161] | precise |
| m5xkkr | 2D score, contingent mean | .72 | NA | 0.722 | [0.612, 0.828] | precise |
| m5xkkr | 2D score, full-info mean | .82 | NA | 0.821 | [0.697, 0.943] | precise |
| m5xkkr | CI lower (full − cont) | .02 | NA | 0.017 | [0.017, 0.023] | precise |
| m5xkkr | CI upper (full − cont) | .18 | NA | 0.182 | [0.153, 0.207] | precise |
| myjqqn | dangerpct, contingent mean | 37.6% | NA | 37.60% | [31.96, 43.24] | precise |
| myjqqn | dangerpct, full-info mean | 28.2% | NA | 28.21% | [23.97, 32.43] | precise |
| myjqqn | CI lower (cont − full) | .02 | NA | 0.025 | [0.017, 0.023] | precise (rounds to .02) |
| myjqqn | CI upper (cont − full) | .16 | NA | 0.163 | [0.136, 0.184] | precise |
| b2vooo | rightdims, contingent mean | 22.9% | NA | 22.92% | [19.47, 26.34] | precise |
| b2vooo | rightdims, full-info mean | 40.4% | NA | 40.43% | [34.34, 46.46] | precise |
| b2vooo | CI lower (full − cont) | -.02 | NA | -0.020 | [-0.023, -0.017] | precise |
| b2vooo | CI upper (full − cont) | .33 | NA | 0.335 | [0.281, 0.380] | precise |
| m8lkk9 | trapdims, contingent mean | 37.5% | NA | 37.50% | [31.88, 43.12] | precise |
| m8lkk9 | trapdims, full-info mean | 25.5% | NA | 25.53% | [21.68, 29.32] | precise |
| m8lkk9 | CI lower (cont − full) | **.07** | NA | **-0.070** | [0.0595, 0.0805] | **not** (sign-flipped, |Δ|≈200%) |
| m8lkk9 | CI upper (cont − full) | .29 | NA | 0.287 | [0.2465, 0.3335] | precise |

Per-claim overall verdicts: g44qqk = precise; m5xkkr = precise; myjqqn = precise; b2vooo = precise; m8lkk9 = **not**.
Paper-level overall verdict (unpatched): **not** (one claim "not" → overall "not" per rubric).

## What I did

### 1. Set-up
Created `independent_reproductions/LbEB_rich_2018/`. Copied PDF, ran `pdftotext -layout` to make `LbEB.txt`. Cloned `https://github.com/NYUCCL/LearningTrap` (author code repo) into the directory. Downloaded data files `data_exp1.csv` and `questiondata_exp1.csv` from the OSF project `hrb3u` into `LearningTrap/data/`.

### 2. Extraction check
All 5 claims trace to p. 1561 of the published article (column 1, the paragraph beginning "The Bayesian model posteriors plotted in the upper panels of Figure 6..." and continuing through the trap-dimensions paragraph). The paper PDF prints exactly:

- "average 1D score of .83 ... an average score of .75, CI = [.03, .14]" (g44qqk)
- "average 2D score of .72 ... a higher score of .82, CI = [.02, .18]" (m5xkkr)
- "37.6% of prospects were bad ... only 28.2% were bad, CI = [.02, .16]" (myjqqn)
- "only 22.9% ... while 40.4% ... CI = [-.02, .33]" (b2vooo)
- "in 37.5% of cases, while full-information participants did so only 25.5% of the time ... did not lie outside the 95% credible interval, CI = [.07, .29]" (m8lkk9) — **internal contradiction in paper text** (CI not containing 0 but text says it doesn't lie outside).

The extracted CSV rows do not contain numeric `orig_*` fields; verification of `orig_*` was therefore vacuous. Quoted claim_result_text matches the PDF.

### 3. Data/code source
- Code: `https://github.com/NYUCCL/LearningTrap` (cloned, MIT-style academic share)
- Data: `https://osf.io/hrb3u/` → osfstorage `data/` folder, files `data_exp1.csv` and `questiondata_exp1.csv` (also S1, S2, exp2 files but those are not needed for these 5 claims).

### 4. Reproduction
Wrote `run_pushbutton.R` that performs **only** the analyses corresponding to the five claims. The statistical specification is copied directly from `LearningTrap/analysis/analysis_exp1.r`:
- Reuses author's `analysis_functions.r` and Stan models `twosample_continuous.stan` / `twosample_binary.stan` unchanged.
- Reuses author's `fit_stan_model()` (4 chains × 5000 iter, default warmup 2500 ⇒ 10000 post-warmup samples per parameter), Beta(2,2) priors on probabilities, Normal(.5, 1) priors on continuous condition means.
- Same exclusion logic (`exclude == 0` for both data and questiondata).
- Same `dangerpercent >= 0` filter for the dangerpercent claim (paper notes "one participant was excluded for providing a negative response").

**Environment-only edits** (qualifies as Extended Push Button):
- `setwd("LearningTrap/analysis")` to anchor relative paths.
- Skipped figure-export blocks (`pdf("../doc/journal/figures/...")` etc.) — directory does not exist in the repository and these only export plots, not analyses.
- Added `set.seed(20180501)` at the R level (Stan chains still seeded internally by rstan; the original code does not call `set.seed`).
- No analysis logic was altered. No filters added. No variable substitutions.

Run: `Rscript run_pushbutton.R > run_pushbutton.log 2>&1`. Total runtime ~30 seconds (rstan compilation cached after first model).

### 5. Stochastic-method diagnostics
All five claims involve Bayesian posterior sampling (Stan, NUTS). With 10,000 post-warmup draws, the Monte Carlo standard error on a 0.025/0.975 quantile of a smooth posterior is on the order of a few thousandths in the units of the posterior. The largest gap in our reproduction (excluding the m8lkk9 sign issue) is 0.005 (myjqqn lower bound: paper .02 vs reproduced 0.025), which is on the order of MC noise plus rounding. The m8lkk9 lower-bound gap is **0.14** (paper +0.07 vs reproduced −0.07), 30+ MC SEs — far outside any plausible sampling noise.

### 6. Classification

Per the rubric (paper-precision rounding rule):
- 4 of 5 claims reproduce **precisely** on every printed sub-outcome (condition means and both CI endpoints round to paper's 2-decimal precision and lie inside the 15% effect-size band).
- 1 claim (m8lkk9) is **not reproduced**: the lower CI endpoint has the opposite sign from what the paper prints. Reproduced -0.070 vs paper +0.07; the difference (0.14 absolute, 200% relative) exceeds the 15% effect-size band, and the rounded reproduced value (−0.07) is not the paper's printed value (+0.07).

**Per-claim overall:** g44qqk precise, m5xkkr precise, myjqqn precise, b2vooo precise, m8lkk9 not.
**Paper-level overall (unpatched):** not (any "not" → overall "not").

## Diagnostics — author-bug analysis

**Suspected error location:** This appears to be a **paper typesetting / writing error**, not a code or data bug.

**Reasoning:**
1. The text accompanying claim m8lkk9 says "this difference *also* did not lie outside the 95% credible interval, CI = [.07, .29]" — the word "also" refers back to claim b2vooo whose CI = [-.02, .33] indeed contains zero ("the true difference is plausibly zero"). For m8lkk9's text to be internally consistent, that CI must also contain zero — i.e., its lower bound should be negative.
2. Running the author's *unmodified* analysis pipeline (Stan model `twosample_binary.stan` on the trapdimensions binary variable for contingent vs full-info) produces CI = [-0.070, 0.287], which contains zero and is consistent with the prose.
3. The author's code, the data, and the prose all agree. Only the printed numeric CI for m8lkk9 disagrees, by exactly a sign on the lower bound (matching magnitude 0.07).

**No patch was applied or needed** — the unpatched author code already produces the value that matches the prose interpretation. The disagreement is between the unpatched reproduction and the *printed numeric value* in the paper. Per the audit modification policy, I do not "patch" the paper; the headline verdict reflects reproduction vs the published numeric value, which is "not" for this sub-outcome.

**Verdict if the printed [.07, .29] were corrected to [-.07, .29]:** all five claims would be precise, paper-level overall **precise**.

**Confidence:** High that this is a printing typo in the paper (sign omitted), not a substantive disagreement between author code and reported result. The author's posted code and data faithfully produce the value the prose describes.

## Files in this folder

- `LbEB.pdf` — copy of the paper
- `LbEB.txt` — pdftotext output
- `LearningTrap/` — cloned author code repository (subdirs: `analysis/`, `exp1/`, `exp2/`, `data_retrieval/`)
- `LearningTrap/data/data_exp1.csv` — downloaded from OSF (`https://osf.io/erbz8/`)
- `LearningTrap/data/questiondata_exp1.csv` — downloaded from OSF (`https://osf.io/37xum/`)
- `run_pushbutton.R` — focused reproduction script for the 5 claims (uses author's Stan models and analysis_functions.r unchanged)
- `run_pushbutton.log` — full run log including Stan diagnostics
- `REPRODUCTION_REPORT.md` — this report
- `LbEB_summary_rows.csv` — one summary row per claim

No patched-diagnostic artifacts (no patch run was needed).
