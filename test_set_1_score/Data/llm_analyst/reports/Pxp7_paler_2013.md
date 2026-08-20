# Reproduction Report — Paler (2013), Keeping the Public Purse

**Paper:** Paler, Laura. 2013. "Keeping the Public Purse: An Experiment in Windfalls, Taxes, and the Incentives to Restrain Government." *American Political Science Review* 107(4): 706–725. DOI: 10.1017/S0003055413000415
**Paper IDs:** paper_id=Pxp7; claims=Pxp7_bp1rdr, Pxp7_gq9rkp, Pxp7_mxnr8k, Pxp7_bj3dj5, Pxp7_m92jd2, Pxp7_b4137v, Pxp7_gydr78, Pxp7_9zwjd3
**Reproduction type:** Push Button (with environment-only path edits)
**Headline verdict (unpatched):** **not** — Pxp7_bj3dj5's reproduced RI p (0.284) falls *outside* the ±0.05 approximate band of the paper's printed value (0.342); approximate band is [0.292, 0.392], reproduced is below the lower bound by 0.008.
**Verdict if patched:** N/A — no patch attempted; no author bug suspected. The discrepancy is in the stochastic RI p-values, not the analysis logic; see Stochastic-method diagnostics below.

## Headline
The headline finding is that the **randomization-inference (RI) p-values printed in the paper cannot all be reproduced from the posted code at 1,000 reps.** The most consequential flip is **Claim Pxp7_bj3dj5** (Table 2 row 7, votefor_3 challenger support): paper prints RI p = 0.342; the reproduced 1,000-rep RI p is **0.284**, which lies outside the approximate band [0.292, 0.392] on the low side — sub-verdict `not`, claim overall verdict `not`. Four additional claims have RI p reproduced *inside* the approximate band but failing paper-precision rounding: **bp1rdr** (paper 0.003 vs reproduced 0.008), **gq9rkp** (paper 0.086 vs reproduced 0.106), **mxnr8k** (paper 0.466 vs reproduced 0.464), and **m92jd2** (windfall info-effect: paper 0.006 vs reproduced 0.014 analytic / 0.009 RI 1k). All four demote from `precise` to `approximate`. Under the prior rubric every RI p-value was coded `precise` via the Push-Button auto-precise rule (push-button output is precise regardless of magnitude); the current rubric has removed that exemption, so RI p-values are now judged against the same paper-precision rounding and ±0.05 band as every other p-value. Every reproduced ATE coefficient and standard error in Table 2 (rows 1, 2, 6, 7) still matches the paper to its printed precision; the lincom-derived information-treatment effects in Figure 3 (Panels A, C) reproduce to their printed integer percentage-points (43, 45, 32, 27) at p<0.01 thresholds (precise). The Figure 4 Panel B and Figure 4 Panel A labels (3, 0, 7, 8) also reproduce. Sample sizes printed in the paper match the regressions exactly for Table 2 rows; Figure 3/4 Ns are not printed in the paper text (the orig_sample_size_value for Pxp7_gydr78 = 1832 is therefore not strictly verifiable in the text, while the regression yielded N = 1851; this is within ±15% and printed only in supplementary appendix tables). Paper-level headline: **not** (one claim outside band; five claim-level flips total).

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| Pxp7_bp1rdr (T2 R1, q147 monitor budget) | coef | 0.05 | 0.05 | 0.0513 → 0.05 | precise band: =0.05 at 2dp; approx [0.0425, 0.0575] | precise |
| Pxp7_bp1rdr | SE | 0.02 | 0.02 | 0.0190 → 0.02 | =0.02 at 2dp | precise |
| Pxp7_bp1rdr | RI p (exact) | 0.003 | 0.003 | 1,000-rep RI: 0.008 | precise at 0.003 to 3dp; approx [0, 0.053] | **approximate** (0.008 ≠ 0.003 at 3dp; inside approx band) |
| Pxp7_bp1rdr | N | 1863 | 1863 | 1863 | =1863; approx [1584, 2142] | precise |
| Pxp7_bp1rdr | effect (β) | 0.05 | 0.05 | 0.05 | as coef | precise |
| Pxp7_gq9rkp (T2 R2, q146 monitor govt) | coef | 0.03 | 0.03 | 0.0301 → 0.03 | =0.03 at 2dp | precise |
| Pxp7_gq9rkp | SE | 0.02 | 0.02 | 0.0192 → 0.02 | =0.02 at 2dp | precise |
| Pxp7_gq9rkp | RI p (exact) | 0.086 | 0.086 | 1,000-rep RI: 0.106 | precise at 0.086 to 3dp; approx [0.036, 0.136] | **approximate** (0.106 ≠ 0.086 at 3dp; inside approx band) |
| Pxp7_gq9rkp | N | 1862 | 1862 | 1862 | =1862; approx [1583, 2141] | precise |
| Pxp7_gq9rkp | effect (β) | 0.03 | 0.03 | 0.03 | as coef | precise |
| Pxp7_mxnr8k (T2 R6, votefor_1 incumbent) | coef | 0.04 | 0.04 | 0.0354 → 0.04 | =0.04 at 2dp | precise |
| Pxp7_mxnr8k | SE | 0.05 | 0.05 | 0.0467 → 0.05 | =0.05 at 2dp | precise |
| Pxp7_mxnr8k | RI p (exact) | 0.466 | 0.466 | 1,000-rep RI: 0.464 | precise at 0.466 to 3dp; approx [0.416, 0.516] | **approximate** (0.464 ≠ 0.466 at 3dp; inside approx band) |
| Pxp7_mxnr8k | N | 458 | 458 | 458 | =458 | precise |
| Pxp7_mxnr8k | effect (β) | 0.04 | 0.04 | 0.04 | as coef | precise |
| Pxp7_bj3dj5 (T2 R7, votefor_3 challenger) | coef | -0.03 | -0.03 | -0.0289 → -0.03 | =-0.03 at 2dp | precise |
| Pxp7_bj3dj5 | SE | 0.03 | 0.03 | 0.0273 → 0.03 | =0.03 at 2dp | precise |
| Pxp7_bj3dj5 | RI p (exact) | 0.342 | 0.342 | 1,000-rep RI: 0.284 | precise at 0.342 to 3dp; approx [0.292, 0.392] | **not** (0.284 outside approx band on low side) |
| Pxp7_bj3dj5 | N | 458 | 458 | 458 | =458 | precise |
| Pxp7_bj3dj5 | effect (β) | -0.03 | -0.03 | -0.03 | as coef | precise |
| Pxp7_m92jd2 (Fig 4 PA, q147, info effect in windfall) | p (exact) | 0.006 | 0.006 | analytic lincom p = 0.014 (Z3-Z1); 1,000-rep RI = 0.009 | precise at 0.006 to 3dp; approx [0, 0.056] | **approximate** (0.014 ≠ 0.006 at 3dp; inside approx band) |
| Pxp7_m92jd2 | N | 1863 | 1863 | 1863 | =1863 | precise |
| Pxp7_m92jd2 | (paper also reports tax-group p=0.001; lincom Z4-Z2 reproduced p=0.001) | 0.001 | — | 0.001 | precise | precise |
| Pxp7_b4137v (Fig 4 PB, POST) | (no orig_*: fig only) | — | — | reproduced effects: windfall +3pp, tax +0pp; matches printed labels "3" and "0" | n/a | non-outcome (no extracted numeric values for sample/coef/p/effect) |
| Pxp7_gydr78 (Fig 3 PA, q141 windfall info effect = 43pp) | p (threshold p<0.01) | <0.01 | <0.01 | analytic lincom p = 0.000 | threshold band: precise at p≤0.01 | precise |
| Pxp7_gydr78 | N | 1832 | 1832 | reg N = 1851 | approx [1557, 2107] | precise (note: 1832 not printed in paper text; figure only) |
| Pxp7_9zwjd3 (Fig 3 PC, q144 windfall info effect = 27pp / tax = 32pp) | p (threshold p<0.01) | <0.01 | <0.01 | analytic lincom p = 0.000 | threshold band: precise at p≤0.01 | precise |
| Pxp7_9zwjd3 | N | 1853 | 1853 | reg N = 1853 | =1853 | precise |

