# Reproduction Report — Lee (2021), "Do Policy Makers Listen to Experts?" (APSR)

**Assigned exhibit:** Figure 4 — "Updating by Prior Attitude from Within-Subject Design"
**Package language:** R
**Rendered PNG:** `/Users/yoel/Dropbox (Awesomest)/Claude-Code/reproducibility_assessment/reproduction_run/figures/03_figure4.png`
**Reproduction code:** `/Users/yoel/Dropbox (Awesomest)/Claude-Code/reproducibility_assessment/reproduction_run/fig4_repro.R`
(self-contained extract of preprocessing lines 14–72 + Fig-4 block lines 263–344 of `Replication_2021_Lee_APSR_public_access.R`)

---

## HEADLINE FINDINGS (per project reporting policy)

- **Figure 4 reproduces exactly.** All 18 point estimates (6 panels × 3 groups) match the published figure to displayed precision; the panel layout, axes, and confidence intervals visually match. **No estimate deviates beyond rounding.**
- **One display discrepancy (Moderate, cosmetic):** the **published figure orders the x-axis Somewhat / Least / Most Congruent**, but the **shipped code factor levels are Least / Somewhat / Most** (lines 57–59, 64, 72). The shipped code therefore does **not** reproduce the published left-to-right ordering. The numeric values per labeled group are identical — only the on-screen position of the "Least" and "Somewhat" points is swapped. No substantive estimate is affected.
- **One genuine code bug found** (lines 43–44), but it is **outside Figure 4's code path** and does not affect this exhibit.

---

## TASK 1 — Computational Reproduction

**Reproduced? YES.** Minutes-to-successful-reproduction: **~2 min** (figure rendered + numeric estimates confirmed). Code path above.

The figure is a no-intercept OLS per issue (`response ~ level - 1`), so each plotted point is simply the mean within-subject change for that pre-treatment group; CIs are `±1.96·SE` (classical homoskedastic SE).

### Comparison table (reproduced point estimates vs published Figure 4)

Values are Δ (change), rescaled −1…1. Published values read off the figure to its displayed precision; all reproduced points fall on the published markers.

| Panel | Group | Reproduced est | Group n | Matches published marker? |
|---|---|---|---|---|
| NEP — Belief | Least | 0.368 | 38 | Y |
| NEP — Belief | Somewhat | 0.250 | 45 | Y |
| NEP — Belief | Most | 0.037 | 135 | Y |
| GMO — Belief | Least | 0.250 | 6 | Y |
| GMO — Belief | Somewhat | 0.133 | 15 | Y |
| GMO — Belief | Most | 0.065 | 31 | Y |
| RC — Belief | Least | 0.381 | 97 | Y |
| RC — Belief | Somewhat | 0.091 | 88 | Y |
| RC — Belief | Most | −0.021 | 84 | Y |
| NEP — Pref | Least | 0.050 | 47 | Y |
| NEP — Pref | Somewhat | 0.061 | 33 | Y |
| NEP — Pref | Most | 0.015 | 138 | Y |
| GMO — Pref | Least | 0.119 | 42 | Y |
| GMO — Pref | Somewhat | 0.080 | 85 | Y |
| GMO — Pref | Most | 0.018 | 84 | Y |
| RC — Pref | Least | 0.074 | 115 | Y |
| RC — Pref | Somewhat | 0.038 | 79 | Y |
| RC — Pref | Most | 0.019 | 79 | Y |

**Regression N per panel** (rows with non-missing outcome): NEP-belief 218, GMO-belief 52, RC-belief 269, NEP-pref 218, GMO-pref 211, RC-pref 273.

**Visual match:** The rendered PNG matches the published Figure 4 in structure (3×2 grid: Needle Exchange / GMO Ban / Rent Control × Belief about Experts / Policy Preference), y-axis scaling (0–60%-pts for belief, 0–20%-pts for preference), dotted zero line, and the substantive pattern (Least and Somewhat congruent groups update significantly; Most congruent ≈ 0). **The only visible difference is the x-axis category order** (see Task 2, Issue 1).

---

## TASK 2 — Coding Errors / Irregularities

