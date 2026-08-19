# Reproduction Report — Ohtsubo (2014), Attention Fosters Intimacy

**Paper:** Ohtsubo, Y., Matsumura, A., Noda, C., Sawa, E., Yagi, A., & Yamaguchi, M. (2014). It's the attention that counts: interpersonal attention fosters intimacy and social exchange. *Evolution and Human Behavior*, 35(3), 237–244. https://doi.org/10.1016/j.evolhumbehav.2014.02.004
**Paper IDs:** paper_id=zlm2; claims=[zlm2_single-trace]
**Reproduction type:** Source Data Reproduction (publisher-supplied raw data, no code archived)
**Headline verdict (unpatched):** **precise**
**Verdict if patched:** N/A — no patch needed

## Headline
The single claim from study 2a — *intimacy higher in attention condition (4.58 ± .82) than in no-attention condition (2.82 ± .79), t(27) = 5.91, p < .001, d = 2.20* — reproduces **exactly** from the publisher's supplementary raw data (mmc1.xlsx). Means, SDs, t, df, p, and Cohen's d all match to the precision printed. Two ancillary results from the same paragraph (friend-interest t27 = 1.04, p = .306; intimacy↔friend correlation r27 = .38, p = .045) also reproduce exactly. **One small note** about how the intimacy index is computed: the paper text describes one of the four caring items as a *reversed* item ("How was the partner not concerned about you?"), but the supplementary data file's `care2` column is already pre-recoded so high = caring. Summing the four items as stored in the file reproduces the paper exactly; an analyst who reads the methods text and applies a literal `8 − care2` reversal will *not* reproduce the result (would yield t = 3.97, d = 1.48). This is a documentation/data-coding mismatch, not a substantive issue — flagged here only because a future reproducer using only the methods text could be misled.

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| zlm2_single-trace | Sample size N | 29 | 29 | 29 | precise = 29; approx [25, 33]; not outside | **precise** |
| zlm2_single-trace | t statistic | 5.91 | 5.91 | 5.9083 → 5.91 | precise = 5.91; approx [5.024, 6.797] | **precise** |
| zlm2_single-trace | p value | < .001 (threshold) | 2.68e-06 (text) | 2.69e-06 | precise = ≤ .001; approx (.001, .051]; not > .051 | **precise** |
| zlm2_single-trace | Cohen's d | 2.20 | 2.20 | 2.1956 → 2.20 | precise = 2.20; approx [1.87, 2.53] | **precise** |
| zlm2_single-trace | Mean (attention) | 4.58 | — | 4.5833 → 4.58 | precise = 4.58; approx [3.893, 5.267] | **precise** (descriptive, secondary) |
| zlm2_single-trace | SD (attention) | 0.82 | — | 0.8165 → 0.82 | precise = 0.82 | **precise** (descriptive, secondary) |
| zlm2_single-trace | Mean (no attention) | 2.82 | — | 2.8214 → 2.82 | precise = 2.82 | **precise** (descriptive, secondary) |
| zlm2_single-trace | SD (no attention) | 0.79 | — | 0.7871 → 0.79 | precise = 0.79 | **precise** (descriptive, secondary) |

**Overall verdict (unpatched):** **precise** — every reported sub-outcome reproduces precisely.

## What I did

### 1. Set-up
Created `independent_reproductions/zlm2_ohtsubo_2014/`. Copied `papers/zlm2.pdf` in; ran `pdftotext -layout` to produce `zlm2.txt`.

### 2. Extraction check
Study 2a result paragraph is on **p. 5** (paper p. 241) of the PDF. The paper prints: *"intimacy was higher in the attention condition (4.58 ± .82) than in the no attention condition (2.82 ± .79), t27 = 5.91, p < .001, d = 2.20 (Fig. 2)"*. Sample size is on p. 5 (3.2.1 Method): *"Participants were 29 Japanese undergraduates (10 males and 19 females...)"*. The extracted CSV row matches: t = 5.91, df1 = 27, p_type "exact" with value 2.68e-06 (computed from t27 = 5.91 two-tailed → 2.69e-06; matches), N = 29, d = 2.20. Extraction is correct.

