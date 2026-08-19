# Reproduction Report — Grossman & Lewis (2014), Administrative Unit Proliferation

**Paper:** Grossman, Guy and Janet I. Lewis. 2014. "Administrative Unit Proliferation." *American Political Science Review* 108(1): 196–217. DOI: [10.1017/S0003055413000567](https://doi.org/10.1017/S0003055413000567).
**Paper IDs:** paper_id=LyWB; claims = 37 (g4161d, m5939x, mydldv, b2xzx8, m8yqyv, bojpjy, bnxwx9, bdnonr, br474w, 9zwvn8, 48o25d, 58d2yx, y7z21v, 285298, 8862ov, oq6yny, npzyo9, dy64qr, rljy6w, vpoyq5, k6o4yd, 7dz284, zl6o9k, l3dk22, 68vd26, 38274j, wqd2x3, pxwkzw, qzqywo, xxv246, jl2kor, 189dok, 9zwvp8, 48o2zd, 58d2lx, y7z25v, 2852n8).
**Reproduction type:** Push Button (one environment-only edit: `cd` path).
**Headline verdict (unpatched):** approximate (32/37 precise; 5/37 approximate)
**Verdict if patched:** N/A — no logic patches considered.

## Headline

The replication is essentially a clean push-button success: all 37 reported coefficients reproduce to the paper's printed precision (i.e., every coefficient claim is `precise` after rounding to the paper's 2-decimal print). Sample sizes also match exactly across Tables 4-8. The deviations from the headline `precise` verdict come from p-value threshold edge cases: four Table 8 (Museveni vote share) claims with reproduced p-values slightly *above* the paper's claimed significance thresholds — model (A) p=0.053 (paper p<0.05), (B) p=0.044 (paper p<0.01, **flagged**), (D) p=0.055 (paper p<0.05), (E) p=0.098 (paper p<0.05) — and one Table 5 claim, **oq6yny** (M6 social services index), where reproduced p displays as 0.010 vs paper-claim p<0.01. Under the rubric's strict-inequality threshold rule (precise requires reproduced p strictly *below* the printed threshold), p=0.010 demotes to `approximate` even though the underlying z = −2.58 implies p ≈ 0.0099, which is strictly < 0.01 — i.e., a Stata-display rounding knife-edge. (Under the prior rubric this sub-outcome was coded `precise` via the ≤-threshold rule; under the current rubric it flips to `approximate` on the displayed value.) Model (B) on Table 8 remains the most substantive deviation — paper claims p<0.01 (one star higher than M(A)/M(C)/M(D)) but reproduction yields p≈0.044 (one star lower). Model (E) is also borderline — paper claims significance at α=0.05 but reproduction puts it at p≈0.098. These are not coefficient-magnitude discrepancies (the point estimates round identically), they are p-value discrepancies; the standard errors also reproduce identically. Tables 4-7 minus oq6yny (32 of 37 claims) reproduce both coefficients and significance threshold claims exactly. Data and code are publicly archived on Harvard Dataverse (doi:10.7910/DVN/26937).

## Comparison table

All values rounded to paper precision. Reproduced values from Stata 18 `xtlogit ... re` / `xtreg fe / re` / `xtmelogit` / `xtdpd` runs. Paper p-value thresholds applied per SCORE rubric (one-sided toward larger reproduced p).

