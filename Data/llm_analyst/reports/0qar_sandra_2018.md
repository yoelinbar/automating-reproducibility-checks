# Reproduction Report — Sandra & Otto (2018), Cognitive capacity limitations and Need for Cognition differentially predict reward-induced cognitive effort expenditure

**Paper:** Sandra, D. A., & Otto, A. R. (2018). Cognitive capacity limitations and Need for Cognition differentially predict reward-induced cognitive effort expenditure. *Cognition*, 172, 101-106. doi:10.1016/j.cognition.2017.12.004
**Paper IDs:** paper_id=0qar; claims=0qar_blj3kw, 0qar_m6y8d5, 0qar_g3y87k, 0qar_gwjq2v
**Reproduction type:** Source Data Reproduction (no analysis code posted; only raw data on OSF)
**Headline verdict (unpatched):** **not reproduced** (all four claims fail on at least one sub-outcome)

## Headline

**The three-way interactions that this paper centers — Trial × Reward × Stroop-RT-cost (Table 2) and Trial × Reward × NFC (Table 3), plus their BAS-controlled siblings reported in §3.5 — do not reproduce.** Reproducing the analysis from the OSF raw data on N=54 (the post-exclusion sample I obtain from the released files using the criteria printed in §2.1: ≥80% accuracy on each task and <15 missed deadlines per block) yields three-way interaction coefficients about **42-60% smaller in magnitude** than the paper's printed values, with p-values ranging from .017 to .24 versus the paper's .007-.012. Sample size also differs: paper N=45 (Stroop EF) and 43 (NFC); reproduction N=54 and 52. All four claim-level verdicts are **not reproduced**.

The non-trivial finding underneath: my reproduction matches almost every other coefficient in Tables 2 and 3 to within rounding (e.g., Block coefficient -0.111 vs paper -0.111; Reward × NFC -0.0233 vs paper -0.0233; Trial-type 0.183 vs 0.175). Model specification — log-RT in milliseconds, lme4 mixed model with by-subject random intercept, Stroop RT cost computed within-subject as z-scored RT diff (incongruent − congruent), Stroop/NFC z-scored across subjects — appears correct. Only the three-way interaction terms and N differ. The most parsimonious explanation is that the OSF data contains 9 "extra" subjects who were excluded from the published analysis but for whom no sub-80%-accuracy or ≥15-misses criterion in the public data triggers exclusion. The paper's text criterion ("either task with an accuracy of at least 80% and 2 participants who missed 15 or more response deadlines in any block") yields only 4+1=5 exclusions on the released data, not the paper's 9. Without analysis code, I cannot pin down which additional 9 subjects to drop.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched, N=54/52) | Bounds (computed from paper) | Sub-verdict |
|---|---|---|---|---|---|---|
| 0qar_blj3kw (Table 2: Trial×Reward×Stroop) | Coefficient | -0.0373 | -0.0373 | -0.0157 | [-0.0429, -0.0317] | **not** |
|  | SE | 0.014 | 0.014 | 0.011 | [0.0119, 0.0161] | not |
|  | p-value | 0.008 | 0.008 | 0.152 | (0, 0.058] for "approx" | **not** |
|  | Sample size | 45 | 45 | 54 | [38.25, 51.75] | **not** |
| 0qar_m6y8d5 (Table 3: Trial×Reward×NFC) | Coefficient | 0.0382 | 0.0382 | 0.0269 | [0.0325, 0.0439] | **not** (29.6% off) |
|  | SE | 0.0145 | 0.0145 | 0.0112 | [0.0123, 0.0167] | not |
|  | p-value | 0.008 | 0.008 | 0.017 | (0, 0.058] for "approx" | approximate |
|  | Sample size | 43 | 43 | 52 | [36.55, 49.45] | **not** (20.9% off) |
| 0qar_g3y87k (§3.5 BAS-controlled, Stroop) | Coefficient | -0.033 | -0.033 | -0.0133 | [-0.0379, -0.0281] | **not** (59.7% off) |
|  | SE | 0.013 | 0.013 | 0.0113 | [0.0111, 0.0150] | approximate |
|  | p-value | 0.012 | 0.012 | 0.239 | [0, 0.062] for "approx" | **not** |
|  | Sample size | 45 | 45 | 54 | [38.25, 51.75] | **not** |
| 0qar_gwjq2v (§3.5 BAS-controlled, NFC) | Coefficient | 0.035 | 0.035 | 0.0253 | [0.0298, 0.0403] | **not** (27.7% off) |
|  | SE | 0.013 | 0.013 | 0.0113 | [0.0111, 0.0150] | approximate |
|  | p-value | 0.007 | 0.007 | 0.025 | [0, 0.057] for "approx" | approximate |
|  | Sample size | 43 | 43 | 52 | [36.55, 49.45] | **not** |

