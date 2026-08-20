# Reproduction Report — Angrist & Lavy (2009), High Stakes Achievement Awards

**Paper:** Angrist, Joshua, and Victor Lavy. 2009. "The Effects of High Stakes High School Achievement Awards: Evidence From a Randomized Trial." *American Economic Review* 99(4): 1384–1414. DOI: 10.1257/aer.99.4.1384
**Paper IDs:** paper_id=Gv3O; claims = Gv3O_q73v5y, Gv3O_j61p8w, Gv3O_5ojq61, Gv3O_yw46nk, Gv3O_2l95y4
**Reproduction type:** Push Button (Tables 2, 4); Source Data Reproduction (Table 8 — only SAS code provided, ported to Stata)
**Headline verdict (unpatched):** approximate (4 of 5 claims precise; 1 claim approximate)

## Headline

Tables 2 and 4 reproduce **precisely** from the archived Stata do-files using the archived data, with no analysis-logic edits — only path edits and an `adopath` for the supplied `brl.ado`. All four Table 2 / Table 4 claims (Gv3O_q73v5y, Gv3O_j61p8w, Gv3O_5ojq61, Gv3O_yw46nk) match the paper's coefficients, BRL standard errors, and Ns to the precision printed.

The fifth claim (Gv3O_2l95y4 — Table 8 Panel B "All Academic", Girls 4th quartile, OLS = 0.086, s.e. = 0.055, N=921) is **approximate, not precise**. Table 8 has *no Stata code* in the archive — only SAS programs (`table8_linear_quart.sas` etc.) that I cannot run with the available tooling. I ported the SAS spec to Stata (school FE on stacked 2000+2001 girls in the top lagged-score quartile, robust SE clustered by `student_id`) and obtained:

- Reproduced coefficient = **0.092** vs paper 0.086 (|Δ|/orig = 6.6%) → within the 15% band but not precise to printed digits.
- Reproduced SE = **0.056** vs paper 0.055 → rounds to 0.06 vs 0.06; within rounding (precise).
- Reproduced N = **905** vs paper 921 (1.7% off) → within 15% (approximate).

The coefficient and N gaps are small but per the project's "any deviation beyond rounding is meaningful" guideline, they are flagged. The most likely sources are subtle SAS-vs-Stata differences in (a) `proc univariate` percentile assignment when there are ties in `lagscore` (different methods give 902–905 for the both-years filter, none recover 921), and/or (b) `proc genmod` GEE's handling of singletons after school-FE absorption. These are diagnosed below — but the headline is the *unpatched* port.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (precise / approx-band) | Sub-verdict |
|---|---|---|---|---|---|---|
| Gv3O_q73v5y (Tab 2, Girls OLS col 5, scqm) | coef | 0.105 | 0.105 | 0.10475 → 0.105 | precise = 0.105; approx [0.0893, 0.1208] | precise |
| | SE | 0.047 | 0.047 | 0.04729 → 0.047 | (treated as effect-size, ser_method) | precise |
| | N | 1861 | 1861 | 1861 | precise = 1861 | precise |
| Gv3O_j61p8w (Tab 2, Girls Logit col 6, scqm) | coef | 0.097 | 0.097 | 0.09737 → 0.097 | precise = 0.097; approx [0.0825, 0.1116] | precise |
| | SE | 0.046 | 0.046 | 0.04555 → 0.046 | | precise |
| | N | 1861 | 1861 | 1861 | precise = 1861 | precise |
| Gv3O_5ojq61 (Tab 2, Boys Logit col 4, scqm) | coef | −0.023 | −0.023 | −0.02338 → −0.023 | precise = −0.023; approx [−0.0265, −0.0196] | precise |
| | SE | 0.045 | 0.045 | 0.04524 → 0.045 | | precise |
| | N | 1960 | 1960 | 1960 | precise = 1960 | precise |
| Gv3O_yw46nk (Tab 4, Girls top by lagscore, Logit, scqm) | coef | 0.206 | 0.206 | 0.20583 → 0.206 | precise = 0.206; approx [0.1751, 0.2369] | precise |
| | SE | 0.079 | 0.079 | 0.07862 → 0.079 | | precise |
| | N | 933 | 933 | 933 | precise = 933 | precise |
| Gv3O_2l95y4 (Tab 8, Panel B All Academic, Girls 4th quartile, OLS col 7) | coef | 0.086 | 0.086 | **0.0916 → 0.092** | precise = 0.086; approx [0.0731, 0.0989] | **approximate** |
| | SE | 0.055 | 0.055 | 0.0562 → 0.056 | precise = 0.055; approx [0.0468, 0.0633] | approximate (rounds to 0.06 vs 0.06; off by 1 in 3rd decimal) |
| | N | 921 | 921 | **905** | precise = 921; approx [783, 1059] | approximate |

