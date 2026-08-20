# Reproduction Report — Antràs & Chor (2013), "Organizing the Global Value Chain"

**Paper:** Antràs, Pol, and Davin Chor. 2013. "Organizing the Global Value Chain." *Econometrica* 81(6): 2127–2204. DOI: 10.3982/ECTA10813
**Paper IDs:** paper_id=a2Yx; claims=37 (a2Yx_3lxxq3, a2Yx_wy441x, a2Yx_pq7763, a2Yx_qxpp39, a2Yx_xz559w, a2Yx_jz7712, a2Yx_1yppy7, a2Yx_9xyyxo, a2Yx_46jj6r, a2Yx_531136, a2Yx_ylyylq, a2Yx_kz4wzr, a2Yx_7o25od, a2Yx_zxorx3, a2Yx_l8kp8k, a2Yx_6rd4ry, a2Yx_3n7jn1, a2Yx_w72o71, a2Yx_ppk1pq, a2Yx_q7y97r, a2Yx_9xyy5o, a2Yx_46jjxr, a2Yx_5311j6, a2Yx_ylyy4q, a2Yx_2zqqpk, a2Yx_8q554l, a2Yx_op33lv, a2Yx_nw667p, a2Yx_dojj32, a2Yx_r7qqwy, a2Yx_v599jx, a2Yx_kl889p, a2Yx_7p4499, a2Yx_z72257, a2Yx_l6zz4r, a2Yx_6w9919, a2Yx_single-trace)
**Reproduction type:** Push Button (only environment-only edit: commenting out the hardcoded `cd "C:\Users\davinchor\..."` line in each `Table*.do` so Stata runs in the current directory)
**Headline verdict (unpatched):** **precise** for 36/37 claims; **not** for 1/37 (a2Yx_qxpp39) due to a paper-side N typo (see Headline)
**Verdict if patched:** N/A — no analysis logic was patched. The single 'not' verdict is an upstream paper-printing issue, not a code/data problem.

## Headline

**HIGH-IMPORTANCE FINDINGS (per project guidelines, deviations are flagged at the top):**

1. **Paper typo on Table III, column 7 sample size.** The published paper prints **N = 270,991** for Table III column 7 (the country-industry-year regression with country-year fixed effects). My reproduction (running the author's `Table3.do` unmodified) returns **N = 207,991**, matching every other country-industry-year specification in Tables III, IV, V, VI, VII as well as the *other* number printed in the same row (col 8 also shows 207,991). The point estimate (-0.115), standard error (0.033), and significance level (p ≈ 0.001 vs. paper p<0.01) all reproduce *precisely*. This is virtually certain to be a typesetting/transcription error — likely "207,991" was mis-keyed as "270,991." Per the audit protocol the headline verdict for claim a2Yx_qxpp39 is therefore **not** (sample size differs by 23.4% from the paper's printed value, exceeding the 15% band), even though every substantive statistic reproduces exactly.

2. **Extraction error on Table III, column 8 (claim a2Yx_xz559w).** The extracted `orig_p_value` flags "p<0.05," but the paper's Table III col 8 prints β₁ = −0.075 with **no significance stars**, and the surrounding paper text explicitly says "β₁ remains negative (although **not statistically significant**)." Reproduced p = 0.303, consistent with the paper's stated non-significance. I treat the paper's actual reported p-status as `non-outcome` (no quantitative p reported in the paper) rather than scoring against the erroneous extraction, so this claim is verdicted **precise** on the unpatched run.

Apart from these two upstream issues, **every one of the 37 reported coefficients, every reported standard error, and every reported sample size reproduces to the paper's printed precision** when running the unmodified author Stata code on the unmodified author data downloaded from the Econometric Society supplementary materials archive. This is among the cleanest reproductions one could expect from a 2013 Econometrica paper: 39 distinct OLS regressions across 5 main-text tables, all matching to 3-decimal precision.

## Comparison table

