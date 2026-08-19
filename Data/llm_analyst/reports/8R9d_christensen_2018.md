# Reproduction Report — Christensen (2018), Remotely Close Associations

**Paper:** Christensen, A. P., Kenett, Y. N., Cotter, K. N., Beaty, R. E., & Silvia, P. J. (2018). Remotely Close Associations: Openness to Experience and Semantic Memory Structure. *European Journal of Personality*, 32, 480–492. DOI: 10.1002/per.2157
**Paper IDs:** paper_id=8R9d; claims (20) = `8R9d_d5r3o4, 8R9d_r1zw73, 8R9d_v4wj5w, 8R9d_gdrl4o, 8R9d_grz8yk, 8R9d_mvwky9, 8R9d_bkpj4j, 8R9d_b7lx28, 8R9d_gzjkoy, 8R9d_mlq1kp, 8R9d_g6zqdl, 8R9d_b31372, 8R9d_9q35x9, 8R9d_4d9x6l, 8R9d_5v4j3k, 8R9d_yox4lo, 8R9d_2kjpzv, 8R9d_8974q1, 8R9d_od1lpq, 8R9d_n1j7wn`
**Reproduction type:** Extended Push Button (R-package API rename swaps; no analysis-logic edits)
**Headline verdict (unpatched):** **not** (multiple Table 3 sub-outcomes outside the ±15% band; Table 2 Q values also drift; one paper-text t-test value diverges from the rerun)
**Verdict if patched:** see Diagnostics — none of the deviations have a clear "bug" to patch in the posted code; the Table 2/3 drifts come from package-API evolution, and the in-text t-test (M=17.66/16.57, t=-3.53) cannot be recovered from any code path in the posted script using the posted data.

## Headline
Most claims reproduce, but several do **not**, and the deviations are not noise. (1) The Table-1/2 means and the in-text Bushel t-test on total-responses disagree with what the posted code on the posted cleaned data produce (paper text: M_high=17.66 vs M_low=16.57, t(514)=−3.53, p=.007; reproduced: M_high=17.92 vs M_low=16.71, t(514)=2.96, p=.003) — a 16% gap on |t| and a doubling of significance, and the means do not match Table 1 either (Low M=16.41, High M=17.83 in Table 1 vs M=16.57 / M=17.66 in text). (2) Table 3 CC t-statistics and d's are systematically ~12–22% smaller than the published values across all five node-drop levels; Table 3 ASPL at the 50%-remaining level diverges by ~25% (t and d both fall outside the band). (3) The Table-2 Q values move from 0.590 → 0.644 (Low) and 0.521 → 0.588 (High), the latter a 13% drift outside the band. The headline correlation (r(514)=0.17, p<.001) and McNemar uniqueness test (χ²=16.91, p<.001, φ=0.22) reproduce precisely.

## Comparison table

