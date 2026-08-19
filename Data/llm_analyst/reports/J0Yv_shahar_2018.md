# Reproduction Report — Shahar (2018), Self-Censorship of Conflict-Related Information

**Paper:** Shahar, E., Hameiri, B., Bar-Tal, D., & Raviv, A. (2018). Self-censorship of conflict-related information in the context of intractable conflict. *Journal of Conflict Resolution*, 62(5), 957-982. DOI: 10.1177/0022002716680266
**Paper IDs:** paper_id=J0Yv; claims=J0Yv_pprv8w, J0Yv_q7r1ko, J0Yv_x6ry86, J0Yv_j6dnjr, J0Yv_1rz4jk
**Reproduction type:** Source Data Reproduction (no analysis code posted; SPSS .sav data files supplied by RA)
**Headline verdict (unpatched):** **precise**
**Verdict if patched:** N/A — no patch needed

## Headline

All five target claims reproduce essentially exactly. Re-implementing the SPSS GLM Repeated Measures with covariate (political orientation) using sum-coded Type-III ANOVA in Python gives:

- **Study 1 recipients main effect** (claims `J0Yv_pprv8w` and `J0Yv_q7r1ko`, identical duplicate rows): F = 7.6576 → **7.66** (paper 7.66 ✓), partial η² = 0.0999 → **.10** (paper .10 ✓), p = 7.05×10⁻⁵ < .001 ✓.
- **Study 2 recipients main effect** (claims `J0Yv_x6ry86` and `J0Yv_j6dnjr`, identical duplicate rows): F = 73.8100 → **73.81** (paper 73.81 ✓), partial η² = 0.2706 → **.27** (paper .27 ✓), p ≈ 1.3×10⁻⁴⁰ < .001 ✓.
- **Study 2 observer main effect** (claim `J0Yv_1rz4jk`): F = 7.6777 → **7.68** (paper 7.68 ✓), partial η² = 0.0371 → **.04** (paper .04 ✓), p = .00612 → **.006** (paper .006 ✓).

Cell means in Tables 1 and 2 reproduce to two decimals. The Study 1 between-subjects political-orientation covariate (paper-side check, not a focal claim) reproduces F(1,69) = 18.105 / partial η² = 0.208 → matches paper's F(1,69) = 18.10, η²ₚ = .21. The Study 2 paper-side checks (political: F = 93.45, η²ₚ = .32; actor: F = 4.31, η²ₚ = .02) also reproduce to all printed digits.

**Note on degrees of freedom for Study 2 recipients:** The paper reports df = (2, 470) where my univariate decomposition gives df = (3, 597). Greenhouse-Geisser ε ≈ 0.787 implied by the ratio 470/597, and `pingouin`'s G-G ε on the data is 0.814 (close). The F-statistic and partial η² are invariant to the GG correction; only the df (and thus the printed p-value) shrink. So the F = 73.81 / η²ₚ = .27 match is exact.

**Sample sizes match exactly:** Study 1 N = 71 (paper N = 71); Study 2 N = 204 (paper N = 204). Cell sizes per condition (53/52/49/50) sum to 204.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| J0Yv_pprv8w (Study 1 recipients) | F | 7.66 | 7.66 | 7.6576 → 7.66 | precise band: [7.66 − 0.5×10⁻²]; approx: [6.51, 8.81] | **precise** |
| J0Yv_pprv8w | p | < .001 | 0.001 (less-than) | 7.05×10⁻⁵ < .001 | precise: ≤ .001; approx: (.001, .051] | **precise** |
| J0Yv_pprv8w | partial η² | .10 | 0.10 | 0.0999 → .10 | precise: rounds to .10; approx: [0.085, 0.115] | **precise** |
| J0Yv_pprv8w | N | 71 | 71 | 71 | precise: =71; approx: [60, 82] | **precise** |
| J0Yv_q7r1ko (Study 1 recipients, dup row) | (same as above) | (same) | (same) | (same) | (same) | **precise** |
| J0Yv_x6ry86 (Study 2 recipients) | F | 73.81 | 73.81 | 73.8100 → 73.81 | precise rounds to 73.81; approx: [62.74, 84.88] | **precise** |
| J0Yv_x6ry86 | p | < .001 | 0.001 (less-than) | 1.3×10⁻⁴⁰ < .001 | precise: ≤ .001 | **precise** |
| J0Yv_x6ry86 | partial η² | .27 | 0.27 | 0.2706 → .27 | precise; approx: [0.230, 0.310] | **precise** |
| J0Yv_x6ry86 | N | 204 | 204 | 204 | precise; approx: [173, 235] | **precise** |
| J0Yv_j6dnjr (Study 2 recipients, dup row) | (same as above) | (same) | (same) | (same) | (same) | **precise** |
| J0Yv_1rz4jk (Study 2 observer) | F | 7.68 | 7.68 | 7.6777 → 7.68 | precise; approx: [6.53, 8.83] | **precise** |
| J0Yv_1rz4jk | p | .006 | 0.006 (exact) | 0.00612 → .006 | precise; approx: [0, .056] | **precise** |
| J0Yv_1rz4jk | partial η² | .04 | 0.04 | 0.0371 → .04 | precise; approx: [0.034, 0.046] | **precise** |
| J0Yv_1rz4jk | N | 204 | 204 | 204 | precise | **precise** |

