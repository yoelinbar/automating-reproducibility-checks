# Reproduction Report — Liu (2015), Trivialization Effects

**Paper:** Liu, P. J., Lamberton, C., & Haws, K. L. (2015). Should Firms Use Small Financial Benefits to Express Appreciation to Consumers? Understanding and Avoiding Trivialization Effects. *Journal of Marketing*, 79(3), 74–90. DOI: 10.1509/jm.14.0091
**Paper IDs:** paper_id=9DZl; claims=[9DZl_gd73pr, 9DZl_grdwrw, 9DZl_mvdj65, 9DZl_g6j1l6, 9DZl_b3vqrj, 9DZl_9kdozq, 9DZl_dv7xy3, 9DZl_k1rz68, 9DZl_7v1odx]
**Reproduction type:** Extended Push Button (SPSS .sps re-implemented in Python via pyreadstat + scipy because no SPSS interpreter is available; the analyses executed are identical to those in the posted .sps files)
**Headline verdict (unpatched):** approximate (8/9 claims precise; 1/9 approximate)
**Verdict if patched:** N/A — no logic patches needed

## Headline
Eight of nine focal claims reproduce **precisely** to the paper's printed precision. The one deviation is in **Claim 9DZl_7v1odx** (Study 4 omnibus F): paper prints F(3,222) = 3.78, the author's syntax requests Brown-Forsythe ANOVA, and BF F = 3.7746 rounds to 3.77 at 2 dp — one ulp off the paper's printed 3.78. The reproduced value sits well inside the ±15% approximate band [3.213, 4.347], so the sub-outcome verdict is `approximate` and the overall verdict on this claim is `approximate`. (Standard one-way F = 3.7807 would round to 3.78; the author's code, however, explicitly requests BF, and the paper's df2 = 222 confirms BF was the test run. Under the prior rubric this claim was coded `precise` partly via the Push-Button auto-precise rule, which no longer applies; under the current rubric BF's 3.77-vs-3.78 mismatch is one-digit-off paper precision and demotes to `approximate`.) Two implementation details required to obtain a clean match on the other eight claims — both are unambiguously specified by the author's posted SPSS syntax: (1) the omnibus one-way ANOVAs in Studies 1b, 1c, 2b, 3 use SPSS's **Brown-Forsythe** F (which alters df2 — e.g., F(8, 319.54)→reported as F(8, 320) — and slightly perturbs F when group sizes are unequal); (2) the unequal-variance follow-up t-tests in Studies 2a and 2b use Welch's adjustment (paper reports the unequal-variances row from SPSS T-TEST, which gives e.g. t(65.02)→t(65) rather than t(79)).

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (precise → approximate) | Sub-verdict |
|---|---|---|---|---|---|---|
| gd73pr (S1a) | F(1,47) | 8.50 | 8.5 | 8.4987 → rounds to 8.50 | precise=8.50; approx ±15% [7.225,9.775] | precise |
| gd73pr | p (exact) | .005 | 0.005 | .00543 → rounds to .005 | precise=.005; approx [0,.055] | precise |
| gd73pr | N | 49 | 49 | 49 | precise=49; approx ±15% [42,56] | precise |
| grdwrw (S1b) | F(1,55) | 10.50 | 10.5 | BF F(1,54.80)=10.4951 → 10.50 | precise=10.50; approx [8.925,12.075] | precise |
| grdwrw | p | .002 | 0.002 | .00204 → .002 | precise=.002 | precise |
| grdwrw | N | 72 | 72 | 72 | precise=72 | precise |
| mvdj65 (S1c) | F(1,39) | 11.97 | 11.97 | BF F(1,38.88)=11.9730 → 11.97 | precise=11.97 | precise |
| mvdj65 | p | .001 | 0.001 | .00132 → .001 | precise=.001 | precise |
| mvdj65 | N | 46 | 46 | 46 | precise=46 | precise |
| g6j1l6 (S2a) | F(1,157) | 3.79 | 3.79 | 3.7904 → 3.79 | precise=3.79 | precise |
| g6j1l6 | p | .053 | 0.053 | .05333 → .053 | precise=.053 | precise |
| g6j1l6 | N | 161 | 161 | 161 | precise=161 | precise |
| b3vqrj (S2a) | t(78) | 2.57 | 2.57 | 2.5663 → 2.57 | precise=2.57 | precise |
| b3vqrj | p | .012 | 0.012 | .01220 → .012 | precise=.012 | precise |
| b3vqrj | N | 161 | 161 | 161 (sub-N=80 used by t-test) | precise | precise |
| 9kdozq (S2b) | t(77) | 1.98 | 1.98 | Welch t(76.80)=1.9793 → 1.98 | precise=1.98 | precise |
| 9kdozq | p | .051 | 0.051 | .0514 → .051 | precise=.051 | precise |
| 9kdozq | N | 364 | 364 | 364 | precise=364 | precise |
| dv7xy3 (S2b) | F(8,320) | 6.18 | 6.18 | BF F(8,319.54)=6.1779 → 6.18 | precise=6.18 | precise |
| dv7xy3 | p | <.001 | 0.001 (less-than) | 2.0e-7 ≤ .001 | precise (threshold) | precise |
| dv7xy3 | N | 364 | 364 | 364 | precise=364 | precise |
| k1rz68 (S3) | t(168) | 3.06 | 3.06 | 3.0598 → 3.06 | precise=3.06 | precise |
| k1rz68 | p | .003 | 0.003 | .00258 → .003 | precise=.003 | precise |
| k1rz68 | N | 251 | 251 | 251 | precise=251 | precise |
| 7v1odx (S4) | F(3,222) | 3.78 | 3.78 | BF F(3,222.42)=3.7746 → 3.77 | precise=3.78; approx ±15% [3.213,4.347] | **approximate** (3.77 vs 3.78 at 2 dp) |
| 7v1odx | p | .011 | 0.011 | .01135 → .011 | precise=.011 | precise |
| 7v1odx | N | 238 | 238 | 238 | precise=238 | precise |