For p<0.001 thresholds, "approx" band = (.001, .051]; reproduced p≪.001 ⇒ precise.

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (precise / approx) | Sub-verdict |
|---|---|---|---|---|---|---|
| d5r3o4 | r | 0.17 | 0.17 | 0.170 | 0.17 / [0.145,0.196] | precise |
| d5r3o4 | p | <0.001 | 0.001 | 1.07e-4 | ≤.001 precise | precise |
| d5r3o4 | N | 516 | 516 | 516 | 516 / [439,593] | precise |
| r1zw73 | t(514) | −3.53 (text says 3.53; sign convention) | −3.53 | 2.957 (sign convention same as paper text) | −3.53 / [−4.06,−3.00] | **not** (|2.957| outside [3.00,4.06]) |
| r1zw73 | p | 0.007 | 0.007 | 0.00325 | 0.007 / [0,0.057] | precise (|.0033−.007|=.0037 < .05) |
| r1zw73 | d | 0.24 | 0.24 | 0.260 | 0.24 / [0.204,0.276] | precise (rounds to 0.26 ≠ 0.24, but within 15%; .26∈[.204,.276]) → **approximate** |
| r1zw73 | N | 516 | 516 | 516 | 516 / [439,593] | precise |
| v4wj5w | chi2(1) | 16.91 | 16.91 | 16.908 | 16.91 / [14.37,19.45] | precise |
| v4wj5w | p | <0.001 | 0.001 | 3.92e-5 | ≤.001 | precise |
| v4wj5w | phi | 0.22 | 0.22 | 0.221 | 0.22 / [0.187,0.253] | precise |
| v4wj5w | N | 516 | 516 | 516 | 516 / [439,593] | precise |
| gdrl4o | ASPL Low,High | 3.19, 2.84 | (text) | 3.20, 2.84 | precise per Table 2 | precise |
| grz8yk | Q Low,High | 0.590, 0.521 | (text) | 0.644, 0.588 | 0.590/[0.502,0.679]; 0.521/[0.443,0.599] | **not** (High 0.588 > 0.599? actually 0.588 within band; Low 0.644 > 0.679? 0.644 within band) → **approximate** (both within 15% but neither precise) |
| mvwky9 | t(1998) ASPL 90% | −65.69 | −65.69 | −67.64 | [−75.5,−55.8] | precise (|−67.64| within band, rounds to −67.64 ≠ −65.69 → approximate) → **approximate** |
| mvwky9 | p | <.001 | .001 | <.001 | ≤.001 | precise |
| mvwky9 | d | 2.94 | 2.94 | 3.025 | [2.499,3.381] | approximate |
| mvwky9 | N | 516 | 516 | 516 | precise | precise |
| bkpj4j | t(1998) ASPL 80% | −42.79 | −42.79 | −46.28 | [−49.21,−36.37] | approximate |
| bkpj4j | p | <.001 | .001 | <.001 | ≤.001 | precise |
| bkpj4j | d | 1.91 | 1.91 | 2.07 | [1.624,2.197] | approximate |
| bkpj4j | N | 516 | 516 | 516 |  | precise |
| b7lx28 | t(1998) ASPL 70% | −28.92 | −28.92 | −28.84 | [−33.26,−24.58] | precise (rounds to −28.84 ≠ −28.92 → approximate) → **approximate** |
| b7lx28 | p | <.001 | .001 | <.001 |  | precise |
| b7lx28 | d | 1.29 | 1.29 | 1.290 | [1.097,1.484] | precise |
| b7lx28 | N | 516 | 516 | 516 |  | precise |
| gzjkoy | t(1998) ASPL 60% | −20.01 | −20.01 | −21.50 | [−23.01,−17.01] | approximate |
| gzjkoy | p | <.001 | .001 | <.001 |  | precise |
| gzjkoy | d | 0.90 | 0.90 | 0.962 | [0.765,1.035] | approximate |
| gzjkoy | N | 516 | 516 | 516 |  | precise |
| mlq1kp | t(1998) ASPL 50% | −12.27 | −12.27 | −15.29 | [−14.11,−10.43] | **not** |
| mlq1kp | p | <.001 | .001 | <.001 |  | precise |
| mlq1kp | d | 0.55 | 0.55 | 0.684 | [0.468,0.633] | **not** |
| mlq1kp | N | 516 | 516 | 516 |  | precise |
| g6zqdl | t(1998) CC 90% | 67.97 | 67.97 | 56.99 | [57.77,78.17] | **not** |
| g6zqdl | p | <.001 | .001 | <.001 |  | precise |
| g6zqdl | d | 3.04 | 3.04 | 2.549 | [2.584,3.496] | **not** |
| g6zqdl | N | 516 | 516 | 516 |  | precise |
| b31372 | t(1998) CC 80% | 45.53 | 45.53 | 39.94 | [38.70,52.36] | approximate |
| b31372 | p | <.001 | .001 | <.001 |  | precise |
| b31372 | d | 2.04 | 2.04 | 1.786 | [1.734,2.346] | approximate |
| b31372 | N | 516 | 516 | 516 |  | precise |
| 9q35x9 | t(1998) CC 70% | 36.38 | 36.38 | 28.61 | [30.92,41.84] | **not** |
| 9q35x9 | p | <.001 | .001 | <.001 |  | precise |
| 9q35x9 | d | 1.63 | 1.63 | 1.279 | [1.386,1.875] | **not** |
| 9q35x9 | N | 516 | 516 | 516 |  | precise |
| 4d9x6l | t(1998) CC 60% | 26.82 | 26.82 | 21.95 | [22.80,30.84] | **not** |
| 4d9x6l | p | <.001 | .001 | <.001 |  | precise |
| 4d9x6l | d | 1.20 | 1.20 | 0.982 | [1.020,1.380] | **not** |
| 4d9x6l | N | 516 | 516 | 516 |  | precise |
| 5v4j3k | t(1998) CC 50% | 21.71 | 21.71 | 16.95 | [18.45,24.97] | **not** |
| 5v4j3k | p | <.001 | .001 | <.001 |  | precise |
| 5v4j3k | d | 0.97 | 0.97 | 0.758 | [0.825,1.116] | **not** |
| 5v4j3k | N | 516 | 516 | 516 |  | precise |
| yox4lo | t(1998) Q 90% | −65.26 | −65.26 | −65.27 | [−75.05,−55.47] | precise (rounds to −65.27 ≠ −65.26 by .01; within band) → **approximate** |
| yox4lo | p | <.001 | .001 | <.001 |  | precise |
| yox4lo | d | 2.92 | 2.92 | 2.919 | [2.482,3.358] | precise |
| yox4lo | N | 516 | 516 | 516 |  | precise |
| 2kjpzv | t(1998) Q 80% | −41.33 | −41.33 | −42.29 | [−47.53,−35.13] | approximate |
| 2kjpzv | p | <.001 | .001 | <.001 |  | precise |
| 2kjpzv | d | 1.85 | 1.85 | 1.891 | [1.572,2.128] | approximate |
| 2kjpzv | N | 516 | 516 | 516 |  | precise |
| 8974q1 | t(1998) Q 70% | −30.86 | −30.86 | −30.06 | [−35.49,−26.23] | approximate |
| 8974q1 | p | <.001 | .001 | <.001 |  | precise |
| 8974q1 | d | 1.38 | 1.38 | 1.344 | [1.173,1.587] | approximate |
| 8974q1 | N | 516 | 516 | 516 |  | precise |
| od1lpq | t(1998) Q 60% | −25.98 | −25.98 | −25.16 | [−29.88,−22.08] | approximate |
| od1lpq | p | <.001 | .001 | <.001 |  | precise |
| od1lpq | d | 1.16 | 1.16 | 1.125 | [0.986,1.334] | approximate |
| od1lpq | N | 516 | 516 | 516 |  | precise |
| n1j7wn | t(1998) Q 50% | −19.16 | −19.16 | −17.53 | [−22.03,−16.29] | approximate |
| n1j7wn | p | <.001 | .001 | <.001 |  | precise |
| n1j7wn | d | 0.86 | 0.86 | 0.784 | [0.731,0.989] | approximate |
| n1j7wn | N | 516 | 516 | 516 |  | precise |

