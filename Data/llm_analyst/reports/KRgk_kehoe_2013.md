# Reproduction Report — Kehoe & Ruhl (2013), New Goods Margin in International Trade

**Paper:** Kehoe, Timothy J. and Ruhl, Kim J. (2013). "How Important Is the New Goods Margin in International Trade?" *Journal of Political Economy* 121(2): 358–392. DOI: 10.1086/670272
**Paper IDs:** paper_id=KRgk; claims=[KRgk_single-trace]
**Reproduction type:** Extended Push Button (cwd path + commented out `graph export ... .eps` figure line; no analysis-logic changes)
**Headline verdict (unpatched):** precise

## Headline
The single claim reproduces precisely. Author code on author data yields, for the SITC2 / Horizon=10 regression in Table 2 (the row corresponding to `growth_least_y1_y11` regressed on `growth_total_y1_y11`, k=10 corresponds to the 1995–2005 ten-year horizon spanning years y1..y11), coefficient = 3.59117 (paper: 3.591), robust SE = 0.4022 (paper: 0.402), N = 1,913 (paper: 1,913), t = 8.93, p < 0.001 (paper: ***). All three reported sub-outcomes (coefficient, p-value threshold, sample size) match paper to printed precision. Extracted values in the input CSV match paper text/table exactly.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| KRgk_single-trace | Coefficient | 3.591 | 3.591 | 3.59117 → 3.591 | precise = 3.591 (3 dp); approx ±15% = [3.052, 4.130] | precise |
| KRgk_single-trace | Robust SE | 0.402 | 0.402 | 0.4022 → 0.402 | precise = 0.402 (3 dp); approx ±15% = [0.342, 0.462] | precise (reported as secondary) |
| KRgk_single-trace | p-value | < 0.001 (***) | 0.001 (less-than) | p < 1e-18 (t=8.93, df=1912) | precise = p ≤ 0.001; approx (0.001, 0.051]; not > 0.051 | precise |
| KRgk_single-trace | Sample size | 1,913 | 1,913 | 1,913 | precise = 1,913; approx ±15% = [1,626, 2,200] | precise |
| KRgk_single-trace | **Overall** | | | | | **precise** |

## What I did

1. **Set-up:** Created `independent_reproductions/KRgk_kehoe_2013/`. Copied PDF; ran `pdftotext -layout` to produce `KRgk.txt`.

2. **Extraction check:** Located the claim values on the Table 2 page of the published JPE article (visible in `KRgk.txt` lines 432–484). The Horizon = 10 row of the SITC2 column reads coefficient = 3.591***, robust SE = 0.402, N = 1,913, R² = .717. Text just above the table (lines 432–435): "Over the entire sample (k = 10), the coefficient on total trade growth is 3.59." Extracted CSV values (`orig_coef_value=3.591`, `orig_coef_se=0.402`, `orig_p_value=0.001` less-than, `orig_sample_size_value=1913`) exactly match. **Note:** The Horizon = 10 row in Table 2 uses growth from year 1 to year 11 (`y1_y11`), i.e. the change spanning a 10-year horizon (1995→2005). In the do-file this is the first regression in the Table 2 block.

3. **Data/code source:** Downloaded `https://users.econ.umn.edu/~tkehoe/papers/NewGoodsAppendix.zip` (12.5 MB) — author's replication archive linked from Tim Kehoe's University of Minnesota website. Contains `Programs/table_1_2_fig_2.do` and `Data/SITC_imports_least_1995.dta` plus auxiliary merge files (`names.dta`, `cepii_1995.dta`, `cepii_2005.dta`, `rgdpl_WDI.dta`).

4. **Reproduction commands and runtime:**
   - Copied `table_1_2_fig_2.do` → `run_table2.do`.
   - Environment-only edits: (a) replaced Windows backslashes (`\`) with forward slashes (`/`) in path literals so the file references resolve on macOS; (b) added a `cd` line to set the working directory to the `DataAppendix` folder (the script uses relative paths); (c) commented out one `graph export ... .eps` line for Figure 2 (the .eps export pipeline isn't installed and the figure isn't part of the claim). No analysis logic touched.
   - Ran with `/usr/local/bin/stata-mp -b do run_table2.do`. Runtime ~5 s. Stata 16.0.

5. **Stochastic-method diagnostics:** N/A — OLS, deterministic.

6. **Classification:** All sub-outcomes precise → overall **precise** (unpatched).

## Diagnostics — author-bug analysis

Diagnostics: none — unpatched run reproduces the published values to printed precision; no logic bug suspected. The only edits were path-format and a figure-export line (allowed under Extended Push Button per the modification policy).

## Files in this folder

- `KRgk.pdf` — paper PDF
- `KRgk.txt` — pdftotext output
- `NewGoodsAppendix.zip` — author replication archive (downloaded)
- `NewGoodsAppendix/` — unpacked archive (Data, Programs, Tables, Output, Figures, etc.)
- `run_table2.do` — author's `table_1_2_fig_2.do` with environment-only edits (cd + slashes + commented .eps export)
- `run_table2.log` — Stata log of unpatched run (the relevant Table 2 / Horizon=10 regression appears at line ~1037)
- `REPRODUCTION_REPORT.md` — this file
- `KRgk_summary_rows.csv` — one-row summary CSV