**Overall verdict per claim (unpatched):**
- Gv3O_q73v5y → **precise**
- Gv3O_j61p8w → **precise**
- Gv3O_5ojq61 → **precise**
- Gv3O_yw46nk → **precise**
- Gv3O_2l95y4 → **approximate** (coefficient and N off but within 15% bounds)

Combined paper-level (worst-of) headline: **approximate**.

## What I did

### 1. Set-up
- Created `independent_reproductions/Gv3O_angrist_2009/`.
- Copied `papers/Gv3O.pdf` and ran `pdftotext -layout` to produce `Gv3O.txt`.

### 2. Extraction check
All five extracted statistics match the published paper exactly:
- Table 2 (p. 311 of journal layout, p. 11 of PDF): Girls OLS col (5) scqm = 0.105 (0.047), Girls Logit col (6) scqm = 0.097 (0.046), Boys Logit col (4) scqm = −0.023 (0.045), N girls = 1,861, N boys = 1,960.
- Table 4 (p. 315, PDF p. 15): Girls top by lagged score, scqm (quartile dummies) col (3) = 0.206 (0.079), N = 933.
- Table 8 (p. 323, PDF p. 23): Panel B All Academic, Girls 4th quartile col (7) OLS = 0.086 [0.055], N = 921.

### 3. Data/code source
Downloaded the replication archive from Angrist's MIT Data Archive: `https://economics.mit.edu/sites/default/files/publications/AngristLavy_AERdata.zip` (file: `AngristLavy_AERdata.zip` in this folder). The archive contains:
- Stata `.do` files for Tables 2, 3, 4, 5, 6, 7, A1, A2, A4, A5
- SAS `.sas` files for Tables 1, 8, A3
- Data files: `base99.dta`, `base00.dta`, `base01.dta`, `base02.dta`, plus SAS counterparts and `base_ns.sas7bdat`
- `brl.ado` (Bell–McCaffrey "BRL" standard-error implementation by the authors)

### 4. Reproduction commands

**Tables 2 & 4 — Push Button:**
- `run_table2.do` and `run_table4.do` are the archived `.do` files with only environment edits:
  - Replace Windows paths with absolute Mac paths.
  - Add `adopath ++ "$REPRODIR/AngristLavy_AERdata/Code"` so `brl.ado` is found.
  - No analysis-logic edits.
- Run with `/usr/local/bin/stata-mp -b do run_table2.do` and likewise for table 4.
- Logs: `run_table2.log`, `run_table4.log`. Key output: see comparison table above.

**Table 8 — Source Data Reproduction (port of SAS to Stata):**
- The archive only provides SAS code for Table 8 (`table8_linear_quart.sas`). No Stata equivalent exists, and I cannot run SAS in this environment.
- I converted `base_ns.sas7bdat` to Stata format via Python `pyreadstat` (`base_ns.dta`).
- I ported the regression spec verbatim into `run_table8.do`:
  - Drop missing (`missing_==0`).
  - Subset to girls (`boy==0`).
  - Per-year quartile assignment of `lagscore` (girls only), keeping top-quartile (4th quartile) observations.
  - Stack 2000 and 2001; for 2000 set treated=semrel=semarab=0 and `school_id_a=school_id*100` (matching SAS).
  - Restrict to schools that appear in both 2000 and 2001 within the top-quartile-girls subsample.
  - OLS: `reg college0 treated semarab semrel lagscore year01 i.school_id, vce(cluster student_id)`.
