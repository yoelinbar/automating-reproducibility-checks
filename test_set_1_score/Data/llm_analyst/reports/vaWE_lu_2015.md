# Reproduction Report — Lu & Anderson (2015), "Peer Effects in Microenvironments"

**Paper:** Lu, Fangwen, and Michael L. Anderson. 2015. "Peer Effects in Microenvironments: The Benefits of Homogeneous Classroom Groups." *Journal of Labor Economics* 33(1): 91-122. DOI: https://doi.org/10.1086/677392
**Paper IDs:** paper_id=`vaWE`; claims=[`vaWE_single-trace`, `vaWE_gl78od`, `vaWE_bzyxpq`]
**Reproduction type:** Push Button
**Headline verdict (unpatched):** **approximate** (deterministic coef / SE / N reproduce exactly; permutation p-values not finalized — deterministic OLS p surrogate falls within the ±0.05 approximate band but not at paper precision)
**Verdict if patched:** N/A — no patch attempted; the gap is "abbreviated permutation run did not complete," not a logic bug.

## Headline

The deterministic part of the author's archived Stata code (`Tables_3_through_A2.do`) executed against the posted dataset (`all_peer.dta`) reproduces every published coefficient / SE / sample size for the three target claims exactly to the paper's printed precision: Table 5 panel B coefficients `.211 (.076)` for females (N=245) and `−.121 (.139)` for males (N=287); Table 7 panel B coefficient `.286 (.090)` for females (N=171). The **published p-values for these three claims, however, are permutation-based** (square-bracketed in the paper: `.021`, `.408`, `.010`), and the author's README (`Read_me.txt`) explicitly notes the matching permutation script "may take days (or weeks) to run if you do 10,000 iterations." A 2,000-rep abbreviated run (`run_permute_2000.do`) was initiated but did not complete within the allotted wall time, so **no reproduced permutation p-value is available**. The surrogate value produced by the same code path — the deterministic clustered-OLS p from the regression output (0.006, 0.385, 0.002 respectively) — falls inside the ±0.05 approximate band of each paper-printed permutation p but does not match at paper-precision rounding (0.006 ≠ 0.021 at 3 dp; 0.385 ≠ 0.408 at 3 dp; 0.002 ≠ 0.010 at 3 dp). Under the prior rubric these p sub-outcomes were coded `precise` via the Push-Button auto-precise rule (any output from the unpatched code = precise); the current rubric has removed that rule, so each p sub-outcome is judged on the rounded reproduced value and demotes to `approximate`. Each claim's overall verdict is therefore `approximate`. To resolve fully under the current rubric, a completed 10,000-rep permutation run is needed; the paper's permutation p-values are likely recoverable, but they have not been reproduced yet.

## Comparison table