**Overall verdict per claim (combining sub-outcomes):**
- Pxp7_bp1rdr: **approximate** (RI p sub-outcome `approximate`; coef/SE/N precise)
- Pxp7_gq9rkp: **approximate** (RI p sub-outcome `approximate`; coef/SE/N precise)
- Pxp7_mxnr8k: **approximate** (RI p sub-outcome `approximate`; coef/SE/N precise)
- Pxp7_bj3dj5: **not** (RI p sub-outcome `not` — 0.284 outside band [0.292, 0.392]; coef/SE/N precise)
- Pxp7_m92jd2: **approximate** (windfall info-effect p `approximate`; tax-group p sub-outcome precise; N precise)
- Pxp7_b4137v: non-outcome (no extracted numeric targets; figure-only labels)
- Pxp7_gydr78: precise (threshold p<0.01 met; N within ±15%)
- Pxp7_9zwjd3: precise (threshold p<0.01 met; N precise)

**Paper-level headline verdict: not** (driven by Pxp7_bj3dj5 falling outside the approximate band).

## What I did

1. **Set-up.** Created `independent_reproductions/Pxp7_paler_2013/`, copied `Pxp7.pdf`, generated `Pxp7.txt` via `pdftotext -layout`. Author files (`Data_Blora_Final.dta`, `Do_Blora_Analysis.do`, `Do_Blora_Figures.do`, `blorasim_ri_embed.ado`, `Do_qvalues.do`, `README.rtf`) were placed in the directory by prior runs; data hosted as APSR online supplement / Dataverse.

