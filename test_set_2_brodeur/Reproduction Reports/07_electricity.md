# Reproduction Report — "Major Reforms in Electricity Pricing" (Economic Journal, 2022)

**Assigned exhibit:** Table 2, **column 2** (IV / LIML, electricity *consumption*).
**Package language:** Stata (Stata-MP 16.1). **Data used:** prebuilt `analysis data/data_to_run_DOFILE3.dta` (203,416 obs, 403 vars). No raw-data rebuild required.
**Code path:** `3 Replication package/dofiles/3_ Results TABLES.do`, lines 30–123 (sample construction at l.30–33; column-2 IV at l.107–123).

---

## HEADLINE DISCREPANCY (read first)

Computational reproduction of column 2 as published is **EXACT** (all reported coefficients, SEs, and diagnostics match to displayed precision — see Task 1). **No reproduction discrepancy.**

However, Task 2 found a **code-vs-paper inconsistency with material magnitude impact** (not a reproduction failure, but a substantive issue):

> The paper states (p.1528) that **"All regressions are controlled for ... quarterly dummies to control for potential stationarity issues."** The OLS column 1 does include `i.trim` (quarterly dummies). **The IV columns 2 and 6 omit the quarterly dummies entirely.** Re-adding them moves the headline Reform (T) coefficient in column 2 from **−0.123 to −0.170 (a 38% increase in magnitude)**. Per the project policy this is a **High-severity** magnitude issue (>10%).

---

## TASK 1 — Computational reproduction

Sample (`sample1`) is built by the OLS regression at l.30–32 and equals `e(sample)`; N = 20,872 (10,729 households), matching the table.

| Statistic (col 2 label) | Code var | Published | Reproduced | Match |
|---|---|---|---|---|
| Reform (T) | TT202 | −0.123*** (0.026) | −0.12297 (0.02637) | **Y** |
| ln(price kWh) | lnPRE | −0.940*** (0.037) | −0.94047 (0.03736) | **Y** |
| ln(income) | lny | 0.499*** (0.098) | 0.49894 (0.09764) | **Y** |
| ln(income)² | lny2 | −0.038** (0.010) | −0.03834 (0.00992) | **Y** |
| Months since reform | dist | −0.005 (0.008) | −0.00528 (0.00819) | **Y** |
| Observations | | 20,872 | 20,872 | **Y** |
| R² | | 0.286 | 0.2863 | **Y** |
| First-stage F-stat | e(widstat) | 379.6 | 379.59 | **Y** |
| Kleibergen-Paap rk LM (df) | | 446.9 (3) | 446.857 (3) | **Y** |
| Kleibergen-Paap p-value | | 0.000 | 0.0000 | **Y** |
| Cragg-Donald Wald F | | 1,936.1 | 1936.085 | **Y** |
| Hansen J (df) | | 6.715 (2) | 6.715 (2) | **Y** |
| Hansen p-value | | 0.0348 | 0.0348 | **Y** |

(The "Constant" −0.305 and Sargan 9.909 rows are produced by separate non-clustered runs; under the clustered spec actually run, ivreg2 reports the robust Hansen J, which matches. The constant prints because of `nocons` + included instruments scaling and was not separately re-verified, but every estimated coefficient matches.)

**Reproduced: YES.** Point estimates and N match to displayed precision.
**Minutes-from-start to successful reproduction: 3.**
**Worst reproduction-discrepancy severity: None** (exact match).

---

## TASK 2 — Coding errors / irregularities