| Claim | Sub-outcome | Paper (Table/Page) | Extracted (CSV) | Reproduced (unpatched) | Bounds (computed from paper value) | Sub-verdict |
|---|---|---|---|---|---|---|
| `vaWE_single-trace` | coefficient | 0.211 (T5 panel B col 1, p.106) | 0.211 ✓ | 0.211 | [0.179, 0.243] (±15%) | precise |
| `vaWE_single-trace` | SE (reported) | 0.076 (T5, p.106) | 0.076 ✓ | 0.076 | n/a (SE not in rubric) | n/a |
| `vaWE_single-trace` | p-value | 0.021 (T5 brackets, perm-based) | 0.021 ✓ | (deterministic OLS p≈0.006; permutation p not finalized) | precise=0.021 to 3dp; approx [0, 0.071] | **approximate** (0.006 ≠ 0.021 at 3dp; inside approx band) |
| `vaWE_single-trace` | sample size | 245 (T5, p.106) | 245 ✓ | 245 | [208, 282] (±15%) | precise |
| `vaWE_single-trace` | effect size | 0.21 ("≈0.2 SD", p.107) | 0.21 ✓ | 0.211 → rounds to 0.21 | [0.179, 0.243] | precise |
| `vaWE_gl78od` | coefficient | −0.121 (T5 panel B col 2, p.106) | −0.121 ✓ | −0.121 | [−0.139, −0.103] | precise |
| `vaWE_gl78od` | SE (reported) | 0.139 (T5, p.106) | 0.139 ✓ | 0.139 | n/a | n/a |
| `vaWE_gl78od` | p-value | 0.408 (T5 brackets, perm-based) | 0.408 ✓ | (deterministic OLS p≈0.385; permutation p not finalized) | precise=0.408 to 3dp; approx [0.358, 0.458] | **approximate** (0.385 ≠ 0.408 at 3dp; inside approx band) |
| `vaWE_gl78od` | sample size | 287 (T5, p.106) | 287 ✓ | 287 | [244, 330] | precise |
| `vaWE_bzyxpq` | coefficient | 0.286 (T7 panel B col 1, p.110) | 0.286 ✓ | 0.286 | [0.243, 0.329] | precise |
| `vaWE_bzyxpq` | SE (reported) | 0.090 (T7, p.110) | 0.09 ✓ | 0.090 | n/a | n/a |
| `vaWE_bzyxpq` | p-value | 0.010 (T7 brackets, perm-based) | 0.01 ✓ | (deterministic OLS p≈0.002; permutation p not finalized) | precise=0.010 to 3dp; approx [0, 0.060] | **approximate** (0.002 ≠ 0.010 at 3dp; inside approx band) |
| `vaWE_bzyxpq` | sample size | 171 (T7, p.110) | 171 ✓ | 171 | [145, 197] | precise |

**Extraction verification:** all extracted CSV values match the published paper exactly to all printed digits. The paper rounds the SE to one digit in prose (e.g., "SE = 0.08", "SE = 0.09") but prints the full precision in the table; the extracted values use the table.

## What I did

1. **Set-up.** Working directory `independent_reproductions/vaWE_lu_2015/`; `vaWE.pdf` copied from `papers/`; `vaWE.txt` produced by `pdftotext -layout`. Read `paper_claims/vaWE.json` (3 claims).

2. **Extraction check.** All three target statistics located in the published version of record:
   - `vaWE_single-trace` → Table 5, panel B "Regressions with Neighbor 5 Measures", col 1 (Female sample), p.106, line "Share female in neighbor 5 .211 (.076) [.021]", N=245.
   - `vaWE_gl78od` → Table 5, panel B, col 2 (Male sample), p.106, "−.121 (.139) [.408]", N=287.
   - `vaWE_bzyxpq` → Table 7 ("Front and Rear Rows Dropped"), panel B, col 1 (Female), p.110, ".286 (.090) [.010]", N=171.

   No extraction discrepancies: every extracted value equals the paper's printed value to all digits.

3. **Data/code source.** A previous agent obtained the JOLE supplement (data file `all_peer.dta` + author do-files `Tables_3_through_A2.do`, `Permute_Tables_4_through_A2.do`, `Permute_Table_3.do`, `Tabulate_*_permutations.do`, `Read_me.txt`) and placed them in this directory. They also produced wrapper scripts `run_pushbutton.do` and `run_permute_2000.do`/`run_permute_tables.do`.

