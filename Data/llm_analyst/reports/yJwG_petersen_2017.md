# Reproduction Report — Petersen (2017), The Effect of Phasic Auditory Alerting on Visual Perception

**Paper:** Petersen, A., Petersen, A. H., Bundesen, C., Vangkilde, S., & Habekost, T. (2017). The effect of phasic auditory alerting on visual perception. *Cognition*, 165, 73–81. DOI: 10.1016/j.cognition.2017.04.004
**Paper IDs:** paper_id=yJwG; claims=yJwG_mjqwop, yJwG_g12xod, yJwG_g9l3pl, yJwG_m4y9z9, yJwG_b574lj
**Reproduction type:** Source Data Reproduction
**Headline verdict (unpatched):** precise
**Verdict if patched (only if applicable):** N/A — no patch needed.

## Headline

All five focal paired t-tests reproduce **precisely** to the paper's printed precision when the analysis is run on the publisher-hosted per-subject TVA parameter estimates (Elsevier supplementary CSVs mmc1, mmc3, mmc5, PII `S0010027717300987`). Every reported sub-outcome — t, df, p, Cohen's dz, and N — matches the paper exactly when the reproduced value is rounded to the precision the paper uses. Multiple non-focal secondary t-tests reported in the same paragraphs (e.g. Exp 2 v 40dB vs 85dB t(27)=2.20; Exp 2 t0 NoCue vs 85dB t(27)=3.90; Exp 3 v 40dB vs 85dB t(24)=2.23; the two `40dB vs 85dB` t0 test of t(27)=0.17) also reproduce. No deviations of any magnitude were observed; no logic-level bugs to diagnose.

**Note on prior failed attempt:** A previous reproduction attempt was blocked because Elsevier's CDN served wrong-paper supplements at the (incorrect) PII `S0010027717301002`. The RA manually retrieved the correct supplement (PII `S0010027717300987`); those are the data used here. No source code was archived, so this is a Source Data Reproduction (re-implemented in Python).

## Comparison table

For paired t-tests, a focal claim has four sub-outcomes (t, df implied via N, p, dz, N). The "Bounds" column is the SCORE-rubric approximate band; "Precise" requires equality to the paper's printed precision.

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| yJwG_mjqwop (Exp 1, v, NoCue vs 85dB) | t | 4.71 | 4.71 | 4.7079 → 4.71 | [4.0035, 5.4165] | precise |
| yJwG_mjqwop | p | < 0.001 | 0.001 (less-than) | 6.68e-05 | precise if p ≤ 0.001 | precise |
| yJwG_mjqwop | dz | 0.89 | 0.89 | 0.8897 → 0.89 | [0.7565, 1.0235] | precise |
| yJwG_mjqwop | N | 28 | 28 | 28 | [23.8, 32.2] | precise |
| yJwG_g12xod (Exp 1, t0, NoCue vs 85dB) | t | 3.52 | 3.52 | 3.5231 → 3.52 | [2.992, 4.048] | precise |
| yJwG_g12xod | p | 0.002 (exact) | 0.002 | 0.001539 → 0.002 | [0, 0.052] approx; precise = 0.002 | precise |
| yJwG_g12xod | dz | 0.67 | 0.67 | 0.6658 → 0.67 | [0.5695, 0.7705] | precise |
| yJwG_g12xod | N | 28 | 28 | 28 | [23.8, 32.2] | precise |
| yJwG_g9l3pl (Exp 2, v, NoCue vs 40dB) | t | 5.44 | 5.44 | 5.4410 → 5.44 | [4.624, 6.256] | precise |
| yJwG_g9l3pl | p | < 0.001 | 0.001 (less-than) | 9.34e-06 | precise if p ≤ 0.001 | precise |
| yJwG_g9l3pl | dz | 1.03 | 1.03 | 1.0282 → 1.03 | [0.8755, 1.1845] | precise |
| yJwG_g9l3pl | N | 28 | 28 | 28 | [23.8, 32.2] | precise |
| yJwG_m4y9z9 (Exp 2, t0, NoCue vs 40dB) | t | 4.21 | 4.21 | 4.2095 → 4.21 | [3.5785, 4.8415] | precise |
| yJwG_m4y9z9 | p | < 0.001 | 0.001 (less-than) | 2.54e-04 | precise if p ≤ 0.001 | precise |
| yJwG_m4y9z9 | dz | 0.80 | 0.80 | 0.7955 → 0.80 | [0.68, 0.92] | precise |
| yJwG_m4y9z9 | N | 28 | 28 | 28 | [23.8, 32.2] | precise |
| yJwG_b574lj (Exp 3, v, NoCue vs 40dB) | t | 5.47 | 5.47 | 5.4745 → 5.47 | [4.6495, 6.2905] | precise |
| yJwG_b574lj | p | < 0.001 | 0.001 (less-than) | 1.26e-05 | precise if p ≤ 0.001 | precise |
| yJwG_b574lj | dz | 1.09 | 1.09 | 1.0949 → 1.09 | [0.9265, 1.2535] | precise |
| yJwG_b574lj | N | 25 | 25 | 25 | [21.25, 28.75] | precise |

**Overall verdict per claim:** all five claims are `precise`.

All extracted values match the paper to all reported digits (verified in `yJwG.txt` against the published version of record — Experiment 1 results lines 215–217; Experiment 2 lines 341–362; Experiment 3 lines 407–417).

## What I did