All extracted values match the paper. All reproduced values match the paper to printed precision. **Overall verdict per claim: precise. Headline verdict: precise.**

## What I did

1. **Set-up.** Working directory `independent_reproductions/J0Yv_shahar_2018/`. Copied `papers/J0Yv.pdf`, generated `J0Yv.txt` via `pdftotext -layout`. The RA (Research Assistant) supplied SPSS data files at `manually downloaded data/J0Yv/{Study 1.sav, Study 2.sav, Study 3.sav}` (Study 3 not in claim set — a separate experiment with N = 123).

2. **Extraction check.**
   - `J0Yv_pprv8w` / `J0Yv_q7r1ko` (Study 1, p. 964 ≈ text lines 348-351): paper text "*a significant effect for information recipients (F(3,69) = 7.66, p < .001, η²ₚ = .10)*" ✓ N = 71 (line 296: "*Participants were 71 Israeli–Jews*") ✓.
   - `J0Yv_x6ry86` / `J0Yv_j6dnjr` (Study 2, p. 967 ≈ text lines 489-490): "*F(2,470) = 73.81, p < .001, η²ₚ = .27*" ✓ N = 204 (line 419) ✓.
   - `J0Yv_1rz4jk` (Study 2 observer, p. 967 line 498): "*F(1,199) = 7.68, p = .006, η²ₚ = .04*" ✓.
   - All `orig_*` extraction values match the paper.

3. **Data/code source.** Author-supplied SPSS .sav files. No analysis code posted with paper (`pr_code_available: No` in CSV). Files supplied by RA into `manually downloaded data/J0Yv/`. Variables in Study 1: `CLOSE_RELATIONSHIP`, `SUPERIORS`, `ISRAELI_NGO`, `OUTSIDE_NGO` (4 within-subject WSC items), plus `Politc_s` (1–5 right-to-left). Study 2: `SC_close_rel`, `SC_Authoritis`, `SC_isr_NGO`, `SC_abrod_NGO` plus `scene_actor`, `scene_observer` (2×2 between), `political_stand`. No missing data on any analysis variable. Cell means match paper Table 1 / Table 2 exactly to two decimals.

4. **Reproduction.** Re-implemented in Python (`pyreadstat.read_sav` for I/O, `statsmodels.formula.api.ols` + `anova_lm(typ=3)` for SPSS GLM Repeated Measures). The model that matches the paper is: `WSC ~ C(Recipient, Sum) * C(<between>, Sum) ... + C(Recipient, Sum):political_stand + C(Subject)` — i.e., Subject fixed effects to absorb between-subject variance, **sum-coded categorical predictors** (matches SPSS GLM defaults), Type-III SS, and the covariate's interaction with the within-subjects factor included in the within design (this is what SPSS does when you specify a covariate in `/WSDESIGN`). Between-subjects effects are then computed on subject-mean DV with the same SS scaled by k = 4 (the number of within levels), reproducing SPSS's "Tests of Between-Subjects Effects" table.

   Exact commands:
   ```
   python3 run_reproduction.py 2>&1 | tee run_reproduction.log
   ```
   Runtime ≈ 3 s. Environment: Python 3.14, pyreadstat, statsmodels 0.14.6, pingouin 0.6.1, scipy 1.17.0. No environment-only edits to author code (no author code exists). Re-implementation is the analyst's, written from scratch to match the SPSS specification described in the paper.

5. **Stochastic-method diagnostics.** N/A — closed-form ANOVA.

6. **Classification.**
   - Every reproduced value rounds to its paper value at the paper's printed precision: F-statistics to 2 decimals, partial η² to 2 decimals, p-values to thresholds or exact 3-decimal values, N exact.
   - All sub-outcomes are `precise`. Combined per-claim verdict: `precise` for each of the 5 claims. Headline: `precise`.

   Sample-size precision band trivially satisfied (paper-N matches reproduced-N exactly).
   F-statistic precision band: reproduced rounded to 2 decimals equals paper. Approximate band ±15% would be satisfied as a fallback even if precision missed.
   p-value: thresholds in claims 1–4 satisfied (reproduced p ≪ paper threshold); claim 5 exact p = .006 reproduces to .006 at 3-decimal precision.
   Partial η²: reproduced rounded to 2 decimals equals paper for all five claims.

## Diagnostics — author-bug analysis

Diagnostics: none — unpatched re-implementation reproduces all 5 claims to paper-printed precision. No author bug suspected. The paper's Greenhouse-Geisser-corrected df = (2, 470) for the Study 2 within main effect is a SPSS reporting convention (not a bug); the F-statistic and partial η² are GG-invariant and match exactly.

## Files in this folder

- `J0Yv.pdf` — published paper (copy of `papers/J0Yv.pdf`)
- `J0Yv.txt` — `pdftotext -layout` extraction of the paper
- `Study 1.sav` / `Study 2.sav` / `Study 3.sav` — author SPSS data files (RA-supplied; symlinked or copy-of `manually downloaded data/J0Yv/*.sav`)
- `run_reproduction.py` — re-implementation script (Source Data Reproduction)
- `run_reproduction.log` — full console output of the reproduction run
- `REPRODUCTION_REPORT.md` — this file
- `J0Yv_summary_rows.csv` — one row per claim
- `sage_suppl.html` — leftover artifact from earlier (failed) supplement-fetch attempt; safe to delete