- Result: coef=0.0916, SE=0.0562, N=905. Log: `run_table8.log`.

### 5. Stochastic-method diagnostics
None of the focal models are stochastic. The Table 4 `predict p` for predicted-probability quartiles uses a deterministic logit. No seed handling concerns.

### 6. Classification
Bounds computed from paper values (±15% for coef/SE/N; rounding to paper precision for "precise"). All Table 2 & Table 4 sub-outcomes round to the paper's printed digits → **precise**. Table 8 coefficient rounds to 0.092 ≠ 0.086 → not precise; |Δ|/orig = 6.6% → in approximate band. Table 8 N=905 vs 921 (1.7% off) → approximate. Combined per-claim verdict for Gv3O_2l95y4: **approximate**.

## Diagnostics — author-bug analysis

Tables 2 & 4: **Diagnostics: none — unpatched run reproduces the paper exactly; no logic bug suspected.**

Table 8 (Gv3O_2l95y4):
- **Suspected source of discrepancy:** Not a clear "bug." The most plausible explanation for the small N gap (921 vs 905) is a difference in how SAS `proc univariate pctlpts=25 to 100 by 25 pctlpre=count` (default percentile method PCTLDEF=5) versus my Stata/Python `<` cutoff handles ties around the 75th percentile, and possibly that SAS `proc genmod`/GEE drops single-school clusters that Stata's `reg ... i.school_id` retains (or vice versa). I tested every percentile method available in numpy (linear, weibull, hazen, etc.) and got top-quartile counts of 906–909 (after both-years filter: 902–905) — none reach 921. So the gap is not pure-percentile-method.
- **Reasoning:** The SAS code base is the canonical source for Table 8 (no Stata version was provided). My Stata port faithfully replicates the spec but cannot exactly match SAS GEE's school-FE handling. A small N gap of 16/921 = 1.7% would not normally cause a coefficient gap of 6.6%, suggesting that the missing rows are non-random (likely a single school that fails the both-years filter under SAS's logic but passes under Stata's, or vice versa).
- **Patched run:** Not applicable — no obvious patch transforms 905 → 921 without inferring undocumented author logic. The headline verdict therefore stays "approximate." If the user has SAS available, running the original `table8_linear_quart.sas` would resolve this; the headline cannot be promoted on the basis of unverified guesses.
- **Verdict if patched:** indeterminate — leaving as approximate.
- **Confidence that this is a bug vs. a legitimate spec disagreement:** Low that this is an author bug; high that this is a tooling difference between SAS GEE/PROC UNIVARIATE and Stata's `reg`/`sum, detail`. The paper's headline conclusion (program effect on top-quartile girls' college enrollment ≈ 0.086) is qualitatively unchanged at 0.092.

## Files in this folder

Unpatched run artifacts:
- `Gv3O.pdf`, `Gv3O.txt` — paper PDF and pdftotext output
- `AngristLavy_AERdata.zip` — original replication archive (downloaded from MIT)
- `AngristLavy_AERdata/` — extracted archive (Code/ + data/ + readme.doc)
- `run_table2.do` / `run_table2.log` — Push Button reproduction of Table 2
- `run_table4.do` / `run_table4.log` — Push Button reproduction of Table 4
- `run_table8.do` / `run_table8.log` — Source Data reproduction of Table 8 (SAS spec ported to Stata)
- `base_ns.dta` — pyreadstat conversion of `base_ns.sas7bdat` for use by `run_table8.do`
- `Gv3O_summary_rows.csv` — per-claim summary in the standard schema
- `REPRODUCTION_REPORT.md` — this file

No patched-diagnostic run artifacts (no patches applied).