(Bounds = ±15% of |paper coef|. p-bounds use the SCORE threshold rule for "p<X": precise = repro p ≤ X; approx = (X, X+0.05]; not = > X+0.05. Reproduced p-values are the exact P>|t| from the Stata cluster-robust regression output.)

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| a2Yx_3lxxq3 | Table III col 2 β₁ | coef=−0.196, se=0.071, N=2783, p<0.01 | same | coef=−0.196, se=0.071, N=2783, p=0.006 | coef ∈ [−0.225, −0.167]; p ≤ 0.01 | precise |
| a2Yx_wy441x | Table III col 3 β₁ | coef=−0.174, se=0.072, N=2783, p<0.05 | same | coef=−0.174, se=0.072, N=2783, p=0.016 | coef ∈ [−0.200, −0.148]; p ≤ 0.05 | precise |
| a2Yx_pq7763 | Table III col 6 β₁ (weighted) | coef=−0.166, se=0.089, N=2783, p<0.10 | same | coef=−0.166, se=0.089, N=2783, p=0.063 | coef ∈ [−0.191, −0.141]; p ≤ 0.10 | precise |
| a2Yx_qxpp39 | Table III col 7 β₁ (cty-yr) | coef=−0.115, se=0.033, **N=270,991**, p<0.01 | same | coef=−0.115, se=0.033, **N=207,991**, p=0.001 | N ∈ [230,342, 311,640]; coef precise | **not** (sample size out of band) |
| a2Yx_xz559w | Table III col 8 β₁ (cty-yr wt) | coef=−0.075, se=0.073, N=207,991, *(p<0.05 in extraction is wrong; paper reports no significance)* | extraction wrong | coef=−0.075, se=0.073, N=207,991, p=0.303 | coef ∈ [−0.086, −0.064]; p non-outcome (paper reports no exact p) | precise |
| a2Yx_kz4wzr | Table IV col 3 β₁ (DM) | coef=−0.024, se=0.064, N=2783 | same | coef=−0.024, se=0.064, N=2783, p=0.715 | coef ∈ [−0.028, −0.020] | precise |
| a2Yx_7o25od | Table IV col 4 β₁ (DM) | coef=0.025, se=0.065, N=2783 | same | coef=0.025, se=0.065, N=2783, p=0.703 | coef ∈ [0.021, 0.029] | precise |
| a2Yx_zxorx3 | Table IV col 6 β₁ (DM weighted) | coef=−0.119, se=0.107, N=2783 | same | coef=−0.119, se=0.107, N=2783, p=0.268 | coef ∈ [−0.137, −0.101] | precise |
| a2Yx_l8kp8k | Table IV col 5 DownMeasure (complements subsample) | coef=0.342, se=0.081, N=1408, p<0.01 | same | coef=0.342, se=0.081, N=1408, p=0.000 | coef ∈ [0.291, 0.393]; p ≤ 0.01 | precise |
| a2Yx_6rd4ry | Table IV col 8 β₁ (DM cty-yr) | coef=−0.002, se=0.091, N=207,991 | same | coef=−0.002, se=0.091, N=207,991, p=0.982 | coef ∈ [−0.0023, −0.0017] | precise |
| a2Yx_jz7712 | Table V col 2 Q1 (DUse_TUse) | coef=−0.165, se=0.093, N=2783, p<0.10 | same | coef=−0.165, se=0.093, N=2783, p=0.077 | coef ∈ [−0.190, −0.140]; p ≤ 0.10 | precise |
| a2Yx_1yppy7 | Table V col 3 Q1 weighted | coef=−0.255, se=0.149, N=2783, p<0.10 | same | coef=−0.255, se=0.149, N=2783, p=0.088 | coef ∈ [−0.293, −0.217]; p ≤ 0.10 | precise |
| a2Yx_9xyyxo | Table V col 6 Q1 cty-yr | coef=−0.138, se=0.100, N=207,991 | same | coef=−0.138, se=0.100, N=207,991, p=0.168 | coef ∈ [−0.159, −0.117] | precise |
| a2Yx_46jj6r | Table V col 4 Q1 DownMeasure | coef=0.049, se=0.119, N=2783 | same | coef=0.049, se=0.119, N=2783, p=0.683 | coef ∈ [0.042, 0.056] | precise |
| a2Yx_531136 | Table V col 5 Q1 DM weighted | coef=−0.283, se=0.202, N=2783 | same | coef=−0.283, se=0.202, N=2783, p=0.164 | coef ∈ [−0.325, −0.241] | precise |
| a2Yx_ylyylq | Table V col 7 Q1 DM cty-yr | coef=−0.089, se=0.142, N=207,991 | same | coef=−0.089, se=0.142, N=207,991, p=0.532 | coef ∈ [−0.102, −0.076] | precise |
| a2Yx_3n7jn1 | Table VI col 1 β₁ | coef=−0.187, se=0.074, N=2783 | same | coef=−0.187, se=0.074, N=2783, p=0.012 | coef ∈ [−0.215, −0.159] | precise |
| a2Yx_w72o71 | Table VI col 2 β₁ | coef=−0.177, se=0.072, N=2783, p<0.05 | same | coef=−0.177, se=0.072, N=2783, p=0.015 | coef ∈ [−0.204, −0.150]; p ≤ 0.05 | precise |
| a2Yx_ppk1pq | Table VI col 3 β₁ | coef=−0.103, se=0.071, N=2783 | same | coef=−0.103, se=0.071, N=2783, p=0.148 | coef ∈ [−0.118, −0.088] | precise |
| a2Yx_q7y97r | Table VI col 4 β₁ | coef=−0.180, se=0.077, N=2783, p<0.05 | same | coef=−0.180, se=0.077, N=2783, p=0.020 | coef ∈ [−0.207, −0.153]; p ≤ 0.05 | precise |
| a2Yx_9xyy5o | Table VI col 5 β₁ | coef=−0.130, se=0.079, N=2783, p<0.10 | same | coef=−0.130, se=0.079, N=2783, p=0.099 | coef ∈ [−0.150, −0.111]; p ≤ 0.10 | precise (just) |
| a2Yx_46jjxr | Table VI col 6 β₁ | coef=−0.171, se=0.093, N=2783, p<0.10 | same | coef=−0.171, se=0.093, N=2783, p=0.067 | coef ∈ [−0.197, −0.145]; p ≤ 0.10 | precise |
| a2Yx_5311j6 | Table VI col 7 β₁ | coef=−0.188, se=0.093, N=2783, p<0.05 | same | coef=−0.188, se=0.093, N=2783, p=0.044 | coef ∈ [−0.216, −0.160]; p ≤ 0.05 | precise |
| a2Yx_ylyy4q | Table VI col 8 β₁ | coef=−0.119, se=0.080, N=2783 | same | coef=−0.119, se=0.080, N=2783, p=0.140 | coef ∈ [−0.137, −0.101] | precise |
| a2Yx_2zqqpk | Table VI col 9 β₁ | coef=−0.199, se=0.091, N=2783, p<0.05 | same | coef=−0.199, se=0.091, N=2783, p=0.030 | coef ∈ [−0.229, −0.169]; p ≤ 0.05 | precise |
| a2Yx_8q554l | Table VI col 10 β₁ | coef=−0.185, se=0.084, N=2783, p<0.05 | same | coef=−0.185, se=0.084, N=2783, p=0.028 | coef ∈ [−0.213, −0.157]; p ≤ 0.05 | precise |
| a2Yx_op33lv | Table VII col 1 β₁ | coef=0.014, se=0.067, N=2783 | same | coef=0.014, se=0.067, N=2783, p=0.840 | coef ∈ [0.0119, 0.0161] | precise |
| a2Yx_nw667p | Table VII col 2 β₁ | coef=0.021, se=0.065, N=2783 | same | coef=0.021, se=0.065, N=2783, p=0.751 | coef ∈ [0.0179, 0.0241] | precise |
| a2Yx_dojj32 | Table VII col 3 β₁ | coef=0.083, se=0.062, N=2783 | same | coef=0.083, se=0.062, N=2783, p=0.186 | coef ∈ [0.0706, 0.0954] | precise |
| a2Yx_r7qqwy | Table VII col 4 β₁ | coef=0.007, se=0.067, N=2783 | same | coef=0.007, se=0.067, N=2783, p=0.916 | coef ∈ [0.0060, 0.0080] | precise |
| a2Yx_v599jx | Table VII col 5 β₁ | coef=0.046, se=0.065, N=2783 | same | coef=0.046, se=0.065, N=2783, p=0.476 | coef ∈ [0.0391, 0.0529] | precise |
| a2Yx_kl889p | Table VII col 6 β₁ | coef=−0.137, se=0.110, N=2783 | same | coef=−0.137, se=0.110, N=2783, p=0.214 | coef ∈ [−0.158, −0.116] | precise |
| a2Yx_7p4499 | Table VII col 7 β₁ | coef=−0.152, se=0.110, N=2783 | same | coef=−0.152, se=0.110, N=2783, p=0.169 | coef ∈ [−0.175, −0.129] | precise |
| a2Yx_z72257 | Table VII col 8 β₁ | coef=−0.040, se=0.101, N=2783 | same | coef=−0.040, se=0.101, N=2783, p=0.695 | coef ∈ [−0.046, −0.034] | precise |
| a2Yx_l6zz4r | Table VII col 9 β₁ | coef=−0.213, se=0.103, N=2783, p<0.05 | same | coef=−0.213, se=0.103, N=2783, p=0.040 | coef ∈ [−0.245, −0.181]; p ≤ 0.05 | precise |
| a2Yx_6w9919 | Table VII col 10 β₁ | coef=−0.216, se=0.099, N=2783, p<0.05 | same | coef=−0.216, se=0.099, N=2783, p=0.030 | coef ∈ [−0.248, −0.184]; p ≤ 0.05 | precise |
| a2Yx_single-trace | Table III col 2 β₂ (DUse_TUse × 1(Elas>Med)) | coef=0.171, se=0.067, N=2783, p<0.05 | same | coef=0.171, se=0.067, N=2783, p=0.012 | coef ∈ [0.145, 0.197]; p ≤ 0.05 | precise |

