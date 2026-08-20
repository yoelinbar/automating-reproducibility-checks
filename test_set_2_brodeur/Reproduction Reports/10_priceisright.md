# Reproduction Report — *Taste-Based Gender Favouritism in The Price Is Right* (Economic Journal, 2024)

**Assigned exhibit:** Table 1, column 6 (Likelihood of Cutting off the Perceived Lead Based on Gender Match — model with the Male × Gender match interaction).
**Package language:** R. **Estimator:** `lfe::felm` (OLS linear probability model with round + gender-composition fixed effects, default iid SEs).

---

## Headline (per reporting policy)

**The assigned exhibit reproduces EXACTLY to displayed precision** — all five coefficients, all five SEs, N, and adjusted R². **No reproduction discrepancy of any severity (Critical / High / Moderate) was found for Table 1, column 6.**

Separately, two documentation/code issues were found that do **not** affect the assigned exhibit's numbers (details in Task 2).

---

## TASK 1 — Computational reproduction

Code path of the assigned regression: `Analysis Taste based gender discrimination in TPIR Final EJ.R`, line **199** (`reg_perlead_6`), data built lines 18–199, dependent data object `fData_c4_perceivedlead` restricted to the four "known" gender compositions (`female_female_female`, `female_female_male`, `female_male_male`, `male_male_male`).

Driver used: `/tmp/tpir_c6.R` (script lines 1–199 verbatim, `setwd` repointed; `library(PropCIs)` commented out — unused; the unrelated `stargazer` table-printing call at line 201 fails on the installed stargazer 5.2.3 due to a version bug, but it runs *after* the regression is estimated and does not affect estimates).

| Term | Published (Model 6) | Reproduced | Match |
|---|---|---|---|
| Male | 0.046*** (0.015) | 0.046141 (0.015426) | **Y** |
| Gender match | −0.047*** (0.014) | −0.046748 (0.013857) | **Y** |
| Target value | −0.00002** (0.00001) | −0.0000164 (0.0000064) | **Y** |
| Prior cutoffs | 0.052*** (0.005) | 0.052295 (0.004882) | **Y** |
| Male × Gender match | 0.006 (0.024) | 0.005697 (0.024290) | **Y** |
| Observations | 10,133 | 10,133 | **Y** |
| Adjusted R² | 0.033 | 0.0326 | **Y** |

All point estimates, SEs, N and adj. R² match to the precision displayed in the paper. The interaction term is insignificant, consistent with the paper's text claim of "no compelling evidence for a gender difference in own-gender favouritism."

**Minutes-from-start to successful reproduction: ~2 min** (full reproduction confirmed at minute 2; total session ~3 min).
**Reproduced: YES.**

---

## TASK 2 — Coding errors and irregularities

| # | Issue | Location | Detected (min) | Affects main claims? |
|---|---|---|---|---|
| 1 | **Erroneous variable note in published Table 1.** The Table 1 note states: *"Male is a dummy variable that takes the value of 1 if the fourth bidder is **female**."* The code defines the opposite: `Male = ifelse(gender=="male",1,...)` (Analysis line 115). The estimates are correct under the code definition (Male coef +0.046 ⇒ *men* cut off more), so this is a write-up error in the note's wording, not a numerical error. | Paper, Table 1 Notes (PDF p.863) vs Analysis R line 115 | 2 | **No** — wording only; estimates unaffected and correctly signed/interpreted in the text. |
| 2 | **Dead-code bug: `Cutoff_cumsum_biddinground` is always 0.** Cleaning line 350 reads `Cutoff_cumsum_biddinground := ifelse(Cutoff_main_nona==T, Cutoff_main_nona-1, Cutoff_main_nona)`, which evaluates to 0 for every row (should mirror line 347, subtracting from `Cutoff_cumsum_biddinground`, not from `Cutoff_main_nona`). Verified: the variable has a single unique value (0) in the data. | `Cleaning scraped data.R` line 350 | 3 | **No** — this variable is never referenced in the analysis script (`grep` returns nothing). The "Prior cutoffs" control actually used is `Cutoff_cumsum_episode` (correctly built, range 0–7). |
| 3 | "Prior cutoffs" (`Cutoff_cumsum_episode`) counts cutoffs of the **actual** leader (`Cutoff_main`), while the dependent variable is cutting off the **perceived** leader (`Cutoff_perceived`). Defensible design choice (it is an episode-level count of "real" cutoffs), but the two cutoff concepts differ; flagged for transparency, not an error. | Cleaning lines 280, 346–347; Analysis line 199 | 3 | No. |