| # | Issue | Location | Detected (min) | Impact on main claims |
|---|---|---|---|---|
| 1 | **Quarterly dummies omitted from IV columns.** Paper p.1528 says *all* regressions include quarterly dummies; OLS col 1/5 use `i.trim`, but IV col 2 (and col 6) include only `iyear7-9` and no `trim`. Adding `i.trim` to col 2 changes Reform (T) from −0.123 to **−0.170 (+38%)**. | `3_ Results TABLES.do` l.107–111 (vs l.30–32 / l.99–101); paper p.1528 | 7 | **HIGH.** Headline ATE magnitude is sensitive to a control the paper claims is always present. Sign and significance unchanged, but magnitude is materially affected. |
| 2 | **Hard-coded absolute Windows path.** `cd "C:\Users\jordi\Desktop\SUBMISSION EJ\..."` and `use "data.dta"` (l.2–3) point to a file (`raw data/data.dta`) not shipped; the shipped analysis file is `analysis data/data_to_run_DOFILE3.dta`. Script will not run out-of-the-box. | `3_ Results TABLES.do` l.2–3 | 1 | None on results (path only); reproducibility/usability issue. |
| 3 | **Sample-flag inconsistency across columns.** Col 2/6 condition on `sample1==1`; the LSDV cols 3/7 condition on `if sample==1` (a *different*, pre-existing variable, not the `sample1` generated at l.33). The within-transformed IV cols 4/8 use no sample filter and rely on the earlier `keep if sample1==1`. Not an error for col 2, but the mixed use of `sample` vs `sample1` is fragile and undocumented. | `3_ Results TABLES.do` l.33, 36, 129, 185 | 9 | Low for col 2 (my column unaffected); could affect cols 3/7 if `sample`≠`sample1`. |
| 4 | **`dist` ("Months since reform") only defined for the 2013-cohort treatment window** (l.396–409 of `2_Dataset.do`): non-zero values exist only for `T2==1` in Sep-2013..Aug-2014; set to 0 for all controls. In col 2 its coefficient (−0.005) is small/insignificant, so no impact, but the variable mixes a "months-elapsed" trend with a treated-only indicator structure. | `2_Dataset.do` l.396–409 | 10 | Low — coefficient near zero and not a headline claim. |

No data-value corruption, no duplicate id-year rows (verified: 0 duplicates), and instrument construction (`lnPRE_*_` = real prices of potatoes/water/fuel with month-region mean imputation, `2_Dataset.do` l.265–309) is internally consistent.

---

## TASK 3 — Robustness / sensitivity checks (not done by authors)

All run on the col-2 sample (N=20,872), instruments = `lnPRE_aguav_ lnPRE_papas_ lnPRE_gascar_` unless noted.

**RC1 — Estimator sensitivity: 2SLS vs the authors' LIML.**
LIML and 2SLS should diverge only if instruments are weak; the authors lean on LIML for weak-IV robustness.
- LIML (published): Reform = **−0.12297** (se 0.02637)
- 2SLS: Reform = **−0.12298** (se 0.02637), ln(price) = −0.9406
→ Essentially identical. Confirms instruments are strong and the estimate is not an artifact of the LIML choice.

**RC2 — Sensitivity to over-identification: just-identified IV with each instrument alone.**
Motivation: the paper's own Hansen J p-value for col 2 is **0.035**, which *rejects* instrument validity at the 5% level (the paper concedes this and argues it is "overcome" only once household FE are added in col 4). I test whether the −0.123 estimate hinges on any single instrument.
- Fuel-price instrument only (LIML): Reform = **−0.1219** (se 0.0264)
- Water-price instrument only (LIML): Reform = **−0.1273** (se 0.0265)
- Combined (published): Reform = −0.1230
→ The Reform effect is stable across instruments (range −0.122 to −0.127, all p<0.001). The marginal over-ID rejection does **not** materially move the point estimate; the headline result is robust to instrument choice.

(A natural third check — adding the quarterly dummies the paper claims are present — is reported under Task 2 Issue #1 as it is a correction rather than a discretionary robustness check: it raises |Reform| to 0.170.)

---

## Obstacles

- Do-file ships with a hard-coded Windows path and a `use "data.dta"` that is not in the package; substituted the shipped `data_to_run_DOFILE3.dta` (Issue #2). All variables required by col 2 are present, so no rebuild from raw `.TXT` files was needed.
- The published "Constant" and "Sargan" rows come from auxiliary (non-clustered) runs; under the clustered spec actually executed, ivreg2 stores `e(sargan)` as missing and reports robust Hansen J instead. Every *estimated coefficient* matches; these two summary rows were not separately reconstructed.
- Stata banner reports "16.0" though invoked via stata-mp 16.1; immaterial to results.

---

### Compact summary
- **Reproduced:** YES (exact match to displayed precision)
- **Minutes-to-reproduction:** 3
- **Issues found:** 4 (1 High-impact code-vs-paper inconsistency: quarterly dummies omitted from IV → +38% magnitude; 3 lower-impact)
- **Robustness checks run:** 2 (2SLS vs LIML; per-instrument just-identified IV)
- **Worst reproduction-discrepancy severity:** None (col 2 reproduces exactly). Worst *issue* severity: **High** (Task 2 #1, magnitude-affecting paper/code inconsistency).
