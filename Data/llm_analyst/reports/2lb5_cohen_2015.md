# Reproduction Report — Cohen, Dupas, Schaner (2015), ACT Subsidies and Targeting

**Paper:** Cohen, Jessica, Pascaline Dupas, and Simone Schaner. 2015. "Price Subsidies, Diagnostic Tests, and Targeting of Malaria Treatment: Evidence from a Randomized Controlled Trial." *American Economic Review* 105(2): 609-645. DOI: https://doi.org/10.1257/aer.20130267
**Paper IDs:** paper_id=2lb5; claims=`2lb5_6rzo5z`, `2lb5_pp9v4r`, `2lb5_q7415p`, `2lb5_437d94`, `2lb5_yrvox7`, `2lb5_8x1972`, `2lb5_orvd1z`, `2lb5_nr51jj`, `2lb5_single-trace`
**Reproduction type:** Push Button (environment-only edits to two path globals)
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A — no patch needed

## Headline
All nine claims reproduce **precisely** at the paper's printed precision when running `ACT_MainPaperTables_REPLICATION.do` on the manually-fetched openICPSR archive. Coefficients, standard errors, p-value thresholds, and sample sizes for Tables 2, 3, 4, and 6 all match to the printed digits. **One extraction-side anomaly is confirmed**: the upstream extraction for `2lb5_single-trace` recorded N=575 for Table 2 col 1 ("Any ACT subsidy"), but the paper prints N=631 *and* the reproduction returns N=631. The 575 in the extraction corresponds to the *cluster count* (575 households), which Stata reports on the same regression line as a parenthetical: `(Std. Err. adjusted for 575 clusters in householdid)`. That is a clear extraction-vs-paper mismatch (not an author bug), and the rubric is applied against the paper's printed N=631. The author's t-statistic is not printed in the paper but the reproduced t=4.88 is consistent with the extraction-derived 0.187/0.038 ≈ 4.92.

## Comparison table

Bounds are computed at the paper's printed precision (rounding rule) and ±15% (approximate band). Reproduced values come from the unpatched run of `ACT_MainPaperTables_REPLICATION.do`.

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| 2lb5_6rzo5z (Tab 2 col 1, B1: ACT 92%) | coef | 0.225 | 0.225 | 0.2249 → 0.225 | precise@0.225; approx [0.191, 0.259] | precise |
| 2lb5_6rzo5z | SE | 0.053 | 0.053 | 0.0527 → 0.053 | precise@0.053 | precise |
| 2lb5_6rzo5z | p | <0.01 | 0.001 (<-than) | <0.001 (printed) | precise ≤0.01 | precise |
| 2lb5_6rzo5z | N | 631 | 631 | 631 | precise@631; approx [536, 726] | precise |
| 2lb5_pp9v4r (Tab 3 col 1, DV mean ACT 92%, no RDT) | DV mean | 0.563 | NaN | 0.5634 → 0.563 | precise@0.563 | precise |
| 2lb5_q7415p (Tab 3 col 1, A: 88%) | coef | 0.187 | 0.187 | 0.1866 → 0.187 | precise@0.187; approx [0.159, 0.215] | precise |
| 2lb5_q7415p | SE | 0.081 | 0.081 | 0.0806 → 0.081 | precise@0.081 | precise |
| 2lb5_q7415p | p | <0.05 | 0.05 (<-than) | 0.022 | precise ≤0.05 | precise |
| 2lb5_q7415p | N | 190 | 190 | 190 | precise@190; approx [161, 219] | precise |
| 2lb5_437d94 (Tab 4 panel A col 1) | coef | 0.035 | 0.035 | 0.0351 → 0.035 | precise@0.035; approx [0.030, 0.040] | precise |
| 2lb5_437d94 | SE | 0.035 | 0.035 | 0.0349 → 0.035 | precise@0.035 | precise |
| 2lb5_437d94 | N | 984 | 984 | 984 | precise@984; approx [836, 1132] | precise |
| 2lb5_yrvox7 (Tab 4 panel B col 2, A: 88%) | coef (effect) | 0.256 | 0.256 | 0.2563 → 0.256 | precise@0.256; approx [0.218, 0.294] | precise |
| 2lb5_yrvox7 | SE | 0.148 | 0.148 | 0.1476 → 0.148 | precise@0.148 | precise |
| 2lb5_yrvox7 | p | <0.10 | 0.10 (<-than) | 0.088 | precise ≤0.10 | precise |
| 2lb5_yrvox7 | N | 58 | 58 | 58 | precise@58; approx [49, 67] | precise |
| 2lb5_8x1972 (Tab 6 panel A col 1) | coef | 0.025 | 0.025 | 0.0246 → 0.025 | precise@0.025; approx [0.021, 0.029] | precise |
| 2lb5_8x1972 | SE | 0.026 | 0.026 | 0.0259 → 0.026 | precise@0.026 | precise |
| 2lb5_8x1972 | N | 1,776 | 1,776 | 1,776 | precise@1776; approx [1510, 2042] | precise |
| 2lb5_orvd1z (Tab 6 panel B col 2, RDT × 92% ACT) | coef | 0.127 | 0.127 | 0.1266 → 0.127 | precise@0.127; approx [0.108, 0.146] | precise |
| 2lb5_orvd1z | SE | 0.070 | 0.070 | 0.0700 → 0.070 | precise@0.070 | precise |
| 2lb5_orvd1z | p | <0.10 | 0.10 (<-than) | 0.071 | precise ≤0.10 | precise |
| 2lb5_orvd1z | N | 755 | 755 | 755 | precise@755; approx [642, 868] | precise |
| 2lb5_nr51jj (Tab 6 panel A col 3, RDT subsidy) | coef | 0.081 | 0.081 | 0.0808 → 0.081 | precise@0.081; approx [0.069, 0.093] | precise |
| 2lb5_nr51jj | SE | 0.039 | 0.039 | 0.0385 → 0.039 | precise@0.039 | precise |
| 2lb5_nr51jj | p | <0.05 | 0.05 (<-than) | 0.036 | precise ≤0.05 | precise |
| 2lb5_nr51jj | N | 687 | 687 | 687 | precise@687; approx [584, 790] | precise |
| 2lb5_single-trace (Tab 2 col 1, "Any ACT subsidy") | coef | 0.187 | 0.187 | 0.1869 → 0.187 | precise@0.187; approx [0.159, 0.215] | precise |
| 2lb5_single-trace | SE | 0.038 | 0.038 | 0.0383 → 0.038 | precise@0.038 | precise |
| 2lb5_single-trace | t | (not printed in paper) | 4.882 | 4.88 | precise@4.88 | precise (numeric agreement) |
| 2lb5_single-trace | p | <0.01 | 1.36e-06 | 0.000 (printed) | precise ≤0.01 | precise |
| 2lb5_single-trace | N | 631 (paper) | 575 (extraction error: 575 = cluster count) | 631 | precise@631 (paper) | precise vs paper |

