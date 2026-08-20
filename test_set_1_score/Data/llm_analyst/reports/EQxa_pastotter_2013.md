# Reproduction Report — Pastötter (2013), "To push or not to push?"

**Paper:** Pastötter, B., Gleixner, S., Neuhauser, T., & Bäuml, K.-H. T. (2013). To push or not to push? Affective influences on moral judgment depend on decision frame. *Cognition*, 126(3), 373–377. doi:10.1016/j.cognition.2012.11.003
**Paper IDs:** paper_id=EQxa; claims=[EQxa_single-trace]
**Reproduction type:** Source Data Reproduction (reconstructed from reported summary statistics — no raw data file ever found)
**Headline verdict (unpatched):** **precise**
**Verdict if patched:** N/A

## Headline

The focal Experiment 1 interaction reproduces precisely. Reconstructing 4-cell push-counts (positive/negative mood × active/passive frame, n=100/cell, N=400) by inverting the four pairwise t/d values printed on p.374, the unique consistent integer cell-count vector that exactly matches the extracted chi² (32.98568) is push-counts (28, 9, 16, 41) for cells (active+positive, active+negative, passive+positive, passive+negative). On that reconstructed dataset, a 2×2 ANOVA on the binary yes/no DV gives interaction F(1,396) = 29.05, p = 1.21e-7, partial η² = .068. Rounded to the paper's printed precision: **F = 29.0** (paper: 29.0), **p < .001** (paper: p < .001), **partial η² = .07** (paper: .07). All three sub-outcomes precise. N=400 is exact (precise). No raw data or author code is available; the reproduction is necessarily a back-calculation, but the paper's reported t-tests fully constrain the cell counts up to small integer ambiguity, and every candidate solution lands the focal F in [28.5, 29.7] — the headline verdict is robust to the residual ambiguity.

**Note on the extraction's encoding choice.** The CSV encodes this F-test interaction as a chi-square with df=3, value 32.98568, p=3.243e-7, Cramer's V (bias-corrected) = 0.2741053. The paper itself reports an F test, not a chi-square. The chi² and V are downstream computations the extractor did on the reconstructed 4×2 table; the paper does not print them. I treat the F-test (focal in the paper) as the rubric anchor and confirm the chi-square / V are also reproduced for completeness. The extracted chi² matches my chi² to 5 decimals, and the extracted bias-corrected V matches Bergsma (2013)'s formula on chi²=32.98568 to 5 decimals.

## Comparison table

Paper-reported values are the focal F-test on p.374. The extracted CSV recasts the same test as a 4×2 chi-square; both computations are reported below.

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| EQxa_single-trace | Sample size N | 400 | 400 | 400 | precise=400; approx [340, 460] | **precise** |
| EQxa_single-trace | Test statistic (paper-form: F) | F(1,396) = 29.0 | (recast as chi²=32.98568) | F(1,396) = 29.05 → rounds to 29.0 | precise=29.0; approx [24.65, 33.35] | **precise** |
| EQxa_single-trace | Test statistic (extracted-form: chi²(3)) | not printed in paper | 32.98568 | 32.98568 | precise=32.98568; approx [28.04, 37.93] | **precise** (push-button-style: matches extracted) |
| EQxa_single-trace | p-value | p < .001 (threshold) | 3.243e-7 | 1.21e-7 (F) / 3.24e-7 (chi²) | precise: any p ≤ .001; approx (.001, .051]; not > .051 | **precise** |
| EQxa_single-trace | Effect size: partial η² | .07 | (V=0.2741053) | partial η² = 0.0683 → rounds to .07 | precise=.07; approx [.0595, .0805] | **precise** |
| EQxa_single-trace | Effect size: Cramer's V (extracted form) | not printed | 0.2741053 | 0.2872 (uncorrected); 0.2741 (bias-corrected, Bergsma 2013) | precise=0.2741; approx [.233, .315] | **precise** (with bias-correction) |

**Overall verdict: precise.** Every sub-outcome the paper reports numerically is reproduced precisely at the paper's printed precision.

## What I did

### 1. Set-up
- Created `independent_reproductions/EQxa_pastotter_2013/`
- Copied `papers/EQxa.pdf` in
- Ran `pdftotext -layout EQxa.pdf EQxa.txt`

### 2. Extraction check (page-level)
- Focal claim is in §2.2 Results (p.374), reading:
  > "Affective influences on moral judgment varied with decision frame, F(1, 396) = 29.0, p < .001, partial η² = .07 (Fig. 1)."
- N=400 is on p.374, §2.1.1.
- Pairwise t-tests for the four follow-up contrasts are also on p.374:
  - Active frame: t198 = 3.6, p < .001, d = .50
  - Passive frame: t198 = 4.1, p < .001, d = .57
  - Positive mood: t198 = 2.1, p < .05, d = .30
  - Negative mood: t198 = 5.6, p < .001, d = .79