**Overall:** 36/37 precise; 1/37 not (paper-typo N). No claim falls into the approximate band.

## What I did

1. **Set-up.** Created `independent_reproductions/a2Yx_antras_2013/`, copied `papers/a2Yx.pdf` in, ran `pdftotext -layout` to produce `a2Yx.txt`.

2. **Extraction check.** Cross-walked all 37 claims against the paper PDF:
   - Page 43 (paper p. 2169–2170) → Table III (DUse_TUse main spec). Verified all 5 Table III column-2/3/6/7/8 β₁ entries match extraction.
   - Page 48 (paper p. 2174) → Table IV (DownMeasure). Verified entries.
   - Page 51 (paper p. 2177) → Table V (quintile interactions).
   - Page 53 (paper p. 2179) → Table VI (DUse_TUse robustness, columns 1–10).
   - Page 54 (paper p. 2180) → Table VII (DownMeasure robustness, columns 1–10).
   - Two extraction issues found: (a) Table III col 7 N: paper prints 270,991, which appears to be a typo (all other cty-yr columns are 207,991). (b) Claim a2Yx_xz559w extracted `p<0.05` is contradicted by the paper, which shows no stars and explicitly says "not statistically significant."

3. **Data/code source.** Located via the Econometric Society supplementary materials at:
   `https://www.econometricsociety.org/publications/econometrica/2013/11/01/organizing-global-value-chain/supp/10813_data_and_programs_0.zip`
   (saved as `data_and_programs.zip`). Extracted into `Antras-Chor Replication Material/`. Contains 11 main-text and appendix `Table*.do` files, 13 `.dta` data files, and `readme.txt`. Code authored in Stata 11.