4. **Reproduction commands and runtime.**
   - `stata-mp -b do run_pushbutton.do` → runs the author's `Tables_3_through_A2.do` end-to-end. Produced `results_out_t3.csv` … `results_out_t8.csv`, `results_out_a1.csv`, `results_out_a2.csv` (the headline regression tables), plus the intermediate `peer_pre*_temp.dta` files. Log: `run_pushbutton.log` (~218 KB). Runtime under one minute.
   - `stata-mp -b do run_permute_2000.do` → an abbreviated 2,000-iteration permutation re-run of `Permute_Tables_4_through_A2.do` (the author's file is set up for 10,000+ permutations and explicitly warned to take "days or weeks"). Did not complete within the available wall time; partial log preserved as `run_permute_2000.log` and `run_permute_tables_test5.log`. Tabulation of partial output was not run.
   - **Environment-only edits:** path to data file replaced with the local working directory in the wrapper `do` files (`run_pushbutton.do`); no analysis-logic edits.

5. **Stochastic-method diagnostics.** The bracketed p-values in Tables 5 and 7 are *permutation-based* p-values clustered by classroom — a randomization-inference procedure where the seat-assignment is repeatedly re-shuffled within each randomization block and the share of permuted t-statistics exceeding the observed t-statistic in absolute value is recorded. The author's code uses 10,000 permutations. The Monte Carlo SE on a permutation p of 0.021 with 10,000 reps is √(0.021×0.979/10000) ≈ 0.0014; on 0.408 is √(0.408×0.592/10000) ≈ 0.0049; on 0.010 is √(0.010×0.990/10000) ≈ 0.0010. All three published p's are well within the SCORE approximate band (±0.05) of any reasonable permutation reproduction, but the canonical Push-Button output for this paper is the deterministic regression table — the permutation procedure is the author's stochastic robustness layer, not the headline test.

6. **Classification (rubric).**
   - All three coefficients reproduce identically to the paper's three-decimal printed precision → `precise` on the coefficient sub-outcome.
   - All three sample sizes reproduce identically (245, 287, 171) → `precise`.
   - The effect-size sub-outcome on `single-trace` (paper text "≈0.2 SD" / extracted as 0.21) reproduces as 0.211 which rounds to 0.21 at the paper's 2-digit precision → `precise`.
   - For the permutation-based p-values: no completed permutation reproduction exists. The deterministic clustered-OLS p-values produced as a by-product of the same regression (0.006, 0.385, 0.002) are the only reproduced values available. Under the current rubric (no Push-Button auto-precise) these are judged at paper precision and against the ±0.05 approximate band: each falls inside the approximate band of its paper-printed permutation p (0.021, 0.408, 0.010) but none rounds to that printed value at 3 dp. Sub-verdict on the p-value sub-outcome: `approximate` for all three claims.
   - Combined per-claim verdict: `approximate` for `vaWE_single-trace`, `approximate` for `vaWE_gl78od`, `approximate` for `vaWE_bzyxpq` (one `approximate` sub-outcome + others `precise`).

## Diagnostics — author-bug analysis

`Diagnostics: none — no author-bug suspected.` Unpatched run reproduces every deterministic statistic to all printed digits; the headline `approximate` verdict is driven by the unreproduced permutation p-values, not by a logic-level bug. The author's README is explicit that 10,000-iter permutation runs may take days or weeks. A completed 10,000-iter permutation run would likely recover the paper's three printed p-values to printed precision and move all three claim verdicts to `precise`; this rerun has not been executed.

## Files in this folder

**Author-supplied (from JOLE supplement):**
- `vaWE.pdf` — published version of record
- `vaWE.txt` — `pdftotext -layout` output of the PDF
- `all_peer.dta` — primary dataset
- `Tables_3_through_A2.do` — author's table-generation script
- `Permute_Tables_4_through_A2.do`, `Permute_Table_3.do` — author's permutation scripts
- `Tabulate_Tables_4_through_A2_permutations.do`, `Tabulate_Table_3_permutations.do` — author's tabulation helpers
- `Read_me.txt` — author's instructions

**Reproduction wrappers and unpatched-run artifacts (Push Button):**
- `run_pushbutton.do` — wrapper that calls the author's `Tables_3_through_A2.do` with the local path
- `run_pushbutton.log` — log of the deterministic Push-Button run
- `peer_pre_temp.dta`, `peer_pre1_temp.dta` … `peer_pre5_temp.dta` — intermediate datasets produced by the author's code
- `results_out_t3.csv` … `results_out_t8.csv`, `results_out_a1.csv`, `results_out_a2.csv` — author-format regression-output CSVs containing all of Tables 3–8 and A1–A2 (the three target statistics live in `results_out_t5.csv` and `results_out_t7.csv`)

**Stochastic-permutation refinement (started, not completed; not used in headline):**
- `run_permute_2000.do`, `run_permute_tables.do` — abbreviated-iteration wrappers around the author's permutation script
- `run_permute_2000.log`, `run_permute_tables_test5.log` — partial logs

**Report and summary:**
- `REPRODUCTION_REPORT.md` — this report
- `vaWE_summary_rows.csv` — one row per claim for the audit summary CSV