**Extraction encoding mismatch (flagged, not a reproduction failure):** The extractor coded this as `chi_squared`, df=3, stat=32.98568, p=3.243e-7. The paper itself reports an **F test**, not a chi-square. The CSV's `orig_analysis_type` field acknowledges this: "Was ANOVA but treated as chi-squared". The extracted chi² and Cramer's V are derived quantities computed on a 4×2 contingency table the extractor implicitly constructed; the paper prints neither. This is a **categorization choice**, not an extraction error per se — but a reader of the comparison table should know the paper-anchored sub-outcomes (F=29.0, p<.001, η²=.07) and the chi²/V are different presentations of the same underlying test.

### 3. Data/code source
- Searched: ScienceDirect supplements, Pastötter's University of Trier page, OSF, Google Scholar, ResearchGate, RLP-forschung profile.
- **Outcome: no raw data, no code, no replication archive.** The CSV's `pr_data_location` says "Online repository, Author website" but neither could be located in 2026 (Pastötter has since moved from Regensburg to Trier; old data downloads, if they ever existed, are not findable). No OSF project for this paper exists.
- Reproduction therefore proceeds via **back-calculation from the paper's reported t-tests and d-values**, which over-determine the four cell push-counts (4 contrasts → 4 unknowns → unique integer solution up to small rounding-error ambiguity).

### 4. Reproduction
- `reconstruct.py` — initial fsolve attempt (failed; non-unique starting point landed on wrong root)
- `reconstruct2.py` — exhaustive grid search over integer push-counts c_AP, c_AN, c_PP, c_PN ∈ [0,100] subject to all four reported d-values within ±0.05. 1549 candidate solutions; top by combined (d-error + t-error/10) is (39, 17, 25, 52).
- `reconstruct3.py` — for the top 15 candidates, computed the 2×2 ANOVA interaction F and chi²/V. All candidates land F ∈ [28.5, 29.7], p ∈ [9e-8, 1.6e-7], partial η² ∈ [.067, .070], chi² ∈ [31.8, 33.2], V ∈ [.282, .288].
- `final_analysis.py` — among candidates, (28, 9, 16, 41) reproduces the extracted chi² to 5 decimals (32.98568), confirming the extractor used the same back-calculation strategy and chose this cell-count vector. Used it for the headline numbers.

Commands run:
```
python3 reconstruct.py     > /dev/null   # initial probe
python3 reconstruct2.py    > /dev/null   # grid search
python3 reconstruct3.py    > /dev/null   # candidate analysis
python3 final_analysis.py | tee final_analysis.log
```

### 5. Stochastic-method diagnostics
None — analysis is deterministic.

### 6. Classification
For paper-anchored sub-outcomes (F-test form, the test the paper actually printed):
- **N**: paper 400, reproduced 400 → precise.
- **F-statistic**: paper 29.0 (3 sig figs), reproduced 29.0488 → rounds to 29.0 at paper precision → precise. Approximate band [24.65, 33.35] for reference.
- **p-value**: paper threshold "p < .001"; reproduced p = 1.21e-7 ≤ .001 → precise (threshold rule, more-significant is fine).
- **Effect size (partial η²)**: paper .07, reproduced .0683 → rounds to .07 at paper precision → precise. Approximate band [.0595, .0805].

Combined: **precise** (every reported sub-outcome is precise).

For extracted-form sub-outcomes (chi-square recast, not in paper text):
- **chi²(3)**: 32.98568 = 32.98568 → precise (matches the extractor's identical back-calculation).
- **Cramer's V**: 0.2741053 = 0.2741 (with Bergsma bias correction) → precise.

## Diagnostics — author-bug analysis

**No author bug.** The reconstruction is internally consistent and the focal F-test reproduces precisely.

**One conceptual flag (not a bug, not a verdict-change) for the audit's downstream use:** the extracted CSV recodes the paper's F(1,396) interaction test as a chi²(3) on a 4×2 contingency table. This is mathematically related but is *not* the test the paper reports. If downstream comparison uses `orig_stat_value = 32.98568` as the canonical test statistic anchor, it will not match the paper's printed F = 29.0. Both are correct under their respective formulations; mixing them in cross-paper aggregation could mislead. The bands above are computed against the paper's printed values (F-form) for the headline; the extracted chi² value is reproduced separately and also matches.

Confidence in this diagnosis: high. The cell-count vector (28, 9, 16, 41) reproduces the extracted chi² to 5 decimals and reproduces every paper-reported t/d to within rounding — there's effectively one possible reconstruction strategy and the extractor used it.

## Files in this folder

Unpatched-run artifacts (the entire reproduction is unpatched):
- `EQxa.pdf` — paper PDF (copy)
- `EQxa.txt` — pdftotext layout output
- `reconstruct.py` — initial fsolve attempt (failed)
- `reconstruct2.py` — grid-search over integer cell counts
- `reconstruct3.py` — candidate analysis (interaction F + chi² across solutions)
- `final_analysis.py` — final reconstruction with cell counts (28, 9, 16, 41)
- `final_analysis.log` — output of final_analysis.py
- `REPRODUCTION_REPORT.md` — this report
- `EQxa_summary_rows.csv` — single-row summary

No patched-diagnostic artifacts (no patch was warranted).