Additional verification (no issue found): the perceived-lead position is never ambiguous — 0 of 10,133 estimation rounds have a tie among C1–C3 at the perceived-best bid. The estimation-sample cutoff rate is 48.1%, matching the paper's stated "overall cutoff rate of 48%." Blank-gender fourth bidders (692 of the C4 pool) are correctly dropped.

---

## TASK 3 — Robustness / sensitivity checks (not done by the authors)

Both checks target the validity of the **inference** and **functional form** for column 6. The authors report only iid (homoskedastic) SEs from `felm` with no clustering, despite repeated observations within episodes/contestants.

### Check 1 — Cluster-robust standard errors (by episode, and by fourth bidder)
Same specification as column 6, SEs clustered. Point estimates are identical (clustering only changes SEs).

| Term | Estimate | Paper iid SE | Cluster by Episode | Cluster by 4th bidder |
|---|---|---|---|---|
| Male | 0.04614 | 0.01543 | 0.01565 | 0.01597 |
| Gender match | −0.04675 | 0.01386 | 0.01405 | 0.01480 |
| Target value | −0.0000164 | 0.0000064 | ~0.00001 | ~0.00001 |
| Prior cutoffs | 0.05229 | 0.00488 | 0.00474 | 0.00490 |
| Male × Gender match | 0.00570 | 0.02429 | 0.02409 | 0.02490 |

**Result:** Clustered SEs are essentially unchanged (within a few percent of the iid SEs). Gender match remains significant at p<0.01 (p=0.0009 episode-clustered, p=0.0016 bidder-clustered); the interaction remains insignificant. The paper's inference is robust to clustering.

### Check 2 — Logit (functional-form robustness for a binary outcome)
LPM replaced by a logit with the same covariates and fixed effects entered as dummies.

| Term | Logit coef (z, p) | LPM coef |
|---|---|---|
| Male | 0.190 (z=2.98, p=0.003) | 0.046 |
| Gender match | −0.194 (z=−3.38, p=0.0007) | −0.047 |
| Male × Gender match | 0.023 (z=0.23, p=0.82) | 0.006 |
| Prior cutoffs | 0.217 (z=10.55) | 0.052 |

Average marginal effect of Gender match from the logit = **−0.0447** on the probability scale, essentially identical to the LPM coefficient (−0.047). Signs, significance, and magnitude of the main effect and the (insignificant) interaction are preserved.

**Conclusion (Task 3):** The column-6 result — significant own-gender favouritism with no significant male/female difference in it — is robust to cluster-robust inference and to a logit specification.

---

## Obstacles

- `PropCIs` and `margins` R packages are not installed; neither is needed for column 6 (PropCIs is only used for a CI helper elsewhere; logit AME was computed manually by counterfactual prediction).
- The package's `stargazer` (5.2.3) throws `Error in if (is.na(s))` when formatting Table 1; this is a stargazer/R version incompatibility in the *table-printing* step only and occurs after estimation. Regression objects and all numbers were extracted directly via `summary()`, so it did not impede reproduction.
- `setwd()` in the script points to the original author's machine path and was repointed to the local package directory; the Figure-2 `pdf()` device was redirected to a tempfile to avoid a missing `Graphs/` directory. No effect on estimates.