4. **Reproduction commands.** Ran with Stata-MP 16:
   ```
   stata-mp -b do Table3.do
   stata-mp -b do Table4.do
   stata-mp -b do Table5.do
   stata-mp -b do Table6.do
   stata-mp -b do Table7.do
   ```
   Each completes in seconds. The only edit applied was commenting out the `local dir "C:\..."; cd "`dir'";` line in each do-file (path-only, no analysis logic). Originals preserved as `Table*.do.orig`. Outputs are in `Table*.log` and `Table*.out` (tab-delimited outreg2 tables).

5. **Stochastic-method diagnostics.** None. All regressions are deterministic OLS / `areg` with cluster-robust SEs.

6. **Classification.** Reproduced coefficients and SEs match all 37 paper-printed values to 3-decimal precision. p-values from the Stata logs were classified against the paper's threshold p-statements using the SCORE one-sided threshold rule. The single non-precise verdict (a2Yx_qxpp39) is driven entirely by the paper-printed N (270,991) being out of the ±15% band relative to the reproduced N (207,991).

## Diagnostics — author-bug analysis

There is no author code or data bug to diagnose. The two non-conformities are upstream of the code:

- **a2Yx_qxpp39 — paper typo on N.** Suspected error: Table III column 7 sample-size cell reads "270,991" where all neighboring country-industry-year specifications and the very next column print "207,991." The author's `Table3.do` unmodified produces 207,991 for col 7 and col 8 alike, consistent with the structurally identical Table IV col 8 (also 207,991). No patch is possible (no code/data change would produce N=270,991). Confidence: **high** that this is a typesetting error in the published paper. **Verdict if patched:** N/A — there is nothing in the code to patch. If the paper's printed N is treated as "correct" by stipulation, the claim still verdicts `not` on sample size; if it is treated as an erratum and N=207,991 is the comparison target, the claim verdicts `precise` on every sub-outcome.