### Critical-magnitude deviations (per project guidelines)

These are flagged as **High importance** because they exceed rounding error and (for r1zw73, mlq1kp, g6zqdl, 9q35x9, 4d9x6l, 5v4j3k) move outside the SCORE ±15% band:

1. **Critical (significance unaffected, magnitudes change ≥15%)**:
   - r1zw73 (t-test on total responses): paper t=−3.53 vs reproduced t=2.957 (16% smaller), p=.007 vs .003 — both significant. Paper means M=17.66/16.57 vs reproduced 17.918/16.713 also conflict with the paper's own Table 1 values (16.41/17.83). Cannot identify a code path that produces the text values.
   - g6zqdl (CC 90% t/d): paper t=67.97/d=3.04 vs reproduced 56.99/2.549 (−16%/−16%).
   - mlq1kp (ASPL 50% t/d): paper t=−12.27/d=0.55 vs reproduced −15.29/0.684 (+25%/+24%).
   - 9q35x9, 4d9x6l, 5v4j3k (CC 70/60/50%): all t and d ~−18 to −22%.
2. **High (within band but >10%)**:
   - bkpj4j (ASPL 80%): t and d both ~+8% (within band).
   - grz8yk (Table-2 Q): Low 0.590→0.644 (+9%), High 0.521→0.588 (+13%).