| # | Issue | Location | Detected (min from start) | Affects main claim? |
|---|---|---|---|---|
| 1 | **Published vs code x-axis ordering mismatch.** Published Figure 4 displays x as *Somewhat / Least / Most Congruent*; shipped factor levels (lines 57–59, 64, 72) are *Least / Somewhat / Most*. Running the shipped code as-is yields a different left-to-right order than the published figure. Per-group values identical; only point positions differ. Severity: **Moderate (cosmetic / non-numeric)**. | `Replication_2021…R` lines 57–59, 64, 72; vs PDF p.685 Fig 4 | ~5 | No — no estimate changes; substantive ordering claim ("least update most") is preserved (in fact clearer) either way. |
| 2 | **`mutate()` arrow-assignment bug.** Lines 43–44 use `republican_alignment <- ifelse(...)` (and `democrat_alignment <- ...`) *inside* `mutate()`. R creates junk columns literally named `"republican_alignment <- ifelse(...)"` instead of recomputing the intended columns; the recomputation is silently dropped. The pre-existing raw columns `republican_alignment`/`democrat_alignment` (CSV cols 24–25) survive and are used downstream. Confirmed the bug behavior in a minimal R example. | `Replication_2021…R` lines 43–44 | ~12 | No (for Fig 4). Fig 4 uses none of these variables. Could affect `polarization` / cross-subject descriptives if the author intended the recomputed values to differ from the raw columns; likely benign since raw columns appear to already hold the intended values. |
| 3 | **GMO belief small N (52).** The within-subject belief outcome `accuracy_response` is non-missing for only 52 GMO respondents (vs 218 NEP / 269 RC). Verified this is a real data feature (most GMO rows have missing `accuracy_response`), not a coding error. The GMO-belief panel correctly shows wider CIs, and one group ("Least") has n=6. | data file; figure GMO-belief panel | ~8 | No — faithfully reflected in the figure; flagged for interpretation (very small subgroup). |

No discrepancies between the data ranges and the paper's variable descriptions were found: belief is a 5-point 0–1 scale, preference a 7-point 0–1 scale, and the response (change) variables range −1…1, exactly as the paper's Figure 4 note states.

---

## TASK 3 — Robustness / Sensitivity Checks

Both checks target the validity of the figure's inference. Neither is reported by the author (the paper uses classical homoskedastic SE × 1.96 normal critical value).

### Check 1 — Heteroskedasticity-robust (HC2) standard errors
Group-mean models with unequal group variances motivate robust SEs. Re-estimated all 18 group means with `vcovHC(type="HC2")`.
- **Result:** The main pattern is robust. Every "Least" and "Somewhat" congruent point that was significant under classical SE remains significant under HC2 in all 6 panels.
- **One direction-of-change note:** Needle Exchange "Most Congruent" flips from non-significant to **significant** under HC2 for **both** belief (est +0.037, robSE 0.0150) and preference (est +0.015, robSE 0.0065). This *strengthens* evidence of (small) updating even among the most-congruent group; it runs with, not against, the paper's accuracy-motivation thesis, so it does not threaten the main claim.

### Check 2 — t-distribution critical values (instead of fixed 1.96 normal)
The figure uses ±1.96·SE regardless of group size; with groups as small as n=6 (GMO Least), the normal approximation understates CI width. Recomputed each CI using `qt(.975, n_g − 1)`.
- **Result:** No significance conclusion changes versus the paper's normal-based CIs. The smallest groups (GMO, t-crit up to 2.57) remain significant for Least/Somewhat; all "Most" groups remain non-significant. The paper's use of 1.96 does not manufacture any of its significant findings.

**Overall:** Figure 4's substantive conclusion — that the least- and somewhat-congruent groups update significantly and the most-congruent groups update near zero — is robust to both alternative inference procedures.

---

## OBSTACLES

- Packages `statar` and `doStata` (Stata interop) are not installed and could not be needed for Figure 4; I extracted the Fig-4-relevant preprocessing + plotting into a self-contained script rather than sourcing the full 1000-line file (which also writes to `Data/`, `Figs/`, `Tabs/` subfolders that do not exist in the package). All required packages for Fig 4 (`tidyverse`, `ggplot2`, `cowplot`, `scales`) were present.
- `survey` and `policymaker` are not raw CSV columns; they are constants set in preprocessing (`survey="CP18"`, `policymaker=1`, lines 46–47), so the Fig-4 subset filter `survey=="CP18" & policymaker==1` keeps all rows. Reproduced faithfully.
- No appendix table giving exact Figure 4 numerical values was located in the PDF, so published comparison is to the figure markers (displayed precision); all reproduced points lie on those markers.
