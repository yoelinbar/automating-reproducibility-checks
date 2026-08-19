# Reproduction Report — Hurst & Kavanagh (2017), Life History Strategies and Psychopathology

**Paper:** Hurst, J. E., & Kavanagh, P. S. (2017). Life history strategies and psychopathology: the faster the life strategies, the more symptoms of psychopathology. *Evolution and Human Behavior, 38*(1), 1–8. https://doi.org/10.1016/j.evolhumbehav.2016.06.001
**Paper IDs:** paper_id=yypJ; claims=[yypJ_single-trace]
**Reproduction type:** Source Data Reproduction
**Headline verdict (unpatched):** precise

## Headline
The focal claim — partial correlation between Mini-K life history strategy and DSM-5 total psychopathology, controlling for age — reproduces precisely. Paper prints pr = -.51 (Table 5, p. 5) with significance per Bonferroni footnote (p < .002); reproduced pr = -0.513 from the supplementary raw item-level CSV (mmc1.csv) that Elsevier hosts at the article landing page. N = 138 matches exactly; Table 1 means (Attach 15.54, Mini-K 14.62, HKSS 87.34, Aggression 59.90, DSM-5 40.10) all match to printed precision, confirming the data file is the analytic dataset. Reproduced p ≈ 1.4e-10, well below the .002 Bonferroni threshold. No author code was posted; analysis re-implemented in Python (residualize on age, Pearson on residuals).

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| yypJ_single-trace | partial r (coef) | −.51 (Table 5) | −0.51 | −0.513 → rounds to −0.51 | precise = −0.51; approx band ±15% → [−0.4335, −0.5865] | precise |
| yypJ_single-trace | p-value (threshold) | p < .002 (Bonferroni footnote bold) | 1.945e-10 (derived) | 1.41e-10 | precise if reproduced p ≤ .002; approx (.002, .052]; not > .052 | precise |
| yypJ_single-trace | sample size N | 138 (Methods, Table 5 row) | 138 | 138 | precise = 138; approx [117, 159] | precise |
| yypJ_single-trace | t-statistic | not printed in paper | -6.88891 (derived from r, N) | -6.951 | n/a — paper does not print t | non-outcome |
| yypJ_single-trace | effect size (Cohen's f²) | not printed in paper | 0.3515 (derived) | 0.359 (= r²/(1-r²) = .2636/.7364) | n/a — paper does not print f² | non-outcome |

**Overall verdict (unpatched): precise** — every reported sub-outcome is precise; the t-stat and f² were derived in extraction but are not numerically printed in the paper, so they are non-outcomes per the SCORE Criterion Guide ("non-inferential numeric evidence is eligible … non-numeric evidence is not").

## What I did

1. **Set-up.** Created `independent_reproductions/yypJ_hurst_2017/`, copied the PDF in, extracted text via `pdftotext -layout`.
2. **Extraction check.** Located the focal value in Table 5 (p. 5), row "Total psychopathology" × column "Mini-K" → pr = -.51. The Table 5 footnote: "Significant correlations (Bonferroni correction, p b .002) are in bold." The -.51 cell is in bold in the rendered PDF, so the threshold p < .002 applies. N = 138 is stated in the abstract, Methods §2.1, and is the row count. Extraction CSV's `orig_coef_value` (-0.51) and `orig_sample_size_value` (138) match the paper. The `orig_stat_value` t = -6.88891 is *derived* from r and N (= r·√(df/(1−r²)) with df = 135), not printed; same for `orig_p_value` (1.945e-10) and `orig_effect_size_value_repro` (Cohen f² = 0.3515 = r²/(1−r²)). These are computed values, not paper-printed numerics.
3. **Data/code source.** No code posted. The "Supplementary Materials" link at the DOI page points to two Elsevier ScienceDirect files:
   - `https://ars.els-cdn.com/content/image/1-s2.0-S1090513816301118-mmc1.csv` (raw item-level data, N=138 × 231 cols)
   - `https://ars.els-cdn.com/content/image/1-s2.0-S1090513816301118-mmc2.xlsx` (codebook/scoring sheet)
4. **Reproduction.** Verified Table 1 means against the dataset (Attach 15.54 ✓, Mini-K 14.62 ✓, HKSS 87.34 ✓, Aggression 59.90 ✓, DSM-5 40.10 ✓ — all exact to printed precision). Computed partial correlation by residualizing both variables on Age via OLS, then Pearson r on the residuals; t = r·√(135/(1−r²)) and two-tailed p from t with df = 135. Implemented in `run_repro.py`. Runtime < 1 s.
5. **Stochastic-method diagnostics.** None — analysis is fully deterministic.
6. **Classification.** Bounds computed above. All three reported sub-outcomes (coef, p, N) are precise → overall **precise**.

### Cross-validation against full Table 5
Reproduced all 28 partial correlations in Table 5 as a sanity check. 26/28 match to the printed 2-decimal precision. Two cells in the Mini-K column are off by ≥ .07, which I list for transparency but is **outside the scope of the focal claim**:

| Cell | Paper | Reproduced | Diff |
|---|---|---|---|
| Mini-K × Goal-corrected partnership | −.39 | −.269 | 0.121 |
| Mini-K × Physical aggression | −.44 | −.373 | 0.067 |

These are independent cells from the focal cell; the focal cell (Mini-K × Total psychopathology) reproduces exactly. The full HKSS column matches throughout, and the Mini-K column matches everywhere else. The two anomalous cells suggest a minor scoring/coding inconsistency in two specific subscales but do not affect the verdict on this claim.

## Diagnostics — author-bug analysis

Diagnostics: none for the focal claim — unpatched run reproduces the printed value to the paper's precision. The two off-diagonal Mini-K cells noted above are flagged for transparency but are not part of claim `yypJ_single-trace`; no patch was attempted.

## Files in this folder

- `yypJ.pdf` — paper PDF
- `yypJ.txt` — pdftotext output
- `mmc1.csv` — Elsevier-hosted supplementary raw data (N=138, item-level)
- `mmc2.xlsx` — Elsevier-hosted supplementary codebook
- `run_repro.py` — reproduction script (Python, partial correlation by residualization)
- `run_repro.log` — script output
- `REPRODUCTION_REPORT.md` — this report