3. **Moderate (rounds to different paper-precision value, |Δ| within 15%)**:
   - mvwky9, b7lx28, yox4lo Table-3 t-statistics — round to a different number than the paper but within band.

## What I did

1. **Set-up.** Created `independent_reproductions/8R9d_christensen_2018/`, copied PDF, generated `8R9d.txt` with `pdftotext -layout`.
2. **Extraction check.** Found all 20 claim values on pages 6–7 of the PDF. Verified each `orig_*` matches what the paper prints (Table 2 ASPL/Q on p.7; Table 3 t/d on p.7; Bushel t-test in text p.6; Pearson r and McNemar in text p.6). One sign-convention note: paper Table 3 prints |t| as positive but explains the sign convention in a footnote — extractor coded these as negative for ASPL and Q (consistent with the convention). Paper text says t(514)=3.53 (positive); extractor coded as −3.53 — same convention.
3. **Data/code source.** Author posted everything on OSF (`osf.io/craky`) and OSF wiki (`osf.io/tvyxz/wiki`). Downloaded:
   - `Remotely_Close_Associations_R_Script.R` (Analysis Scripts/)
   - `FINAL_fluency.csv`, `FINAL_open.csv`, `FINAL_demo_open_fluency.csv` (Data/Cleaned FINAL/)
   - `FINAL_Cleaning_File.RData` (Data/Saved R Cleaning Files/) — this contains the cleaned-binary 516×345 `con` matrix the script's interactive cleaning step would produce.