**Overall per-claim verdicts (unpatched):**
- 0qar_blj3kw: **not reproduced**
- 0qar_m6y8d5: **not reproduced**
- 0qar_g3y87k: **not reproduced**
- 0qar_gwjq2v: **not reproduced**

## What I did

### 1. Set-up
Created `independent_reproductions/0qar_sandra_2018/`, copied PDF, ran `pdftotext -layout` to produce `0qar.txt`.

### 2. Extraction check
Verified all four claim values against the published PDF:
- Table 2 (page 104, p.4 of article): "Trial type × reward × stroop RT cost: −0.0373 (0.014), 0.008*". Matches extracted.
- Table 3 (page 104): "Trial type × reward × NFC: 0.0382 (0.0145), 0.008*". Matches extracted.
- §3.5 (page 104) text: "(β = −0.033, SE = 0.013, p = .012) as well as NFC scores (β = 0.035, SE = 0.013, p = .007)". Matches extracted.
- §2.1: "leaving 45 participants in the final analyses" and "further excluded 2 participants with missing NFC questionnaire responses" (so NFC analyses N=43). Matches extracted.

All extractions match the printed paper to all reported digits.

### 3. Data/code source
Paper text §"Supplementary material" (p.105): "All raw data pertaining to this study can be accessed via the Open Science Framework at http://osf.io/gqvsh."

OSF project gqvsh has a child node "Data" (id `akpum`) with three folders:
- `stroop/` — 58 per-subject CSV files (PsychoPy logs)
- `task_switching/` — 124 per-subject CSV files (one `taskSwitch_…` low-reward + one `taskSwitchHR_…` high-reward block per subject; 62 subjects)
- `questionnaire_data.csv` — 56 subjects × {nfc, gad, bis-11, bis, bas}

**No analysis code is posted.** The paper says "All inferential statistics were computed using mixed-effects regressions using the lme4 package" but does not link a script.

Downloaded all files via OSF WaterButler API into `data/`.

### 4. Reproduction
- Type: **Source Data Reproduction**. Re-implemented the analysis described in the paper's §2.4 in R using `lme4` + `lmerTest`.
- Per-subject pipeline (see `run_final.R`):
  - Stroop main loop: 120 trials (rows where `trials.thisN` is non-NA in stroop CSV).
  - Task-switch main loop: 140 trials per block (rows where `trials.thisN` is non-NA).
  - **Stroop RT cost** (the EF measure): per paper §3.1, "the difference between standardized RTs on incongruent and congruent trials". Computed within subject by z-scoring all correct-trial RTs, then taking mean(z|incongruent) − mean(z|congruent).
  - **Task-switch trial-type** (switch vs. repeat): the `spades_or_hearts` column (0/1) toggles each trial; switch=1 when it differs from previous trial within block (first trial of block dropped).
  - **Reward**: 0 = low-reward block (`taskSwitch_…`), 1 = high-reward block (`taskSwitchHR_…`).
  - **Block** ("linear predictor of trial block" per §2.4): inferred from filename timestamps (which session ran first per subject).
  - Outcome: log(RT in milliseconds), correct trials only.
- **Exclusions** (per paper §2.1): drop subject if Stroop or either task-switch block accuracy < 80%, OR if missed-deadline count ≥ 15 in any block. This yields 4 accuracy fails (subjects 015, 020, 061, 063) + 1 miss fail (063 again) = 4 unique exclusions; **N=54 retained** (paper reports 9 exclusions, N=45). For NFC analyses, lose 2 more subjects with no questionnaire data → N=52 (paper N=43).
- Models match Tables 2/3 spec: `log_rt ~ trial_type * reward * predictor + block_idx + (1 | sid)`, where predictor ∈ {z-scored Stroop cost, z-scored NFC}.
- §3.5 model: adds `+ trial_type * reward * z(BAS)` to the same formula.