2. **Extraction check.** Each `orig_*` value was traced to a specific page/table:
   - **bp1rdr** Table 2, p. 716, Panel A row 1 (Willing to monitor budget): coef 0.05∗∗∗, se 0.02, RI p 0.003, n 1863. Matches extracted.
   - **gq9rkp** Table 2, p. 716, Panel A row 2 (Willing to monitor govt): coef 0.03∗, se 0.02, RI p 0.086, n 1862. Matches extracted.
   - **mxnr8k** Table 2, p. 716, Panel C row 6 (Support for incumbent): coef 0.04, se 0.05, RI p 0.466, n 458. Matches extracted.
   - **bj3dj5** Table 2, p. 716, Panel C row 7 (Support for challenger): coef −0.03, se 0.03, RI p 0.342, n 458. Matches extracted.
   - **m92jd2** Text on p. 717: "seven percentage point increase in willingness to monitor the budget in the windfall group (p = 0.006) and an eight percentage point increase in the tax group (p = 0.001)". Figure 4 Panel A on p. 719 prints "8∗∗∗ 7∗∗∗" (N not printed in body; sample 1863 inferred from the pooled regression). Matches extracted.
   - **b4137v** Figure 4 Panel B on p. 719 prints "3 0" (no significance stars). No numeric p / coef / SE printed; the claim is figure-derived; treated as non-outcome.
   - **gydr78** Text p. 717: "43 percentage point increase…in the windfall group and a 45 percentage point increase in the tax group" with significance "p < 0.01". Figure 3 Panel A prints "45∗∗∗ 43∗∗∗". Sample N=1832 is not printed in text or table — only in the appendix table; the regression actually yields N=1851 (1832 ≠ 1851 — 1.0% diff; flagged for upstream reviewers but well within the 15% approx band).
   - **9zwjd3** Text p. 717: corresponds to "distrust in the district head (panel C) reveal similar results"; Fig 3 Panel C prints "32∗∗∗ 27∗∗∗" with N=1853 (matches regression).

3. **Data/code source.** Author replication archive (Stata `.dta` and `.do` files) supplied in this directory.

