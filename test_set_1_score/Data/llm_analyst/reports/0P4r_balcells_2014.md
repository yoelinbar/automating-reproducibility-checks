# Reproduction Report — Balcells & Kalyvas (2014), "Does Warfare Matter?"

**Paper:** Balcells, Laia, and Stathis N. Kalyvas. 2014. "Does Warfare Matter? Severity, Duration, and Outcomes of Civil Wars." *Journal of Conflict Resolution* 58(8): 1390–1418. DOI: [10.1177/0022002714547903](https://doi.org/10.1177/0022002714547903).
**Paper IDs:** paper_id=0P4r; claims=0P4r_l8rjny, 0P4r_6rpyov, 0P4r_3n6yo5, 0P4r_1rz255, 0P4r_855y48, 0P4r_djjn3z, 0P4r_v998jj, 0P4r_rqq4wz, 0P4r_yyyd4j, 0P4r_single-trace
**Reproduction type:** Push Button
**Headline verdict (unpatched):** approximate (9/10 claims precise; 1/10 approximate)
**Verdict if patched (only if applicable):** N/A — no patches needed

## Headline
Nine of the ten claims reproduce **precisely** to the paper's printed precision using the author-provided OSF replication archive (data + Stata do-files, no edits to analysis logic). The one deviation is in claim **0P4r_yyyd4j** (Table 2 descriptive statistics), on the PRIO_Irr mean: paper prints 510.34, reproduced value is 510.3483 which rounds to 510.35 at the paper's 2-dp precision — one ulp off the printed value. The reproduced 510.35 still sits well inside the approximate band [510.34 × 0.85, 510.34 × 1.15] = [433.79, 586.89], so the sub-outcome verdict is `approximate` rather than `not`, and the overall verdict on the claim becomes `approximate`. (Under the prior rubric this sub-outcome was coded `precise` via the Push-Button auto-precise rule, which no longer applies.) All other Table 2 descriptives, all Table 1 duration-model coefficients (after the standard ln-transform of Stata's printed time ratios), all focal SEs, all focal p-thresholds, and all sample sizes match exactly.

## Comparison table

Notation: for the Weibull AFT (Table 1), the printed paper coefficients are on the log-time scale, computed as `ln(TimeRatio)` and `SE(TimeRatio)/TimeRatio` (delta method) — the way Stata reports them when the `tr` option is dropped. p-values are taken directly from Stata's z-test on the log-scale parameter (invariant under the log).

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| 0P4r_l8rjny (T1 M1, Irregular) | coef | 1.20 | 1.20 | ln(3.330544)=1.203 → 1.20 | exact match at 2 dp | precise |
|  | SE (effect_size) | 0.23 | 1.20 (extraction labels SE field as effect_size) | 0.7805/3.3305 = 0.234 → 0.23 | exact match at 2 dp | precise |
|  | p-value | p<.01 | p<.01 | z=5.13, p≈2.9e-7 | ≤0.01 | precise |
|  | N | 1,206 | 1206 | 1,206 | exact | precise |
| 0P4r_l8rjny (T1 M1, SNC) | coef | 0.83 | — | ln(2.293024)=0.830 → 0.83 | exact | precise |
|  | SE | 0.38 | — | 0.8638/2.2930 = 0.3768 → 0.38 | exact | precise |
|  | p-value | p<.05 | — | z=2.20, p=0.028 | ≤0.05 | precise |
| 0P4r_6rpyov (T1 M2, Irregular) | coef | 0.85 | 0.85 | ln(2.331266)=0.8463 → 0.85 | exact | precise |
|  | SE | 0.33 | 0.85 | 0.7713/2.3313 = 0.3309 → 0.33 | exact | precise |
|  | p-value | p<.05 | p<.05 | z=2.56, p=0.011 | ≤0.05 | precise |
|  | N | 906 | 906 | 906 | exact | precise |
| 0P4r_6rpyov (T1 M2, SNC) | coef | 0.51 | — | ln(1.658094)=0.506 → 0.51 | exact | precise |
|  | SE | 0.40 | — | 0.6625/1.6581 = 0.3996 → 0.40 | exact | precise |
| 0P4r_3n6yo5 (T1 M3, Irregular) | coef | 0.93 | 0.93 | ln(2.542421)=0.9333 → 0.93 | exact | precise |
|  | SE | 0.32 | 0.93 | 0.8020/2.5424 = 0.3155 → 0.32 | exact | precise |
|  | p-value | p<.01 | p<.01 | z=2.96, p=0.003 | ≤0.01 | precise |
|  | N | 906 | 906 | 906 | exact | precise |
| 0P4r_1rz255 (T3 M2, Conventional) | coef | 0.86 | 0.86 | 0.8611 → 0.86 | exact | precise |
|  | SE | 0.37 | 0.86 | 0.3728 → 0.37 | exact | precise |
|  | p-value | p<.05 | p<.05 | z=2.31, p=0.021 | ≤0.05 | precise |
|  | N | 92 | 92 | 92 | exact | precise |
| 0P4r_1rz255 (T3 M2, SNC) | coef | 0.27 | — | 0.2721 → 0.27 | exact | precise |
|  | SE | 0.53 | — | 0.5296 → 0.53 | exact | precise |
| 0P4r_855y48 (T4 M1, Conv) | coef | -0.48 | -0.48 | -0.4816 → -0.48 | exact | precise |
|  | SE | 0.20 | -0.48 | 0.1989 → 0.20 | exact | precise |
|  | p-value | p<.05 | p<.05 | z=-2.42, p=0.015 | ≤0.05 | precise |
|  | N | 979 | 979 | 979 | exact | precise |
| 0P4r_855y48 (T4 M1, SNC) | coef | -0.88 | — | -0.8820 → -0.88 | exact | precise |
|  | SE | 0.48 | — | 0.4787 → 0.48 | exact | precise |
|  | p-value | p<.10 | — | z=-1.84, p=0.065 | ≤0.10 | precise |
| 0P4r_djjn3z (T5 incwon, Conv) | coef | -1.12 | -1.12 | -1.1239 → -1.12 | exact | precise |
|  | SE | 0.49 | -1.12 | 0.4930 → 0.49 | exact | precise |
|  | p-value | p<.05 | p<.05 | z=-2.28, p=0.023 | ≤0.05 | precise |
|  | N | 131 | 131 | 131 | exact | precise |
| 0P4r_v998jj (T5 rebels-won, Conv) | coef | 1.40 | 1.40 | 1.3979 → 1.40 | exact | precise |
|  | SE | 0.59 | 1.40 | 0.5871 → 0.59 | exact | precise |
|  | p-value | p<.05 | p<.05 | z=2.38, p=0.017 | ≤0.05 | precise |
|  | N | 131 | 131 | 131 | exact | precise |
| 0P4r_rqq4wz (T6 incwon, Conv) | coef | -1.09 | -1.09 | -1.0906 → -1.09 | exact | precise |
|  | SE | 0.54 | -1.09 | 0.5352 → 0.54 | exact | precise |
|  | p-value | p<.05 | p<.05 | z=-2.04, p=0.042 | ≤0.05 | precise |
|  | N | 130 | 130 | 130 | exact | precise |
| 0P4r_rqq4wz (T6 incwon, SNC) | coef | -0.88 | — | -0.8803 → -0.88 | exact | precise |
|  | SE | 0.77 | — | 0.7741 → 0.77 | exact | precise |
| 0P4r_yyyd4j (T2 descriptives) | TR Conv mean | 3,038.13 | non-numeric narrative | 3,038.127 → 3,038.13 | exact | precise |
|  | TR Irr mean | 1,257.91 | — | 1,257.908 → 1,257.91 | exact | precise |
|  | TR SNC mean | 1,015.1 | — | 1,015.103 → 1,015.10 | exact | precise |
|  | PRIO Conv mean | 1,614.86 | — | 1,614.857 → 1,614.86 | exact | precise |
|  | PRIO Irr mean | 510.34 (paper prints "510,34" — European comma) | — | 510.3483 → 510.35 | 510.35 ≠ 510.34 at 2 dp; approx band [433.79, 586.89] | **approximate** |
|  | PRIO SNC mean | 109.24 | — | 109.2425 → 109.24 | exact | precise |
| 0P4r_single-trace (T1 M4, Irregular) | coef | 0.87 | — | ln(2.382259)=0.8682 → 0.87 | exact | precise |
|  | SE | 0.35 | — | 0.8234/2.3823 = 0.3456 → 0.35 | exact | precise |
|  | p-value | p<.05 | — | z=2.51, p=0.012 | ≤0.05 | precise |
|  | N | 906 | — | 906 | exact | precise |

**Overall:** 9 of 10 claims `precise`. Claim **0P4r_yyyd4j** (Table 2 descriptives) is `approximate` because the PRIO_Irr mean sub-outcome (510.35 vs paper 510.34) fails paper-precision rounding while remaining well inside the ±15% approximate band. Paper-level headline verdict: `approximate`.

## What I did

### 1. Set-up
Created directory `independent_reproductions/0P4r_balcells_2014/`, copied PDF in, ran `pdftotext -layout` to produce `0P4r.txt`.

### 2. Extraction check
Re-read paper Tables 1, 2, 3, 4, 5, 6 (pp. 1400, 1402, 1404, 1408, 1411, 1412 in the journal pagination; pp. 9, 11, 13, 17, 20, 21 in the supplied PDF text mapping). Every `orig_*` value in `paper_claims/0P4r.json` matches the published paper's printed digits (Table 1 M1 Irr: 1.20 (0.23) ***, N 1,206; T1 M2 Irr: 0.85 (0.33) **, N 906; T1 M3 Irr: 0.93 (0.32) ***, N 906; T3 M2 Conv: 0.86 (0.37) **, N 92; T4 M1 Conv: -0.48 (0.20) **, N 979; T5 inc-won Conv: -1.12 (0.49) **, N 131; T5 rebels-won Conv: 1.40 (0.59) **, N 131; T6 inc-won Conv: -1.09 (0.54) **, N 130). No extraction discrepancies.

### 3. Data/code source
Located via web search: OSF project [3j72h](https://osf.io/3j72h/) ("Phase 2 Reproduction Materials"). API listing pulled five files via `https://api.osf.io/v2/nodes/3j72h/files/osfstorage/...` and downloaded:
- `KB2014_ReplicationDoFile.do` — Tables 3, 4, 5, 6 (and online appendix)
- `DurationAnalysesRep/TR_Duration_Replication_JCR2014.do` + `TR_panelformat_Replication.dta` — Table 1 M1–M4 (TR Weibull duration)
- `TRdataset_JCR2014_replication_final.dta` — TR cross-section (Tables 3 (TR), 5)
- `PRIO100_replication_final.dta` — PRIO100 dataset (Tables 4, 6; Table 3 M4–M6)
- `README.pdf` — replication notes

Note: the OSF archive does not contain a separate do-file for the PRIO100 duration models (Table 1 M5–M8); the in-paper claims here are all in M1–M4 (TR), so this is non-blocking.

### 4. Reproduction
Wrote `run_pushbutton.do` that concatenates the author's `TR_Duration_Replication_JCR2014.do` (verbatim) with the relevant blocks from `KB2014_ReplicationDoFile.do` (verbatim, in the order they appear in the original do-file). Environment-only edits: added `cd` to the working directory and `log using` block. **No analysis-logic edits.** Ran via `/usr/local/bin/stata-mp -b do run_pushbutton.do`. Runtime <2 seconds. Output in `run_pushbutton.log`.

### 5. Stochastic-method diagnostics
None — all models are deterministic MLE. No bootstrap, no MCMC, no permutation.

### 6. Classification
The paper prints duration-model coefficients on the log-survival-time scale ("AFT specification, which indicates the effect of the covariates on the log survival time," p. 1400). Stata's `streg ... time tr` prints time ratios; `time` (without `tr`) would print the log-time coefficients directly. The two parameterizations are exact log/exp transforms of each other, so:
- coefficient on log-time scale = `ln(TimeRatio)`
- SE on log-time scale = `SE(TimeRatio) / TimeRatio` (delta method exact)
- z-statistic and p-value: invariant (Stata reports them the same in either output)

After this transform every Table 1 number matches the paper to the paper's printed precision (2 dp). All non-Weibull tables print on Stata's native scale and match directly.

Bounds applied per the SCORE rubric (precise = same to paper's printed precision; approximate = within 15%; threshold p-values: precise iff reproduced p is below the stated threshold per the strict-inequality rule). Every reported sub-outcome verdict is `precise` except for the PRIO_Irr_mean sub-outcome of claim 0P4r_yyyd4j (Table 2), which is `approximate` (510.35 vs paper 510.34 at 2 dp; within ±15% but not equal at paper precision). All other claims are `precise`; the affected claim's overall verdict is `approximate`. Paper-level headline: **approximate**.

## Diagnostics — author-bug analysis
Diagnostics: none — unpatched run reproduces the published numbers; no logic bug suspected.

One note for transparency: the published Table 4 has an erratum in its footnote — the paper says GDP per capita comes from the Penn World Table 7, but the actual variable used in the regression is Maddison (2008) GDP per capita (`gdpmad`). The author flags this herself in the do-file (lines 150–151). The paper's printed coefficients correspond to `gdpmad`; running with `gdpmad` reproduces the printed numbers (verified for M1; M2/M3 are not focal claims here but match in the same run). This is a footnote-level errata, not a verdict-level discrepancy.

## Files in this folder
- `0P4r.pdf` — paper PDF
- `0P4r.txt` — pdftotext output
- `README.pdf` — author's replication README
- `KB2014_ReplicationDoFile.do` — author's main do-file (Tables 3, 4, 5, 6 + appendix)
- `KB2014_ReplicationDoFile.zip` — original archive
- `DurationAnalysesRep/TR_Duration_Replication_JCR2014.do` — author's Table 1 do-file
- `DurationAnalysesRep/TR_panelformat_Replication.dta` — TR panel data for duration model
- `DurationAnalysesRep.zip` — original archive
- `TRdataset_JCR2014_replication_final.dta` (+ `.zip`) — TR cross-section
- `PRIO100_replication_final.dta` (+ `.zip`) — PRIO100 cross-section
- `run_pushbutton.do` — exact script run (concatenation of author's two do-files; no analysis edits)
- `run_pushbutton.log` — Stata log of the unpatched run
- `REPRODUCTION_REPORT.md` — this file
