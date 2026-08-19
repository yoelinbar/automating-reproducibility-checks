# Reproduction Report — Bauer, Ruby, Pape (2017), "Solving the Problem of Unattributed Political Violence"

**Paper:** Bauer, Vincent, Keven Ruby, and Robert A. Pape. 2017. "Solving the Problem of Unattributed Political Violence." *Journal of Conflict Resolution* 61(7): 1537–1564. DOI: 10.1177/0022002715612575
**Paper IDs:** paper_id=Z0ma; claims=[Z0ma_single-trace]
**Reproduction type:** Extended Push Button (one env-only edit: removed Windows `cd` to drive letter)
**Headline verdict (unpatched):** approximate
**Verdict if patched (only if applicable):** N/A — no logic patch applied

## Headline

**DEVIATION FLAG (Moderate, per project Statistical Reproduction Guidelines).** The reproduced "Drones t-2" coefficient is **-0.9243** vs the paper's reported **-0.94** (Table 6, p. 1557, "Multiple Imputation" / "DV: Violence"). Absolute gap = **0.0157**, relative gap = **1.7%**. Rounded to the paper's 2-decimal precision the reproduction yields **-0.92**, which does not equal -0.94 — so the rubric records this sub-outcome as **approximate**, not precise. Significance is unchanged: reproduced p = 0.0498 (Stata prints 0.050), N = 152 — both match the paper's "p < .05" threshold and "n = 152" exactly. Overall verdict: **approximate** (one approximate sub-outcome, none `not`). The reproduction is deterministic given the authors' pre-built `qryDrones_Export.xlsx` (the 100 imputations are already baked in), so no Monte Carlo noise can explain the 0.016 gap; the most likely cause is a different MI realization than the one the authors had in hand when Table 6 was prepared (their `Imputations.csv` would have been overwritten if Step 1 was rerun before the published numbers were captured), or a small downstream rounding choice we cannot recover from the supplement.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed from paper value) | Sub-verdict |
|---|---|---|---|---|---|---|
| Z0ma_single-trace | Coefficient (Drones t-2 → Attributed) | -0.94 (Table 6, p. 1557) | -0.94 | **-0.9243** (rounds to -0.92) | precise = -0.94 to 2 dec; approx = \|coef\| ∈ [0.799, 1.081] | **approximate** |
| Z0ma_single-trace | p-value | p < .05 (Table 6 footnote; restated p. 1559) | 0.05 (less-than) | **p = 0.0498** (Stata displays 0.050; t=-1.962, large-sample DF) | precise ≤ .05; approx (.05, .10]; not > .10 | **precise** |
| Z0ma_single-trace | Sample size | n = 152 (Table 6, p. 1557) | 152 | **152** | precise = 152; approx [129.2, 174.8] | **precise** |
| Z0ma_single-trace | Test statistic | not reported in paper | NaN | (t = -1.962 from reproduction; not in paper) | n/a | **non-outcome** |
| Z0ma_single-trace | Effect size | not reported as a separate metric | NaN | n/a | n/a | **non-outcome** |

**Overall (unpatched):** approximate.

## What I did

### 1. Set-up
Created `independent_reproductions/Z0ma_bauer_2017/`. Copied `papers/Z0ma.pdf` in and ran `pdftotext -layout` to produce `Z0ma.txt`. Read `REPRODUCTION_PLAN.md`, `SUBAGENT_PROMPT_TEMPLATE.md`, and `paper_claims/Z0ma.json`.

Manually-fetched SAGE supplement was placed by the RA at `manually downloaded data/Z0ma/BauerRubyPape2015Replication/`, containing 4 entries plus a `Replay.txt`:
- `Attribution_Step1_MI_2015-09-23.do` — multinomial-logit MI (creates `Imputations.csv`)
- `Attribution_Step2_VAR_2015-09-23.do` — VAR on multiply-imputed series (creates Table 6)
- `Drones_MI.accdb` — MS Access database transforming events → longitudinal data
- `PakistanAttacks_(2015-03-29).xlsx` — raw events file
- `qryDrones_Export.xlsx` — output of the Access transformation, longitudinal weekly counts with 100 pre-stacked MI draws (15,555 rows = 155 weeks × 101 frames including m=0 original)