1. **Set-up.** Working directory `independent_reproductions/yJwG_petersen_2017/`. Copied paper PDF (`yJwG.pdf`), pdftotext output (`yJwG.txt`). Copied the six supplement files delivered by the RA from `manually downloaded data/yJwG/` and unzipped the three .zip's (each contained a single SPSS `.sav` file with the same per-subject parameter estimates as the parallel CSVs). Moved the previously-fetched wrong-paper supplements (`mmc1.pdf`, `mmc1.txt`, `mmc2.xlsx`) into `wrong_paper_supplements_archived/` to avoid confusion.

2. **Verify supplement files correspond to the paper.** Inspected CSV headers:
   - `mmc1.csv` (29 lines = header + 28 rows): `ID, Gender, Age, v_NoCue, t0_NoCue, pg_NoCue, VarExp_NoCue, v_85dBCue, t0_85dBCue, pg_85dBCue, VarExp_85dBCue, LogLik_2x3model, LogLik_1x3model`. N=28, two cue conditions (NoCue, 85dB) — matches Experiment 1.
   - `mmc3.csv` (29 lines = header + 28 rows): adds 40dBCue columns. N=28, three conditions — matches Experiment 2.
   - `mmc5.csv` (26 lines = header + 25 rows): three cue conditions plus per-subject pupil dilation columns at 10–80 ms windows. N=25 — matches Experiment 3.

   The TVA parameters (v = visual processing speed in items/s; t0 = perceptual threshold in ms; pg = guessing rate; VarExp = variance explained) are exactly the per-subject estimates the paper says were obtained by Nelder-Mead simplex MLE on the trial-level recognition accuracy data. Data corresponds to the paper.

3. **Extraction check.** Re-read pp. 75–77 of the PDF. All five claims' (t, df, p, dz, N) values match `paper_claims/yJwG.json` exactly — no extraction discrepancies.

4. **Data/code source.** Per-subject TVA parameter estimates from Elsevier supplementary CSVs (PII `S0010027717300987`, mmc1/mmc3/mmc5). No author code is archived. Re-implemented the paired t-tests in Python (`run_reproduction.py`, scipy 1.x). Source-Data Reproduction.

5. **Reproduction commands.** `python3 run_reproduction.py | tee run_reproduction.log` (runtime <1 s). The script computes paired t-tests via the standard formula t = mean(d) / (sd(d)/sqrt(n)) with two-sided p from `scipy.stats.t.sf`, and Cohen's dz = mean(d) / sd(d). No environment edits required; no analysis logic edits.

6. **Stochastic-method diagnostics.** N/A — paired t-test on fixed inputs is deterministic.

7. **Classification (unpatched).** Every focal sub-outcome reproduces to the paper's printed precision after rounding. Every claim verdicts `precise`. Overall paper verdict: `precise` on all 5/5 claims.

### Secondary tests in the same paragraphs (not focal extractions)

These are not the focal sub-outcomes the rubric scores against, but reproducing them gives additional confidence the data file matches the analysis the paper actually ran:

| Reported in paper | Paper | Reproduced |
|---|---|---|
| Exp 2, v 85dB vs 40dB | t(27)=2.20, p=0.037, dz=0.41 | t(27)=2.1948, p=0.0370, dz=0.4148 |
| Exp 2, t0 NoCue vs 85dB | t(27)=3.90, p=0.001, dz=0.74 | t(27)=3.8966, p=0.000581, dz=0.7364 |
| Exp 2, t0 40dB vs 85dB | t(27)=0.17, p=0.869 | t(27)=0.1661 (sign convention; \|t\|), p=0.8693 |
| Exp 3, v 85dB vs 40dB | t(24)=2.23, p=0.035, dz=0.45 | t(24)=2.2303, p=0.0353, dz=0.4461 |

All secondary values match.

## Diagnostics — author-bug analysis

**Diagnostics: none — unpatched run reproduces; no logic bug suspected.**

The only artifact worth flagging is procedural and external to this paper: the publisher's previous mis-hosting of supplementary materials at PII `S0010027717301002`. Once the correct PII (`S0010027717300987`) is used, the supplementary CSVs and the paper's reported statistics are in full agreement.

## Files in this folder

Reproduction artifacts:
- `yJwG.pdf`, `yJwG.txt` — paper PDF and pdftotext extraction
- `1-s2.0-S0010027717300987-mmc1.csv` — Experiment 1 per-subject TVA estimates (N=28)
- `1-s2.0-S0010027717300987-mmc2.zip` + extracted `Exp1.sav` — same data in SPSS format
- `1-s2.0-S0010027717300987-mmc3.csv` — Experiment 2 per-subject estimates (N=28)
- `1-s2.0-S0010027717300987-mmc4.zip` + extracted `Exp2.sav`
- `1-s2.0-S0010027717300987-mmc5.csv` — Experiment 3 per-subject estimates (N=25)
- `1-s2.0-S0010027717300987-mmc6.zip` + extracted `Exp3.sav`
- `run_reproduction.py` — Python reproduction script
- `run_reproduction.log` — captured stdout
- `REPRODUCTION_REPORT.md` — this report
- `yJwG_summary_rows.csv` — per-claim summary

Archived (wrong-paper Elsevier supplements from the original blocked attempt; kept for the record):
- `wrong_paper_supplements_archived/mmc1.pdf`
- `wrong_paper_supplements_archived/mmc1.txt`
- `wrong_paper_supplements_archived/mmc2.xlsx`

No `diagnostic_patched.*` files (no patched run needed).