### 3. Data/code source
- **Code:** None archived. CSV says `pr_code_available: No`.
- **Data:** Publisher's "Appendix A. Supplementary materials" link in the paper resolves only to the DOI page, but probing Elsevier's CDN for the standard supplement URL pattern returned a single Excel workbook:
  `https://ars.els-cdn.com/content/image/1-s2.0-S1090513814000245-mmc1.xlsx`
  Saved as `mmc1.xlsx` (125 KB). Five sheets: Study 1a, 1b, 2a, 2b, 2c. The Study 2a sheet has 29 data rows + header, columns: ID, age, sex, attention (a0/a1), care, care2, accept, understand, friend1, friend2.
- I also checked the first author's OSF profile (`osf.io/w58b9`) — many projects but none for this 2014 paper.

### 4. Reproduction
Single Python script `run_repro.py`:
```
python3 run_repro.py
```
Computes the 4-item intimacy index = (care + care2 + accept + understand) / 4, then runs an independent-samples t-test (equal variances) of attention (a1, n=15) vs no-attention (a0, n=14). No environment-only edits required (no posted code).

Runtime: < 1 second. Output `run_repro.log`:
```
N attention    = 15, mean = 4.5833, sd = 0.8165
N no-attention = 14, mean = 2.8214, sd = 0.7871
t(27) = 5.9083, p = 2.694735e-06
Cohen's d (pooled) = 2.1956
Friend-interest t-test: t(27) = 1.0429, p = 0.3062  (paper: t27=1.04, p=.306)
Pearson r(intimacy, friend) = 0.376, p = 0.0446  (paper: r27=.38, p=.045)
```

### 5. Stochastic-method diagnostics
N/A — deterministic t-test.

### 6. Classification
For each sub-outcome the reproduced value, rounded to the paper's printed precision, equals the paper's printed value. Bounds shown in table above. Overall: **precise**.

## Diagnostics — author-bug analysis

There is no author bug that affects the headline verdict. The reproduction is precise on all sub-outcomes. The one issue worth recording is documentation-side:

- **Apparent data/text mismatch:** Paper text (p. 5, §3.1.3 Dependent variables) says the four-item intimacy index includes *"an additional reversed item corresponding to caring (How was the partner not concerned about you?)"*. The natural reading is that `care2` is a raw response to a negatively-worded item that should be reverse-coded (`8 − care2` on the 7-point scale) before averaging. But the supplementary data file's `care2` column is already pre-recoded: in the attention condition, mean(care2) = 5.13; in the no-attention condition, mean(care2) = 3.00 — i.e., higher = more caring, the same direction as the other items. Summing the four columns as-stored reproduces the paper exactly; applying an additional `8 − care2` reversal collapses the effect to t = 3.97, d = 1.48.
- **Reasoning:** The numerical reproducibility test (paper means/SDs match exactly with no further reversal, but do not match if reversed) is conclusive that the file holds the already-reversed scores.
- **Patched run:** Not applicable — the unpatched (as-stored) computation is what reproduces. I report the alternative (reversal) as a counterfactual only.
- **Verdict if "patched" with literal reversal:** would be `not` (t = 3.97 vs paper 5.91 → 33% deviation; d = 1.48 vs 2.20 → 33% deviation; both outside the ±15% band).
- **Confidence:** high that the data file's care2 is already recoded; the paper's methods text is misleading on this point but the analytical claim itself is fine.

## Files in this folder
- `zlm2.pdf` — paper (copied from `papers/`)
- `zlm2.txt` — `pdftotext -layout` output of the paper
- `mmc1.xlsx` — Elsevier supplementary data file (5 sheets, one per study)
- `run_repro.py` — Python reproduction script (final, as-stored intimacy)
- `run_repro.log` — script output
- `REPRODUCTION_REPORT.md` — this file