| Claim | Table/Model | Sub-outcome | Paper | Reproduced | Sub-verdict |
|---|---|---|---|---|---|
| g4161d | T4 M1 | DEC share ratio | β=−0.78, p<0.01, N=434 | β=−0.78 (−.7788), p=0.000, N=434 | precise |
| m5939x | T4 M1 | Development index | β=−1.81, p<0.01, N=434 | β=−1.81 (−1.808), p=0.000, N=434 | precise |
| mydldv | T4 M1 | Ethnic marg. | β=1.32, p<0.01, N=434 | β=1.32, p=0.002, N=434 | precise |
| b2xzx8 | T4 M2 | DEC share ratio | β=−0.75, p<0.01, N=428 | β=−0.75, p=0.000, N=428 | precise |
| m8yqyv | T4 M2 | Development index | β=−1.59, p<0.01, N=428 | β=−1.59, p=0.002, N=428 | precise |
| bojpjy | T4 M2 | Ethnic marg. | β=1.47, p<0.01, N=428 | β=1.47, p=0.001, N=428 | precise |
| bnxwx9 | T4 M3 | DEC share ratio | β=−0.84, p<0.01, N=434 | β=−0.84, p=0.000, N=434 | precise |
| bdnonr | T4 M3 | Development index | β=−1.84, p<0.01, N=434 | β=−1.84, p=0.000, N=434 | precise |
| br474w | T4 M3 | Ethnic marg. | β=1.46, p<0.01, N=434 | β=1.46, p=0.001, N=434 | precise |
| 9zwvn8 | T4 M4 | DEC share ratio | β=−0.79, p<0.01, N=428 | β=−0.79, p=0.000, N=428 | precise |
| 48o25d | T4 M4 | Development index | β=−1.62, p<0.01, N=428 | β=−1.62, p=0.001, N=428 | precise |
| 58d2yx | T4 M4 | Ethnic marg. | β=1.53, p<0.01, N=428 | β=1.53, p=0.001, N=428 | precise |
| y7z21v | T4 M5 | DEC share ratio | β=−0.78, p<0.01, N=426 | β=−0.78, p=0.000, N=426 | precise |
| 285298 | T4 M5 | Development index | β=−1.62, p<0.01, N=426 | β=−1.62, p=0.001, N=426 | precise |
| 8862ov | T4 M5 | Ethnic marg. | β=1.54, p<0.01, N=426 | β=1.54, p=0.001, N=426 | precise |
| **oq6yny** | **T5 M6** | **Social services index** | **β=−1.70, p<0.01**, N=428 | **β=−1.70, p=0.010, N=428** | **approximate** (p=0.010 fails strict p<0.01; underlying z=−2.58 implies p≈0.0099 — display knife-edge) |
| npzyo9 | T5 M7 | Economic activity index | β=−1.00, p<0.01, N=428 | β=−1.00, p=0.001, N=428 | precise |
| dy64qr | T5 M8 | County share of seats in DEC | β=−3.55, p<0.01, N=428 | β=−3.55, p=0.000, N=428 | precise |
| rljy6w | T6 M9 | DEC share ratio (between) | β=−0.43, p<0.1, N=428 | β=−0.43, p=0.092, N=428 | precise |
| vpoyq5 | T6 M9 | DEC share/pop share (within) | β=−1.13, p<0.01, N=428 | β=−1.13, p=0.002, N=428 | precise |
| k6o4yd | T6 M9 | Development index | β=−1.58, p<0.01, N=428 | β=−1.58, p=0.002, N=428 | precise |
| 7dz284 | T6 M9 | Ethnic marg. (between) | β=3.72, p<0.05, N=428 | β=3.72, p=0.018, N=428 | precise |
| zl6o9k | T6 M10 | DEC share ratio (between) | β=−0.47, p<0.1, N=428 | β=−0.47, p=0.071, N=428 | precise |
| l3dk22 | T6 M10 | DEC share/pop share (within) | β=−1.37, p<0.01, N=428 | β=−1.37, p=0.000, N=428 | precise |
| 68vd26 | T6 M10 | Development index | β=−1.79, p<0.01, N=428 | β=−1.79, p=0.001, N=428 | precise |
| 38274j | T6 M10 | Ethnic marg. (between) | β=3.69, p<0.05, N=428 | β=3.69, p=0.018, N=428 | precise |
| wqd2x3 | T7 a1 (1996-2000) | DEC share ratio | β=−0.56, p<0.1, N=148 | β=−0.56, p=0.058, N=148 | precise |
| pxwkzw | T7 a1 | Development index | β=−2.79, p<0.1, N=148 | β=−2.79, p=0.069, N=148 | precise |
| qzqywo | T7 a2 (2001-2005) | DEC share ratio | β=−3.20, p<0.01, N=147 | β=−3.20, p=0.000, N=147 | precise |
| xxv246 | T7 a2 | Development index | β=−1.52, p<0.1, N=147 | β=−1.52, p=0.072, N=147 | precise |
| jl2kor | T7 a3 (2006-2010) | DEC share ratio | β=−0.69, p<0.1, N=133 | β=−0.69, p=0.096, N=133 | precise |
| 189dok | T7 a3 | Development index | β=−1.61, p<0.1, N=133 | β=−1.61, p=0.088, N=133 | precise |
| **9zwvp8** | **T8 (A) FE** | **Splinter** | **β=0.027, p<0.05**, N=644 | **β=0.027, p=0.053, N=644** | **approximate** |
| **48o2zd** | **T8 (B) FE+lag** | **Splinter** | **β=0.030, p<0.01**, N=482 | **β=0.030, p=0.044, N=482** | **approximate** |
| 58d2lx | T8 (C) demean RE | Splinter | β=0.028, p<0.05, N=644 | β=0.028, p=0.049, N=644 | precise |
| **y7z25v** | **T8 (D) demean RE+eth** | **Splinter** | **β=0.027, p<0.05**, N=644 | **β=0.027, p=0.055, N=644** | **approximate** |
| **2852n8** | **T8 (E) Dynamic panel** | **Splinter** | **β=0.026, p<0.05**, N=475 | **β=0.026 (current splinter), p=0.098, N=475** | **approximate** |

Bounds for coef approximate band: ±15% of paper |β|. All reproduced coefficients fall well inside. Sample-size N matches exactly for all 37 claims. P-value bounds use the SCORE one-sided threshold rule.

## What I did

