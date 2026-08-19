# Reproduction Report — Marshall & Fisher (2015), "Compensation or Constraint?"

**Paper:** Marshall, John & Stephen D. Fisher. 2015. "Compensation or Constraint? How Different Dimensions of Economic Globalization Affect Government Spending and Electoral Turnout." *British Journal of Political Science* 45(2): 353-389. DOI: 10.1017/S0007123413000422
**Paper IDs:** paper_id=GOYb; claims=GOYb_single-trace
**Reproduction type:** Push Button (Extended — only environment-only edit was the working-directory `cd` path)
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A — no patch needed

## Headline
Exact reproduction of Table 2, Model 5 (Ownership Scale on aggregate electoral turnout, one-step difference-GMM Arellano-Bond, country-clustered robust SEs, 23 OECD countries, 1970–2007). All four reported sub-outcomes match the paper to all printed digits. **No deviations.** A notable side finding about the *replication archive itself*: the Cambridge Core supplementary archive (the URL the paper points to) is incomplete — it ships the spending-side `.dta`/`.do` files but does **not** include `Turnout.dta` or `Turnout results.do`, the materials needed for Table 2. Those had to be obtained from the author's personal Dropbox link off his Columbia/Harvard research webpage. The unpatched run from the author's complete archive reproduces the headline statistic exactly.

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| GOYb_single-trace | Coefficient (Ownership Scale) | -3.519 | -3.519 | -3.519048 → rounds to -3.519 | precise band: -3.519 (3 dp); approx: [-4.047, -2.991] | precise |
| GOYb_single-trace | Standard error | 0.938 | 0.938 | 0.9375968 → rounds to 0.938 | precise band: 0.938 (3 dp) | precise |
| GOYb_single-trace | p-value | < 0.01 (threshold) | 0.01 (less-than) | 0.000 (z=-3.75) | precise: p ≤ 0.01; approx: (0.01, 0.06]; not: > 0.06 | precise |
| GOYb_single-trace | Sample size | 202 | 202 | 202 | precise: 202; approx: [172, 232] | precise |
| GOYb_single-trace | Effect size (= coef) | -3.519 | -3.519 | -3.519048 → rounds to -3.519 | precise band: -3.519 | precise |

**Overall verdict (unpatched): precise.**

## What I did

### 1. Set-up
Created `independent_reproductions/GOYb_marshall_2015/`. Copied `papers/GOYb.pdf` in. Ran `pdftotext -layout` to produce `GOYb.txt`.

### 2. Extraction check
Read the published-VOR PDF. Table 2, Model 5 (page 22, "Models of aggregate electoral turnout — Arellano and Bond difference GMM estimation"):
- Ownership Scale coefficient: **-3.519** (printed in column "Model 5", row "Ownership Scale")
- SE: **(0.938)***** (significance stars *** = p<0.01)
- N: **202** observations (also reported)

Extracted CSV row matches paper to all reported digits. The claim_id `orig_*` values (`-3.519`, `0.938`, `0.01` less-than, `202`) are correctly traced to Table 2 Model 5 on page 22 of the published article.

### 3. Data/code source
- **Cambridge Core supplementary materials** (the official `pr_data_location`, "Publisher website") — downloaded all 7 files: `sup001.pdf` (appendix), `sup004.R`, `sup005.dta` (= Spending.dta), `sup006.xlsx` (model results), `sup007.do` (= Spending results.do), `sup008/009/010.dta` (subset of `spendmiN.dta` imputed datasets).
- **Critical gap**: The Cambridge archive is incomplete. It contains *only* the spending (Table 1) materials. `Turnout.dta` and the Stata code that produces Table 2 (`Turnout results.do`) are not included.  Confirmed by inspecting all variables in the four shipped `.dta` files — none contain a `turnout` column.
- **Resolved by** following the author's research page at https://john-l-marshall.github.io/research/ to a public Dropbox link, downloaded as a ZIP. The Dropbox archive contains the full set of materials including `Turnout.dta` (1.07 MB, 1 file) and `Turnout results.do` (116 KB, 1096 lines).

The Dropbox archive is dated March 2017 and includes the same Spending materials plus the missing turnout materials, an Instructions.docx, and an internal `Replication.zip`.

### 4. Reproduction
**Edit applied:** Only the working-directory `cd` line at the top was changed from the author's Windows path to the local absolute path. No analysis edits.

