# Reproduction Report — Behrman et al. (2015), Aligning Learning Incentives (ALI), Mexico

**Paper:** Behrman, Jere R.; Parker, Susan W.; Todd, Petra E.; Wolpin, Kenneth I. (2015). "Aligning Learning Incentives of Students and Teachers: Results from a Social Experiment in Mexican High Schools." *Journal of Political Economy* 123(2): 325–364. DOI: [10.1086/675910](https://doi.org/10.1086/675910).
**Paper IDs:** paper_id=G55r; claims=[G55r_single-trace]
**Reproduction type:** Push Button
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A (no patch needed)

## Headline

**Push Button reproduction succeeds and matches the paper to all reported digits.** Running the author's `table_7_gr10_yr1.do` on `table_7_gr10_yr1.dta` (manually retrieved from the JPE supplement) reproduces the Table 7 ATE T3 / 10th grade / Year 1 (with copying adjustment) cell as **31.40501 (SE 5.78514), N = 11,314**, which rounds exactly to the paper's printed **31.4 (5.79), N = 11,314**. The do-file actually prints two copying adjustments: Correction 1 (cap copiers' ALI score at the 25th-percentile of control non-copiers, 420) yields 31.42429 (5.842366), which matches Appendix Table C1's 31.4 (5.84); Correction 2 (cap copiers at the predicted ALI score from a regression of ALI on math score among control non-copiers) yields 31.40501 (5.78514), which matches Table 7's 31.4 (5.79). The cited claim text references Table 7, so Correction 2 is the canonical reproduction target.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| G55r_single-trace | Coefficient (ATE T3, gr10, Yr1, copying-adj.) | 31.4 | 31.4 | 31.40501 → rounds to 31.4 | precise band: rounds to 31.4 at 1 dp; approx band: [26.69, 36.11] | **precise** |
| G55r_single-trace | SE (reported in parentheses, paper sub-outcome implicit) | 5.79 | 5.79 | 5.78514 → rounds to 5.79 | precise band: rounds to 5.79 at 2 dp | **precise** |
| G55r_single-trace | Sample size | 11,314 | 11,314 | 11,314 | precise band: 11,314; approx band: [9,617, 13,011] | **precise** |
| G55r_single-trace | p-value | not printed for ATE-vs-C; CI [19.8, 43.0] implies p < .001 | NaN | implied p ≈ 0 (t = 31.40501/5.78514 = 5.43, df=86 clusters → p ≈ 5.0e-7) | n/a — non-outcome | non-outcome |
| G55r_single-trace | Effect size | not printed | NaN | n/a | n/a | non-outcome |

**Overall verdict:** every reported and reproduced sub-outcome is `precise` → **precise**.

## What I did

1. **Set-up.** Working dir `independent_reproductions/G55r_behrman_2015/`. Copied `table_7_gr10_yr1.do`, `table_7_gr10_yr1.dta`, and `readme.docx` from `manually downloaded data/G55r/` into the reproduction directory.

2. **Extraction check.** Located Table 7 on text line 1023 of `G55r.txt` (paper p. 346–347). The cell "Year 1: Academic Year 2008/9 — T3 — 10th grade — With copying adjustment — ATE" prints **31.4** with SE **(5.79)**. The body text on p. 347 (text line 1082) confirms: "T3 students in the tenth grade scored 31.4 standardized points higher … 95 percent confidence interval … 19.8 to 43.0." N = 11,314 appears in the Table C1 footnote (text line 1773) as the 2008/9 cohort sample size. Extracted values match the paper exactly.

3. **Data/code source.** Manually fetched JPE supplement materials (39 entries total in `manually downloaded data/G55r/`). The `readme.docx` provided by the authors confirms file mapping (Table 7 → `table_7_gr(x)_yr(z).dta` and `table_7_gr(x)_yr(z).do`) and variable mapping (`dum_treat1`=C, `dum_treat2`=T1, `dum_treat3`=T2, `dum_treat4`=T3).

4. **Reproduction commands.**
   - `cd independent_reproductions/G55r_behrman_2015/`
   - `/usr/local/bin/stata-mp -b do table_7_gr10_yr1.do`
   - Runtime: a few seconds. Log saved as `table_7_gr10_yr1.log`.
   - Environment-only edits: **none.** The do-file ran as-archived. The `!ALI score regressions...` lines emit a benign shell error (Stata's `!` shell-escape) but do not affect the regressions.

5. **Stochastic-method diagnostics.** N/A — OLS with cluster-robust SEs is deterministic.

6. **Classification.**
   - Coefficient: paper 31.4 (1 dp). Reproduced 31.40501 → rounds to 31.4 → **precise**.
   - SE: paper 5.79 (2 dp). Reproduced 5.78514 → rounds to 5.79 → **precise**.
   - Sample: paper 11,314. Reproduced 11,314 → exact → **precise**.
   - p-value, effect-size: non-outcome (not printed in paper).
   - Overall: **precise**.

### Which "copying adjustment"?

The do-file runs three regressions: (a) no correction, (b) Correction 1 (replace copiers' ALI score with 420 = 25th pctile of control non-copiers), (c) Correction 2 (replace copiers' ALI score with the lower of (i) actual and (ii) predicted from regression of ALI on math score among control non-copiers).

| Source in paper | T3 ATE | SE | Matches |
|---|---|---|---|
| Table 7 (main, p. 346, with copying adjustment) | 31.4 | 5.79 | **Correction 2:** 31.40501, 5.78514 |
| Appendix Table C1 (p. 358, with copying adjustment*) | 31.4 | 5.84 | Correction 1: 31.42429, 5.84237 |

The cited claim is Table 7, so **Correction 2** is the canonical reproduction. Correction 1 also rounds to 31.4 but with SE 5.84 (matches Appendix C1, not main Table 7).

## Diagnostics — author-bug analysis

Diagnostics: none — unpatched run reproduces the published numbers to the paper's printed precision. No author bug suspected.

## Files in this folder

- `G55r.pdf` — copy of the published paper.
- `G55r.txt` — `pdftotext -layout` output of the PDF.
- `readme.docx` — author-provided file/variable map.
- `table_7_gr10_yr1.do` — author's Stata do-file (unmodified).
- `table_7_gr10_yr1.dta` — author's Stata data file (2008/9 cohort, 10th grade).
- `table_7_gr10_yr1.log` — Stata log of the run.
- `REPRODUCTION_REPORT.md` — this report.
- `G55r_summary_rows.csv` — one-row summary CSV per the protocol.