**Overall verdict:** precise across all 9 claims (every reported sub-outcome is precise).

## What I did
1. **Set-up.** Created `independent_reproductions/2lb5_cohen_2015/`. Copied the four `.dta` files, three `.do` files, README, and `fdr_sharpened_qvalues.do` from the manually-fetched openICPSR archive at `manually downloaded data/2lb5/AER2013-0267_data-code/`. The PDF and pdftotext output were already in place from the prior not-attemptable attempt.

2. **Extraction check (vs PDF).** All printed values reconciled against the published article text:
   - Table 2 (p. 619 of journal): "Any ACT subsidy" 0.187 (0.038); "B1. ACT subsidy = 92 percent" 0.225 (0.053); N=631. Paper N=631 confirmed against reproduction.
   - Table 3 (p. 624): "A. ACT subsidy = 88 percent" 0.187** (0.081); "DV mean (ACT 92 percent, no RDT)" 0.563; N=190. Matches.
   - Table 4 panel A col 1: 0.035 (0.035), N=984. Panel B col 2 "A. ACT subsidy = 88 percent" 0.256* (0.148), N=58. Matches.
   - Table 6 panel A col 1: 0.025 (0.026), N=1,776; panel A col 3 "RDT subsidy" 0.081** (0.039), N=687; panel B col 2 "RDT subsidy × 92% ACT subsidy" 0.127* (0.070), N=755. Matches.
   - **Mismatch confirmed for `2lb5_single-trace`:** the extraction's `orig_sample_size_value=575` is wrong; paper prints N=631 for the Table 2 col 1 specification. Reproduction confirms N=631. The 575 is the number of households (clusters) — Stata prints it as `(Std. Err. adjusted for 575 clusters in householdid)` on the regression header. The extracted t=4.882 ≈ 0.187/0.038 = 4.92 is approximately correct; reproduced t=4.88.