I copied/symlinked these into the reproduction directory.

### 2. Extraction check
Located Table 6 ("Vector Auto Regression Estimates by Attribution Strategy") on p. 1557 of the published article. The "Multiple Imputation" column, "DV: Violence" panel, "Drones" block, "t-2" lag row prints "**-0.94***" with the asterisk corresponding to *p* < .05 per the table footnote. The row "n" prints "152" for the Multiple Imputation column. p. 1559 confirms "using MI finds a negative correlation between drone strikes and violence (*p* < .05)." All `orig_*` extracted values match the printed paper to all reported digits. No extraction discrepancies.

### 3. Data/code source
SAGE supplement, manually fetched by the RA. The pipeline as documented in `Replay.txt`:
1. Run `Attribution_Step1_MI_2015-09-23.do` on `PakistanAttacks_(2015-03-29).xlsx` → produces `Imputations.csv` (100 multinomial-logit imputations of the missing-attribution variable).
2. Open `Drones_MI.accdb` (MS Access, Windows-only) → linked to `Imputations.csv` → exports `qryDrones_Export.xlsx` (weekly longitudinal panel with 100 MI frames).
3. Run `Attribution_Step2_VAR_2015-09-23.do` on `qryDrones_Export.xlsx` → produces the Table 6 "Multiple Imputation" column.

