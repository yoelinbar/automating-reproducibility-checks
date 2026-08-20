# Reproduction Report — Hill & Roberts (2023), *Acquiescence Bias Inflates Estimates of Conspiratorial Beliefs* (Political Analysis)

**Assigned exhibit:** Table 2, **column 3** ("All" statements, with covariate interactions; clustered SEs on respondent `id`).
**Package language:** R. **Code path:** `replication_packages/01_acquiescence/02_CovariateAnalysis.R`, lines 378–393 (object `lms.pooled[[3]]`, written to `tables/_Table02.tex`).

---

## TOP-LINE FINDING (read first)

**Table 2 column 3 does NOT reproduce.** Running the authors' own code on the shipped data produces a column 3 that differs **materially** from the published table on multiple coefficients **and on N**. The cause is isolated: the **`education` covariate shipped in the replication package (`LucidWideFile.csv`) is on a different scale, and contains 14 miscoded values (-3105), than the education variable that produced the published table.**

When the (miscoded) education term is removed from the model, column 3 reproduces the **published** numbers almost exactly — including the published N of 15,419 and the published "Pos keyed" coefficient of 0.170. This means the published Table 2 col 3 (and col 4) was effectively estimated **without** the shipped education variable (or with a near-zero-scaled, complete version of it), and the replication package as distributed cannot reproduce those columns as printed.

### Severity-flagged discrepancies (col 3: reproduced-as-coded vs published)

| Coefficient | Published | Reproduced (code as-is) | Abs. diff | Severity |
|---|---|---|---|---|
| **Pos keyed (main effect)** | **0.170** (0.023) | **0.069** (0.028) | **0.101 (59% smaller)** | **CRITICAL** — t-stat / magnitude collapse; SE also mismatched |
| **Education** | **0.00002** (0.00001) | **−0.011** (0.003) | sign flip, ~550× magnitude | **CRITICAL** — sign reversed |
| **Pos keyed × Education** | **−0.0001** (0.00002) | **+0.024** (0.005) | sign flip, ~240× magnitude | **CRITICAL** — sign reversed, p<1e-7 vs ~0 |
| Numeracy | −0.005 (0.007) | 0.0002 (0.007) | 0.005 | Moderate |
| Pos keyed × Numeracy | −0.002 (0.010) | −0.015 (0.010) | 0.013 | Moderate |
| Constant | 0.420 (0.015) | 0.470 (0.019) | 0.050 (12%) | High |
| **No. of observations** | **15,419** | **15,286** | **133 rows** | **High** (data/sample mismatch) |
| R² | 0.048 | 0.050 | 0.002 | Moderate |
| Aligned | 0.069 (0.009) | 0.070 (0.009) | 0.001 | Match (rounding) |
| Pos keyed × Aligned (headline) | 0.025 (0.012) | 0.024 (0.012) | 0.001 | Match (rounding) |
| Age | −0.0002 (0.0003) | −0.0001 (0.0003) | 0.0001 | Match (rounding) |
| Pos keyed × Age | −0.001 (0.0004) | −0.001 (0.0004) | ~0 | Match |

The **substantive headline of the column — Pos keyed × Aligned = 0.025** (acquiescence bias is larger among ideologically aligned respondents) — **does reproduce** to displayed precision (0.024 vs 0.025, identical SE). So the paper's main claim for this column survives, but three printed coefficients and the N do not.

Note: Table 2 **columns 1 and 2** (no covariates) reproduce exactly (Aligned 0.069; Pos keyed 0.140 / −0.006; Pos×Aligned 0.024 / 0.068; N 15,431 / 7,707; R² 0.046 / 0.029). The breakage is confined to the covariate columns (3 and 4), and is driven entirely by `education`.

---

## TASK 1 — Computational reproduction

**Reproduced? PARTIAL / NO for the printed values.** Code runs clean (`Rscript 02_CovariateAnalysis.R`, exit 0). All required R packages present (lfe, stargazer, data.table, dplyr, etc.). The shipped `tables/_Table02.tex` (re-generated on disk) is bit-for-bit identical to my fresh run, so the code deterministically yields the as-coded numbers below — they simply differ from the article.

| Quantity (col 3) | Published | Reproduced | Match? |
|---|---|---|---|
| Aligned | 0.069 (0.009) | 0.069 (0.009) | Y |
| Pos keyed | 0.170 (0.023) | 0.069 (0.028) | **N** |
| Numeracy | −0.005 (0.007) | 0.0002 (0.007) | N (Moderate) |
| Age | −0.0002 (0.0003) | −0.0001 (0.0003) | Y |
| Education | 0.00002 (0.00001) | −0.011 (0.003) | **N** |
| Pos keyed × Aligned | 0.025 (0.012) | 0.024 (0.012) | Y |
| Pos keyed × Numeracy | −0.002 (0.010) | −0.015 (0.010) | N (Moderate) |
| Pos keyed × Age | −0.001 (0.0004) | −0.001 (0.0004) | Y |
| Pos keyed × Education | −0.0001 (0.00002) | 0.024 (0.005) | **N** |
| Constant | 0.420 (0.015) | 0.470 (0.019) | **N** (High) |
| N | 15,419 | 15,286 | **N** |
| R² | 0.048 | 0.050 | N (Moderate) |

**Minutes-from-start to (the as-coded) reproduction: ~1 minute** (code is fast). **Minutes to discover the published-vs-package discrepancy and isolate its cause (education): ~6 minutes.** Reproduction of the *printed* column 3 from the shipped package: **NOT ACHIEVED** (only achievable by dropping the shipped education variable — see Task 3).