1. **Set-up.** Created `independent_reproductions/LyWB_grossman_2014/`, copied paper PDF, ran `pdftotext -layout` to inspect Tables 4-8 on pp. 207-211.
2. **Extraction check.** Verified each of the 37 extracted `orig_*` values directly against the printed PDF tables. All extracted values match the paper's printed values exactly.
   - Note: claims `LyWB_npzyo9` and `LyWB_dy64qr` had truncated `claim_result_text` strings (no bracketed Table reference visible) but their numeric values uniquely identify them (M7 ECON index = −1.00; M8 county share of DEC = −3.55).
   - Paper Table 8 footnote uses non-standard star convention: `* p < 0.05, ** p < 0.01, *** p < 0.001` (rather than the more common 0.10/0.05/0.01); the extraction follows this correctly.
3. **Data/code source.** Replication package on Harvard Dataverse, [doi:10.7910/DVN/26937](https://doi.org/10.7910/DVN/26937), linked from Grossman's personal page. Two files: `Data analysis.do` (282 lines) and `DistrictFormation.dta` (~423KB).
4. **Reproduction.** Ran `stata-mp -b do run_pushbutton.do`. Single environment-only edit: changed the hard-coded `cd "~/Dropbox/District.Formation/data/replication files/"` to the local working directory, and inserted a `log using` after `set more off`. The script ran end-to-end and produced all regressions for Tables 4 (M1-M5), 5 (M6-M8), 6 (M9-M10), 7 (a1-a3 by wave), and 8 (fe1, fe2, re4, re5, d1). It errors out only on the very last `esttab` for Table 8 (`coefficient i.split_cat not found` — an esttab/version syntax issue with factor-variable display) — but every regression had already executed and the coefficient/SE/p outputs are visible in the log. Runtime ≈10 seconds.
5. **Stochastic-method diagnostics.** Not applicable — all models are deterministic ML/GMM estimators with default Stata convergence settings.
6. **Classification.** Each claim's three sub-outcomes (coefficient, p, N) classified mechanically per the SCORE rubric. Coefficient comparisons use paper-precision rounding (2 decimals throughout for Tables 4-7; 3 decimals for Table 8). P-values use the threshold-based one-sided rule.

## Diagnostics — author-bug analysis

**Diagnostics: none — unpatched run reproduces all coefficients to paper precision; the five `approximate` verdicts arise from p-value threshold edge cases, not author bugs.**

There is no logic-level bug to patch. Coefficients and standard errors reproduce to the paper's printed precision in every cell of Tables 4-8. The five flagged cases reflect borderline significance:

- Table 5 (M6) Social services index coef −1.70, p=0.010 (paper marks `**` for p<0.01). The Stata-displayed p is exactly 0.010; the underlying z = −2.58 implies a true p ≈ 0.0099, strictly < 0.01. Under the rubric's strict-inequality threshold rule applied to the displayed value, this demotes to `approximate`; under a rule applied to the underlying value it would remain `precise`. A display knife-edge.

- Table 8 (A) Splinter coef 0.0270, SE 0.0139, p=0.053 (paper marks `*` for p<0.05). The reproduced p sits 0.003 above 0.05 — a knife-edge call that authors may have rounded down or that depends on whether one uses the cluster-robust SE option (none specified in the do-file).
- Table 8 (B) Splinter coef 0.0298, SE 0.0147, p=0.044 (paper marks `**` for p<0.01). The reproduced p (0.044) is inside the p<0.05 band but not the p<0.01 band the paper claims. Mild discrepancy worth noting — suggests the paper's table star may be a typo (should be `*` not `**`), or the printed SE was rounded from a smaller value than the do-file produces. Coefficient and SE round to paper values exactly.
- Table 8 (D) Splinter coef 0.0269 (rounds to 0.027), SE 0.0140, p=0.055 — same knife-edge pattern as (A).
- Table 8 (E) Splinter (dynamic panel `xtdpd`, current period contemp.) coef 0.0265, SE 0.0160, p=0.098. Paper claims `*` (p<0.05). The reproduced p is well above 0.05. The estimate magnitude and SE both round to the paper values, but the p-value gap is the largest. Possible explanations to investigate: the paper might have reported a p-value based on the lag rather than the contemporaneous coefficient; or used the one-step instead of two-step variance estimator with a small-sample correction.

These are not coefficient-magnitude discrepancies and do not affect the substantive conclusions of the paper. Per the modification policy, the headline verdict reflects unpatched output.

## Files in this folder

- `LyWB.pdf` — paper PDF (copy of `papers/LyWB.pdf`)
- `LyWB.txt` — `pdftotext -layout` extraction
- `Data analysis.do` — author's original Stata do-file (downloaded from Harvard Dataverse, unmodified)
- `DistrictFormation.dta` — author's data file (Harvard Dataverse)
- `run_pushbutton.do` — copy of `Data analysis.do` with two environment-only edits: (a) `cd` path replaced with local path; (b) `log using run_pushbutton.log, replace text` inserted after `set more off`. No analysis-logic changes.
- `run_pushbutton.log` — Stata log from the push-button run
- `REPRODUCTION_REPORT.md` — this report
- `LyWB_summary_rows.csv` — 37 rows, one per claim, in the required schema
