# Reproduction Report — Menaldo (2016), Fiscal Roots Of Financial Underdevelopment

**Paper:** Menaldo, Victor. 2016. "The Fiscal Roots of Financial Underdevelopment." *American Journal of Political Science* 60(2): 456–471. DOI: 10.1111/ajps.12240
**Paper IDs:** paper_id=Vx4e; claims=[Vx4e_single-trace]
**Reproduction type:** Push Button (Extended only insofar as `ssc install xtabond2` was needed to install the package; no code edits)
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A — no patch attempted

## Headline
The headline claim — Table 2, Column 5 — reproduces precisely. The reported coefficient on State Capacity (lagged ICRG quality-of-government index) is −2.479 with SE 0.023 and N = 2,682 in the paper; the archived Stata code, run unchanged on the archived `Country Year Dataset.dta`, produces coefficient = −2.479105 (rounds to −2.479), SE = 0.0228352 (rounds to 0.023), N = 2,682, and 228 instruments — matching every printed digit in the paper's Table 2 column 5. No deviations of any kind detected.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed, ±15% of |paper|) | Sub-verdict |
|---|---|---|---|---|---|---|
| Vx4e_single-trace | Coefficient (State Capacity, IQG, lagged) | −2.479 | −2.479 | −2.479 (raw −2.479105) | [−2.851, −2.107] | precise |
| Vx4e_single-trace | Std. Error | 0.023 | 0.023 | 0.023 (raw 0.0228352) | (reported as the SE; rounding-rule check) | precise |
| Vx4e_single-trace | Sample size | 2,682 | 2,682 | 2,682 | [2280, 3084] | precise |
| Vx4e_single-trace | Effect size (regression coefficient) | −2.479 | −2.479 | −2.479 | [−2.851, −2.107] | precise |
| Vx4e_single-trace | p-value | not printed (paper says "highly significant") | NaN | <0.001 (z = −108.57) | one-sided p<0.05 threshold ⇒ precise | non-outcome (no numeric paper value) → effectively precise on threshold |
| Vx4e_single-trace | Test statistic (z) | not printed | NaN | −108.57 | n/a | non-outcome |

**Overall verdict (unpatched): precise.**

## What I did

1. **Set-up.** Created `independent_reproductions/Vx4e_menaldo_2016/`, copied `papers/Vx4e.pdf`, ran `pdftotext -layout` to produce `Vx4e.txt`.

2. **Extraction check.** Located Table 2 on page 464 of the published version of record. Column (5) prints: State Capacity (IQG) coefficient = −2.479, SE = 0.023; Observations = 2,682; # of Instruments = 228; AR(2) z = 0.80 (p = 0.42); Hansen χ²(223) = 124.92 (p = 0.99). These match the extracted `orig_coef_value` (−2.479), `orig_coef_se` (0.023), `orig_sample_size_value` (2682), `orig_effect_size_value_repro` (−2.479) in `paper_claims/Vx4e.json`. Note: the JSON's `orig_sample_size_units` is labelled "countries" but the paper's 2,682 is country-year observations (130 countries × ~21 years on average); this is a minor extraction mislabel of units, not a value mismatch.

3. **Data/code source.** Harvard Dataverse, AJPS Dataverse, DOI `10.7910/DVN/WVQ10L`. Downloaded:
   - `Country Year Dataset.dta` (the country-year panel, in original Stata format)
   - `Software Commands Paper.do` — the author's verbatim do-file for the paper's tables
   - `readme.txt`, `Information to Reconstruct Analysis Dataset.txt`, codebook PDFs
   - `Software Commands Appendix.do`, `masterpaneluse.tab` (not needed for the headline claim)

4. **Reproduction commands and runtime.** Wrote `run_pushbutton.do`, copying the exact `xtabond2` invocation for Table 2 column 5 from `Software Commands Paper.do`:

   ```
   xtabond2 credittogovtstateenterp l.credittogovtstateenterp l.icrg_qog l.privatecredit year, ///
       gmm(l.credittogovtstateenterp l.icrg_qog l.privatecredit, lag(4 5)) iv(year) twostep
   ```

   Environment-only edits: added `cd <dir>` (path), `clear all`, `capture xtset wbcodeMEN year` (the .dta is already xtset-declared but I issued it defensively), and `ssc install xtabond2` because the user-written `xtabond2` package is not built in to Stata. None of these touch analysis logic.

   Runtime: ~2 seconds. Output saved to `run_pushbutton.log`. Used Stata-MP (paper used Stata SE 11; differences would be MP/SE not statistical).

5. **Stochastic-method diagnostics.** None needed — system GMM is deterministic given data and instrument set.

6. **Classification (rounding rule applied to paper precision).**
   - Coefficient: paper prints −2.479 (3 decimals); reproduced −2.479105 → rounds to −2.479 → equals → **precise**.
   - SE: paper prints 0.023 (3 decimals); reproduced 0.0228352 → rounds to 0.023 → equals → **precise**.
   - N: paper prints 2,682; reproduced 2682 → equals → **precise**.
   - Effect size = same coefficient → **precise**.
   - p-value / test-stat: paper does not print numeric values for this column's coefficient (only that it is "highly significant"); per the rubric ("All criteria … are restricted to numeric evidence"), these sub-outcomes are `non-outcome` and excluded from combination. The reproduced z = −108.57 implies p ≪ 0.001 either way.
   - Overall: **precise** (every reported sub-outcome precise; non-outcomes excluded).

## Diagnostics — author-bug analysis
None. Unpatched run reproduces the paper's value to all printed digits. No author bug suspected. The author's archive is well-organized, with verbatim per-column do-file commands and a complete codebook.

## Files in this folder
Unpatched-run artifacts:
- `Vx4e.pdf`, `Vx4e.txt` — paper (PDF and pdftotext output)
- `CountryYearDataset.dta` — author's analysis dataset (Harvard Dataverse, file id 2724589)
- `SoftwarePaper.do` — author's "Software Commands Paper.do" (file id 2723137)
- `SoftwareAppendix.do` — author's "Software Commands Appendix.do" (file id 2723139), not used for the headline
- `masterpaneluse.tab` — companion source-data file (file id 2711338), not used for the headline
- `reconstruct_analysis.txt` — author's reconstruction guide (file id 2711350)
- `readme.txt` — author's readme (file id 2723141)
- `run_pushbutton.do` — the do-file I executed
- `run_pushbutton.log` — Stata log of the unpatched reproduction
- `REPRODUCTION_REPORT.md` — this report
- `Vx4e_summary_rows.csv` — one-row CSV summary (parent-folder convention)

No patched-diagnostic artifacts (no patch performed).
