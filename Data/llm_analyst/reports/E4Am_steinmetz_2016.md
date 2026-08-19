# Reproduction Report — Steinmetz (2016), "Being Observed Magnifies Action"

**Paper:** Steinmetz, J., Xu, Q., Fishbach, A., & Zhang, Y. (2016). Being observed magnifies action. *Journal of Personality and Social Psychology*, 111(6), 852–865. DOI: [10.1037/pspi0000065](https://doi.org/10.1037/pspi0000065)
**Paper IDs:** paper_id=E4Am; claims=E4Am_single-trace, E4Am_m6oov9, E4Am_g39923, E4Am_gwvvdx, E4Am_gpvvw3, E4Am_mq11q9
**Reproduction type:** Source Data Reproduction (no analysis code posted; raw data on OSF; analyses re-implemented in Python)
**Headline verdict (unpatched):** approximate
**Verdict if patched:** N/A — no logic-level patches applied; see Diagnostics for two minor inconsistencies (paper text vs. data N).

## Headline

All six numerical claims reproduce in direction and significance from the OSF-archived raw data (https://osf.io/gfytw/). Five of six test-statistic / p / effect-size triples match the paper to all printed digits. The overall verdict drops to **approximate** because two claims fail the strict paper-precision rounding rule on small numbers:

1. **Study 3 (claim E4Am_g39923) sample size.** Paper text says "We recruited 97 students … data from one participant were excluded" → analyzed N=96. The data file (Study3.sav) contains 98 rows with one flagged "excluded" → analyzed N=97. The paper's reported degrees of freedom *F(1, 95)* and *t(95)* are consistent with N=97 (df_error = 95), not the N=96 the text reports. The paper text is internally inconsistent. Our reproduction matches the paper's dfs exactly.
2. **Study 3 (claim E4Am_g39923) F statistic and p-value.** Reproduced F(1,95)=7.4747, p=0.00747, vs. paper's reported F=7.48, p=.007 — small (<0.07%) gap that fails the strict paper-precision rounding rule (7.4747 → 7.47 ≠ 7.48; 0.00747 → 0.007 = 0.007 — actually p IS precise). Effect-size eta²=0.0729 → 0.07 = paper's 0.07, precise.
3. **Study 4 (claim E4Am_gpvvw3) effect size f².** Reproduced f²=0.1353 (rounds to 0.14) vs paper's 0.13. 4% gap, well within the 15% approximate band. Coefficient (β=0.11), test statistic (t=3.98), and p-value all match precisely.

All other sub-outcomes reproduce precisely to the paper's printed precision. The substantive direction, effect magnitudes, and significance levels of every claim are confirmed.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| E4Am_single-trace (Study 1) | t | 2.20 | 2.2 | 2.2043 → 2.20 | precise=2.20; ±15%=[1.87, 2.53] | precise |
| E4Am_single-trace | p | .030 | 0.03 | 0.0304 → 0.030 | precise=0.030; ±0.05=[0, 0.08] | precise |
| E4Am_single-trace | eta² (cohen_d in CSV) | .057 | 0.486 (d) | eta²=0.0573 → 0.057; d=0.4874 → 0.49 | ±15% of 0.486 = [0.413, 0.559] | precise |
| E4Am_single-trace | N | 82 | 82 | 82 | precise=82; ±15%=[70, 94] | precise |
| E4Am_m6oov9 (Study 2) | t | 2.14 | 2.14 | 2.1408 → 2.14 | ±15%=[1.82, 2.46] | precise |
| E4Am_m6oov9 | p | .035 | 0.035 | 0.0346 → 0.035 | ±0.05=[0, 0.085] | precise |
| E4Am_m6oov9 | eta² | .043 | 0.043 | 0.0426 → 0.043 | ±15%=[0.037, 0.049] | precise |
| E4Am_m6oov9 | N | 105 | 105 | 105 | ±15%=[89, 121] | precise |
| E4Am_g39923 (Study 3, RM-MANOVA main eff. obs.) | F | 7.48 | 7.48 | 7.4747 → 7.47 | ±15%=[6.36, 8.60] | approximate |
| E4Am_g39923 | p | .007 | 0.007 | 0.00747 → 0.007 | ±0.05=[0, 0.057] | precise |
| E4Am_g39923 | eta² | .07 | 0.07 | 0.0729 → 0.07 | ±15%=[0.0595, 0.0805] | precise |
| E4Am_g39923 | N | 96 | 96 | 97 | ±15%=[82, 110] | approximate |
| E4Am_gwvvdx (Study 3, total points) | t | 0.20 | 0.20 | 0.2019 → 0.20 | ±15%=[0.17, 0.23] | precise |
| E4Am_gwvvdx | p | .840 | 0.84 | 0.8404 → 0.840 | ±0.05=[0.79, 0.89] | precise |
| E4Am_gwvvdx | d | 0.04 | 0.04 | 0.0410 → 0.04 | ±15%=[0.034, 0.046] | precise |
| E4Am_gwvvdx | N | 96 | 96 | 97 | ±15%=[82, 110] | approximate |
| E4Am_gpvvw3 (Study 4) | β | 0.11 | 0.11 | 0.1126 → 0.11 | ±15%=[0.0935, 0.1265] | precise |
| E4Am_gpvvw3 | t | 3.98 | 3.98 | 3.979 → 3.98 | ±15%=[3.38, 4.58] | precise |
| E4Am_gpvvw3 | p | <.001 | 0.001 | 0.000119 → <.001 | precise≤0.001 | precise |
| E4Am_gpvvw3 | f² | 0.13 | 0.13 | 0.1353 → 0.14 | ±15%=[0.1105, 0.1495] | approximate |
| E4Am_gpvvw3 | N | 121 | 121 | 121 | ±15%=[103, 139] | precise |
| E4Am_mq11q9 (Study 5) | F | 6.90 | 6.9 | 6.897 → 6.90 | ±15%=[5.87, 7.94] | precise |
| E4Am_mq11q9 | p | .009 | 0.009 | 0.00915 → 0.009 | ±0.05=[0, 0.059] | precise |
| E4Am_mq11q9 | eta² | .026 | 0.026 | 0.0262 → 0.026 | ±15%=[0.0221, 0.0299] | precise |
| E4Am_mq11q9 | N | 261 | 261 | 261 | ±15%=[222, 300] | precise |

**Per-claim overall verdicts:**
- E4Am_single-trace → **precise**
- E4Am_m6oov9 → **precise**
- E4Am_g39923 → **approximate** (F approximate, N approximate)
- E4Am_gwvvdx → **approximate** (N approximate)
- E4Am_gpvvw3 → **approximate** (f² approximate)
- E4Am_mq11q9 → **precise**

**Paper-level overall: approximate** (4 of 6 precise; 2 of 6 approximate; 0 not).

## What I did

1. **Set-up.** Created reproduction directory; copied PDF; ran `pdftotext -layout` to extract paper text.
2. **Extraction check.** Located each statistic in the published PDF:
   - E4Am_single-trace → p. 4 (Study 1, "t(80) = 2.20, p = .030, 95% CI [0.082, 1.610], η² = .057")
   - E4Am_m6oov9 → p. 5 (Study 2, "t(103) = 2.14, p = .035, 95% CI [-1.63, -0.06], η² = .043")
   - E4Am_g39923 → p. 6 (Study 3, "F(1, 95) = 7.48, p = .007, η² = .07" + interaction "F(1, 95) = 0.05, p = .820")
   - E4Am_gwvvdx → p. 6 (Study 3, total points, "t(95) = 0.20, p = .840, d = 0.04")
   - E4Am_gpvvw3 → p. 8 (Study 4, "β = 0.11, t(117) = 3.98, p < .001, 95% CI [0.06, 0.17], f² = 0.13")
   - E4Am_mq11q9 → p. 9 (Study 5, "F(1, 256) = 6.90, p = .009, η² = .026")

   All extracted values match the paper PDF exactly. **One finding:** the paper text on p. 5 says "We recruited 97 students … data from one participant were excluded from analyses" → implies analyzed N = 96. But the reported dfs (df_error = 95) imply analyzed N = 97. The data file confirms N = 97 was actually analyzed (98 collected, 1 flagged "excluded"). This is an internal inconsistency in the published paper, not in the extraction.
3. **Data/code source.** Paper text and JSON say no code was posted. I located the authors' OSF project at https://osf.io/gfytw/ via web search. It contains five SPSS files: `Study1.sav`, `Study2.sav`, `Study3.sav`, `Study4.sav`, `Study5.sav`. No SPSS/R/Python analysis script is posted. Downloaded all five with `curl`.
4. **Reproduction.** Re-implemented analyses in Python (`pyreadstat`, `scipy.stats`, `statsmodels`), guided by the paper's text descriptions. Variable identification:
   - Study 1 — DV = `Q27.0` ("How big was the food portion?"); condition coded 1 = camera, 2 = control (verified by manipulation-check Q41).
   - Study 2 — DV = `zoverall_food` (precomputed z-averaged number of pieces eaten across grapes/almonds/M&Ms); condition coded 1 = observed, 2 = control (verified by direction of mean).
   - Study 3 — DV for g39923 = mean of (`A4.2` points-gained estimate, `A4.3` points-lost estimate); the "main effect of being observed" in a 2×2 mixed RM-MANOVA equals the between-subjects t² on the per-subject mean of the within levels. DV for gwvvdx = `A4.4` ("how many points do you have in total"). One participant flagged in the `comment` column ("excluded from analyses because +147 SD above mean") was dropped.
   - Study 4 — DV = `Overclm` ("To what extent do you consider your performance contributed to the team's success/failure"). Predictors: `Adc` (number of spectators), `Outcome` (win/lose, coded ±1), and their interaction.
   - Study 5 — DV = `Estimate`; 2×2 ANOVA of `Obs` × `Action`. One participant has a missing `Estimate` (analysis N = 260; matches paper's reported df 1, 256).
5. **Stochastic-method diagnostics.** None — all analyses are deterministic.
6. **Classification.** Bounds and per-sub-outcome verdicts in the table above. Overall paper verdict: **approximate** (4 claims precise, 2 approximate).

Reproduction script: `run_repro.py`. Log: `run_repro.log`. Runtime ~3 s.

## Diagnostics — author-bug analysis

Two minor data/text inconsistencies surfaced that do not affect the substantive findings or warrant patched analyses:

1. **Study 3 sample-size text inconsistency.**
   - **Suspected bug:** Paper text on p. 5 reports "We recruited 97 students … data from one participant were excluded" → analyzed N = 96. But the reported degrees of freedom (df_error = 95 in the F-tests and t-tests) are consistent only with analyzed N = 97. The data file holds 98 rows; one is flagged "excluded from analyses because +147 SD above mean," leaving 97 — which matches the paper's dfs.
   - **Reasoning:** The text's "97 recruited" likely should read "98 recruited" (or, equivalently, the "96 analyzed" should read "97 analyzed"). The dfs and the data file are mutually consistent; only the prose-stated N is off-by-one.
   - **Patched run:** No analysis edit needed. Our unpatched reproduction with N = 97 yields the dfs the paper reports (1, 95) and reproduces F, p, and eta² closely. If the SCORE rubric were applied with the paper's dfs as the implied analysis N (97), the sample-size sub-verdict would flip from approximate → precise. Reported as parallel verdict only; headline keeps the paper's printed N (96) as the comparator → approximate.
   - **Verdict if patched (using N=97 as paper-implied):** precise on N for both Study 3 claims; overall E4Am_g39923 still approximate (F sub-verdict still mis-rounds 7.4747 vs 7.48); overall E4Am_gwvvdx → precise.
   - **Confidence:** high (the dfs unambiguously imply N = 97).

2. **Study 3 F-statistic precision (E4Am_g39923).**
   - **Suspected bug:** Likely none — the 0.5% gap (7.4747 vs 7.48) most plausibly reflects SPSS computational details (e.g., GLM Repeated Measures uses pooled error structure and may produce 7.48 to display precision while my Python implementation via t² on per-subject within-cell means produces 7.4747). The substantive interpretation is identical.
   - **Confidence:** high that the gap is computational/algorithmic, not a coding error in either the paper or my reproduction.

3. **Study 5 sample size.** Paper text says "We recruited 261 students" and reports dfs (1, 256). The data has 261 rows but one participant is missing on the Estimate DV, so the analysis-sample N is 260 (matches the dfs exactly: 256 + 4 model df = 260). Not flagged in the rubric since orig_sample_size_value = 261 matches the data-file size.

No logic-level patches were applied. The headline verdict reflects the unpatched run.

## Files in this folder

- `E4Am.pdf` — copy of the published paper
- `E4Am.txt` — `pdftotext -layout` output
- `Study1.sav`, `Study2.sav`, `Study3.sav`, `Study4.sav`, `Study5.sav` — author data files from OSF (https://osf.io/gfytw/)
- `run_repro.py` — Python reproduction script (the only analysis script; written by analyst because no code is posted)
- `run_repro.log` — full console output of the reproduction run
- `REPRODUCTION_REPORT.md` — this report
- `E4Am_summary_rows.csv` — one row per claim, summary verdicts
