# Reproduction Report — Bruner (2017), Does Decision Error Decrease With Risk Aversion?

**Paper:** Bruner, David M. (2017). "Does decision error decrease with risk aversion?" *Experimental Economics* 20:259–273. DOI: 10.1007/s10683-016-9484-1.
**Paper IDs:** paper_id=amYY; claims=amYY_mk1lqr, amYY_m7vpjd, amYY_bzp733, amYY_glo6xk, amYY_b65wxy, amYY_m3zlw1
**Reproduction type:** Extended Push Button (commented out four `graph export` lines because Stata's PNG translator was unavailable; no analysis logic touched)
**Headline verdict (unpatched):** precise

## Headline
The author's posted Stata do-file (`DecisionErrorAnalysis.do`) on the posted dataset (`RiskData.dta`) reproduces every numeric statistic the paper prints, exactly. Pearson correlation between average safe choices and error rate among the 79 risk-averse subjects = **-0.4625, p = 0.0000** (paper: -0.4625, p ≈ 0.0000). Spearman correlation = **-0.4361, p = 0.0001** (paper: -0.4361, p = 0.0001). The Figure 2 sub-distribution percentages (1.27/3.80/.../31.65 for risk averse; 6.06/3.03/.../48.48 for high risk aversion) match the printed figure labels to all reported digits. No deviations of any kind. The four claims that anchor on figure-only descriptive content are coded `non-outcome` per the rubric (no eligible numeric value extracted in the input CSV).

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| amYY_mk1lqr | (Fig 2 distribution, 106 subj) | figure-only | NaN | distribution matches Fig 2 (e.g. 24.53% chose 10) | n/a | non-outcome |
| amYY_m7vpjd | (Fig 2 distribution, 79 risk averse) | figure-only | NaN | 31.65% chose 10; matches Fig 2 labels | n/a | non-outcome |
| amYY_bzp733 | (Fig 2 low/high RA distributions) | figure-only | NaN | High RA 48.48% chose 10; matches Fig 2 | n/a | non-outcome |
| amYY_glo6xk | (Fig 3 error rate per decision, low vs high RA) | figure-only | NaN | scatterplot reproduced (per-decision means) | n/a | non-outcome |
| amYY_b65wxy | Pearson correlation | -0.4625 | -0.4625 | -0.4625 | exact match | precise |
| amYY_b65wxy | Pearson p-value (exact 0.0000) | 0.0000 | 0.0 | 0.0000 | rounds to 0.0000 | precise |
| amYY_b65wxy | Sample size | 79 | 79 | 79 | exact match | precise |
| amYY_b65wxy | Effect size (Pearson r) | -0.4625 | -0.4625 | -0.4625 | exact match | precise |
| amYY_m3zlw1 | Spearman correlation | -0.4361 | -0.4361 | -0.4361 | exact match | precise |
| amYY_m3zlw1 | Spearman p-value (0.0001) | 0.0001 | 0.0001 | 0.0001 | exact match | precise |
| amYY_m3zlw1 | Sample size | 79 | 79 | 79 | exact match | precise |
| amYY_m3zlw1 | Effect size (Spearman ρ) | -0.4361 | -0.4361 | -0.4361 | exact match | precise |

**Overall verdict (unpatched): precise.**

## What I did
1. **Set-up:** Created `independent_reproductions/amYY_bruner_2017/`, copied `papers/amYY.pdf`, ran `pdftotext -layout` to produce `amYY.txt`.
2. **Extraction check:**
   - Pearson r = -0.4625 with p = 0.0000 reported in Fig. 4 caption (p. 12 of journal numbering, page 271 of issue) and footnote 19 on p. 13.
   - Spearman ρ = -0.4361 with p = 0.0001 reported in Fig. 4 caption and footnote 19.
   - N = 79 risk-averse subjects appears p. 11 ("79 out of 106 subjects exhibited risk aversion") and again as the y-axis-anchor for the restricted-sample analyses.
   - All extracted `orig_*` values match what the paper prints.
3. **Data/code source:** Downloaded `data.zip` (~120 KB) from the Google-Drive link advertised on the author's personal site (https://sites.google.com/view/david-bruner/research). Archive contains `RiskData.dta`, `DecisionErrorAnalysis.do`, `cleandata.do`, `convert2stata.do`, eight session `.xls`/`.sbj` files, and four pre-rendered figure PNGs.
4. **Reproduction:** Ran the author's `DecisionErrorAnalysis.do` via `stata-mp -b do`. The file errored on the first `graph export "*.png"` because the Stata image translator wasn't installed; this is purely an environment issue (the figures are not consumed by any downstream calculation). I made one environment-only edit — commented out the four `graph export` lines — and re-ran. Saved as `run_pushbutton.do`/`run_pushbutton.log`.
   - Ran `verify_figs.do`/`verify_figs.log` to dump the four `numsafe30` distributions that drive Figure 2 — needed because the figure labels are the closest thing to numeric evidence for the figure claims.
5. **Stochastic-method diagnostics:** none — the analysis is deterministic (Pearson + Spearman correlations).
6. **Classification:**
   - Pearson r = -0.4625 (4 dp) reproduced as -0.4625 → precise.
   - Pearson p reported by author as 0.0000 (4 dp); reproduced 0.0000 → precise. (Stata's `pwcorr ..., sig` prints 0.0000 when p < 0.00005.)
   - Spearman ρ = -0.4361 reproduced exactly → precise.
   - Spearman p = 0.0001 reproduced as 0.0001 → precise.
   - N = 79 reproduced exactly → precise.
   - Figure-only sub-outcomes (claims mk1lqr, m7vpjd, bzp733, glo6xk) have no numeric `orig_*` value in the extraction CSV; the paper carries them only via the figure labels. Per the rubric ("non-inferential numeric evidence eligible … describing a plot/figure is not"), these are `non-outcome`. The reproduced histograms nonetheless match the figure label values to all printed digits — recorded for context but not used in the verdict.

## Diagnostics — author-bug analysis
Diagnostics: none — unpatched run reproduces exactly; no logic bug suspected. The single environment edit (commenting out four `graph export "*.png"` lines whose PNG outputs are not used in any analytic statement) is permitted under Push Button per the modification policy.

## Files in this folder
- `amYY.pdf`, `amYY.txt` — paper and pdftotext output
- `data.zip` — downloaded archive
- `DMB_ExEcon_2017_Data_Analysis/` — unpacked author archive (data, do-files, figures, README)
- `RiskData.dta` — copy at top level so `run_pushbutton.do` can find it
- `run_pushbutton.do`, `run_pushbutton.log` — author's `DecisionErrorAnalysis.do` with `graph export` lines commented out (env-only edit), plus its log containing the headline correlations
- `verify_figs.do`, `verify_figs.log` — supplementary script that dumps the four Figure 2 sub-distributions
- `REPRODUCTION_REPORT.md` — this report
- `amYY_summary_rows.csv` — per-claim summary