**Worst severity: CRITICAL** (three coefficients with sign flips / >50% magnitude change, plus an N mismatch).

---

## TASK 2 — Coding errors / data irregularities

| # | Issue | Location | Detected (min) | Could affect main claims? |
|---|---|---|---|---|
| 1 | **`education` variable is miscoded / wrong scale vs published table.** Shipped `education` is a 1–8 ordinal scale; the published Table 2 education coefficient (0.00002, SE 0.00001) is mathematically incompatible with a 1–8 variable (which yields −0.011, SE 0.003). The variable that produced the published table is not the one in the package. | `data/LucidWideFile.csv` col `education`; used in `02_CovariateAnalysis.R:386,389`; affects published Table 2 cols 3–4 | ~5 | **Yes** for the *covariate* coefficients (education, Pos-keyed main effect, their interaction). The headline Pos×Aligned interaction is unaffected. |
| 2 | **14 sentinel/miscoded values `-3105` in `education`** (identical in `lucid_education`), NA-set at `02_CovariateAnalysis.R:34`. These 14 respondents × their stacked questions drop 133 rows from the covariate models, lowering N from 15,431 to 15,286. The published col 3 N is 15,419 (only 12 rows dropped — i.e. only the single numeracy-NA respondent), implying the published run had **no** education missingness. | `02_CovariateAnalysis.R:34`; `LucidWideFile.csv` | ~5 | **Yes** — explains the N=15,419 vs 15,286 mismatch and confirms the education variable differs from the published one. |
| 3 | **`education` and `lucid_education` are exactly identical** (full crosstab is diagonal). The recode `DT$education[DT$education==-3105]<-NA` is the only transformation, so no separate "cleaned" education exists in the package. There is no continuous/years-of-education column anywhere in the 114 columns. | `LucidWideFile.csv` | ~7 | Supports #1 — the package lacks the variable needed to reproduce published cols 3–4. |
| 4 | **Shipped `tables/_Table02.tex` already disagrees with the published Table 2** (e.g. it prints Pos keyed = 0.069, education = −0.011, N = 15,286). The package's own compiled output does not match the article, indicating the package was finalized with a different education variable than the manuscript. | `tables/_Table02.tex` (lines 18, 27, 46) vs paper p. 584 | ~2 | **Yes** — independent confirmation the package as distributed does not regenerate the printed table. |
| 5 | `dplyr::recode` of `newdv` emits "Unreplaced values treated as NA" warnings; any DV category not in {No false, Not sure, Yes true} silently becomes NA. Not an error here (categories are exhaustive for the AG items) but masks potential coding gaps. | `02_CovariateAnalysis.R:355` | ~3 | Low. |

No errors found in the headline `aligned` construction, the felm clustering, or the pooling logic; those reproduce cleanly.

---

## TASK 3 — Robustness / sensitivity checks

Both checks target column 3's validity and are not reported by the authors for this table. Code: `/tmp/robust.R` (built from the package's own data-construction logic).

### Check 1 — Re-estimate column 3 **without the (miscoded) education term**
Rationale: education is the variable identified as mis-scaled/miscoded (Task 2 #1–2). Drop `education*allcGentz`; keep numeracy, age, and aligned interactions.

| Coefficient | This check | Published col 3 |
|---|---|---|
| Aligned | 0.0693 (0.0093) | 0.069 (0.009) |
| **Pos keyed** | **0.1713 (0.0232)** | **0.170 (0.023)** |
| **Pos keyed × Aligned** | **0.0248 (0.0122)**, p=.042 | **0.025 (0.012)** |
| **N** | **15,419** | **15,419** |

**Result:** dropping the shipped education variable **reproduces the published column 3 almost exactly**, including the exact published N (15,419) and the Pos-keyed main effect (0.170). This pins the entire discrepancy on the `education` covariate and confirms the published table was estimated effectively without the package's education variable. The headline interaction is unchanged (0.025, p<.05).

### Check 2 — Code "Not sure"/"Don't know" as **0** (disagree) instead of 0.5
Rationale: the paper's DK→0.5 coding is a modeling choice; the script even contains an unused `recodenotsurezero` switch. Test whether the headline acquiescence-by-alignment interaction is robust to treating DK as non-endorsement.

| Coefficient | DK = 0 | Baseline (DK = 0.5, as printed in code) |
|---|---|---|
| Aligned | 0.0666 (0.0105) | 0.0699 (0.0093) |
| Pos keyed | 0.0717 (0.0326) | 0.0693 (0.0280) |
| **Pos keyed × Aligned** | **0.0233 (0.0148), p=.115** | **0.0241 (0.0122), p=.049** |

**Result:** the point estimate of the headline interaction is **stable** (0.023 vs 0.024), but under DK=0 the clustered SE inflates and the interaction is **no longer significant at .05 (p=.115)** — a **CRITICAL**-grade sensitivity by the project rubric (significance crosses .05). The substantive direction is unchanged; the statistical significance of the "aligned respondents show more acquiescence" interaction for the pooled "All" column is fragile to how Don't-know responses are coded.

---

## OBSTACLES

- The published Table 2 col 3 cannot be reproduced from the shipped package as-is; the education variable needed to match the article (tiny coefficient, no missingness, N=15,419) is not present in `LucidWideFile.csv`. I could not recover the original education coding from package contents alone; I inferred it must be a different-scale, complete variable, and demonstrated (Task 3, Check 1) that removing the shipped education term recovers the published numbers.
- The `-3105` sentinel is undocumented in the README; its meaning (likely a survey-platform refusal/missing code) had to be inferred.
- Wall-clock timing was very short because the R code runs in seconds; "minutes-from-start" figures above reflect investigation time, not compute time.