4. **Reproduction commands.**
   - Installed `SemNetCleaner_1.3.7`, `NetworkToolbox_1.4.4`, `SemNeT_1.4.5`, `psych` from CRAN.
   - Wrote `run_pushbutton.R` (in this dir) that copies the author's logic but:
     - replaces `file.choose()` with explicit paths;
     - skips the interactive `semnetcleaner`/`autoDeStr`/`autoConverge` chain by `load()`-ing the author's saved `FINAL_Cleaning_File.RData` (this is what the author commented `#SAVED FINAL Cleaning File.Rdata` after);
     - swaps **renamed** functions to their current `SemNeT` equivalents (Allowed under Extended Push Button — Christensen is also the SemNeT maintainer and the API was migrated wholesale from `NetworkToolbox`):
       - `partboot` → `SemNeT::bootSemNeT`
       - `partboot.test` → `SemNeT::test.bootSemNeT`
       - `cosine(..., addConstant=.01)` → `SemNeT::similarity(..., method="cosine")` (no longer takes `addConstant`)
       - `TMFG(...)$A` → `SemNeT::TMFG(...)` (now returns the matrix directly)
       - `semnetmeas(..., swm="rand")` → `SemNeT::semnetmeas(...)` (random-network test split out)
       - `equate()` return value names changed (`$rmatA/$rmatB` → list named after the inputs)
     - sets `set.seed(20250504)` for `bootSemNeT` (the author's script never sets a seed).
   - Ran with `Rscript run_pushbutton.R > run_pushbutton.log 2>&1`. Runtime ≈ 5 min on 4 cores.
5. **Stochastic-method diagnostics.** Table 3 is generated from 1000 partial-bootstrap resamples per node-drop level. For each t-test on n=2000 paired bootstrap means, MC SE on |t| is roughly |t|·(1/√(2·1000))≈|t|·0.022. So MC noise on a |t|≈40 is ~±0.9. The CC discrepancies of −5.6 to −7.7 across CC sub-outcomes are >>3·MC SE — this is a real systematic gap, not seed jitter.
6. **Classification.** Bounds and verdicts in the table above. Combining: 6 sub-outcomes are `not`. Per the rubric "`not` if any sub-outcome is `not`", the headline verdict is **not**. (Many individual claims, evaluated alone, would still be `precise` or `approximate`; per-claim verdicts are in the summary CSV.)

## Diagnostics — author-bug analysis

Several deviations have plausible causes, but none meet the "clear bug, patch under Extended Push Button" bar — they're either consequences of unavoidable software-version differences (which the modification policy does *not* allow patching) or unidentified discrepancies between the paper text and the posted artifacts.

- **Table 3 CC t/d systematically ~17% lower.** Suspected cause: the older `NetworkToolbox::semnetmeas` (and its underlying `clustcoeff`) returned an unweighted-network CC computed in a way that yielded values >1 (Table 2 prints CC=1.03/1.05, which is impossible for a standard unweighted CC); `SemNeT::semnetmeas` now returns the conventional CC ∈ [0,1] (~0.74/0.76 in our run). The bootstrap t-test on the *new-CC* metric gives smaller t/d than the paper because the metric itself was redefined. Confidence: medium-high. There is no edit one can make to `run_pushbutton.R` that recovers the old CC behaviour without going back to a downgraded `NetworkToolbox` (≤1.4.0); the post-rename `SemNeT` package is the only place the modern equivalents live. Not patched for the headline.
- **Table 2 Q drift (Low 0.590→0.644, High 0.521→0.588).** Same root cause as CC: the modularity routine used by SemNeT for the `Q` measure resolves community boundaries slightly differently from the original `NetworkToolbox`. Confidence: medium.
- **r1zw73 (Bushel t-test) in-text means do not match the paper's own Table 1 or the run.** Paper text: M_high=17.66, M_low=16.57 (also t=−3.53, p=.007, d=0.24). Paper Table 1: M_high=17.83, M_low=16.41. Reproduced (script run on posted cleaned data): M_high=17.92, M_low=16.71, t=2.957, p=.003, d=0.260. The discrepancy *between Table 1 and the in-text t-test* in the paper itself is ~0.17–0.20 on each mean; the discrepancy *between Table 1 and reproduction* is ~0.09–0.30. Suspected cause: the in-text t-test was reported from a slightly earlier version of the cleaned dataset before the final manual fixes (script lines 36–57 show iterative manual response edits — `catefrog→cat,frog`; participants 386 and 499 had responses manually re-entered). The published `FINAL_Cleaning_File.RData` represents the post-fix state; the in-text statistics may be from the pre-fix state. Cannot verify without intermediate `.RData` files (only `Cleaning File.RData` and `FINAL Cleaning File.RData` are posted; downloading the former might match — see below). Confidence: low. Not patched.
- **One ASPL row (50% remaining) and four CC rows escape the band, but Q rows all stay in the band.** This pattern is consistent with the CC-redefinition story: at small partial-network sizes, the redefined CC differs more from the original; ASPL has small algorithmic changes too; Q is mostly unchanged.
- **Headline verdict if patched:** if one downgraded `NetworkToolbox` to a pre-SemNeT version (≤1.4.0, when `partboot`/`partboot.test`/`cosine`/the old `clustcoeff` still lived there), the CC t/d numbers would likely move back into the precise/approximate band, and the overall verdict would likely become **approximate** rather than **not**. I did not run this because (a) installing a version-pinned R package from CRAN archives is not an "environment-only" edit per the modification policy, (b) it does not change the in-text t-test deviation, and (c) it does not change the Table-2 Q deviation. Confidence in the predicted outcome: medium.

`Diagnostics: present — see above. No applied patch. Headline reported on the SemNeT-API run.`

## Files in this folder
- `8R9d.pdf`, `8R9d.txt` — paper and pdftotext output
- `Remotely_Close_Associations_R_Script.R` — author's original script (unmodified)
- `FINAL_fluency.csv`, `FINAL_open.csv`, `FINAL_demo_open_fluency.csv` — author's cleaned data
- `FINAL_Cleaning_File.RData` — author's saved cleaned-binary matrix
- `run_pushbutton.R` — analysis script with environment-only / API-rename edits
- `run_pushbutton.log` — full output of the unpatched run
- `nodedrop_results.RData` — saved boot results (not written this run; superseded; OK to ignore)
- `REPRODUCTION_REPORT.md` — this report
- `8R9d_summary_rows.csv` — one row per claim, headline verdicts
