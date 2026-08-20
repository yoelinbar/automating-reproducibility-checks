# Reproduction Report — Thames & Williams (2010), Incentives for Personal Votes and Women's Representation

**Paper:** Thames, Frank C., and Margaret S. Williams. 2010. "Incentives for Personal Votes and Women's Representation in Legislatures." *Comparative Political Studies* 43(12): 1575–1600. DOI: 10.1177/0010414010374017
**Paper IDs:** paper_id=l22v; claims=[l22v_single-trace]
**Reproduction type:** Source Data Reproduction (data only — `pr_code_available=No`; reproduction script written from paper text)
**Headline verdict (unpatched):** precise
**Verdict if patched (only if applicable):** N/A

## Headline
Full reproduction of Table 2, Model 1. Coefficient (2.389), panel-corrected SE (1.012), N (232), countries (57), R² (.053), and ρ (.713) all match the published values to printed precision. Reproduced t = 2.36 (paper does not print t, but the extracted t = 2.36 matches our reproduction). Reproduced exact p = 0.018 ≤ .05, consistent with the paper's "**" significance flag.

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| l22v_single-trace | Sample size | 232 | 232 | 232 | precise: 232; approx: [197.2, 266.8] | precise |
| l22v_single-trace | Coefficient (ballot=0) | 2.389 | 2.389 | 2.389 (2.389209) | precise: 2.389 to 3dp; approx: [2.031, 2.747] | precise |
| l22v_single-trace | SE / effect size (ser_method) | 1.012 | 2.389 (extracted as ser_method = coef itself) | 1.012 (1.012373) | precise: 1.012 to 3dp | precise |
| l22v_single-trace | Test statistic (t) | not printed (only "**") | 2.361 (computed from coef/SE) | 2.36 | precise: 2.361 to 3dp; approx: [2.007, 2.715] | precise |
| l22v_single-trace | p-value | p ≤ .05 (threshold via "**") | 0.05 (less-than) | 0.018 | threshold: p ≤ .05 = precise; approx: (.05, .10] | precise |

Overall: **precise**.

## What I did
1. **Set-up.** Created `independent_reproductions/l22v_thames_2010/`. Copied PDF, ran `pdftotext -layout` to `l22v.txt`. Read paper claim JSON.
2. **Extraction check.** Table 2, Model 1 ("Ballot = 0 (1, 0)") on page 1587 of CPS print pagination prints b=2.389, SE=(1.012), with "**" footnoted as p ≤ .05. N=232, Countries=57, R²=.053, ρ=.713. All `orig_*` values in the JSON match the paper.
3. **Data/code source.** Author website (per `pr_data_location`) led to Frank Thames' Harvard Dataverse: `https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/2W0I5I`. Single file: `Women in Leg CPS Replication Data 1 19 2009_1.tab` (actually a Stata-format file, 2407×31). **No code archived** (only data). Downloaded via `curl https://dataverse.harvard.edu/api/access/datafile/2437102?format=original`. Saved as `data.tab`; converted to `data.dta` for Stata.
4. **Reproduction.** Wrote `run_pushbutton.do` based on paper's text:
   - Restricted to the 57 countries listed in the paper appendix (pp. 1594–1596).
   - Filter `polity2 >= 6` per paper's Data and Method section (the country-list restriction is sufficient on its own; both filters yield identical N=232).
   - Panel: `cid` (encoded country); time: `electionrank`.
   - Stata: `xtpcse npctwomenlegsal avg_ballot_0 logm_dist leftvotekeefer1 yrssuffrage legsize lnsgdppcuscon fempctlabor govspgdp if polity2>=6 & insample==1, correlation(ar1) pairwise`
   - `pairwise` is required because the panel is unbalanced; without it Stata refuses to compute the disturbance-covariance matrix. This corresponds to standard practice for `xtpcse` on unbalanced data and matches the paper's printed N exactly.
   - Run on Stata MP 16. Runtime <1s.
5. **Stochastic-method diagnostics:** N/A — Prais-Winsten with PCSE is deterministic given the data.
6. **Classification.** All five sub-outcomes (N, coef, SE/effect-size, test stat, p) classify as `precise`. Overall verdict: `precise`.

### Sample-restriction notes
- Without restricting to the 57-country appendix list (paper's polity2≥6 only, election years, all controls non-missing): N=247, 72 countries, b=2.058. Paper's posted data extends well beyond the analysis sample (2407 rows, 131 country labels including non-democracies and many non-election country-years). The 57-country appendix list is what reconciles the data to the paper.
- The country list is itself the paper's stated sample frame ("a time-series cross-sectional data set of 57 countries"); applying it is not a logic-level patch — it's recovering the analysis sample the paper transparently documents.

## Diagnostics — author-bug analysis
Diagnostics: none — unpatched run reproduces the paper exactly when the analysis sample (the 57 countries listed in the appendix) is applied to the posted data. No author code was archived to patch.

## Files in this folder
- `l22v.pdf` — paper PDF
- `l22v.txt` — pdftotext output
- `data.tab` — replication data downloaded from Harvard Dataverse (Stata format despite .tab extension)
- `data.dta` — same file resaved as proper .dta for Stata
- `run_pushbutton.do` — reproduction do-file (Source Data reconstruction from paper text)
- `run_pushbutton.log` — Stata log showing N=232, 57 countries, all coefficients/SEs matching Table 2 Model 1
- `REPRODUCTION_REPORT.md` — this file