The exact line of code that produces Model 5 (Table 2, Ownership Scale) is **line 170 of `Turnout results.do`**:

```stata
xtabond turnout factor $controls $trendsminuslux, artests(4) vce(robust) lag(1)
```

Where `factor` is the ownership-scale variable created by `xi: factor logfdistock logfdiflow logportequ i.cowcode, ipf` then `predict factor, b` (lines 29–30). The author's own comment above the line explains: *"...same missing data (no Belgium of Luxembourg) problems for factor variable as FDI flows"* — hence `$trendsminuslux` is used in place of `$trends`.

`run_pushbutton.do` re-runs (a) `xtset cowcode t`, (b) the global macros, (c) the factor construction, (d) the line above. Stata version: stata-mp from `/usr/local/bin/stata-mp` (StataNow 18 / 19 era; original was Stata MP 12.1). Runtime: ~1s.

Results from `run_pushbutton.log`:

```
Arellano-Bond dynamic panel-data estimation     Number of obs     =        202
Group variable: cowcode                         Number of groups  =         22
                                                Wald chi2(21)     =   6.23e+10
One-step results
                              (Std. Err. adjusted for clustering on cowcode)
              |               Robust
      turnout |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
      factor |  -3.519048   .9375968    -3.75   0.000    -5.356704   -1.681392
```

### 5. Stochastic-method diagnostics
None applicable. `xtabond` one-step difference GMM is deterministic given the data. No randomness, no seed needed. The factor-analysis step (`factor ... ipf`) uses iterated principal factors on a fixed correlation matrix — also deterministic.

### 6. Classification
For each sub-outcome:

- **Coefficient (-3.519, 3 dp)**: reproduced -3.519048 → round to 3 dp → -3.519. Equals paper. **Precise.**
- **SE (0.938, 3 dp)**: reproduced 0.9375968 → round to 3 dp → 0.938. Equals paper. **Precise.**
- **p-value (threshold p<0.01)**: reproduced p = 0.000 (z = -3.75 → two-sided p ≈ 1.8e-4) ≤ 0.01. **Precise.**
- **Sample size (202)**: reproduced 202. **Precise.**
- **Effect size (= regression coefficient = -3.519)**: same as above. **Precise.**

**Overall: precise** (all sub-outcomes precise).

## Diagnostics — author-bug analysis
**Diagnostics: none.** The unpatched run reproduces the paper's printed values to all printed digits. No logic-level bug suspected in the code.

The one finding worth flagging is *not* an analysis bug but an **archival completeness issue**: the publisher-hosted Cambridge supplementary archive omits `Turnout.dta` and `Turnout results.do`. A reader trying to replicate Table 2 from the publisher-hosted files alone would be stuck. The materials are available, but only via the author's separately-maintained Dropbox link. This is a documentation/archive gap, not a code or data bug — the author's complete archive is correct and reproduces exactly.

## Files in this folder
**Unpatched-run artifacts:**
- `run_pushbutton.do` — the reproduction script (only edit vs original: `cd` path)
- `run_pushbutton.log` — Stata log of the unpatched run
- `Turnout.dta` — author's data (sourced from Dropbox archive; identical to file inside `dropbox_replication/`)

**Source materials:**
- `GOYb.pdf`, `GOYb.txt` — paper PDF and pdftotext output
- `S0007123413000422_sup001.pdf` — published online appendix
- `S0007123413000422_sup004.R` — R script (figures + Amelia imputation; references `Turnout.dta` it does not ship)
- `S0007123413000422_sup005.dta` — Spending.dta (Table 1 source data)
- `S0007123413000422_sup006.xlsx` — spending-model results compilation
- `S0007123413000422_sup007.do` — Spending results.do (only do-file in Cambridge archive; Table 1 only)
- `S0007123413000422_sup008/009/010.dta` — three imputed-spending `.dta` files (subset of the 10 spendmi files in author's full archive)
- `dropbox_replication/` — full author archive from Dropbox link (contains `Turnout.dta`, `Turnout results.do`, `Spending.dta`, `Spending results.do`, all 10 `spendmiN.dta`, `Instructions.docx`, `Results.smcl`, etc.)

**Summary file (sibling, not in this folder):**
- `../GOYb_summary_rows.csv` — required summary CSV (one row per claim)

**Patched-diagnostic artifacts:** none (no patch was applied).
