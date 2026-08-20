# Reproduction Report — "The Heterogeneous Tax Pass-through under Different Vertical Relationships" (Economic Journal, 2022)

**Assigned exhibit:** Figure 2 (Differential effect of the tax increase on vertically-integrated gas stations' diesel prices, by number of nearby competitors — the "competition effect")
**Package language:** R/Stata (Figure 2 is produced by Stata)
**Code path:** `replication_packages/12_taxpass/Results/do_TabsFigs.do`, lines 523–598 (Figure 2 block). Reproduced via a minimal extract `Results/repro_fig2.do`.
**Rendered figure:** `reproduction_run/figures/12_figure2.png` (Stata graph exported to PDF, converted to PNG with `pdftoppm`; the headless Stata install lacks the `Graph2png` translator, so direct PNG export failed and PDF→PNG was used).

---

## HEADLINE (per project reporting policy)

**Task 1 reproduction: EXACT MATCH.** All six point estimates and all six subsample N's reproduce to the displayed 4-decimal precision, and the rendered figure is a visual match to the published Figure 2. **No reproduction discrepancy of any severity (Critical/High/Moderate) was found for the assigned exhibit.**

The one substantive caveat surfaced is an **inference** caveat, not a point-estimate discrepancy: treatment (`tax`) is assigned at the **province** level (4 treated provinces of 8), but standard errors are clustered at the gas-station level. Re-clustering at the province level and applying a Webb wild-cluster bootstrap (the appropriate small-cluster correction) raises the full-sample p-value from p<0.001 to **p ≈ 0.17** (Task 3, Robustness 1). This does not change the published figure but materially weakens the statistical significance of the headline "competition effect."

---

## TASK 1 — Computational reproduction

Figure 2 plots the coefficient on `tax_ver_int` (Tax × Vertical-Integration) from six `xtreg, fe` regressions of log diesel price on increasingly inclusive subsamples defined by number of competitors in a 2-km radius. Specification = column (5) of Table 2 (gas-station FE + week FE + time-varying controls + province×ln(Brent) FE), SEs clustered at gas-station `id`.

| Subsample (N gas stations) | Published `tax_ver_int` | Reproduced | Match | Published N | Reproduced N_g | Match |
|---|---|---|---|---|---|---|
| 0 competitors (72)      | 0.0117 | 0.0117 | Y | 72  | 72  | Y |
| 0–1 (99)                | 0.0111 | 0.0111 | Y | 99  | 99  | Y |
| 0–2 (121)               | 0.0106 | 0.0106 | Y | 121 | 121 | Y |
| 0–3 (137)               | 0.0092 | 0.0092 | Y | 137 | 137 | Y |
| 0–4 (147)               | 0.0083 | 0.0083 | Y | 147 | 147 | Y |
| Full sample (178)       | 0.0077 | 0.0077 | Y | 178 | 178 | Y |

(Reproduced full-sample exact value = .00771005; cross-checks against Table 2 col (5) = 0.008 rounded and N=9,252 obs / 178 stations — all consistent.)

**Visual comparison:** the reproduced PNG (`12_figure2.png`) matches the published Figure 2 (page 1697): identical downward-sloping point estimates with the same printed labels (0.0117 … 0.0077), identical ±1.96·SE bands, identical x-axis category labels with sample sizes in parentheses, same y-axis scale (0–0.020). **Visual match: YES.**

- **Reproduced? YES.**
- **Minutes-from-start to successful reproduction: ~3 minutes** (numeric match confirmed at ~2.6 min; PNG render finalized at ~3 min after working around the missing `Graph2png` translator).

---

## TASK 2 — Coding errors and irregularities

No errors that change the published numbers were found. The following are accurate-but-noteworthy observations and a paper-vs-code presentation discrepancy.

| # | Description | Location | Detected (min) | Could affect main claims? |
|---|---|---|---|---|
| 1 | **Listed "control variables" are silently dropped from the within estimator.** `ver_int`, `toll_highway`, and `n_of_competitors_2km` are all **time-invariant per gas station** (verified: 0 obs where they vary within `id`), so all three are *omitted because of collinearity* with the gas-station FE in every Figure 2 regression. They contribute nothing to the estimates. The paper/Table-2 note presents the spec as including these controls; in the FE model they are mechanically irrelevant. | `do_TabsFigs.do` line 542 (`loc cov`), 549–579; confirmed via regression notes | ~3.5 | No — estimates are correct; this is a presentation/transparency discrepancy, not a numerical error. |
| 2 | **Redundant sample filter.** Every Figure 2 regression restricts `if mdate>=tm(2015m7) & mdate<=tm(2016m6)`, but the shipped `maindata.dta` already spans exactly mdate 666–677 (Jul-2015–Jun-2016); the filter deletes **0 observations**. Harmless but indicates the restriction is non-binding. | `do_TabsFigs.do` lines 549–579 | ~2.5 | No. |
| 3 | **Competitor-count adjustment (`_own`) applies only to the subsample selector, not to the covariate.** Per footnote 28, for VI stations within 2 km of a same-brand/same-contract station the competitor count is reduced by 1 (`n_of_competitors_2km_own`). This adjusted variable defines the subsample cutoffs, but the regressor list still uses the raw `n_of_competitors_2km` (which, per #1, is dropped anyway). This is internally consistent with the footnote but easy to misread. | `do_TabsFigs.do` lines 537–542 | ~3.5 | No. |
| 4 | **Hard-coded week-count fix for one station.** `by id: gen week = _n if id!=126` then `replace week = _n - 3274 if id==126` (id 126 "has no data for first week"). A bespoke magic constant; not used in Figure 2 but worth flagging as a fragile manual patch in the build. | `cleaning_maindata.do` lines 527–530 | ~3 | No (not used in Fig 2). |
| 5 | **Inference level vs. treatment level (design issue, not a bug).** `tax`/`tax_ver_int` switch on at the **province** level for 4 of 8 provinces, yet SEs are clustered at the gas-station level (178 clusters). With effectively 8 treatment clusters, gas-station clustering likely overstates precision. See Task 3 Robustness 1. | `do_TabsFigs.do` lines 549–579 (`cluster(id)`) | ~4 | **Potentially yes** — affects the *significance* of the competition effect, though not the point estimates plotted. |

---

## TASK 3 — Robustness / sensitivity checks

Both checks target the **full-sample** point estimate (0.0077), the right-most point in Figure 2 and the headline pass-through-difference estimate. Code: `Results/robust.do`, `Results/robust_bt.do`.

### Robustness 1 — Province-level inference (treatment is assigned at province level)
Not done by the authors (they cluster only at the gas-station level). Re-cluster at province and apply a Webb wild-cluster bootstrap (9,999 reps), the standard small-number-of-clusters correction.

| Inference method | Full-sample `tax_ver_int` | SE | t | p-value | 95% CI |
|---|---|---|---|---|---|
| Cluster at gas station (paper baseline) | 0.0077 | 0.0019 | 4.12 | <0.001 | [0.0040, 0.0114] |
| Cluster at province (analytic, 8 clusters) | 0.0077 | 0.0029 | 2.66 | 0.033 | [0.0008, 0.0146] |
| **Webb wild-cluster bootstrap (province, 9,999 reps)** | 0.0077 | — | t(7)=2.66 | **0.170** | **[−0.0105, 0.0195]** |

**Finding:** the point estimate is unchanged, but under province-level inference the effect's significance is fragile — analytic province clustering keeps p<0.05, but the (more reliable) wild-cluster bootstrap returns **p ≈ 0.17 with a CI spanning zero**. Because treatment varies at the province level, this is the inference-relevant test, and it suggests the statistical significance of the differential pass-through is not robust to honest small-cluster inference.

### Robustness 2 — Leave-one-treated-province-out
Not done by the authors. Re-estimate the full-sample coefficient dropping each treated province in turn, to check the effect isn't driven by a single province. (SEs clustered at gas-station level, matching the baseline.)

| Dropped treated province | `tax_ver_int` | SE | t | N gas stations |
|---|---|---|---|---|
| Baseline (all) | 0.0077 | 0.0019 | 4.12 | 178 |
| − Huesca (22) | 0.0054 | 0.0023 | 2.33 | 154 |
| − Navarra (31) | 0.0064 | 0.0019 | 3.43 | 147 |
| − Teruel (44) | 0.0096 | 0.0019 | 4.97 | 168 |
| − Zaragoza (50) | 0.0090 | 0.0024 | 3.77 | 152 |

**Finding:** the differential pass-through stays positive and individually significant (gas-station clustering) in all four leave-one-out samples. It is largest with Teruel/Zaragoza retained and smallest when Huesca is dropped (0.0054, a ~30% reduction), so Huesca is the most influential treated province, but no single province drives the result. This supports the robustness of the *point estimate* (and contrasts with the inference fragility found in Robustness 1).

---

## OBSTACLES

1. **Missing `Graph2png` translator** on the headless Stata-MP install: `gr export ... .png` failed with `r(111)`. Worked around by exporting to PDF and converting with `pdftoppm -png` (available). Numbers and visual content are unaffected.
2. **`boottest` invocation sensitivity:** an initial `cap boottest` after an intervening `qui` regression produced no output (swallowed by `cap`). Resolved by running `boottest` immediately after its estimating regression in a clean do-file (`robust_bt.do`).
3. A stray `03_figure4.png` pre-existed in the figures directory (from an unrelated run); per instructions I did not touch other files.

---

## COMPACT SUMMARY

- **Reproduced?** YES — exact match on all 6 point estimates and all 6 N's; rendered figure is a visual match.
- **Minutes-to-reproduction:** ~3.
- **Issues found:** 5 (none change the plotted numbers; #1 is a paper-vs-code presentation discrepancy — listed controls are collinear-dropped; #5 is a treatment-level vs. clustering-level inference issue).
- **Robustness checks run:** 2 (province-level wild-cluster-bootstrap inference; leave-one-treated-province-out).
- **Worst reproduction-discrepancy severity:** None (exact reproduction). Note separately: the wild-cluster bootstrap inference check (Task 3) flips the full-sample effect to non-significant (p≈0.17) — an inference-robustness concern, not a reproduction discrepancy.
