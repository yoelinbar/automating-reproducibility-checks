# Reproduction Report — Fehr (2011), Contracts as Reference Points—Experimental Evidence

**Paper:** Fehr, Ernst; Hart, Oliver; Zehnder, Christian (2011). "Contracts as Reference Points—Experimental Evidence." *American Economic Review* 101(2): 493-525. DOI: https://doi.org/10.1257/aer.101.2.493
**Paper IDs:** paper_id=gdlO; claims=[gdlO_single-trace]
**Reproduction type:** Source Data Reproduction (no code archive; numeric session-level data is in the paper's footnote 16)
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A

## Headline
The single claim — that the difference in shading frequency between rigid and flexible contracts in the good state is statistically significant by a Wilcoxon signed-rank test, p = 0.031 (one-sided) — reproduces precisely. The paper reports the session-level high-quality frequencies in footnote 16 (page 507): rigid contracts {89, 97, 95, 91, 96}%, flexible contracts {78, 76, 79, 67, 75}%. The exact one-sided Wilcoxon signed-rank test on the implied shading frequencies yields p = 1/32 = 0.03125, which rounds to 0.031 to the paper's printed precision. With n = 5 paired session observations all in the same direction, this is the smallest possible exact one-sided p-value attainable, so the claim is necessarily reproduced exactly when the published session-level numbers are used.

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| gdlO_single-trace | p-value (one-sided) | 0.031 | 0.031 | 0.03125 (rounds to 0.031) | precise: 0.031; approximate: [0.000, 0.081]; not: > 0.081 | precise |
| gdlO_single-trace | sample size | 328 (participants total in experiment) | 328 | 328 (paper's stated N; the test itself uses 5 paired sessions) | precise: 328; approximate: [279, 377]; not: outside | precise |
| gdlO_single-trace | test statistic | not reported | NaN | W = 15 | n/a | non-outcome |
| gdlO_single-trace | coefficient | not reported | NaN | n/a | n/a | non-outcome |
| gdlO_single-trace | effect size | not reported | NaN | n/a | n/a | non-outcome |

**Overall verdict (unpatched): precise.**

## What I did

### 1. Set-up
Created `independent_reproductions/gdlO_fehr_2011/`. Copied `papers/gdlO.pdf` in. Ran `pdftotext -layout` to produce `gdlO.txt`.

### 2. Extraction check
- The reported result is on **page 507** (PDF text line 806-808):
  > "The difference in the frequency of shading between the two contract types is statistically significant (nonparametric signed rank test, p-value = 0.031 (one-sided)) and very stable over time (see Figure 1)."
- Sample-size statement on page 502 (line 466-467):
  > "...a total number of 328 participants in the experiment."
- The session-level data needed to recompute the test is in **footnote 16** (page 507, lines 823-825):
  > "In the good state the session level frequencies of high quality in rigid contracts are (in percent): 89, 97, 95, 91, and 96. The corresponding numbers for flexible contracts are (in percent): 78, 76, 79, 67, and 75."

The extracted values in `paper_claims/gdlO.json` (`orig_p_value=0.031`, `orig_p_value_type="exact"`, `orig_p_value_tails="one-tailed"`, `orig_sample_size_value=328`) all match the paper exactly.

### 3. Data/code source
- `pr_code_available` is "No" — no code archive exists for this paper. (AER replication archive postings became mandatory after 2011 for newly accepted articles; this paper has no openICPSR project. The supplementary materials on the AER website include only the experimental instructions, not analysis code.)
- However, the paper itself prints the raw session-level data needed for this specific signed-rank test in footnote 16. **No external data download is required for this claim.** This is therefore a Source Data Reproduction in the strictest sense: re-implement the test from the numbers the paper publishes.

### 4. Reproduction
Wrote `run_signedrank.py` to compute the exact Wilcoxon signed-rank test using `scipy.stats.wilcoxon(..., alternative='greater', method='exact')`. Ran with Python 3 / scipy. Runtime < 1 s. Log saved to `run_signedrank.log`.

Outputs:
- Differences (flex − rigid shading), per session: [11, 21, 16, 24, 21] — all five positive.
- Exact one-sided p-value: 0.03125 = 1/32.
- Cross-check using prices from footnote 15: also yields p = 0.03125 (matches the paper's other "p = 0.031 (one-sided)" report on page 507).

### 5. Stochastic-method diagnostics
None — the test is exact, deterministic, and based on n = 5 paired observations.

### 6. Classification
- p-value: paper prints 0.031 (3 decimals). Reproduced 0.03125 rounds to 0.031 → **precise**.
- Sample size: paper's stated N = 328; reproduction uses the same data described in the paper, so N matches → **precise**. (Note the test's *effective* unit of analysis is 5 paired sessions, not 328 participants; the orig_sample_size_value in the extraction reflects the paper's experiment-wide subject count, not the signed-rank df.)
- All other sub-outcomes are non-outcome (not reported).

**Combined verdict: precise.**

## Diagnostics — author-bug analysis
Diagnostics: none. The unpatched reproduction matches the paper exactly. With 5 paired session observations all favoring the same direction, p = 1/32 = 0.03125 is the unique attainable exact one-sided p-value, so any correct implementation of the test on the paper's published session-level data must produce 0.031 to the paper's reported precision. There is nothing to suspect or patch.

One worth-noting observation (not a bug): the paper writes "p-value = 0.031" but the exact test statistic equals 0.03125. The third decimal "1" in the paper is a banker-style rounding of 0.03125 to 3 decimals. This is fully consistent with the paper-precision rounding rule.

## Files in this folder
- `gdlO.pdf` — copy of the published paper.
- `gdlO.txt` — `pdftotext -layout` extraction.
- `run_signedrank.py` — reproduction script (unpatched).
- `run_signedrank.log` — script output.
- `REPRODUCTION_REPORT.md` — this report.
- `gdlO_summary_rows.csv` — one-row claim summary CSV.