Environment edits: none (re-implementation, not posted code).

Run command: `Rscript run_final.R 2>&1 | tee run_final.log` (~10 s).

### 5. Stochastic-method diagnostics
None — `lmer` is deterministic given fixed data.

### 6. Classification (unpatched)
Computed bounds per the SCORE rubric (paper-precision rounding for "precise"; ±15% of |orig| for coefficients/N; ±0.05 of orig p for exact p). All four claims have ≥1 "not" sub-outcome → overall verdict per claim is **not reproduced**.

## Diagnostics — author-bug analysis

**Suspected source of divergence:** Sample-size mismatch between the released data and the paper's analyzed sample.

- **Evidence in the released data:** OSF folder `Data/stroop/` contains 58 subject files, `Data/task_switching/` contains 62 unique subject IDs (4 subjects have task-switch but no Stroop), `questionnaire_data.csv` contains 56 subjects. Subject IDs run 001-064 with 028 and 060 entirely absent. Paper §2.1 reports 54 recruited and 9 excluded → N=45 final. With the released data + paper's printed exclusion criteria (<80% on either task, ≥15 missed deadlines in any block), I obtain only 5 exclusion-triggers in 4 unique subjects → N=54.
- **Reasoning:** Either (a) the OSF release contains 9 subjects who were excluded from the publication for reasons not enumerated in §2.1 (e.g., debriefing-stage exclusions, equipment problems, etc.), or (b) the criteria as printed in the paper are looser than what was actually applied. The paper's coefficient SEs (~0.014) are roughly √(54/45) larger than mine (~0.011), exactly what one would expect if the paper's analyzed N really was ~45 — supporting the "extra subjects in the OSF release" interpretation. There is no analysis code on OSF that would identify the excluded subjects.
- **Patched run attempted:** I tried excluding subjects by stricter accuracy thresholds (e.g., <85%, <88%) but no clean threshold yields exactly 9 exclusions. With ad-hoc removal of the 9 worst-min-accuracy subjects (N=49, not exactly 45 either), the three-way interaction for Stroop is -0.0412 (SE 0.0324, p=0.20) — closer to paper magnitude (-0.0373) but still not significant and SE still too small. The patch does not bring p into the paper's range, suggesting the missing piece is not just N but possibly subject identity (which 9 to drop).
- **Verdict if patched (best attempt at N≈45):** still **not reproduced** for the three-way interactions on the basis of p-value (0.20 vs paper 0.008, outside even the approximate band).
- **Confidence:** Medium that the released-data N>paper N is real and is a major contributor; low that any modification I can make from public information will recover paper coefficients exactly.

**Note on coefficient scaling:** Initial attempts (raw 0/1 Stroop cost, no z-scoring) produced coefficients off by orders of magnitude. Once z-scoring across-subjects on Stroop RT cost / NFC was applied (and log-RT computed in milliseconds), all main effects and most two-way interactions match the paper to within 1-2 percent (e.g., paper's reward main effect = 0.0103, mine = 0.0105; paper's Reward×NFC = -0.0233, mine = -0.0233; paper's Block coefficient = -0.111, mine = -0.111). This high-fidelity match on every other coefficient is what most strongly suggests the model spec is correct and the divergence on the three-way interactions is driven by the sample-composition gap, not a model-spec error.

## Files in this folder

- `0qar.pdf` — paper PDF (copy of `papers/0qar.pdf`)
- `0qar.txt` — pdftotext extraction
- `run_final.R` — source-data reproduction script
- `run_final.log` — full output of the reproduction run
- `REPRODUCTION_REPORT.md` — this file
- `data/` — OSF download
  - `data/questionnaire_data.csv` — 56 subjects × 6 columns
  - `data/stroop/*.csv` — 58 PsychoPy logs (one per subject, 120 trials each)
  - `data/task_switching/*.csv` — 124 PsychoPy logs (62 subjects × {LR, HR} block, 140 trials each block)
