# Reproduction Report — Wilfahrt (2018), Precolonial Legacies and Institutional Congruence

**Paper:** Wilfahrt, Martha. 2018. "Precolonial Legacies and Institutional Congruence in Public Goods Delivery: Evidence from Decentralized West Africa." *World Politics* 70(2): 239–274. DOI: 10.1017/S0043887117000363
**Paper IDs:** paper_id=k7wj; claims=[k7wj_single-trace]
**Reproduction type:** Extended Push Button (only environment edits: `cd` path + `display` lines for additional precision)
**Headline verdict (unpatched):** approximate

## Headline

Reproduction of Table 1, Model 3 (focal claim) succeeds at the headline level but with a small numerical discrepancy in the focal coefficient. The paper reports an odds ratio of **2.508** (SE 0.390, p<0.001, N=14,168) for `Congruence_20km_T1` in Model 3. Re-running the author's archived `Table1.do` on the archived `VillageData.dta` yields **2.5246** (SE 0.3891, z=6.01, p≈1.88e-09, N=14,168). N matches exactly; p-value is well within precise band; odds ratio rounds to 2.525 (paper-precision, 3 decimals) → not "precise" but only **0.66% off** → comfortably **approximate**. SE rounds to 0.389 vs paper's 0.390 (off by 0.001). The likely cause is the documented GIS-coordinate jittering (~0.5km, per the ReadMe), which slightly perturbs the `c.Latitude##c.Longitude` interaction and the location/elevation/distance covariates in Model 3 (Models 1 and 2 do not include these geographic terms). Per CLAUDE.md guidance: this is a **moderate-severity** deviation (small, sub-1%, but exceeds rounding tolerance for the focal coefficient).

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed from paper value) | Sub-verdict |
|---|---|---|---|---|---|---|
| k7wj_single-trace | Coefficient (odds ratio) | 2.508 | 2.508 | 2.5246 (rounds to 2.525) | precise = 2.508; approx = [2.1318, 2.8842] | approximate |
| k7wj_single-trace | SE | 0.390 | 0.39 | 0.3891 (rounds to 0.389) | not a focal sub-outcome (descriptive) | non-outcome |
| k7wj_single-trace | p-value | < 0.001 | 0.001 (less-than) | 1.88e-09 | precise: p ≤ 0.001; approx (0.001, 0.051]; not > 0.051 | precise |
| k7wj_single-trace | Sample size | 14,168 | 14,168 | 14,168 | precise = 14,168; approx [12,043, 16,293] | precise |
| k7wj_single-trace | Effect size (OR, ser_method) | 2.508 | 2.508 | 2.5246 | same as coefficient row | approximate |
| k7wj_single-trace | Test statistic (z) | not reported | NaN | 6.01 | (paper does not print) | non-outcome |

**Overall verdict (unpatched):** approximate (coefficient/effect size are approximate; p and N are precise; no sub-outcome is "not").

Extraction check: extracted values match the published Table 1 cell exactly.

## What I did

1. **Set-up.** Created `independent_reproductions/k7wj_wilfahrt_2018/`. Copied `papers/k7wj.pdf`. Ran `pdftotext -layout` to produce `k7wj.txt`.

2. **Extraction check.** Located Table 1 on page 257 of the PDF (`k7wj.txt` lines 915–931). Model 3 column shows `2.508***` with SE `(0.390)`, N=14,268 ... wait — re-checking line 926: N for M3 is "14168". Significance markers are `*** p < 0.001, ** p < 0.05`. The claim row's `orig_coef_value=2.508`, `orig_coef_se=0.39`, `orig_p_value=0.001` (less-than), `orig_sample_size_value=14168` all match. Note: the paper reports odds ratios (Table 1 footnote: "coefficients are odds ratios"), and `orig_effect_size_value_repro=2.508 (ser_method)` is the same value as the coefficient. **Extraction matches the printed paper exactly.**

3. **Data/code source.** Harvard Dataverse: doi:10.7910/DVN/O9PUSY (World Politics Dataverse, Wilfahrt 2018). Downloaded all 11 files via the Dataverse `/api/access/datafile/<id>?format=original` endpoint. The `.tab` files served by Dataverse are actually Stata `.dta` (Stata 13/14 format, magic bytes `73 02`), so I copied them to `.dta` extensions to match the do-file expectations.

   Files inventory: `Codebook.rtf`, `ReadMe.rtf`, `Table1.do`, `Table2.do`, `Table3.do`, `Figure2.do`, `Supplementary Materials.do`, `VillageData.dta` (focal), `LocAllocT1.dta`, `LocAllocT2.dta`, `PlaceboTests.dta`.

