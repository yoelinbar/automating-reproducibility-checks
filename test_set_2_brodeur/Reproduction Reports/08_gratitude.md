# Reproduction Report — Mindful-Gratitude Practice and Collective Narcissism (Psychological Science, 2024)

**Assigned exhibit:** Table 1, Model 2 (Study 1; OLS regression of anti-Semitism on collective narcissism × manipulation, HC4-robust SEs, n = 569)
**Package language:** R
**Code path:** `replication_packages/08_gratitude/Data/Data and Analyses (revised)/Study 1 (Pilot).R`
**Data used:** `replication_packages/08_gratitude/Data/pilot_CN_MIND.sav` (the `.sav`; the CSV referenced by the code is **missing** — see Obstacles)

## Headline

**Table 1, Model 2 reproduces exactly to displayed precision.** All point estimates, robust SEs, p-values, 95% CIs, N, R², and F-tests match the published article. **No reproduction discrepancies of any severity (Critical/High/Moderate) were found.**

---

## Task 1 — Computational reproduction

Reproduced via the package's `Study 1 (Pilot).R` workflow (`lm(antiSe ~ CNSC*condition)` with `vcovHC(type="HC4")`), substituting the supplied `.sav` for the missing CSV. The `.sav` contains the exact variables the code expects (`antiSe`, `CNSC`, `condition` coded 0=control/1=attention/2=gratitude).

| Predictor | Published B (SE), p | Reproduced B (SE), p | Match |
|---|---|---|---|
| Mindful-gratitude practice | 1.04 (0.41), p=.011 | 1.043 (0.410), p=.0113 | **Y** |
| Mindful-attention practice | 0.11 (0.36), p=.771 | 0.105 (0.362), p=.7714 | **Y** |
| Collective narcissism | 0.49 (0.06), p<.001 | 0.494 (0.059), p<.001 | **Y** |
| CN × Mindful-Gratitude | −0.30 (0.11), p=.009 | −0.302 (0.115), p=.0087 | **Y** |
| CN × Mindful-Attention | −0.04 (0.10), p=.713 | −0.036 (0.098), p=.7127 | **Y** |
| Observations | 569 | 569 | **Y** |
| R² | .179 | .1787 | **Y** |
| F(5,563) | 21.92, p<.001 | 21.92, p<.001 | **Y** |
| ΔR² (F(2,563)) | .02, F=3.57, p=.03 | .0167, F=3.57, p=.029 | **Y** |

Published 95% CIs (bootstrapped) are also matched to two decimals by the HC4 normal-theory CIs (e.g., gratitude [0.24, 1.85]; CN×Gratitude [−0.53, −0.08]; CN×Attention [−0.23, 0.16]).

- **Reproduced: YES**
- **Minutes-from-start to successful reproduction: ~1 minute**
- **Worst reproduction-discrepancy severity: None**

---

## Task 2 — Coding errors / data irregularities

| # | Issue | Location | Detected (min) | Affects main claims? |
|---|---|---|---|---|
| 1 | **Primary data file referenced by the analysis code is missing.** `Study 1 (Pilot).R` (and the supplemental script) call `read_csv('Study 1 - Pilot.csv')` and `read_csv('prepilot.csv')`, but no CSV files exist anywhere in the package. Reproduction was only possible because a `.sav` (`pilot_CN_MIND.sav`) with the same variables happens to be present. The code as shipped will not run out of the box. | `Study 1 (Pilot).R:13`; `Study 1 - Supplemental Analyses.R:14, 218` | 1 | No (data recoverable from the `.sav`; results reproduce). Reproducibility/packaging defect only. |
| 2 | **`age` is stored as a binned/bracketed variable (range 2–6), not raw years.** The paper reports "ranging in age from 18 to 76 years (M = 44.79, SD = 15.28)". The supplied data has `age` M=4.45, SD=1.41, range 2–6 — i.e., age categories, not years. The reported age M/SD/range cannot be reproduced from this file. | `pilot_CN_MIND.sav` var `age`; paper p.140 | 2 | No (age is not in Table 1 Model 2). Documentation/data-completeness gap. |
| 3 | **Code/data redundancy with no codebook.** The `.sav` carries multiple overlapping condition variables (`cond` coded −1/0/1, `cond2` 0/1, `condition` 0/1/2) and duplicate outcome columns (`antiSe`, `antisem`, `antiSems` are all identical to mean(skala2r1..r5)). Without a codebook the analyst must guess which to use; the correct one (`condition`) was confirmed only by matching the paper's n's (208/181/180). | `pilot_CN_MIND.sav` | 2 | No (correct variable identifiable and used). Minor confusion risk. |

