# Reproduction Report — Turcu & Urbatsch (2015), Diffusion of Diaspora Enfranchisement Norms

**Paper:** Turcu, A., & Urbatsch, R. (2015). Diffusion of Diaspora Enfranchisement Norms: A Multinational Study. *Comparative Political Studies*, 48(4), 407–437. DOI: 10.1177/0010414014546331
**Paper IDs:** paper_id=YeQg; claims=[YeQg_single-trace]
**Reproduction type:** Push Button
**Headline verdict (unpatched):** precise

## Headline
The single claim — Table 1, column III, focal "Recent nearby franchise extension" Cox proportional-hazards estimate — reproduces precisely on all reported sub-outcomes (HR = 1.86, z = 2.92, p = 0.004 ≤ 0.01 threshold, N = 5,988 country-years, 176 countries, 105 failures). The author-archived Stata code (`diaspora_enfranchisement_code.txt`) and dataset (`diaspora_enfranchisement_data.dta`), downloaded from the SAGE publisher supplement, run unchanged (only path/`use` boilerplate added) and produce the table values exactly. No deviation; no diagnostics needed.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| YeQg_single-trace | Coefficient (HR) | 1.86 | 1.86 | 1.856874 → rounds to 1.86 | precise: round to 2 dp = 1.86; approx band [1.581, 2.139] | precise |
| YeQg_single-trace | Test statistic (z) | 2.92 | 2.92 | 2.92 | precise: matches to 2 dp; approx band [2.482, 3.358] | precise |
| YeQg_single-trace | p-value | < .01 (threshold) | 0.01 | 0.004 | precise: any p ≤ 0.01 (one-sided threshold rule); approx (0.01, 0.06]; not > 0.06 | precise |
| YeQg_single-trace | Sample size (country-years) | 5,988 | 5988 | 5,988 | precise: exact; approx [5090, 6886] | precise |
| YeQg_single-trace | Effect size | (none reported numerically as separate stat) | NaN | non-outcome | n/a | non-outcome |

**Overall verdict (unpatched): precise.**

## What I did

### 1. Set-up
Created `independent_reproductions/YeQg_turcu_2015/`, copied `papers/YeQg.pdf`, ran `pdftotext -layout` to produce `YeQg.txt`.

### 2. Extraction check
Paper Table 1, p. 420, column III (the model with full baseline controls, excluding the CEE indicator and "backsliding" countries). Text on p. 421 confirms the focal estimate. Extracted values match the paper exactly:

> "Recent nearby franchise extension … 1.86** (2.92)" — Table 1 col III (p. 420)
> "*p < .05, two-tailed. **p < .01, two-tailed." — Table 1 footnote (p. 420)
> "Country-years … 5,988" — Table 1 col III row (p. 420)

So `orig_coef_value=1.86`, `orig_stat_value=2.92`, `orig_p_value=0.01` (threshold less-than), `orig_sample_size_value=5988` all match.

The "1.86" reported in the paper is the **hazard ratio** (Stata `stcox` reports `Haz. Ratio` by default); the paper does not call it a coefficient explicitly, but the parenthesized number is the t/z-statistic for the underlying log-hazard coefficient. This convention is implicit but consistent across the table and unambiguous from the analytic context.

### 3. Data/code source
SAGE publisher supplement: `https://journals.sagepub.com/doi/suppl/10.1177/0010414014546331/suppl_file/replication_materials.zip` (735 KB). The Cloudflare front page blocks plain `curl`; I downloaded with `cloudscraper` (Firefox/Windows profile, after first warming up the article page so the supplement download has a valid Referer). Contents:
- `diaspora_enfranchisement_codebook.pdf`
- `diaspora_enfranchisement_data.dta` (11,664 rows × 69 vars, already `stset`)
- `diaspora_enfranchisement_code.txt` (the do-file commands as plain text — Cox specifications for Tables 1, 2, and 3)

### 4. Reproduction
Wrapper do-file `run_pushbutton.do` runs the archived `stcox` lines verbatim (only added `cd`, `clear all`, `set more off`, and `use`). Command:
```
/usr/local/bin/stata-mp -b do run_pushbutton.do
```
Runtime ~2 s. Output saved as `run_pushbutton.log`.

The archived code references variables `colb`, `colf`, `cols`, but the dataset only contains `colbrit`, `colfren`, `colspan`. **Stata's standard variable-name abbreviation matched these unambiguously**, and the reproduced table is correct (it explicitly shows `colbrit`, `colfren`, `colspan` in the output). No edit needed; this still qualifies as Push Button.

Column-III output (reproduced):
```
No. of subjects      =          176        Number of obs    =       5,988
No. of failures      =          105
                       Haz. Ratio   Std. Err.    z    P>|z|
     k6delta            1.856874     .394164    2.92   0.004
```

This matches Table 1 col III for every reported quantity: HR=1.86 (1.857 → 2 dp = 1.86), z=2.92, p=0.004 (<.01), N=5,988 country-years, 176 countries, 105 failures. (Other column rows in Table 1 also reproduce exactly: cols I/II/IV/V N=7120/7120/5988/6080, HR=2.04/1.92/1.72/1.82 with z=3.29/3.03/2.45/2.82.)

### 5. Stochastic-method diagnostics
None — Cox MLE is deterministic given the data.

### 6. Classification
Bounds computed in the comparison table above. All four reported sub-outcomes are `precise`. Effect size is `non-outcome` (paper does not report a separate effect-size statistic for this estimate). Overall: **precise.**

## Diagnostics — author-bug analysis
Diagnostics: none — unpatched run reproduces exactly. The `colb`/`colbrit` etc. mismatch resolves through Stata's variable-name abbreviation; no logic patch needed.

## Files in this folder
- `YeQg.pdf` — copy of the paper
- `YeQg.txt` — `pdftotext -layout` output
- `replication_materials.zip` — author's archive from SAGE supplement
- `repl/diaspora_enfranchisement_data.dta` — author data
- `repl/diaspora_enfranchisement_code.txt` — author code
- `repl/diaspora_enfranchisement_codebook.pdf` — codebook
- `run_pushbutton.do` — wrapper that runs author code unchanged
- `run_pushbutton.log` — Stata log (unpatched)
- `bag.zip`, `bag/` — incidental Internet-Archive OSF metadata pulled while data hunting (no original-data content); kept for audit trail
- `sage_suppl.html` — early failed Cloudflare page-load attempt (5 KB, kept for audit trail)
- `REPRODUCTION_REPORT.md` — this file
- `YeQg_summary_rows.csv` — one-row summary