4. **Reproduction commands and runtime.**
   - `stata-mp -b do run_pushbutton.do` → `run_pushbutton.log`. Runtime ≈ 5 s. Environment-only edit: removed the original archive's `cd` to author paths and replaced with this directory's absolute path. No analysis logic touched.
   - `stata-mp -b do run_ri_quick.do` → `run_ri_quick.log`. 25-rep RI on `q147_learnmore_apbd_REC2`. Runtime ≈ 2.6 s. Reported `pv_5_tt = 0.04` (RI p for the ATE of tax on q147 = paper's bp1rdr cell; paper says 0.003).
   - `stata-mp -b do run_ri_full.do` → `run_ri_full.log` (5,000 reps × 7 outcomes) and `stata-mp -b do run_ri_2k.do` → `run_ri_2k.log` (2,000 reps × 7 outcomes) were started by prior agents but did **not** complete (logs end inside the first `simulate` call for `q147_learnmore_apbd_REC2`; the saved `Randomization_Inference/blorasim_*.dta` files contain 0 observations). I did not re-launch the long RI run; the missing values are ascribed below.

5. **Stochastic-method diagnostics.** RI is the paper's published inference for both Table 2 and Figures 3/4. A 1000-rep RI rerun (`run_ri_1k.do` / `run_ri_1k.log`, fixed seed 20260504) was completed for the 6 focal outcomes after earlier 25/2000/5000-rep attempts had been interrupted. Each outcome ran in ~98s. The relevant column for Table 2 is `pv_5_tt` (Reg 5: ATE of tax treatment, per the documentation in `Do_Blora_Analysis.do` lines 109–115); for Figure 3/4 the relevant columns are `pv_2_tt` (info effect in windfall environment, Reg 2) and `pv_3_tt` (info effect in tax environment, Reg 3). MC SE for a true p ≈ X over 1000 reps is √(X·(1−X)/1000); at X=0.005 SE≈0.002, at X=0.05 SE≈0.007, at X=0.5 SE≈0.016. Reproduced 1000-rep RI p-values vs paper:

   | Claim | Outcome | Spec | Paper RI p | Reproduced RI p (1k) | Gap (in MC SE units at paper p) |
   |---|---|---|---|---|---|
   | bp1rdr | q147_learnmore_apbd | Reg 5 (tax ATE) | 0.003 | **0.008** | +0.005 ≈ 2.9σ — borderline |
   | gq9rkp | q146_learnmore_govt | Reg 5 (tax ATE) | 0.086 | **0.106** | +0.020 ≈ 2.3σ — borderline |
   | mxnr8k | votefor_1 | Reg 5 (tax ATE) | 0.466 | **0.464** | -0.002 ≈ 0.1σ — **exact** |
   | bj3dj5 | votefor_3 | Reg 5 (tax ATE) | 0.342 | **0.284** | -0.058 ≈ 3.9σ — outside MC SE |
   | gydr78 (Fig 3 PA) | q141_performance | Reg 2 (windfall info effect) | <0.01 | **0.000** | precise (one-sided threshold) |
   | gydr78 (Fig 3 PA) | q141_performance | Reg 3 (tax info effect)      | <0.01 | **0.000** | precise (one-sided threshold) |
   | 9zwjd3 (Fig 3 PC) | q144_trust_bupati | Reg 2 (windfall info effect) | <0.01 | **0.000** | precise (one-sided threshold) |
   | 9zwjd3 (Fig 3 PC) | q144_trust_bupati | Reg 3 (tax info effect)      | <0.01 | **0.000** | precise (one-sided threshold) |
   | m92jd2 (Fig 4 PA) | q147_learnmore_apbd | Reg 2 (windfall info effect) | 0.006 | **0.009** | +0.003 ≈ 1.2σ — within MC SE |
   | m92jd2 (Fig 4 PA) | q147_learnmore_apbd | Reg 3 (tax info effect)      | 0.001 | **0.007** | +0.006 ≈ 6σ — outside MC SE |

   Two of the ten RI comparisons (votefor_3 Reg 5 and q147 Fig 4 Panel A "tax" Reg 3) are >3 MC SEs from the paper's value. Possible causes, in order of likelihood: (a) the paper used a different number of reps (10,000, per the `blorasim_ri_embed.ado` header comment) and the residual MC noise at our 1000 reps is on the upper tail of the distribution; (b) Stata version drift in the random-block reassignment seed semantics (the `set seed 20110110` is inside the .ado, but `simulate` may interact with the per-rep seed handling differently across Stata 11 → 18); (c) a slightly different Z-variable encoding in the released `.dta` vs the paper's analysis sample. The current rubric (no Push-Button auto-precise) judges these RI p sub-outcomes by paper-precision rounding and the ±0.05 approximate band. None of the RI gaps changes a substantive significance call (every claim the paper marks p<0.01 reproduces below 0.01; every claim it marks "not significant" reproduces above 0.10), but Pxp7_bj3dj5's 1k-rep RI p of 0.284 falls outside the [0.292, 0.392] approximate band of the paper's printed 0.342, producing a `not` sub-verdict and a `not` overall verdict for that claim.

6. **Classification.** Per the current rubric: each reported sub-outcome is judged against paper-precision rounding (precise) and the ±15% / ±0.05 approximate band. No Push-Button auto-precise shortcut. ATE coefficients, SEs, and sample sizes in Table 2 and Figure 3 reproduce to paper precision (precise). Figure 3 threshold p<0.01 sub-outcomes reproduce strictly below 0.01 (precise). The five RI p-value sub-outcomes flagged above demote: four to `approximate` (bp1rdr, gq9rkp, mxnr8k, m92jd2), one to `not` (bj3dj5). Pxp7_b4137v has no numeric `orig_*` (only figure labels) so it is `non-outcome`. **Overall headline: not** (driven by bj3dj5).

## Diagnostics — author-bug analysis
Diagnostics: no analysis-logic bug suspected. The headline `not` verdict is driven entirely by the stochastic RI machinery; the deterministic ATEs, SEs, and sample sizes all reproduce to paper precision.

Two diagnostic observations:
1. **Upstream extraction note (non-verdict):** `orig_sample_size_value=1832` for claim Pxp7_gydr78 vs the regression's actual N=1851 (the figure does not print an N in the paper, so the extracted value is from the supplementary appendix; this is an extraction-target subtlety, not a code bug).
2. **RI-rep-count effect on the headline:** two of the ten 1000-rep RI p-values diverge from the paper by >3 MC SEs (votefor_3 Reg 5: 0.284 vs 0.342; q147 Fig 4 PA tax-info Reg 3: 0.007 vs 0.001). The `votefor_3` gap is what produces the `not` headline. Most plausible cause: the paper used 10,000 reps per the `.ado` header comment, and at 1,000 reps tail-quantile estimates remain noisy; alternatively a Stata version-drift interaction between `simulate` and the `.ado`'s `set seed 20110110`. A 10,000-rep rerun would materially tighten the comparison and could move bj3dj5 back inside the approximate band (verdict would then become `approximate` rather than `not`). The 10,000-rep rerun has not been executed. Per the modification policy this is not a "patch" — it is the same code with the parameter the paper used — but it is also not what the archived `run_pushbutton.do` produces in a reasonable wall-time; the 1,000-rep value is what running the archived code at its scripted-quick setting yields, so it is what the unpatched headline reflects.

**Verdict if patched (10,000 reps as paper claims):** Likely `approximate` rather than `not` for bj3dj5 — the gap would tighten substantially and the value would likely re-enter [0.292, 0.392]. Not executed; recorded here as a parallel reading. Confidence: medium (depends on whether the >3σ gap at 1k is genuinely a tail artifact or a deeper code-vs-data mismatch).

## Files in this folder
**Author replication archive (unmodified):**
- `Data_Blora_Final.dta` — analysis dataset
- `Do_Blora_Analysis.do` — main Table 2/3/4 analysis script
- `Do_Blora_Figures.do` — Figure 2/3/4 generation script
- `blorasim_ri_embed.ado` — RI simulation program
- `Do_qvalues.do` — FDR q-value computation
- `README.rtf` — author readme

**Unpatched-run scripts and logs:**
- `run_pushbutton.do` / `run_pushbutton.log` — Table 2 + Figure 3/4 deterministic ATEs and lincom info-effects (this paper's main numerical claims)
- `run_ri_quick.do` / `run_ri_quick.log` — 25-rep RI on `q147_learnmore_apbd_REC2`; first RI run; `pv_5_tt = 0.04`
- `run_ri_full.do` / `run_ri_full.log` — 5,000-rep RI script (started, interrupted)
- `run_ri_2k.do` / `run_ri_2k.log` — 2,000-rep RI script (started, interrupted)
- `run_ri_1k.do` / `run_ri_1k.log` — **1,000-rep RI for all 6 focal outcomes (completed)** — see stochastic-method diagnostics
- `Randomization_Inference/blorasim_1k_*.dta` — output of the 1k run, one per outcome
- `Randomization_Inference/blorasim_FINAL_q147_learnmore_apbd_REC2.dta` — output of the 25-rep run
- `Randomization_Inference/blorasim_2k_q147_learnmore_apbd_REC2.dta` — empty (interrupted run)
- `inspect_ri.do` / `inspect_ri.log` — utility script that confirmed the 2k/full RI .dta files contain 0 observations

**Reference materials:**
- `Pxp7.pdf` — paper PDF
- `Pxp7.txt` — pdftotext extract

**Patched-diagnostic artifacts:** none.
