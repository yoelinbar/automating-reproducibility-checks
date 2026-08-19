# Reproduction Report — Mckibben (2013), Effects of Structures and Power on State Bargaining Strategies

**Paper:** Mckibben, Heather Elko. 2013. "The Effects of Structures and Power on State Bargaining Strategies." *American Journal of Political Science* 57(2): 411–427. DOI: 10.1111/j.1540-5907.2012.00628.x
**Paper IDs:** paper_id=P8az; claims=[P8az_single-trace]
**Reproduction type:** Push Button (gologit2 dependency installed; no analysis edits)
**Headline verdict (unpatched):** precise

## Headline
The headline statistic — Issue-linkage structure coefficient in Model 1 of Table 1 (Cooperative Strategy = 0 panel) — reproduces to all printed digits. Reproduced coef = 1.219314 (paper printed 1.219), clustered SE = 0.1921669 (paper printed 0.192), p = 0.000 (paper marked with *, p < .05), N = 588 (paper N = 588). Auxiliary fit statistics also match exactly (Wald χ²(19) = 391.36; Pseudo R² = 0.281; log pseudolikelihood = −506.659). No deviations of any kind; no diagnostic concerns.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| P8az_single-trace | Coefficient (issue_linkage_structure, panel "Cooperative Strategy = 0") | 1.219 | 1.219 | 1.219314 → rounded to 3 dp = 1.219 | precise: ==1.219 to 3 dp; approx: [1.036, 1.402] | precise |
| P8az_single-trace | p-value (threshold) | p < .05 | 0.05 (less-than) | 0.000 | precise if ≤0.05; approx (0.05, 0.10]; not >0.10 | precise |
| P8az_single-trace | Sample size | 588 | 588 | 588 | precise: 588; approx: [500, 676] | precise |
| P8az_single-trace | Effect size (log-odds = coef in logit) | 1.219 | 1.219 | 1.219314 → 1.219 | same bounds as coef | precise |
| P8az_single-trace | Test statistic | not reported (paper prints SE only, not z) | NaN | (z = 6.35 in our run) | non-outcome | non-outcome |

Standard error sub-outcome (paper-reported SE = 0.192, reproduced 0.1921669 → 0.192) also matches exactly; SE is not in the SCORE rubric grid as a separate sub-outcome but is an additional confirmation.

Overall verdict: **precise** (all reported sub-outcomes precise).

## What I did

1. **Set-up.** Created `independent_reproductions/P8az_mckibben_2013/`, copied PDF, ran `pdftotext -layout`.

2. **Extraction check.** Located Table 1 in the published article (page 422). The Issue-linkage structure row prints `1.219∗` with `(0.192)` in the "Cooperative Strategy = 0" column under Model 1, and the table footer shows `N = 588`. The ∗ is defined as `p < .05`. Extracted values (`orig_coef_value=1.219`, `orig_coef_se=0.192`, `orig_p_value=0.05` less-than, `orig_sample_size_value=588`) match the paper exactly. No extraction discrepancy.

3. **Data/code source.** Harvard Dataverse, doi:10.7910/DVN/E5ZSZR ("Replication data for: The Effects of Structures and Power on State Bargaining Strategies"). Three files: `McKibben_AJPS Bargaining Strategies dofile.do`, `McKibben_AJPS Bargaining Strategies data.tab` (Stata .dta original), `McKibben_AJPSCodebook.pdf`. Downloaded via Dataverse `/api/access/datafile/` endpoints with `?format=original` for the data file to retrieve the binary .dta.

4. **Reproduction.** Ran the Model 1 specification from the dofile via `stata-mp -b do run_pushbutton.do`:

   ```
   gologit2 dv lag_dv issue_linkage_structure agreement_importance qmv publicity lngdp foreignpolicy euro new_ms presidency parl_scrut, autofit cluster(i_bargain)
   ```

   Environment-only edits: (a) `cd` to the working directory; (b) wrapped `gologit2`/`omodel`/`pre` invocations with `ssc install` capture-blocks so the user-written commands install on first run. No changes to the analysis call. Runtime ~5 seconds.

5. **Stochastic-method diagnostics.** Not applicable — gologit2 with `autofit` is deterministic.

6. **Classification.**
   - Coefficient: paper 1.219 (3 dp). Reproduced 1.219314 → rounds to 1.219 → identical → precise.
   - Approx band would be [1.036, 1.402]; reproduced is well inside but the precise rule fires first.
   - p-value: threshold "p < .05". Reproduced p = 0.000 ≤ 0.05 → precise.
   - N: 588 = 588 → precise.
   - Effect size (log-odds = the logit coefficient): same as coefficient → precise.
   - Test statistic: paper does not print a z/t for this row (only SE), so non-outcome by the rubric (non-numeric for that sub-outcome in the paper).
   - Overall: **precise**.

## Diagnostics — author-bug analysis

Diagnostics: none — unpatched run reproduces to all printed digits, including all auxiliary fit statistics. No logic bug suspected.

(Note: the gologit2 output prints a `WARNING! 24 in-sample cases have an outcome with a predicted probability that is less than 0.` This is a known gologit2 diagnostic for parallel-lines models with continuous covariates and does not affect coefficient point estimates; the paper's published numbers reflect the same warning.)

## Files in this folder

- `P8az.pdf` — published article (copy)
- `P8az.txt` — `pdftotext -layout` output
- `McKibben_AJPS_dofile.do` — author's original Stata do-file (downloaded from Dataverse)
- `McKibben_AJPS_data.dta` — author's original data (downloaded from Dataverse, original binary format)
- `McKibben_AJPSCodebook.pdf` — author's codebook
- `run_pushbutton.do` — wrapper that installs `gologit2`/`omodel`/`pre` if missing then runs the Model 1 specification verbatim from the author dofile
- `run_pushbutton.log` — Stata log from the push-button run (contains the reproduced coefficient, SE, N, and fit stats)
- `REPRODUCTION_REPORT.md` — this file
- `P8az_summary_rows.csv` — one-row summary

No patched-diagnostic artifacts (none needed).
