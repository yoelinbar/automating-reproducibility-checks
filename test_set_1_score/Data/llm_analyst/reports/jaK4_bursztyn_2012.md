# Reproduction Report — Bursztyn (2012), Schooling Decision in Brazilian Favelas

**Paper:** Bursztyn, Leonardo, and Lucas C. Coffman. 2012. "The Schooling Decision: Family Preferences, Intergenerational Conflict, and Moral Hazard in the Brazilian Favelas." *Journal of Political Economy* 120(3): 359–397. DOI: https://doi.org/10.1086/666746
**Paper IDs:** paper_id=jaK4; claims=jaK4_single-trace
**Reproduction type:** Push Button (one syntax-only environment edit; see below)
**Headline verdict (unpatched):** precise
**Verdict if patched:** not applicable

## Headline
Push-button reproduction succeeds exactly. Running the author-supplied Stata do-file on the author-supplied dataset (after a single trivial syntax fix to a malformed line in the do-file's first command — `clearset more off` → `clear` + `set more off`, which is an environment-only edit, not a logic edit), the Table 4 column (2) regression returns coefficient = **−0.5818793** (paper: −0.5819), cluster-robust SE = **0.0913819** (paper: 0.091), N = **156** (paper: 156), with p = 8.16e-5 (paper threshold: p < 0.01). All four reported sub-outcomes round to the paper's printed precision exactly. Overall verdict: **precise**.

## Comparison table

| Claim | Sub-outcome | Paper (p.385, Table 4 col 2) | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| jaK4_single-trace | Coefficient | −0.5819 | −0.5819 | −0.58187926 → rounds to −0.5819 | precise = same to 4 dp; approx ∈ [−0.6692, −0.4946] | **precise** |
| jaK4_single-trace | SE (reported as Std. Err.) | 0.091 | 0.091 | 0.09138188 → rounds to 0.091 | (treated as a reported number; ±15% = [0.077, 0.105]) | **precise** |
| jaK4_single-trace | p-value | < 0.01 (***) | 0.01 (less-than) | 8.16e-05 | precise ≤ 0.01; approx (0.01, 0.06]; not > 0.06 | **precise** |
| jaK4_single-trace | Sample size | 156 | 156 | 156 | precise = 156; approx [133, 179] | **precise** |
| jaK4_single-trace | Effect size | not reported | NaN | n/a | n/a | non-outcome |
| **Overall** | | | | | | **precise** |

## What I did

### 1. Set-up
Working dir: `independent_reproductions/jaK4_bursztyn_2012/`. Copied the author's archive contents (`Bursztyn_Coffman_JPE.dta`, `Bursztyn_Coffman_JPE_tables.do`, `Readme.pdf`) from `manually downloaded data/jaK4/` into the reproduction directory. PDF text already present from a prior pass (`jaK4.txt`).

### 2. Extraction check
Located Table 4 ("Regressions: Treatment Effects: Dependent Variable = Dummy for Parent Prefers R$120 CCT to R$125 CT") on **p. 385** of the PDF (line 1279–1306 of `jaK4.txt`). Column (2) reports:

- "Text message treatment dummy" coefficient = **−.5819**, std. err. = **(.091)\*\*\***, sig. at 1 percent.
- Observations: **156**.

The extracted JSON values match the paper exactly to all printed digits. **No extraction discrepancy.**

### 3. Data/code source
Provided manually by the RA at `manually downloaded data/jaK4/`. The archive contains:
- `Bursztyn_Coffman_JPE.dta` — analysis dataset (single household-level Stata file)
- `Bursztyn_Coffman_JPE_tables.do` — full do-file producing all paper tables
- `Readme.pdf`
- `Bursztyn_Coffman_JPE_CDF_figures/`, `Bursztyn_Coffman_JPE_figure1/` — figure-only subfolders (not needed for Table 4)

### 4. Reproduction commands and environment-only edits
Wrote `run_pushbutton.do` that calls the *exact* Table 4 col 2 specification from the original do-file (line 82). Two environment-only edits relative to the archived `.do`:

1. **Syntax-only fix:** Line 1 of the original do-file is `clearset more off` — a typo concatenating `clear` and `set more off` (Stata returns an `unrecognized command: clearset` error and the do-file refuses to run). Replaced with the two intended commands. This is the kind of trivial syntax/environment fix permitted under the modification policy: it touches no analysis logic, only restores executability.
2. **Working-directory `cd`** to point at the local data file.

The regression command itself (`xi: reg WTP_dummy i.treatment higher_fee more_than beta child_beta delta12 child_delta12 age_p age_child male_p male_c i.marital_status logincome employed catholic protestant no_religion schooling_parent schooling_child number_of_children spouse_employed_married i.race_parent i.race_child if treatment!=3, cluster(school)`) is a verbatim copy of the do-file's line 82.

Run command: `stata-mp -b do run_pushbutton.do`. Runtime: <2 s. Exit code 0. Log: `run_pushbutton.log`.

Key output (from log lines 86, 130–142):
```
_Itreatmen~2 |  -.5818793   .0913819    -6.37   0.000    -.7854908   -.3782677
...
coef = -.58187926
se   = .09138188
t    = -6.3675564
p    = .00008165
N    = 156
```

The treatment indicator `_Itreatment_2` corresponds to the "text message" treatment (treatment==2), with baseline (treatment==1) as the omitted category — matching the paper's Table 4 col 2 specification.

### 5. Stochastic-method diagnostics
N/A — OLS with cluster-robust SEs is fully deterministic.

### 6. Classification
- **Coefficient:** Paper prints −0.5819 (4 decimals); reproduced −0.58187926 → rounds to −0.5819 → equals paper → **precise**.
- **Std. Err.:** Paper prints 0.091 (3 decimals); reproduced 0.09138188 → rounds to 0.091 → equals paper → **precise**. (The claim row encodes this as `orig_coef_se`, not `orig_stat_value`; treated here as a reported numeric sub-outcome.)
- **p-value:** Paper reports threshold "< 0.01" (***); reproduced p = 8.16e-5 ≤ 0.01 → **precise** (more significant than threshold is fine per the rubric's one-sided rule).
- **Sample size:** Paper prints 156; reproduced 156 → **precise**.
- **Effect size:** Not reported in the paper for this claim → **non-outcome**.

Overall verdict (combining): every reported sub-outcome is `precise` → **precise**.

## Diagnostics — author-bug analysis
Diagnostics: none — unpatched run reproduces the paper's value exactly. The only edit applied (fixing `clearset` → `clear` + `set more off`) is a Stata syntax/typo fix with no effect on analysis logic; it is required even to enter the do-file's `use` statement.

## Files in this folder
- `jaK4.pdf` — copy of paper PDF
- `jaK4.txt` — `pdftotext -layout` output
- `Readme.pdf` — author's readme accompanying the archive
- `Bursztyn_Coffman_JPE.dta` — author's analysis dataset (manually fetched)
- `Bursztyn_Coffman_JPE_tables.do` — author's original do-file (manually fetched, unmodified)
- `run_pushbutton.do` — wrapper running the exact Table 4 col 2 spec; contains the 2-character syntax fix and a `cd` to the local path
- `run_pushbutton.log` — Stata log of the unpatched run
- `data_zip_attempt_403.html` — preserved artifact of the prior failed direct-download attempt (no longer relevant; data delivered manually)
- `jaK4_summary_rows.csv` — one-row claim summary
- `REPRODUCTION_REPORT.md` — this report
