# Reproduction Report — Comola & Prina (2022), *Economic Journal* 133(649):516

**Paper:** "The Interplay Among Savings Accounts and Network-Based Financial Services"
**Assigned exhibit:** Table 1, **column 3** (Total transfers; undirected dyadic ITT regression)
**Package language:** Stata (Stata-MP 16.1)
**Code path:** `replication_packages/11_savings/3 Replication Package/MS20211013_dofile.do`, lines 17–31 (Table 1 block). Column 3 is the third dependent variable in the loop, `transfer_12months_any_undirect`.
**Data:** `dyadic_panel.dta`

---

## TOP-LINE DISCREPANCY (flagged per CLAUDE.md, severity = CRITICAL)

> **The point estimates and standard errors of Table 1, column 3 reproduce EXACTLY. However, the displayed statistical-significance star on the TC coefficient (one_treated) is NOT reproduced by the package's own code.**
>
> - Published: **TC = 0.0123∗∗** (5% significance).
> - Package's wild-bootstrap procedure (the method the paper's notes and README say the stars are based on), run exactly as written (`set seed 835` once, gift→loan→transfer loop, `boottest`): **p = 0.0631 → only ∗ (10%)**.
> - At 99,999 replications the bootstrap p stabilises at **p ≈ 0.051** with a **95% wild-bootstrap CI of [−0.00027, 0.0268] that includes zero** — i.e., NOT significant at 5%.
> - The published ∗∗ instead matches the **asymptotic** cluster-robust t-test (p = 0.035), contradicting the stated rule.
>
> This is a **Critical** discrepancy under the project policy (the displayed significance level changed: ∗∗ → ∗). It does **not** affect the column-3 **TT** coefficient (the paper's main claim), which is robustly significant (p ≈ 0.004–0.007, ∗∗∗) under every method.

---

## TASK 1 — Computational reproduction

Command run (faithful to do-file lines 20–25 for the third dependent variable):
```stata
use "dyadic_panel.dta", clear
xtset dyad_code
set seed 835
xi: xtreg transfer_12months_any_undirect both_treated one_treated year if HHNO1 < HHNO2, fe cluster(village_code)
```

| Quantity (col 3, Total transfers) | Published | Reproduced | Match |
|---|---|---|---|
| TT  (both_treated) coef | 0.0161 | 0.0161349 | **Y** |
| TT  SE | (0.0048) | (0.0047673) | **Y** |
| TT  significance star | ∗∗∗ | ∗∗∗ (boot p=0.0040) | **Y** |
| TC  (one_treated) coef | 0.0123 | 0.0122653 | **Y** |
| TC  SE | (0.0054) | (0.0053853) | **Y** |
| **TC significance star** | **∗∗** | **∗ (boot p=0.0631)** | **N — see Critical flag** |
| t=1 (year) coef | −0.0030 | −0.0029551 | **Y** |
| t=1 SE | (0.0053) | (0.0053147) | **Y** |
| Constant coef | 0.0260 | 0.0259999 | **Y** |
| Constant SE | (0.0018) | (0.0018462) | **Y** |
| Mean of dep. var. | 0.030 | 0.0297 | **Y** |
| N observations | 56,308 | 56,308 | **Y** |
| N dyads | 28,154 | 28,154 | **Y** |

**Point estimates, SEs, mean, and N all reproduce to displayed precision.** The only failure is the displayed significance star on TC (see Critical flag above and Task 2).

**Minutes-from-start to successful reproduction of the numeric estimates: <1 minute** (point estimates/SEs/N matched on the first regression run). The significance-star discrepancy was characterised by minute ~3.

---

## TASK 2 — Coding errors and irregularities found

| # | Issue | Location | Min. confirmed | Affects main claims? |
|---|---|---|---|---|
| 1 | **Col-3 TC significance star not reproducible from package code.** Published TC = 0.0123∗∗ (5%). The package's own wild-bootstrap (`boottest`, seed 835, exact loop order) gives p = 0.0631 → ∗ (10%). At 99,999 reps p ≈ 0.051 with 95% CI including 0. The ∗∗ instead matches the asymptotic t (p=0.035). README and Table 1 notes explicitly state the stars are "based on the p-values obtained from the clustered wild-bootstrap tests (code line 26)." So the star contradicts the documented procedure. | Paper Table 1 col 3, row TC; do-file lines 24–28; README "Data files Output" bullet for Table 1 | ~3 | Secondary. Does NOT affect the main TT effect (robust ∗∗∗). Weakens the secondary claim that the "one-treated" (TC) effect on total transfers is significant at 5%. |
| 2 | **`boottest` p-values are inherently stream/seed-dependent at the 0.05 boundary for col-3 TC.** Running `boottest {one_treated}` alone vs. batched `{one_treated} {both_treated} {year}`, or after the gift/loan regressions consume random draws, shifts the realised p between ~0.044 and ~0.063 at 999 reps. Authors fixed seed 835 but the batched/sequential design makes the col-3 TC star fragile right at p=0.05. | do-file line 26 (`boottest {one_treated} {both_treated} {year}`) | ~3 | Same as #1 — explains how an unstable borderline p could be reported as ∗∗. |
| 3 | **`outreg2`-generated stars (asymptotic) differ from the bootstrap stars actually printed in the paper.** The auto-generated `table1.txt` uses asymptotic t-test stars: col1 year = ∗∗ (paper prints ∗), col2 TC = ∗∗ (paper prints ∗), col3 TC = ∗∗ (paper prints ∗∗). The paper correctly overrides cols 1–2 with bootstrap stars but, for col-3 TC, the printed star coincides with the (incorrect) asymptotic outreg2 star rather than the bootstrap one. Suggests col-3 TC star may have been taken from the wrong source. | do-file line 27; regenerated `table1.txt` | ~2 | Diagnostic for #1. |
| 4 | **Table A6 export bug (not the assigned cell, but a real coding error).** Lines 372/382/392/402 run `outreg2 one_treated both_treated year ...` while the regressions are on `TT TC CT year` (and `one_treated`/`both_treated` are not even regressors in those models). The A6 .tex would export the wrong/empty coefficients. | do-file lines 369–404 | ~5 | Not relevant to Table 1; affects Appendix Table A6 only. |
| 5 | **README/file-name mismatch.** README refers to `dofile_ComolaPrina_EJ.do`; the shipped file is `MS20211013_dofile.do`. Likewise README refers to a 5th data file set; all data are present. Cosmetic. | README vs. package folder | ~4 | No. |

No errors were found in the construction of the column-3 dependent variable, the sample filter (`HHNO1 < HHNO2`, giving the 56,308 undirected dyad-period observations / 28,154 dyads), or the FE/clustering specification — all reproduce exactly.

---

## TASK 3 — Robustness / sensitivity checks (not done by the authors)

Both checks target the validity of the inference on the assigned column (Table 1, col 3). The do-file used is `_robust.do` / `_robust2.do` in the package directory.

### Check 1 — High-precision and alternative-weight wild-bootstrap inference for col-3 TC
Rationale: with only **19 village clusters**, asymptotic cluster-robust inference is unreliable; the authors use 999-rep Rademacher wild bootstrap, whose realised p for TC sits exactly on the 0.05 boundary. I re-ran with 99,999 reps and with alternative few-cluster-robust schemes.

| Method (col-3 TC = one_treated) | p-value | 95% CI | Star |
|---|---|---|---|
| Asymptotic cluster-robust t (19 clusters) | 0.0352 | — | ∗∗ |
| Wild bootstrap, Rademacher, 99,999 reps (authors' method) | **0.0515** | [−0.00027, 0.0268] (incl. 0) | ∗ |
| Wild bootstrap, **Webb** 6-pt weights, 99,999 reps | 0.0504 | incl. 0 | ∗ |
| Wild bootstrap, **jackknife** residuals, 99,999 reps | 0.0508 | incl. 0 | ∗ |
| Col-3 **TT** (both_treated), bootstrap 99,999 reps | 0.0073 | [0.0050, 0.0265] (excl. 0) | ∗∗∗ |

**Result:** Every wild-bootstrap variant (the procedure the paper states it uses) places col-3 TC just **above** the 5% threshold with a 95% CI that contains zero. Only the asymptotic test reaches p<0.05. The TT effect is robustly ∗∗∗ under all methods. This corroborates Task-2 issue #1: the published ∗∗ on col-3 TC is not supported by the authors' stated inference method.

### Check 2 — Baseline (pre-treatment) dyadic placebo / balance
Rationale: test whether treatment status predicts the col-3 outcome **at baseline (year==0)**, which should be null if randomisation is clean.

**Result:** In the balanced 2-period dyadic panel, `both_treated` and `one_treated` are **time-invariant and perfectly collinear within year==0** (both omitted), and the baseline constant (0.0260) equals the pooled FE constant. The dyadic FE design fully absorbs cross-sectional treatment variation, so a year-0-only placebo is not identified here — confirming (rather than challenging) the design's internal logic, but providing no additional test. This is a true negative: the check is structurally uninformative for this estimator, which is itself worth noting (the ITT effect is identified only off the within-dyad time change, not a level difference).

---

## Obstacles
- `outreg2` had to be installed via `ssc install outreg2` (only its asymptotic stars are auto-generated; the paper's stars require manual transfer from `boottest`). `boottest` was already available.
- `boottest` p-values are stochastic; I used up to 99,999 replications and multiple seeds/weight schemes to pin down the col-3 TC borderline result.
- README file-name and the actual do-file name differ (cosmetic; all data and code present).
- Worked strictly from the paper PDF and the shipped replication package, as instructed.