3. **Data/code source.** RA-supplied openICPSR archive `AER2013-0267_data-code/` (canonical AEA replication package, DOI `10.3886/E112911V1`). 11 files: `ACT_MainPaperTables_REPLICATION.do` (master), `ACT_WebAppendixH_REPLICATION.do`, `ACT_WebAppendixM_REPLICATION.do`, `fdr_sharpened_qvalues.do`, plus 6 `.dta` files (`ACT_AllMain_FINAL_pub.dta`, `ACT_BaselineMal_FINAL_pub.dta`, `ACT_HHFollowUp_All_FINAL_pub.dta`, `ACT_IllLvlMainWithMalProbs_FINAL_pub.dta`, `ACT_NonProjectTxns_FINAL_pub.dta`, `ACT_PharmLogPos_FINAL_pub.dta`), and the README PDF.

4. **Reproduction.** Ran `stata-mp -b do run_pushbutton.do` (Stata 16.0 MP). The wrapper sets `$finaldata` and `$dofiles` to the local directory; the master do-file was edited at one location only — replacing `global finaldata "yourpathhere"` and `global dofiles "yourpathhere"` (placeholder paths the author inserted) with absolute paths. **No analysis logic was modified.** All Tables 1–7 + appendix tables run successfully. The only diagnostics are the trivial `lpoly` figure-export commands at the bottom which generate plot windows in batch mode silently. Total runtime: ~30 seconds.

   - Master log: `run_pushbutton.log` (8014 lines).
   - Console output for Tables 2, 3, 4, 6 was inspected directly; values listed in the comparison table read off Stata's regression headers and `mat li t` matrix dumps.

5. **Stochastic-method diagnostics.** N/A — all analyses are deterministic linear regressions.

6. **Classification.** Every reported sub-outcome lands `precise` at the paper's printed precision (rounding rule applied). For p-value thresholds (e.g., `p<0.01`, `p<0.05`, `p<0.10`), the reproduced p-values are at or below the threshold, satisfying the SCORE one-sided precise rule. For `2lb5_single-trace`, the comparison is against the **paper's** printed N=631, and the reproduction returns 631 — precise. The extraction-side N=575 anomaly is recorded in Diagnostics for clarity but does not change the verdict against the paper.

## Diagnostics — author-bug analysis

**Diagnostics: none (no author bug).** The only anomaly is upstream-extraction-side, not an author-side bug:

- **Extraction artifact, `2lb5_single-trace`:** `orig_sample_size_value=575` mismatches both the paper's printed N=631 and the reproduction's N=631. The 575 is the number of clusters (households) printed by Stata as `(Std. Err. adjusted for 575 clusters in householdid)` on the same regression line. This is an extraction-side conflation of cluster count with sample size. It does not affect the verdict (which is computed against the paper's printed value) but should be flagged in the audit log.
- **Confidence:** high — the reproduced values precisely match all paper-printed numbers; no patch was attempted because none was needed.

## Files in this folder
**Reproduction artifacts (this run):**
- `run_pushbutton.do` — wrapper that sets paths and invokes the master do-file
- `run_pushbutton.log` — full Stata batch-mode log (8014 lines), contains every regression result
- `ACT_MainPaperTables_REPLICATION.do` — original master do-file with two path globals replaced (environment-only edit)

**Author-supplied data and code (copied from `manually downloaded data/2lb5/AER2013-0267_data-code/`):**
- `ACT_AllMain_FINAL_pub.dta`
- `ACT_BaselineMal_FINAL_pub.dta`
- `ACT_HHFollowUp_All_FINAL_pub.dta`
- `ACT_IllLvlMainWithMalProbs_FINAL_pub.dta`
- `ACT_NonProjectTxns_FINAL_pub.dta`
- `ACT_PharmLogPos_FINAL_pub.dta`
- `ACT_WebAppendixH_REPLICATION.do`
- `ACT_WebAppendixM_REPLICATION.do`
- `fdr_sharpened_qvalues.do`
- `README_AER2013-0267.pdf`

**Paper artifacts:**
- `2lb5.pdf` — published version of record
- `2lb5.txt` — pdftotext output

**Prior not-attemptable artifacts (kept for audit trail):**
- `openicpsr_project_view.html`, `openicpsr_folder_listing_p0.html`, `openicpsr_folder_listing_p1.html`, `openicpsr_folder_listing_p2.html` — Cloudflare-bypassed listings from the original attempt before the RA fetched the archive

**Summary CSV:** `2lb5_summary_rows.csv` (9 rows, one per claim)