Note on Claim 7v1odx F: BF gives 3.7746 (rounds to 3.77 at 2 dp) vs paper's printed 3.78. Standard ANOVA gives 3.7807 → rounds to 3.78. Either way the value is well within ±15%; the choice of BF vs standard rounds slightly differently. Treating this as one digit of rounding deviation is the most conservative read; the standard one-way (also computed) rounds to exactly 3.78. See classification note below.

### Classification for Claim 7v1odx
The paper's printed F=3.78 lies between BF (3.7746→3.77) and standard one-way (3.7807→3.78). The author's syntax requests BROWNFORSYTHE in the ONEWAY command, and the paper's df2 = 222 confirms BF was used (standard would be 234). At 2 dp BF rounds to 3.77, not 3.78 — one-ulp off the paper's printed value. Per the SCORE rounding rule (round the reproduced value to the paper's printed precision, then compare), the BF F sub-outcome is `approximate`: 3.77 ≠ 3.78 at 2 dp, but the value sits well inside the ±15% band [3.213, 4.347]. Combined with `precise` N and `precise` p, the overall claim verdict is `approximate`.

The standard one-way F (3.7807, also produced by the same SPSS ONEWAY command) rounds to 3.78 — so the paper's printed value is recoverable from the same code if one reads the standard-F row instead of the BF row, but the author's explicit choice and the paper's df2 both anchor on the BF row, which fails paper-precision rounding by one ulp.

### Headline verdict (paper-level, combined across claims)
8 precise, 1 approximate (Claim 9DZl_7v1odx). Paper-level headline: **approximate**.

## What I did

1. **Set-up.** Created `independent_reproductions/9DZl_liu_2015/`, copied PDF, ran `pdftotext -layout`.
2. **Extraction check.** All 9 `orig_*` values match the paper's printed numbers (verified via grep through `9DZl.txt`). Specific page locations: Study 1a F=8.50 p.78 (line 420); Study 1b F=10.50 p.78 (line 433); Study 1c F=11.97 p.79 (line 467); Study 2a F=3.79 (interaction) p.80 (line 539); Study 2a t(78)=2.57 p.81 (line 618); Study 2b F=6.18 and t(77)=1.98 p.82; Study 3 t(168)=3.06 p.82 (line 769); Study 4 F=3.78 p.83. Extraction matches paper for every claim.
3. **Data/code source.** Author's OSF repository at https://osf.io/95kyd/ (linked from Liu's website https://sites.google.com/view/peggyjliu/home/publications). Downloaded all 7 data files (`.sav`) and 7 syntax files (`.sps`) via OSF API.
4. **Reproduction.** Re-implemented the SPSS syntax in Python (`run_reproduction.py`). The Python re-implementation faithfully follows each `.sps` file: same exclusions (Study 1a `exclude=0`, Study 1b/4 `exclude_review=0`, Study 2a/4 `agree=1`), same DV (`dv_index3` / `dv_average` / `dv`), same IVs, same model (one-way ANOVA, two-way ANOVA, t-tests, Brown-Forsythe). Implemented SPSS Brown-Forsythe formula `F* = SSB / Σ(1−n_i/N)·s_i²` with WS df2. Used Welch's t-test where the author's SPSS T-TEST output's "equal variances not assumed" row was the one quoted in the paper (this is unambiguous from the df reported: t(65) for adherent verbal-vs-money in S2a, t(77) for 0% vs 5% in S2b — both shorter than equal-var df).
   - Run command: `python3 run_reproduction.py | tee reproduction.log`
   - Runtime: ~1 second
   - **Environment-only edits:** none beyond the SPSS→Python translation, which is mandated by the plan ("SPSS .sps syntax is read-only — re-implement in Python"). No analysis logic was changed.
5. **Stochastic-method diagnostics.** Not applicable — all analyses are deterministic.
6. **Classification.** Eight claims' sub-outcomes match the paper to printed precision; Claim 9DZl_7v1odx's BF F-statistic sub-outcome rounds to 3.77 at 2 dp vs paper's 3.78, so that sub-outcome is `approximate` (within ±15% band) and the claim's overall verdict is `approximate`.

## Diagnostics — author-bug analysis
Diagnostics: none — unpatched run reproduces 8 of 9 claims to printed precision; Claim 7v1odx's BF F-statistic is 0.01 off paper precision (3.77 vs 3.78), well within the ±15% band, and the author's syntax (BROWNFORSYTHE on ONEWAY) exactly matches the paper's df2 = 222. No author bug suspected. The data, code, and paper are mutually consistent; the deviation is a paper-side last-digit rounding artifact that is invisible under the prior rubric's Push-Button auto-precise rule and surfaces under the current strict rounding rule.

## Files in this folder
- `9DZl.pdf` — paper PDF (copy)
- `9DZl.txt` — pdftotext extraction
- `Study1a_Data.sav` … `Study4_Data.sav` — 7 author data files from OSF
- `Study1a_Syntax.sps` … `Study4_Syntax.sps` — 7 author SPSS syntax files from OSF
- `run_reproduction.py` — Python re-implementation of the SPSS syntax (analyses identical, no logic changes)
- `reproduction.log` — full output of `python3 run_reproduction.py`
- `REPRODUCTION_REPORT.md` — this file
- `9DZl_summary_rows.csv` — per-claim summary rows
