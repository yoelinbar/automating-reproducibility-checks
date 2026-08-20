# Reproduction Report — Cingranelli (2014), Principals, Agents and Human Rights

**Paper:** Cingranelli, D., Fajardo-Heyward, P., & Filippov, M. (2014). "Principals, Agents and Human Rights." *British Journal of Political Science.* DOI: 10.1017/S0007123413000070
**Paper IDs:** paper_id=qg47; claims=[qg47_single-trace]
**Reproduction type:** Source Data Reproduction (Stata `.dta` posted on Cambridge supplement; no code archived)
**Headline verdict (unpatched):** approximate
**Verdict if patched:** N/A — no logic-level patch attempted (none was needed to land within bounds)

## Headline
The focal coefficient on Reliance on Taxes in Table 3, Equation 7 (random-effects ordered probit with full controls and lagged DV) reproduces to the paper's printed precision: paper β = 0.007 (SE 0.003, p < 0.05); reproduced β = 0.0073 (SE 0.0032, p = 0.020) with N = 1,739 vs paper N = 1,718. All test-statistic / coefficient sub-outcomes hit "precise" at the paper's printed precision; the only deviation is sample size (1,739 vs 1,718; +1.22%), which classifies as **approximate** under the ±15% rubric. Overall verdict: **approximate**, driven solely by the small N deviation. The 21-observation gap likely reflects an undocumented sample restriction in the original paper (the posted dataset has more rows than the analysis sample), but no code was archived to confirm; substantive conclusions are unchanged.

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| qg47_single-trace | Coefficient (Reliance on Taxes, Eq. 7) | 0.007 | 0.007 | 0.0073 → rounds to 0.007 | precise: 0.007 at 3 dp; approx: [0.00595, 0.00805] | precise |
| qg47_single-trace | p-value (threshold) | p < 0.05 | 0.05 (less-than) | 0.020 | precise: ≤ 0.05; approx: (0.05, 0.10] | precise |
| qg47_single-trace | Sample size (country-years) | 1,718 | 1,718 | 1,739 | precise: 1,718; approx: [1,461, 1,976] | approximate |
| qg47_single-trace | Effect size (ser_method = coef) | 0.007 | 0.007 | 0.0073 → 0.007 | as coefficient | precise |
| qg47_single-trace | Test statistic (focal) | not reported separately (SE 0.003 → z ≈ 2.33 implied) | n/a | z = 2.32 | precise: 2.33 to 2 dp | precise (treated as non-outcome since paper prints SE not z) |

Overall (combining reported sub-outcomes): one approximate (N), rest precise → **approximate**.

## What I did
1. **Set-up.** Created `independent_reproductions/qg47_cingranelli_2014/`. Copied `papers/qg47.pdf` and ran `pdftotext -layout` → `qg47.txt`.
2. **Extraction check.** The claim row points to Table 3, Equation (7) — random-effects ordered probit. The PDF (text page 620, Table 3) prints "Reliance on Taxes 0.007** (0.003)", "No. of observations 1,718", with footnote "**p < 0.05". Extracted values (`orig_coef_value=0.007`, `orig_coef_se=0.003`, `orig_p_value=0.05`/less-than, `orig_sample_size_value=1718`) match the paper exactly.
3. **Data/code source.** No code archived. The Cambridge supplement contains an Online Appendix PDF (`sup001.pdf`) and one Stata data file (`sup002.dta`, 339KB, 2,181 rows × 37 vars). Downloaded directly from `https://static.cambridge.org/content/id/urn:cambridge.org:id:article:S0007123413000070/resource/name/S0007123413000070sup001.pdf` and `…sup002.dta`.
4. **Reproduction.** Wrote `run_repro.do` re-implementing Eq. 7 from the paper's text/table description: `xtoprobit ciri_physint tax_rev_new tot_rev_new log_pop income p_democ extconf intconf ukcol ciri_physint_lag, vce(cluster country_id)` after `xtset country_id year`. Variable names taken directly from the dataset's labeled columns (Tax = `tax_rev_new`, Total revenue = `tot_rev_new`, etc.). Ran via `stata-mp -b do run_repro.do`; saw convergence in 7 iterations; output saved in `run_repro.log`. No environment-only edits made beyond writing the do-file from scratch (Source Data Reproduction).
5. **Stochastic-method diagnostics.** N/A — model is deterministic (mvaghermite quadrature).
6. **Classification.** Coef 0.0073 rounded to 3 decimals = 0.007 = paper → precise. p = 0.020 ≤ paper's threshold 0.05 → precise (one-sided threshold rule). N 1,739 vs 1,718 → 21 / 1,718 = 1.22% deviation, well within ±15% but not equal → approximate. Effect size = coefficient → precise. Overall: **approximate**.

## Diagnostics — author-bug analysis
- **Suspected discrepancy:** The reproduced N (1,739) exceeds the paper's printed N (1,718) by 21 observations for Equation 7. The dataset has 2,181 rows; listwise-deleting on the full Eq. 7 control set yields 1,739. Adding the optional Catholics/Muslims/ELF controls (used in other equations) does not move N. Equations 5/6 in my run also come out to 1,918 / 1,739 vs the paper's 1,718 / 1,718, suggesting the paper applied an undocumented row exclusion across all Table 3 specs.
- **Reasoning:** Most likely candidates: (a) a country-year restriction the paper applied silently (e.g., dropping early-1980s observations for some countries lacking sufficient panel coverage), (b) a sample restriction tied to the PTS subsample, or (c) drop of country-years with zero clusters. Without archived do-files, I cannot identify the exact filter.
- **Patched run:** Not attempted — no defensible filter is identifiable from the paper text. Adding a filter to force N=1,718 would not be allowed under the modification policy in any case.
- **Verdict if patched:** N/A.
- **Confidence:** Medium — the small-magnitude N gap (1.2%) and the precise reproduction of all coefficient/p-value sub-outcomes strongly suggest the same underlying model on a near-identical sample.

## Files in this folder
- `qg47.pdf` — paper PDF (copied from `papers/`)
- `qg47.txt` — `pdftotext -layout` output
- `sup001.pdf` — Cambridge online appendix PDF (downloaded)
- `sup001.txt` — `pdftotext -layout` of supplement
- `sup002.dta` — Cambridge supplementary Stata dataset (downloaded; the only data file posted)
- `cambridge_page.html`, `supp_test.html` — discovery-step HTML scrapes (kept for provenance)
- `run_repro.do` — Source-Data reproduction script (Eq. 5/6/7 of Table 3)
- `run_repro.log` — Stata log
- `REPRODUCTION_REPORT.md` — this file
- `qg47_summary_rows.csv` — one-row claim-level summary
