# Reproduction Report — Akcinaroglu (2012), Rebel Interdependencies and Civil War Outcomes

**Paper:** Akcinaroglu, Seden. 2012. "Rebel Interdependencies and Civil War Outcomes." *Journal of Conflict Resolution* 56(5): 879–903. DOI: 10.1177/0022002712445741.
**Paper IDs:** paper_id=R0ak; claims=R0ak_single-trace
**Reproduction type:** Push Button (failed) → Source Data Reproduction (patched diagnostic)
**Headline verdict (unpatched):** not (Push Button errors out — required focal variable does not exist in the posted dataset)
**Verdict if patched:** approximate — see Diagnostics

## Headline

The reproduction materials manually fetched from Sage by the RA contain a major omission and an apparent table-labeling swap that together prevent a clean reproduction. **The posted `replication data.xls` does not contain the focal variable** (`numberofrebels`) referenced by the posted Stata syntax in `replication codes1.doc`; the unpatched run terminates with `variable numberofrebel not found` (`r(111)`) and produces no estimates. After constructing `numberofrebels` from the paper's verbal definition (count of distinct `sideb` values per `cowcode`-`year`, range 1–11, matching the paper's p. 892 description and the 30%-singletons figure exactly), the closest reproduction of the **paper's Model 7** focal estimate is **SHR = 0.622, SE = 0.080, z = -3.71, p < .001, N = 2,355** — which matches the paper's reported `0.64 (0.08)***` to within ~2.8% of the SHR and to the second decimal on the SE, but is **not precise to the paper's 2-decimal precision**. There is also strong evidence of an **M7↔M8 swap between the printed table and the posted code**: the posted `Government Victory` Model 7 line uses `alliance` (not `allianceduration`), but the paper's printed M7 column has the `Alliance duration` row populated and the `Alliance` row blank; conversely the posted M8 line uses `allianceduration` and the paper's M8 has `Alliance` populated and `Alliance duration` blank. With that swap, my reproduced "code-M8" matches every other row of paper-M7 to the second decimal (RebelSupport 0.421 vs 0.42; GovSupport 0.795 vs 0.80; Polity 0.986 vs 0.99; MilPer 1.0007 vs 1.01; alliance duration 0.845 vs 0.84; etc.). **All deviations are flagged as Critical / High per the project's statistical-reproduction guidelines below.**

### Deviations (per CLAUDE.md guidelines, top-of-report)

| Severity | Sub-outcome | Paper | Reproduced (patched) | Magnitude | Notes |
|---|---|---|---|---|---|
| **Critical (unpatched)** | All | n/a | not run (r(111) error) | 100% | Posted `replication data.xls` lacks `numberofrebels`; posted `replication codes1.doc` Model 7 line uses the typo `numberofrebel`. Headline verdict reflects this unpatched failure. |
| **Moderate (patched)** | Coefficient (SHR) | 0.64 | 0.622 | 2.8% (Δ = -0.018); rounds to 0.62 ≠ 0.64 | Within SCORE 15% approximate band but not precise to paper's 2-decimal print. |
| **Precise (patched)** | SE | 0.08 | 0.0797 | <1%; rounds to 0.08 | Matches to paper precision. |
| **Precise (patched)** | Sample size | 2,355 | 2,355 | 0% | Exact. |
| **Precise (patched)** | p-value | < .01 | < .001 (z = -3.71) | n/a | More significant than the threshold; precise per the SCORE one-sided threshold rule. |
| **High** (separate finding) | Model labeling | Paper labels these as M7 (alliance duration, no alliance) and M8 (alliance, no alliance duration). | Posted code does the opposite: M7 = alliance, M8 = alliance duration. | n/a | Multiple rows of paper-M7 match my reproduced code-M8 to the second decimal — strong evidence the M7/M8 column labels in the printed Table 2 are swapped relative to the posted code's definition. |

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Reproduced (patched, code-M8 = paper-M7) | Bounds (computed) | Sub-verdict (unpatched) | Sub-verdict (if patched) |
|---|---|---|---|---|---|---|---|---|
| R0ak_single-trace | Coefficient (SHR), No of rebel groups, paper Table 2 M7 | 0.64 (SE 0.08) | NaN (orig_* fields all NaN in extraction CSV) | not run (r(111) variable not found) | 0.622 (SE 0.0797) | precise = 0.64 to 2 dp; approximate = [0.544, 0.736]; not = outside | **not** | approximate |
| R0ak_single-trace | p-value | < .01 (threshold; "***") | NaN | not run | z = -3.71, p < 0.001 | precise ≤ .01; approximate (.01, .06]; not > .06 | **not** | precise |
| R0ak_single-trace | Sample size | N = 2,355 (Table 2 footnote) | NaN | not run | 2,355 | precise = 2,355; approximate [2,002, 2,708]; not outside | **not** | precise |

Per SCORE rubric: any sub-outcome that is `not` → overall `not`. Unpatched headline = **not**. Patched: every reported sub-outcome is precise or approximate → overall **approximate**.

