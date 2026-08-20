# Reproduction Report — Tertytchnaya (2018), When the Money Stops

**Paper:** Tertytchnaya, K., De Vries, C. E., Solaz, H., & Doyle, D. (2018). When the Money Stops: Fluctuations in Financial Remittances and Incumbent Approval in Central Eastern Europe, the Caucasus and Central Asia. *American Political Science Review*, 112(4), 758–774. DOI: 10.1017/S0003055418000485
**Paper IDs:** paper_id=9wya; claims=`9wya_single-trace`, `9wya_m64d4z`, `9wya_g3j7jq`, `9wya_gwo2oy`, `9wya_gp1k1r`
**Reproduction type:** Push Button (Stata `xtreg` on author's `LiK_final_rec.dta` from Harvard Dataverse, no logic edits)
**Headline verdict (unpatched):** **not** (overall: at least one focal coefficient sub-outcome is `not`, and the only single-trace claim's p-value moves out of the precise-or-approximate band on a different-but-related sub-outcome)
**Verdict if patched:** N/A — no bug to patch. Diagnoses below explain the gap.

## Headline

**Critical deviation across multiple claims.** The author's archived data + code, run unmodified, do not reproduce the published Tables 2 and 3 numbers. The most consequential miss is **Claim `9wya_g3j7jq` (Table 2, Model 3, Change in Remittances Index)**: paper reports coef = 0.064, SE = 0.023, p ≤ 0.01 (***); reproduced is coef = 0.0463, SE = 0.0334, **p = 0.166** — a sign-preserving but **significance-destroying** result (significance changed: was p ≤ .01, now p > .10). Three of the six focal coefficients in Tables 2–3 fall outside the SCORE ±15% approximate band (T2 M2: +34.3%; T2 M3: −27.7%; T3 M3: +31.1%); a fourth (T3 M1) sits 15.1% above (just outside the band). All six observation counts come in 3.1–4.2% lower than the paper's printed N (e.g., T2 M1 paper N=1,287 vs reproduced N=1,245). The *direction* of every focal coefficient matches the paper, but magnitudes, SEs, and one significance star do not. There is no obvious author-bug to patch — the released `ReplicationCode_APSR_LiK_Revised.do` block for Tables 2/3 is run verbatim against the released `LiK_final_rec.dta`. The most plausible explanation is that the released `LiK_final_rec.dta` is not the exact analysis sample that produced the printed tables (e.g., a downstream filter or recoding step that shipped `Recoding_APSR_LiK_Revised.do` was applied differently in the version that produced the published numbers, or the recoded file was uploaded at a different vintage than the paper).

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| 9wya_single-trace (T2 M1, diffamountrec) | coef | 0.048 | 0.048 | 0.0451 | [0.0408, 0.0552] | precise (rounds to 0.05 vs 0.05; both round to 0.05 at 2dp — see note) |
| 9wya_single-trace | SE | 0.019 | 0.019 | 0.0227 | [0.01615, 0.02185] | not (outside ±15%; reproduced 19.5% above paper) |
| 9wya_single-trace | z stat | 2.526 | 2.526316 | 1.99 | [2.147, 2.905] | not (outside ±15%) |
| 9wya_single-trace | p-value (exact) | 0.0115 (2-tailed; reconstructed from z) | 0.01153 | 0.0471 | [0.0, 0.0615] | approximate (within ±0.05) |
| 9wya_single-trace | N | 1,287 | 1,287 | 1,245 | [1,094, 1,480] | approximate (3.3% under, within ±15%) |
| 9wya_m64d4z (T2 M2, difffremfreq) | coef | 0.070 | NaN | 0.0940 | [0.0595, 0.0805] | not (+34.3% above paper) |
| 9wya_m64d4z | SE | 0.032 | NaN | 0.0323 | [0.0272, 0.0368] | precise (rounds to 0.032 at 3dp) |
| 9wya_m64d4z | p threshold | p ≤ 0.05 (**) | NaN | 0.0036 | precise iff ≤ 0.05 | precise (more significant than threshold) |
| 9wya_m64d4z | N | 1,273 | NaN | 1,233 | [1,082, 1,464] | approximate (−3.1%) |
| 9wya_g3j7jq (T2 M3, diffremitindex) | coef | 0.064 | NaN | 0.0463 | [0.0544, 0.0736] | not (−27.7%, outside band) |
| 9wya_g3j7jq | SE | 0.023 | NaN | 0.0334 | [0.01955, 0.02645] | not (+45% above) |
| 9wya_g3j7jq | p threshold | p ≤ 0.01 (***) | NaN | 0.166 | approx if (0.01, 0.06]; not if > 0.06 | **not** (0.166 ≫ 0.06) — **significance lost** |
| 9wya_g3j7jq | N | 1,287 | NaN | 1,245 | [1,094, 1,480] | approximate (−3.3%) |
| 9wya_gwo2oy (T3 M1, diffamountrec) | coef | −0.162 | NaN | −0.1865 | [−0.1863, −0.1377] | not (+15.1%, just over band) |
| 9wya_gwo2oy | SE | 0.045 | NaN | 0.0548 | [0.0383, 0.0518] | not (+21.7%) |
| 9wya_gwo2oy | p threshold | p ≤ 0.01 (***) | NaN | 0.0007 | precise iff ≤ 0.01 | precise (more significant) |
| 9wya_gwo2oy | N | 1,297 | NaN | 1,242 | [1,102, 1,492] | approximate (−4.2%) |
| 9wya_gp1k1r (T3 M2, difffremfreq) | coef | −0.245 | NaN | −0.2485 | [−0.2818, −0.2082] | precise (rounds to −0.249 vs −0.245? Actually rounds to −0.249 at 3dp ≠ −0.245 → approximate; |reproduced − paper|/|paper| = 1.4%) |
| 9wya_gp1k1r | SE | 0.077 | NaN | 0.0783 | [0.0654, 0.0886] | precise (rounds to 0.078 vs 0.077 at 3dp ≠; 1.7% diff → approximate) |
| 9wya_gp1k1r | p threshold | p ≤ 0.01 (***) | NaN | 0.0015 | precise iff ≤ 0.01 | precise |
| 9wya_gp1k1r | N | 1,283 | NaN | 1,230 | [1,091, 1,475] | approximate (−4.1%) |

**Per-claim overall verdicts (unpatched, applying SCORE combine rule = `not` if any sub-outcome `not`, else `approximate` if any `approximate`):**
- `9wya_single-trace`: **not** (SE & test stat outside ±15%)
- `9wya_m64d4z`: **not** (coef +34%)
- `9wya_g3j7jq`: **not** (coef −28%, SE +45%, **significance lost**)
- `9wya_gwo2oy`: **not** (coef +15.1%, SE +22%)
- `9wya_gp1k1r`: **approximate** (all sub-outcomes within bounds; closest to a clean reproduction)

**Note on the single-trace coefficient sub-verdict.** Paper prints 0.048 (3 decimals). Reproduced 0.0451 rounds to 0.045 at 3dp ≠ 0.048 → not precise. |0.0451 − 0.048|/0.048 = 6.1%, within ±15% → **approximate**, not precise as I initially wrote in the table. The cell is corrected here: T2 M1 coef sub-verdict = **approximate**. The single-trace overall verdict still ends as **not** because the SE and test-stat sub-outcomes are outside ±15%.

## What I did

1. **Set-up.** Created `independent_reproductions/9wya_tertytchnaya_2018/`, copied `papers/9wya.pdf`, ran `pdftotext -layout` to extract the paper text (`9wya.txt`). Read `paper_claims/9wya.json` for the five claim rows.

2. **Extraction check.** All five claim values trace cleanly to the paper:
   - `9wya_single-trace`: Table 2, page 766 (pdftotext line 650), Model 1, Change in Amount of Remittances = 0.048\*\* (SE 0.019); N=1,287 individuals/866 groups. Extraction matches.
   - `9wya_m64d4z`: Table 2, Model 2, Change in Frequency of Remittances = 0.070\*\* (SE 0.032); N=1,273. Matches paper.
   - `9wya_g3j7jq`: Table 2, Model 3, Change in Remittances Index = 0.064\*\*\* (SE 0.023); N=1,287. Matches paper.
   - `9wya_gwo2oy`: Table 3, page 768 (line 782), Model 1, Change in Amount of Remittances = −0.162\*\*\* (SE 0.045); N=1,297. The narrative "−9.55 points" min-to-max effect is also at line 759. Matches paper.
   - `9wya_gp1k1r`: Table 3, Model 2, Change in Frequency of Remittances = −0.245\*\*\* (SE 0.077); N=1,283. Matches paper.

3. **Data/code source.** Harvard Dataverse, doi:10.7910/DVN/MO3KOQ ("Replication Data for ‘When the Money Stops…'", APSR Dataverse). Downloaded all 19 files into `data/`. The Tables 2/3 analysis uses `LiK_final_rec.dta` (33.9 MB, Stata 13) plus `ReplicationCode_APSR_LiK_Revised.do`. I downloaded the original `.dta` via `?format=original` (Dataverse otherwise serves a `.tab` conversion); both files produce identical results when fed into the same `xtreg` calls, so the tab→dta conversion is not the source of the gaps.

4. **Reproduction.** Two passes, both Push Button (no logic edits, only the `cd` line and an `import delimited` for the .tab pass):
   - `run_pushbutton.do` — reads `LiK_final_rec.tab`, runs the six `xtreg` lines from `ReplicationCode_APSR_LiK_Revised.do` for Tables 2 and 3 verbatim. Log: `run_pushbutton.log`.
   - `run_pushbutton_dta.do` — same, but reads `LiK_final_rec.dta` (the original Stata file, downloaded via `?format=original`). Log: `run_pushbutton_dta.log`. **Identical numbers** to the .tab run.

   The author's `ReplicationCode_APSR_LiK_Revised.do` is the file the paper's archive identifies as the analysis script. The six `xtreg` lines for Tables 2/3 are reproduced exactly as posted (covariate list, `i.year i.hhid` fixed effects, `i(idpp)` random effect on individual). No environment edits beyond setting the working directory and substituting `import delimited` for `use` in the .tab pass.

5. **Stochastic-method diagnostics.** None — `xtreg` GLS is deterministic, no seeded steps.

6. **Classification (unpatched).** Bounds and sub-verdicts in the table above. Combined verdicts per claim:
   - 4 of 5 claims: **not reproduced** (overall).
   - 1 of 5 claims (T3 M2): **approximate**.
   - 0 of 5: **precise**.
   - **Most serious finding:** Claim `9wya_g3j7jq` (T2 M3) shows a **significance-class change** — paper p ≤ 0.01 (\*\*\*), reproduced p = 0.166. This is the SCORE-rubric's most-severe deviation category (significance gained or lost).

## Diagnostics — author-bug analysis

**Suspected bug:** No specific code bug identifiable. The released `ReplicationCode_APSR_LiK_Revised.do` Tables 2/3 block runs cleanly against the released `LiK_final_rec.dta` and produces internally-consistent regression output (z-stats, SEs, R², groups all line up). The model spec — `xtreg <DV> <focal> i.educ_cat2 marital gender age_adult ethnicity employed intentmigrate total_index3 tot_inc_rec lifesat riskaccept i.year i.hhid, i(idpp)` — exactly matches the paper's footnote ("panel GLS estimation with random effects varying across individuals and household and wave fixed effects"). All covariates referenced in the do-file exist in the data. No filter clauses (`if`/`in`) are dropped, missing, or refer to non-existent variables.

**What is wrong, then:** The released `LiK_final_rec.dta` does not appear to be the exact analysis-sample vintage that produced the printed Tables 2/3. Evidence:

- All six observation counts are 3.1–4.2% smaller than the paper's printed N. The pattern is internally consistent (M1 and M3 share an N in both the paper and reproduction; M2 is slightly smaller in both — driven by `difffremfreq` listwise deletion). This is the signature of *the same regression on a slightly smaller sample*, not of *a different regression on the same sample*.
- The Table 2 M3 coefficient flips from highly significant to insignificant while Table 2 M1 and Table 3 M2 (both involving slightly different focal regressors / DVs) reproduce close to the paper. The Remittances *Index* (M3 in both tables) is the worst-reproducing — and that index is the most-derived variable in the recoding pipeline (see `Recoding_APSR_LiK_Revised.do`, which builds it from amount, frequency, and stability subcomponents). Plausible: a downstream recoding decision differs between the released `.dta` and the version that produced the paper.
- Looking at `Recoding_APSR_LiK_Revised.do`, the script is meant to be run on `LiK_final_short.dta`, which is **not in the Dataverse repository** — only the post-recode `LiK_final_rec.dta` is. So the recoding step that built the index variables in the released file cannot be re-derived from raw to verify the index construction.

**No patched run attempted.** There is nothing to patch — the regression specification and the data are the released objects of record. A "fix" would require guessing what the author's pre-publication `LiK_final_rec.dta` contained, which is exactly the inference the modification policy forbids.

**Confidence:** Medium-high that this is a data-vintage / pipeline drift issue rather than a model-spec bug. The directions are right, the magnitudes are off in non-uniform ways, and the most-derived focal variable (the Index) shows the worst miss. A clean re-run would require obtaining the underlying Life in Kyrgyzstan raw data (restricted, IZA dataset 124) and rebuilding through `merge-recode-20YY.do` → `Recoding_APSR_LiK_Revised.do` to compare against the released `.dta`.

## Files in this folder

- `9wya.pdf` — paper PDF (copied from `papers/`)
- `9wya.txt` — `pdftotext -layout` extraction
- `data/` — Harvard Dataverse files (doi:10.7910/DVN/MO3KOQ):
  - `LiK_final_rec.tab` (Dataverse-converted tab-separated, 25 MB)
  - `LiK_final_rec.dta` (original Stata 13 file via `?format=original`, 34 MB)
  - All 17 other repository files (do-files, R script, EBRD .tab files, descriptive_fig.tab, models.tab)
- `run_pushbutton.do` / `run_pushbutton.log` — unpatched run on `.tab` file (Push Button + `import delimited`)
- `run_pushbutton_dta.do` / `run_pushbutton_dta.log` — unpatched run on original `.dta` (Push Button)
- `REPRODUCTION_REPORT.md` — this file
- `9wya_summary_rows.csv` — one row per claim, summary

No patched-diagnostic artifacts (no patch attempted; see Diagnostics).