Because Access is not available on macOS and `qryDrones_Export.xlsx` is shipped pre-built in the supplement (presumably the authors' own output), I ran Step 2 directly on the shipped `qryDrones_Export.xlsx` — i.e., I used the authors' frozen 100-imputation dataset rather than re-rolling Step 1. This makes the reproduction **deterministic** — no MI stochasticity to worry about — and is the closest possible match to "what the authors had in hand when they made Table 6."

### 4. Reproduction commands
Copied `Attribution_Step2_VAR_2015-09-23.do` to `run_pushbutton.do` and made one **env-only** edit:

```diff
- local drive = substr("`c(pwd)'", 1, 2)
- cd `drive'
+ * env-only edit: removed Windows-style cd to drive letter; stay in cwd.
```

(The original `cd` would `cd C:` on Windows; on macOS `cd /U` would error and abort the run. No analysis logic touched.)

Ran:
```
stata-mp -b do run_pushbutton.do
```
Runtime ≈ 30 seconds. Outputs: `run_pushbutton.log`, `attribution_VAR.log`, `results.irf`.

The key Table 6 result comes from `mi estimate, cmdok: var PakMil Drones Attributed, lags(1/2)` (line 100 of the original do-file). The relevant rows of the `mi estimate` output (run_pushbutton.log lines 542–597):

```
Multiple-imputation estimates                   Imputations       =        100
Vector autoregression                           Number of obs     =        152
...
Attributed   |
      Drones |
         L1. |   .1538535   .4712474     0.33   0.744    -.7697979    1.077505
         L2. |    -.92432   .4711191    -1.96   0.050    -1.847725   -.0009147
```

This is the "Drones t-2" coefficient on "Attributed" violence in the trivariate VAR (PakMil, Drones, Attributed) with 2 lags, MI'd across 100 imputations and combined via Rubin's rules — exactly what the paper describes (p. 1558).

### 5. Stochastic-method diagnostics
The headline run is **deterministic** because the supplied `qryDrones_Export.xlsx` already contains the authors' 100 MI draws (m=1..100), generated upstream by Step 1 + Access. Step 2 just reads them and applies Rubin's rules — no RNG involvement at this stage. Re-running Step 2 yields bit-identical results. So the 0.016 gap to the paper's -0.94 is **not** Monte Carlo noise. It would be MC noise only if I re-rolled Step 1 (different random `mi impute mlogit` draws → different imputed sample → different VAR coefficients per imputation → different Rubin-pooled coefficient), but Step 1 wasn't rerun for the headline.

The most plausible explanations for the 0.016 gap:
1. The authors' published Table 6 came from a different `Imputations.csv` realization than the one whose Access-export ships in the supplement (e.g., they reran Step 1 between archiving and publication). Step 1 contains `set seed 1000` — but only before the *crossfold cross-validation* block (line 149), not before `mi impute mlogit` (line 200). So Step 1 is non-deterministic and successive runs would produce different imputed datasets, leading to different Table 6 coefficients.
2. Stata version drift in `mi estimate` / `var` defaults between the authors' run circa 2015 and current Stata (no version control in the do-file).

Either way, the gap is small (1.7%), well within the 15% approximate band, with significance and N exactly preserved.

### 6. Classification (unpatched)
- **Sample size:** paper 152, reproduced 152 → **precise**.
- **p-value:** paper "p < .05" (threshold). Reproduced p = 0.0498 ≤ 0.05 → **precise** under threshold rule.
- **Coefficient:** paper -0.94 (2 dec). Reproduced -0.9243 → rounds to -0.92 ≠ -0.94 → not precise. Approximate band |coef| ∈ [|−0.94|×0.85, |−0.94|×1.15] = [0.799, 1.081]. |−0.9243| = 0.9243 ∈ band → **approximate**.
- **Test statistic:** not reported in paper → **non-outcome**.
- **Effect size:** not reported in paper → **non-outcome**.

Combined: at least one `approximate`, none `not` → **overall: approximate**.

## Diagnostics — author-bug analysis

**Diagnostics: none — no logic-level author bug suspected.** The unpatched run reproduces the published coefficient to within 1.7%, with N and p exactly preserved. The small magnitude gap is consistent with either (a) a different stochastic realization of Step 1's `mi impute mlogit` (Step 1 sets `set seed 1000` only before the `crossfold` cross-validation block, not before the imputation block, so successive runs of Step 1 do not reproduce bit-identically) or (b) Stata-version drift in `mi estimate`/`var` defaults since 2015. Neither is a bug.

For completeness, I did **not** attempt to rerun Step 1 + Access on macOS — Access is Windows-only, and even if I bridged that step (e.g., reimplementing the Access query in Python), without `set seed` before the MI block the run would not bit-reproduce the authors' Table 6 either. The deterministic headline using the shipped `qryDrones_Export.xlsx` is the strongest reproduction available from this supplement.

## Files in this folder

**Author supplement (unmodified, copied in):**
- `Attribution_Step1_MI_2015-09-23.do` — Step 1 MI script (not rerun for the headline; documented for completeness)
- `Attribution_Step2_VAR_2015-09-23.do` — Step 2 VAR script (original)
- `Drones_MI.accdb` — MS Access linkage database (not runnable on macOS)
- `PakistanAttacks_(2015-03-29).xlsx` — raw events data
- `qryDrones_Export.xlsx` — pre-built weekly panel with 100 MI frames (the input to Step 2)
- `Replay.txt` — author's pipeline notes

**Headline reproduction artifacts:**
- `run_pushbutton.do` — Step 2 with one env-only edit (removed Windows `cd` to drive letter)
- `run_pushbutton.log` — full Stata log of the headline run
- `attribution_VAR.log` — secondary log written by the do-file's `log using` command
- `results.irf` — Stata IRF file written by the run

**Audit artifacts:**
- `Z0ma.pdf` — copy of the published article
- `Z0ma.txt` — `pdftotext -layout` extraction
- `REPRODUCTION_REPORT.md` — this file
- `Z0ma_summary_rows.csv` — one summary row for the single claim