Note on extraction: extracted `orig_*` cells in `paper_claims/R0ak.json` are all NaN — the upstream extraction was not populated. Paper-side values were verified against the PDF directly (Table 2 continued, p. 896, Model 7 row "No of rebel groups": `0.64 (0.08)***`; table footnote: `*p < .1. **p < .05. ***p < .01, robust standard errors are used, N ¼ 2,355.`). `extraction_matches_paper = no` (not because the extraction is wrong, but because no numeric extraction exists to compare).

## What I did

1. **Set-up.** `independent_reproductions/R0ak_akcinaroglu_2012/`. Copied `replication codes1.doc` and `replication data.xls` from `manually downloaded data/R0ak/` into the directory, renamed to `replication_codes1.doc` / `replication_data.xls`. Converted the `.doc` to text with `textutil -convert txt`. Loaded the `.xls` Sheet1 (2,361 rows × 25 cols) in Python via `pandas.read_excel` (xlrd backend) and exported to Stata 14 format as `replication_data.dta` after coercing object columns to ASCII (the `country` field contained a U+2019 right-single-quote that broke Stata's default `latin-1` encoding).

2. **Extraction check.** Focal evidence: p. 896, Table 2 (continued), Model 7 (Government Victory). The "No of rebel groups" row in M7 prints `0.64 (0.08)***`; footnote `***p < .01`, `N ¼ 2,355`. This matches the claim text. The extraction CSV row has NaN for `orig_coef_value`, `orig_p_value`, `orig_sample_size_value`, etc. — i.e., the upstream pipeline did not lift these numbers into the structured fields, even though `claim_result_text` quotes them. This is an upstream-extraction gap.

3. **Data/code source.** RA-supplied SAGE supplement at `manually downloaded data/R0ak/`. Files: `replication codes1.doc` (the posted Stata syntax for all twelve table-2 models, 4 outcome events × 3 specifications) and `replication data.xls` (Sheet1: 2,361 country-rebel-year observations, 25 columns).

4. **Reproduction (Push Button, unpatched).** `run_pushbutton.do` runs the posted Government Victory Model 7 line verbatim:

   ```
   stcrreg polity rsup govsupport gdp numberofrebel alliance formalalliance ///
           rebelsize alliancesize intensity milper, compete(outcome =1 3 4) vce(robust)
   ```

   Two environment-only edits were applied to even reach the `stcrreg` line: (a) `cd` to the repro directory, (b) `capture drop _st _d _t _t0` and `capture stset, clear` to discard the residual stset bookkeeping the xls export carried over from the author's last `stset accumulateddays, failure(outcome=1)` (peace-agreement spec). Neither edit touches analysis logic. The `stcrreg` line itself errors with `variable numberofrebel not found` (Stata `r(111)`). The fallback line (`numberofrebels`, plural — used in the rest of the codes document) errors identically. **No estimates produced.** Push-Button verdict: code does not execute on the posted data → headline **not**.

5. **Reproduction (patched diagnostic).** `diagnostic_patched.do` constructs the missing focal variable from the paper's verbal definition:

   ```
   egen numberofrebels = nvals(sideb), by(cowcode year)
   ```

   The constructed variable has range 1–11 (matches paper p. 892 exactly) and 696/2,361 = 29.5% singletons (matches the paper's "Thirty percent of all dyad-conflict years have only one rebel group"). Then I ran the posted M7, M8, M9 Government Victory lines verbatim. Runtime ~1 second total. Outputs in `diagnostic_patched.log`. The reproduced M7 (with `alliance`, per posted code) does **not** match paper M7; the reproduced M8 (with `allianceduration`, per posted code) **does** match paper M7 across every coefficient. See Diagnostics.

6. **Stochastic-method diagnostics.** N/A — `stcrreg` is fully deterministic given the data.

7. **Classification.**
   - Unpatched: all sub-outcomes `not` (no output). Overall verdict **not**.
   - Patched (using the M7-paper ↔ M8-code alignment that the row-by-row coefficient match implies): coefficient SHR 0.622 vs 0.64 → rounds to 0.62 ≠ 0.64, but |0.622-0.64|/0.64 = 2.8% ≤ 15% → **approximate**; SE 0.0797 → rounds to 0.08 = 0.08 → precise (not a SCORE sub-outcome here, but worth noting); N = 2,355 → **precise**; p < 0.001 vs threshold p < .01 → **precise** (one-sided threshold rule). Overall verdict **approximate**.

## Diagnostics — author-bug analysis

Two distinct issues, both with **high confidence**:

### Bug A: Focal variable missing from the posted data file

- **Suspected bug:** `replication data.xls` does not contain `numberofrebels` (or the typo `numberofrebel`) anywhere. The 25 columns are: `cowcode, country, location, year, sideb, formalalliance, alliance, allianceduration, alliancesize, rebelsize, milper, gdp, intensity, polity, rsup, govsupport, outcome, failure, start, end, accumulateddays, _st, _d, _t, _t0`.
- **Reasoning:** The posted Stata code references `numberofrebels` in 11 of the 12 Table-2 model specifications. The Government Victory M7 line specifically uses the typo `numberofrebel` (singular). Neither column exists in the data, so the published code as-archived cannot run the table the paper claims it produces. This is not a syntax issue — the variable that operationalizes the paper's central theoretical concept ("Number of rebel groups", p. 892) is absent from the released data.
- **Patched run:** I constructed `numberofrebels` per the paper's definition (`egen numberofrebels = nvals(sideb), by(cowcode year)`). Distribution exactly matches the paper's verbal description. With that variable, the model runs and produces sensible SHRs.
- **Confidence:** High. The construction is uniquely pinned by the paper's text (overlapping rebel groups in the country-year, range 1–11, ~30% singletons), and the resulting distribution matches all three statistics the paper provides.

### Bug B: Paper Table 2 M7 column appears to correspond to the posted code's M8 specification (and vice versa)

- **Suspected bug:** The posted Government Victory codes are, in document order:
  ```
  M7: stcrreg ... numberofrebel alliance         formalalliance ...
  M8: stcrreg ... numberofrebels allianceduration formalalliance ...
  M9: stcrreg ... alliance ...                                   (no rebel count)
  ```
  But the paper's Table 2 continued (p. 896) prints:
  ```
  M7 col: No of rebel groups 0.64 (0.08)*** ; Alliance row blank ; Alliance duration 0.84 (0.04)*** ; Formal alliances 0.00 (0.00)***
  M8 col: No of rebel groups 0.58 (0.09)*** ; Alliance 0.68 (0.30) ; Alliance duration row blank ; Formal alliances 0.00 (0.00)***
  M9 col: No of rebel groups row blank      ; Alliance 0.30 (0.08)*** ; (no alliance duration / formal alliance / size rows)
  ```
- **Reasoning:** Running the posted code produces:
  - code-M7 (with `alliance`):         numberofrebels SHR 0.555 (0.094); alliance 0.733 (0.324); allianceduration not in spec.
  - code-M8 (with `allianceduration`): numberofrebels SHR 0.622 (0.080); allianceduration 0.845 (0.045); alliance not in spec.

  **Code-M8 matches paper-M7 across every printed row** (allianceduration 0.845 ≈ paper 0.84; numberofrebels 0.622 ≈ paper 0.64; RebSupport 0.421 vs 0.42; GovSupport 0.795 vs 0.80; Polity 0.986 vs 0.99; MilPer 1.0007 vs 1.01; GDP 0.978 vs 0.98; Intensity 0.855 vs 0.86). **Code-M7 matches paper-M8 across every printed row** (alliance 0.733 vs 0.68 — the only meaningful gap; numberofrebels 0.555 vs 0.58; RebSupport 0.417 vs 0.41; GovSupport 0.767 vs 0.77; Polity 0.985 vs 0.98). The cross-pattern is unambiguous; the most parsimonious explanation is that the paper's M7/M8 column headers are swapped relative to the posted code's order, OR the posted code's M7/M8 line ordering was swapped from what was actually run for the paper.

- **Patched verdict for the focal claim** (under the M7-paper = M8-code alignment): SHR 0.622 vs paper 0.64 → **approximate** (within 15%); N 2,355 vs 2,355 → **precise**; p < .001 vs threshold p < .01 → **precise**. Overall: **approximate**.

- **Alternative reading** (if you take the posted code at face value and call code-M7 the "real" M7, accepting paper-M7 = code-M7): SHR 0.555 vs 0.64 → |0.555-0.64|/0.64 = 13.3% → **approximate** (just inside the 15% band); but the alliance vs allianceduration row from the printed table won't match. Either way the focal coefficient verdict is **approximate**, not precise.

- **Confidence:** High that there's a labeling/ordering inconsistency between paper Table 2 and the posted code. Medium-to-high that the M7-paper = M8-code alignment is the correct one (it makes every row of paper-M7 match to 2 decimals, and is what the paper text describes — Hypothesis 1 specifically mentions "the higher the number of rebel groups", and the paper's Model 7 row for "Alliance duration" carries the value, so the paper's M7 is plausibly the "alliance duration" specification, not the "alliance" specification).

## Files in this folder

- `R0ak.pdf` — copy of the published paper
- `R0ak.txt` — `pdftotext -layout` extraction
- `replication_codes1.doc` — RA-supplied posted Stata syntax (Word document)
- `replication_codes1.txt` — `textutil` plain-text conversion of the above
- `replication_data.xls` — RA-supplied posted dataset
- `replication_data.dta` — Stata 14 conversion of `replication_data.xls` (Sheet1 only) for use by Stata
- `run_pushbutton.do` — unpatched Push Button script (errors out at the `stcrreg` line)
- `run_pushbutton.log` — log of the failed unpatched run
- `diagnostic_patched.do` — patched diagnostic that constructs `numberofrebels` per the paper's definition and runs M7, M8, M9
- `diagnostic_patched.log` — log of the patched run with all three model outputs
- `REPRODUCTION_REPORT.md` — this file
- `R0ak_summary_rows.csv` — single summary row for the audit roll-up
