# Reproduction Report — Hansen (2014), Sound Patterns Change Level Of Construal

**Paper:** Hansen, J., & Melzner, J. (2014). What you hear shapes how you think: Sound patterns change level of construal. *Journal of Experimental Social Psychology*, 54, 131-138. DOI: https://doi.org/10.1016/j.jesp.2014.05.002

**Paper IDs:** paper_id=EAa; claims=[EAa_single-trace]
**Reproduction type:** Source Data Reproduction (no analysis code posted; raw SPSS data on OSF; analysis re-implemented from paper text)
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A — no patch needed

## Headline

The focal claim — a 5 (Sound Priming) × 2 (Information Type, within) mixed-design ANOVA on toaster evaluation showing the predicted interaction *F*(4, 90) = 3.47, *p* = .01, η²ₚ = .13, *N* = 95 — reproduces precisely on every reported sub-outcome. Re-running the analysis on the author-released SPSS file (OSF project 5q9sk, `Daten Sound CL.sav`) with the paper's stated N=95 exclusion (`filter==1` in the data) yields *F*(4, 90) = 3.466 (rounds to 3.47), *p* = .0111 (rounds to .01), η²ₚ = .1335 (rounds to .13). All five cell means/SDs reported in the paper's results paragraph (e.g., abstract sound *M*₄.₅ = 5.14, *SD* = 0.72; concrete sound *M*₂.₅ = 4.33, *SD* = 1.41) match the data file to two decimals.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| EAa_single-trace | Sample size | 95 | 95 | 95 | precise = 95; approx = [81, 109] | precise |
| EAa_single-trace | F statistic (interaction) | 3.47 | 3.47 | 3.466 → 3.47 | precise = 3.47; approx = [2.95, 3.99] | precise |
| EAa_single-trace | p-value (exact) | .01 | 0.01 | .0111 → .01 | precise = .01; approx = [0, .06] | precise |
| EAa_single-trace | Effect size (η²ₚ) | .13 | 0.13 | .1335 → .13 | precise = .13; approx = [.11, .15] | precise |
| EAa_single-trace | Coefficient | non-outcome | NaN | n/a | n/a | non-outcome |

**Overall verdict (unpatched): precise.**

## What I did

### 1. Set-up
Created `independent_reproductions/EAa_hansen_2014/`, copied `papers/EAa.pdf`, ran `pdftotext -layout` to produce `EAa.txt`.

### 2. Extraction check
Located the focal claim on page 5 of the PDF (manuscript p. 135), Results-and-discussion paragraph for "Measure 3: weighting of average versus single evaluative information":

> "Importantly, we found the predicted interaction, *F*(4, 90) = 3.47, *p* = .01, η²ₚ = .13."

Sample size verified on page 3 (manuscript p. 133):

> "Five participants were excluded from the analyses ... The remaining sample consisted of 95 participants (69 females, 26 males)."

All `orig_*` values in `paper_claims/EAa.json` match the printed values exactly. **Extraction is correct.**

### 3. Data/code source
Paper's pr_code_available = "No"; pr_data_location = "Online repository". Searched OSF and located the project at `https://osf.io/5q9sk/` ("What you hear shapes how you think: Sound patterns change level of construal"). Files present:
- `Daten Sound CL.sav` — full SPSS data file (100 participants × 68 variables)
- `Sound Files/` — audio stimuli (not needed for analysis)
- `Toaster Task/` — Toaster.pdf (stimulus) + read me.rtf (counterbalancing notes)

No analysis code is posted, so this is a **Source Data Reproduction**: re-implement the analysis described in the paper text from the released raw data.

Variables used: `group` (5-level Sound Priming, 1=concrete sound through 5=abstract sound per SPSS value labels), `toaster45_mean`/`toaster25_mean` (author-precomputed mean of the five evaluation items per toaster — Cronbach's α reported in the paper as .94 for each), `filter` (1 = retained, 0 = excluded for technical/hearing problems; 95 retained out of 100 — matches paper).

### 4. Reproduction
Ran:
```
python3 run_reproduction.py > run_reproduction.log 2>&1
```
Reads SAV with `pyreadstat`, applies `filter==1` (drops 5 excluded participants per paper), reshapes to long, and runs `pingouin.mixed_anova` with within=InfoType, between=group, subject=Subject.

No environment-only edits were necessary because no author code was run. The exclusion `filter==1` is **not** an "added filter" in the SCORE-policy sense — it is the author-provided exclusion variable in their own data file, which precisely yields the paper's reported N=95.

Output (`run_reproduction.log`):
```
Source        SS  DF1  DF2       MS        F    p_unc      np2
group      5.275    4   90  1.319    1.733  .1496  .0715
InfoType   7.205    1   90  7.205    2.853  .0947  .0307
Interaction 35.007  4   90  8.752    3.466  .0111  .1335
```

The two-way interaction line is the focal test. Group means recovered also match the paper:
- Concrete (group 1): M₄.₅ = 3.77 (SD 1.36); M₂.₅ = 4.33 (SD 1.41) — paper: 3.77/1.36 and 4.33/1.41.
- Abstract (group 5): M₄.₅ = 5.14 (SD 0.72); M₂.₅ = 2.98 (SD 0.79) — paper: 5.14/0.72 and 2.98/0.79.

### 5. Stochastic-method diagnostics
None — analysis is deterministic OLS-based ANOVA.

### 6. Classification (per SCORE Criterion Guide, paper-precision rounding)

- Sample size: paper 95, reproduced 95 → **precise.**
- F statistic: paper 3.47 (2 d.p.), reproduced 3.466 → rounds to 3.47 → **precise.**
- p-value (exact, paper prints "p = .01", 2 d.p.): reproduced .0111 → rounds to .01 → **precise.** (Also within ±.05 approximate band; both criteria satisfied.)
- η²ₚ: paper .13 (2 d.p.), reproduced .1335 → rounds to .13 → **precise.**
- Coefficient: not reported for this F-test claim → **non-outcome.**

Combined: every reported sub-outcome is `precise` → **overall: precise.**

## Diagnostics — author-bug analysis

**Diagnostics: none.** Unpatched (Source-Data) reproduction matches the paper to all reported digits on every sub-outcome. No suspected bug in the released data; no logic-level patch was tried because none was needed.

## Files in this folder
- `EAa.pdf` — paper PDF (copy of `papers/EAa.pdf`)
- `EAa.txt` — `pdftotext -layout` extraction
- `Daten_Sound_CL.sav` — author's SPSS data (downloaded from OSF 5q9sk)
- `Toaster.pdf` — author's toaster-stimulus image (OSF, not needed for stats)
- `readme.rtf` — author's read-me about counterbalancing (OSF)
- `run_reproduction.py` — analysis script (Source-Data re-implementation)
- `run_reproduction.log` — output of the unpatched run
- `EAa_summary_rows.csv` — per-claim summary row
- `REPRODUCTION_REPORT.md` — this file
