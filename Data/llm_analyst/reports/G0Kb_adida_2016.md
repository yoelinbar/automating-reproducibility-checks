# Reproduction Report — Adida (2016), "The Spousal Bump"

**Paper:** Adida, C. L., Combes, N., Lo, A., & Verink, A. (2016). The Spousal Bump: Do Cross-Ethnic Marriages Increase Political Support in Multiethnic Democracies? *Comparative Political Studies* 49(5), 635–661. https://doi.org/10.1177/0010414015621080
**Paper IDs:** paper_id=G0Kb; claims=[`G0Kb_single-trace`]
**Reproduction type:** Extended Push Button (Zelig package archived from CRAN; substituted with equivalent `lm()` + `sandwich::vcovHC` per Zelig `model="ls", robust=TRUE` semantics; no analysis-logic edits)
**Headline verdict (unpatched):** approximate
**Verdict if patched (only if applicable):** N/A — no logic-level patch was applied

## Headline

The unpatched run reproduces the Table 2 Model (2) "Fon wife" coefficient and standard error precisely (coef = 0.208, SE_robust ≈ 0.083, both round to the paper's printed 0.21 and 0.08), and reproduces N=158 and R² = 0.127 (rounds to 0.13). **The one notable deviation is the significance star.** The paper marks the coefficient `**` (99% confidence). With the heteroskedasticity-robust SE the paper says it uses (footnote 20), the reproduced two-sided p-value is ≈ 0.012–0.015 (depending on HC0/HC1/HC2/HC3), which falls in the (0.01, 0.05] band — `*` (95%), not `**` (99%). Only the classical (non-robust) OLS p-value of 0.0084 attains p<0.01. Per the SCORE rubric this drops the p-value sub-outcome from "precise" to "approximate"; significance direction is unchanged (still significant at 95%).

## Comparison table

| Claim | Sub-outcome | Paper (Table 2, model 2, p. 647) | Extracted (orig_*) | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| G0Kb_single-trace | coefficient (Fon wife) | 0.21 | NaN (not extracted) | 0.20801 → 0.21 (paper-precision round) | precise = 0.21; approx = [0.1785, 0.2415] | precise |
| G0Kb_single-trace | standard error (Fon wife) | 0.08 | NaN | 0.08304 (HC1) → 0.08 | precise = 0.08; approx = [0.068, 0.092] | precise (not a formal sub-outcome but reported) |
| G0Kb_single-trace | p-value (threshold "p<0.01" via `**`) | <0.01 | NaN | 0.0133 (HC1 robust); 0.0117 (HC0); 0.0150 (HC3); 0.0084 (classical) | precise = ≤0.01; approx = (0.01, 0.06]; not = >0.06 | approximate |
| G0Kb_single-trace | sample size | 158 | NaN | 158 | precise = 158; approx = [134, 182] | precise |
| G0Kb_single-trace | R² (auxiliary) | 0.13 | NaN | 0.1274 → 0.13 | precise = 0.13 | precise |

Overall: at least one sub-outcome `approximate`, none `not` → **approximate.**

## What I did

### 1. Set-up
Created `independent_reproductions/G0Kb_adida_2016/`. Copied `papers/G0Kb.pdf`. Ran `pdftotext -layout` to produce `G0Kb.txt`.

### 2. Extraction check
The `orig_*` fields in `paper_claims/G0Kb.json` are all `NaN` — no extracted values to compare against. I therefore traced the claim text directly to the paper:
- **Page 647, Table 2** (Determinants of Yayi Vote Choice on Chantal Coethnics and Non-Coethnics in Benin Survey Experiment): row "Fon wife", column (2) "Chantal coethnics" with enumerator FE = `0.22**` in column (1) and `0.21**` in column (2), SE = `(0.08)`. R² = `.13`. Observations = `158`. Significance legend: `* and ** indicate 95% and 99% confidence levels, respectively.`
- The claim text (`claim_result_text`) targets **model (2)** with "OLS estimate = 0.21 (0.08); 99% confidence level" — exact match to the printed table.
- Footnote 20 (line 510 of pdftotext): "Standard errors are robust."

No paper↔extraction mismatch (extraction is empty), but I logged the exact paper values above.

### 3. Data/code source
`pr_data_location = "Publisher website"` — the SAGE journal page is behind Cloudflare and the supplemental URL returned HTTP 403 to scripted access. The paper itself contains no explicit data-availability statement.

I located a public, author-controlled replication archive on GitHub by following the publications page on Adida's personal site (`claire.adida.net/articles.html`, which loads `https://docs.google.com/spreadsheets/d/e/2PACX-1vTG8TtO6ceiZYswhG21Y7AUm9QMtVy_QROe_iMZ6DfWRZ-VbHw62WnOKRcfMX7iQfNRqR_BGyxRDAtl/pub?output=csv`). For 2016 *CPS* "The Spousal Bump" the `Other_Links` field reads `[replication](https://github.com/claireadida/paper-replication-ACLV2016)`.

Cloned that repo into `paper-replication-ACLV2016/`. Contents of `ACLV Replication/`:
- `analysis.R` — author's R script, exactly the file referenced by Adeline Lo in the header comments
- `dataFonIsNotGoun.dta` — the Stata dataset the script reads when present (per script line 22)
- `Benin2012survey.csv` — *not present here* (the analysis.R falls back to it if the .dta is missing)
- `REPLICATION_GUIDE_Table2_issues.md` and `VERIFICATION_SUMMARY.md` — third-party-style commentary in the repo. **Per the audit policy I did not consult these for verdict reasoning** beyond noting the repo's file inventory.

The `analysis.R` header (line 16–25) selects the .dta when present and explicitly comments that this is the dataset that produced "paper Table 2." Running the file as-archived therefore consumes `dataFonIsNotGoun.dta` and the Chantal-coethnics Model (2) specification (lines 131, 147).

### 4. Reproduction
Run command:
```
Rscript run_table2_model2.R 2>&1 | tee run_table2_model2.log
```
Runtime: ≈ 2 s.

**Environment-only edits relative to author's `analysis.R` (allowed under Extended Push Button):**
- Working directory set to local repo.
- The author's call `zelig(BoniVote ~ Femme + FemmeFon + RAdummy1 + RAdummy2 + RAdummy3, model="ls", data=data, robust=TRUE)` substituted with `lm(...)` + `sandwich::vcovHC(..., type="HC1")` + `lmtest::coeftest(...)`. Justification: Zelig is archived from CRAN as of R ≥ 4.0 and is unavailable under R 4.5.2; for the `ls` model with `robust=TRUE`, Zelig fits OLS via `lm()` and reports HC sandwich SEs. The statistical specification — outcome `BoniVote`, regressors `Femme + FemmeFon + RAdummy1 + RAdummy2 + RAdummy3`, sample restriction `FonGroup==1 & pop==1` — is unchanged. Reported HC0/HC1/HC2/HC3 for transparency.

No analysis-logic edits.

### 5. Stochastic-method diagnostics
Not applicable to the table-headline claim (OLS is deterministic). Footnote 21 mentions a bootstrap robustness check; the headline Table 2 numbers are not bootstrap quantities, so the focal sub-outcomes don't depend on seed handling.

### 6. Classification
Bounds and reproduced values reported in the comparison table.
- Coefficient: paper 0.21 (2 dp). Reproduced 0.20801 → round to 0.21 → equals 0.21 → **precise.**
- Sample size: 158 → 158 → **precise.**
- R² (auxiliary): 0.13 (2 dp). Reproduced 0.1274 → round to 0.13 → **precise.**
- p-value (threshold rule, `**` = 99% = p<0.01): reproduced 0.0133 (HC1, what the paper says it uses) is in the (0.01, 0.06] band → **approximate.**
- SE (auxiliary): 0.08 (2 dp). Reproduced 0.083 (HC1) → 0.08 → **precise.**

Overall verdict per the rubric (any sub-outcome `not` → not; else if any `approximate` → approximate; else precise): **approximate.**

## Diagnostics — author-bug analysis

**Suspected issue:** The published Table 2 marks the coefficient `**` (99% confidence) but with the heteroskedasticity-robust standard errors the paper says it uses (footnote 20: "Standard errors are robust"), the two-sided p-value for FemmeFon is ≈ 0.012–0.015 across all standard HC variants — `*` (95%), not `**` (99%). Only the classical (non-robust) OLS SE produces p = 0.00838 (< 0.01).

**Quoted line (analysis.R, line 147):**
```
vote2 <- zelig(BoniVote ~ Femme + FemmeFon + RAdummy1 + RAdummy2 + RAdummy3, model="ls", data=data, robust=TRUE)
```
followed by:
```
stargazer(vote2, title="", align=TRUE, ci=FALSE, keep=c("FemmeFon"))
```
The `robust=TRUE` flag in Zelig's `ls` model fits HC sandwich SEs (HC0 by default). With HC0 the reproduced p = 0.0117, which gives `*` not `**` under standard star conventions.

**Reasoning:** It is plausible that `stargazer` was applied to a model object whose default `vcov` is the classical OLS variance (which gives p < 0.01), so the printed star reflects classical-SE significance even though the printed SE itself rounds the same as the robust SE at 2-decimal precision. Alternatively, an older version of Zelig with a different `robust=TRUE` default (or a different downstream summary path) could have produced HC0 SE but classical-OLS p-values for star assignment. Either way, the printed `**` is not consistent with using robust SE for inference; with robust SE it should be `*`.

**Patched run:** No code patch was applied — the discrepancy is between the printed *star* and the paper's stated SE choice, not a code defect that I can patch into a different number. The reproduced printed SE (0.08) and coefficient (0.21) are unchanged regardless of which SE is used to assign the significance star. If we *retroactively* apply the classical-OLS p-value (0.00838) for star assignment (which the data does support), then the verdict would tighten to **precise** on the p-value sub-outcome. I am not promoting that into the headline because the paper text says robust SE and that's what an unpatched, faithful reading of the analysis path produces.

**Verdict if we used classical-OLS p for the star (a permissive interpretation):** precise.
**Verdict if we hold the paper to its stated robust-SE inference:** approximate (headline).

**Confidence:** Medium-high that this is a routine star-table inconsistency rather than a substantive coding error. The substantive direction and magnitude of the result are unchanged; the result is significant at conventional levels under both classical and robust SE; only the 99% claim relies on the classical-SE path.

## Files in this folder

- `G0Kb.pdf` — version-of-record PDF (copied from `papers/G0Kb.pdf`)
- `G0Kb.txt` — `pdftotext -layout` output of the PDF
- `paper-replication-ACLV2016/` — cloned author replication repo (`https://github.com/claireadida/paper-replication-ACLV2016`)
  - `ACLV Replication/analysis.R` — author's R script (unmodified)
  - `ACLV Replication/dataFonIsNotGoun.dta` — author's Stata dataset used by Table 2
  - `ACLV Replication/REPLICATION_GUIDE_Table2_issues.md`, `VERIFICATION_SUMMARY.md`, `run_with_dta.R` — third-party commentary in the repo (not consulted for the verdict)
- `run_table2_model2.R` — reproduction script (extracted Model 2 specification from `analysis.R`; environment-only edits documented in script header)
- `run_table2_model2.log` — full log output of the reproduction run
- `REPRODUCTION_REPORT.md` — this file
- `G0Kb_summary_rows.csv` — one-row summary CSV