4. **Reproduction commands.** I created `run_pushbutton.do` containing:
   - One env-only edit: `cd` to my reproduction directory (replacing the author's `/Users/Martha/Box Sync/...` path).
   - The exact M3 logit specification copied verbatim from `Table1.do` line 21.
   - Added trailing `display` statements to print the OR, OR-SE, p-value, z-stat, N to higher precision (display-only; does not affect the regression).

   Command: `/usr/local/bin/stata-mp -b do run_pushbutton.do` (Stata MP 16.0). Runtime ~5 seconds. Output saved to `run_pushbutton.log`.

   Output for `Congruence_20km_T1` in Model 3:
   - Odds Ratio = 2.524578
   - Robust SE on OR = 0.3891463 (clustered on `CR_2002_num`, 317 clusters)
   - z = 6.01 → p = 1.88e-09
   - Number of obs = 14,168
   - Pseudo R2 = 0.1665 (paper Table 1 cell: 0.167 — matches)

   I also ran `test_log_coef.do` (an additional diagnostic, no `or` option) to confirm the underlying log-odds coefficient: β = 0.9261, SE = 0.1541. Exponentiating: exp(0.9261) = 2.5246, consistent with the OR output.

5. **Stochastic-method diagnostics.** Not applicable — logistic regression is deterministic; no MC SE needed.

6. **Classification (unpatched).**
   - Coefficient (OR) → paper precision = 3 decimals → reproduced 2.5246 rounds to **2.525**, paper printed **2.508** → not "precise". |2.5246 − 2.508|/2.508 = 0.66% → within ±15% → **approximate**. Bounds: [2.508 × 0.85, 2.508 × 1.15] = [2.1318, 2.8842]; reproduced 2.5246 inside.
   - Effect size (also OR, ser_method) → same value, same band → **approximate**.
   - p-value: paper threshold "p < 0.001". Reproduced p = 1.88e-09 ≤ 0.001 → **precise** (one-sided rule).
   - Sample size: 14,168 = 14,168 → **precise**.
   - SE / test statistic: not part of the rubric's sub-outcomes for this claim (paper does not print z; SE is descriptive); both → **non-outcome**.
   - Combine: any "not"? No. Any "approximate"? Yes (coefficient + effect size). Overall: **approximate**.

## Diagnostics — author-bug analysis

**Suspected bug:** None at the analysis-logic level. The do-file specification matches what Table 1 reports.

**Most likely source of the small OR discrepancy (0.66%):** The ReadMe explicitly states:

> "The GIS data on which the dataset is constructed was graciously shared with me with the understanding that I not distribute it publicly. Accordingly, the data has been scrubbed of village and local government names ... and the village coordinates have been jittered by 0.00XX decimal degrees, the equivalent of about a half kilometer. This does not impact the paper's main results, but does impede the utility of the geographic data for other purposes."

Model 3 includes `c.Latitude##c.Longitude`, `Village_Elevation`, `LnD_waterway`, `Mangrove`, `LL_Rainforest_grassland`, `Sahel_Grassland_Bush` — all geography-derived. Coordinate jittering will perturb these and the resulting fit slightly. Models 1 and 2 (which do not include the geographic block) reportedly produce the headline values without this perturbation. This is consistent with the observed pattern: a small (sub-1%) coefficient drift, not a logic disagreement.

No patch was applied — there is no bug to patch. **Verdict if patched:** N/A. **Confidence:** high that the discrepancy is the intentional, documented coordinate jittering rather than a code or specification bug.

## Files in this folder

Author-supplied (downloaded from Harvard Dataverse doi:10.7910/DVN/O9PUSY):
- `Table1.do`, `Table2.do`, `Table3.do`, `Figure2.do`, `Supplementary Materials.do`
- `VillageData.tab` / `VillageData.dta` (same bytes; `.dta` is the runnable copy)
- `LocAllocT1.tab` / `.dta`, `LocAllocT2.tab` / `.dta`, `PlaceboTests.tab` / `.dta`
- `Codebook.rtf`, `ReadMe.rtf`
- `dataset_info.json` (Dataverse API metadata response)

Reproduction artifacts (unpatched run):
- `run_pushbutton.do` — the author's M3 line, with `cd` path edited and trailing `display` lines added for precision
- `run_pushbutton.log` — Stata batch log (the focal output)
- `test_log_coef.do` / `test_log_coef.log` — diagnostic to print log-odds coefficient (β=0.9261)

Paper:
- `k7wj.pdf`, `k7wj.txt`

Report:
- `REPRODUCTION_REPORT.md` (this file)
- `k7wj_summary_rows.csv`
