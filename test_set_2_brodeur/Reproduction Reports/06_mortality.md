# Reproduction Report — *How the Other Half Died: Immigration and Mortality in US Cities* (RESTUD, 2024)

**Assigned exhibit:** Table 1, Column 6 (External causes; DD with state-by-year FE)
**Package language:** R (fixest). Reproduced with prebuilt intermediate data `data/temp/analysis_master_disease_catagory.dta`.

## Headline reproduction result

**EXACT MATCH at displayed precision.** No reproduction discrepancies of any severity (Critical / High / Moderate) were found for the assigned exhibit. Point estimate, SE, N, R², and significance stars all match the published Table 1 col 6.

---

## Task 1 — Computational reproduction

| Quantity | Published (Table 1, col 6) | Reproduced | Match? |
|---|---|---|---|
| Quota exposure × Post (coef) | −0.048\*\*\* | −0.047808 → **−0.048** | Y |
| Std. error (clustered, city) | (0.016) | 0.016454 → **0.016** | Y |
| Significance | \*\*\* (p<0.01) | t=−2.906, **p=0.0039** | Y |
| Observations | 12,333 | **12,333** | Y |
| R² | 0.645 | **0.645** | Y |

All 8 columns of `dd_main.tex` reproduce byte-identically to the shipped `results/dd_main.tex` (verified via `diff`; the only diff-flagged lines are identical text differing in trailing whitespace from the re-write).

- **Minutes-to-reproduction:** ~2 minutes (regression succeeded on first execution; only a fixest multi-index display-syntax tweak was needed afterward).
- **Code path:** `code/analysis/quota_effects_main.R` → reads `data/temp/analysis_master_disease_catagory.dta` → `feols(... | city_nr + year + sw0(state_year), cluster=~city_nr, split=~disease_order, fixef.rm="singleton")`. Column 6 = model index [6] = `disease_order == "3. External"` with `state_year` FE.
- **Environment note:** package specifies fixest 0.11.0 / R 4.1.0; reproduced under **fixest 0.14.1 / R 4.5.2** (fixest was missing and installed from CRAN). Despite the version gap, results match to displayed precision — no version-induced deviation.

---

## Task 2 — Coding errors / data irregularities

No coding errors that affect the assigned exhibit were found. Items below are observations/discrepancies between the paper's description and the code, none of which alter the reproduced numbers or the paper's main claims.

| # | Description | Location | Detected (min from start) | Affects main claims? |
|---|---|---|---|---|
| 1 | **1921 timing.** Paper text (Sec. 4.3 / Sec. 5) describes the post indicator as the "period after 1921" and uses 1921 as the *omitted reference year* in the event study. In the DD, `DD_quota` codes `year >= 1921` as **treated** (so 1921 is post in the DD but the reference/untreated year in the event study). Defensible (Emergency Quota Act enacted May 1921), but a literal-text vs code discrepancy. | `code/dataprep/construction_master.R:375-377` | ~12 | No — robustness Check A shows the estimate is stable to recoding 1921 as pre. |
| 2 | **Quota exposure not perfectly constant across post years** in the assembled data (group means: 1.8445 most years, 1.8433 in 1925, 1.8480 in 1930/1933+, 1.8750 in 1931–32). This reflects the *within-post panel being unbalanced* (which cities have non-missing DV vary by year), not a time-varying treatment — `DD_quota = TE5_pred10` (fixed) for year≥1921. Not an error. | `data/temp/analysis_master_disease_catagory.dta` (verified) | ~10 | No |
| 3 | **"catagory" misspelling** propagated through filenames and the category crosswalk (`disease_catagory`, `analysis_master_disease_catagory.dta`); authors note "can't fix CWH typos at this stage." Cosmetic only. | `construction_master.R:31`, file/var names | ~9 | No |
| 4 | **Sample-window mismatch in raw vs analysis.** The .dta carries years 1900–1940 (41 years), but `lndeath_rate` is non-missing only for 1900–1937, and the balance filter keeps cities with 30–38 non-missing DV-years, consistent with the stated 1900–1937 window. No spurious 1938–1940 rows enter the regression (confirmed N=12,587 col 5 / 12,333 col 6). Documentation-vs-data is consistent once balance/NA filtering is applied. | data inspection | ~11 | No |
| 5 | **N-shrink footnote verified.** Cols 5→6 drop 254 obs (12,587→12,333) from singleton removal under state-by-year FE; matches the paper's footnote ("254 city-year-cell observations, 11 cities"). Confirms intended behavior, not an error. | Table 1 note; `fixef.rm="singleton"` | ~6 | No (confirms paper) |

---

## Task 3 — Robustness / sensitivity checks (not done by authors)

Both run on the col-6 specification (External causes, state-by-year FE), clustered by city. Script: `reproduction_run/robust_t1c6.R`.

| Check | Rationale (validity of empirical strategy) | Coef (SE) | p | vs baseline −0.0478 |
|---|---|---|---|---|
| **Baseline (reproduced col 6)** | — | −0.0478 (0.0165) | 0.0039 | — |
| **A. Recode 1921 as pre-period** (`DD_quota=0` in 1921) | Tests sensitivity to the 1921 timing ambiguity flagged in Task 2 #1 (event-study reference vs DD post). | −0.0504 (0.0171) | 0.0034 | +5.3% magnitude, still \*\*\* — robust |
| **B. Drop NYC + Chicago** | External-cause log death rates are noisy and could be driven by a few very large cities; tests influence of the two largest. | −0.0477 (0.0165) | 0.0041 | −0.2%, essentially identical — robust |

**Conclusion:** The col-6 external-cause DD estimate is not sensitive to the 1921 treatment-timing choice (if anything slightly stronger when 1921 is pre) and is not driven by the two largest cities. Both checks reinforce the validity of the reported result.

---

## Obstacles

- `fixest` was absent from the R install; installed from CRAN (0.14.1, vs package-specified 0.11.0). No effect on reproduced values.
- The package is multi-GB; the assigned exhibit was reachable directly from the shipped intermediate `analysis_master_disease_catagory.dta` (~436 MB), so the full ~30-min dataprep pipeline was not rerun (per task guidance to use prebuilt data).
- fixest 0.14.1 changed the `fixest_multi` indexing API (character-name `[[ ]]` no longer accepted); used integer index [6] instead. Cosmetic only.