**Verifications that passed (no issue):** `CNSC` = mean of `cn_r1..cn_r5` exactly (max abs diff = 0); `antiSe` = mean of `skala2r1..skala2r5` exactly; sex distribution 313 female / 256 men matches the paper exactly; no missing data on the Model 2 variables; 569 unique IDs (no duplicates); condition cell sizes (208/181/180) match the paper. The indicator coding in the code (control=000, attention via factor, gratitude via factor) matches the paper's stated 0/1 indicator scheme.

No coding error that would change Table 1 Model 2 was found.

---

## Task 3 — Robustness / sensitivity checks (not done by the authors)

Both target the validity of the key result: the **CN × Mindful-Gratitude interaction** (b = −0.302).

### RC1 — Sensitivity to the choice of robust SE estimator
The authors used HC4, which is the most aggressive of the HC family. I re-estimated the interaction's SE under classical OLS and HC0–HC4.

| Estimator | b | SE | p |
|---|---|---|---|
| classical OLS | −0.302 | 0.095 | .0015 |
| HC0 | −0.302 | 0.111 | .0070 |
| HC1 | −0.302 | 0.112 | .0073 |
| HC2 | −0.302 | 0.113 | .0077 |
| HC3 | −0.302 | 0.114 | .0084 |
| HC4 (published) | −0.302 | 0.115 | .0087 |

**Result:** The interaction is significant (p < .01) under every estimator. The conclusion does not hinge on the HC4 choice; if anything HC4 is the most conservative.

### RC2 — Influence / outlier sensitivity
Dropped the 39 observations with Cook's distance > 4/n and refit (HC4).

| Quantity | Full sample (N=569) | Influential dropped (N=530) |
|---|---|---|
| CN × Gratitude b (SE), p | −0.302 (0.115), p=.009 | −0.241 (0.087), p=.006 |
| Gratitude main effect b (SE), p | 1.043 (0.410), p=.011 | 0.763 (0.316), p=.016 |

**Result:** Sign and significance of both the interaction and the gratitude main effect are preserved. The interaction magnitude shrinks ~20%, indicating the full-sample estimate is somewhat inflated by influential points, but the substantive conclusion (gratitude attenuates the CN–prejudice link) is not driven by outliers and survives their removal.

---

## Obstacles

1. **Missing CSV data files** — the analysis code reads `Study 1 - Pilot.csv` / `prepilot.csv`, which are absent from the package. Worked around by loading the included `pilot_CN_MIND.sav`, whose variable set matches the code's expectations and whose cell sizes/demographics match the paper. Reproduction was unaffected, but the package is not self-contained as shipped.
2. **No codebook** — multiple overlapping/duplicate variables required matching against the paper's reported n's to confirm the correct columns.
3. Compute well within the 30-minute box (~2 minutes total).

---

### Compact summary
- Reproduced: **Y**
- Minutes-to-reproduction: **~1**
- Issues found: **3** (all packaging/documentation; none affect Table 1 Model 2 results)
- Robustness checks run: **2** (alternative SE estimators; influence/outlier exclusion) — both confirm the result
- Worst reproduction-discrepancy severity: **None** (exact match to displayed precision)