- **a2Yx_xz559w — extraction error.** Suspected error: extraction CSV lists `orig_p_value=0.05, type=less-than` for Table III col 8 β₁; the paper itself prints no significance stars on this coefficient and the surrounding text explicitly says it is "not statistically significant." The reproduced p=0.303 confirms the paper. The headline verdict is `precise` because the paper does not in fact assert any p-threshold for this coefficient (it is non-outcome on p), and coef + N reproduce exactly. Confidence: **high** that this is an extraction bug, not a paper or code issue.

Beyond these two, `Diagnostics: none — unpatched run reproduces; no logic bug suspected.`

## Files in this folder

- `a2Yx.pdf` — copy of the published paper (version of record from Wiley Online Library / Econometrica)
- `a2Yx.txt` — `pdftotext -layout` extraction
- `data_and_programs.zip` — Econometric Society replication archive
- `Antras-Chor Replication Material/` — extracted contents:
  - `readme.txt` (author's description)
  - 13 `.dta` input data files
  - 11 `Table*.do` and `AppTable*.do` and `Figure*.do` Stata scripts (originals)
  - `Table3.do`, `Table4.do`, `Table5.do`, `Table6.do`, `Table7.do` — env-only edited (cd line commented out); originals preserved as `Table*.do.orig`
  - `Table3.log`, `Table4.log`, `Table5.log`, `Table6.log`, `Table7.log` — Stata batch logs (the unpatched-run artifacts)
  - `Table3.out`, `Table4.out`, `Table5.out`, `Table6.out`, `Table7.out` — outreg2 tab-delimited output tables (the unpatched-run artifacts that I read coefficients from)
  - `Table3.xml`, …, `Table7.xml` — Excel/XML versions of the same outreg2 output
- `REPRODUCTION_REPORT.md` — this file
- `a2Yx_summary_rows.csv` — one row per claim
- `stata.log` — incidental smoke-test log

No `diagnostic_patched.*` files: no logic-level patches were attempted because none were warranted.
