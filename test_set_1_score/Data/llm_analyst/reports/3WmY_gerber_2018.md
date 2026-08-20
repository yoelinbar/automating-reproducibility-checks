# Reproduction Report — Gerber (2018), Deliberative Abilities and Influence in EuroPolis

**Paper:** Gerber, Marlène; Bächtiger, André; Shikano, Susumu; Reber, Stefan; Rohr, Samuel. "Deliberative Abilities and Influence in a Transnational Deliberative Poll (Europolis)." *British Journal of Political Science*, 48(4), 1093–1118 (2018). DOI: 10.1017/S0007123416000144.
**Paper IDs:** paper_id=3WmY; claims=`3WmY_single-trace`
**Reproduction type:** Push Button (one cosmetic file-extension rename: `.tab` → `.dta`; the underlying bytes are an unchanged Stata `.dta` file mis-extensioned by Dataverse — see "Reproduction" §4 below)
**Headline verdict (unpatched):** precise

## Headline
The archived Stata code reproduces every reported sub-outcome of Table 2's Model 2b ("Absolute opinion change (immigration)"), the focal model for this claim, to the paper's printed precision: coefficient on `DQ_jlev` (deliberative quality – level of justification) = 0.13005 → rounds to 0.130; SE = 0.0662 → rounds to 0.066; two-sided z-test p = 0.0495 (< 0.05 threshold); N individuals = 174; N groups = 13. No deviations to flag.

## Comparison table
| Claim | Sub-outcome | Paper (Table 2, Model 2b, p. 1112) | Extracted (CSV) | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| 3WmY_single-trace | Coefficient (DQ_jlev) | 0.130 | 0.13 | 0.13005 → 0.130 | precise = 0.130; approx ∈ [0.1105, 0.1495] | precise |
| 3WmY_single-trace | Effect size (= coef, SER method) | 0.130 | 0.13 | 0.13005 → 0.130 | precise = 0.130; approx ∈ [0.1105, 0.1495] | precise |
| 3WmY_single-trace | Standard error | 0.066 | 0.066 | 0.0662 → 0.066 | n/a (SE is not in the SCORE rubric; reported for context) | precise (informational) |
| 3WmY_single-trace | p-value (threshold "< 0.05") | p < 0.05 | 0.05 (less-than) | 0.04950 | precise: p ≤ 0.05; approx (0.05, 0.10]; not > 0.10 | precise |
| 3WmY_single-trace | Sample size (N individuals) | 174 | 174 | 174 | precise = 174; approx ∈ [148, 200] | precise |
| 3WmY_single-trace | Test statistic | not separately reported in paper | NaN | (z = 1.96 by computation) | n/a | non-outcome |

Overall (unpatched): all reported sub-outcomes precise → **precise.**

## What I did

### 1. Set-up
Created `independent_reproductions/3WmY_gerber_2018/`. Copied `papers/3WmY.pdf` in, generated `3WmY.txt` via `pdftotext -layout`.

### 2. Extraction check
The claim refers to Table 2 ("Determinants of Opinion Change on Immigration Position (Replicating Sanders)"), right-hand column "Absolute opinion change (immigration)" — labelled "Model 2b" in the in-text discussion (p. 1112 of the published version of record; PDF text line 1252). Paper-printed values for the focal predictor "Deliberative quality – level of justification":

- Coefficient: 0.130 (with `*` significance flag)
- Std. error: 0.066 (in parentheses below)
- N individuals = 174; N groups = 13
- Significance threshold: `*p < 0.05` (per the table footnote)

These match the extracted `orig_*` values to all reported digits (extracted: coef 0.13, SE 0.066, p 0.05 less-than, N 174). Extraction is correct.

### 3. Data/code source
Located via Harvard Dataverse search (`q=Gerber+Europolis+deliberative`):
**Replication Data for: "Deliberative Abilities and Deliberative Influence in a Transnational Deliberative Poll (EuroPolis)"** — doi:10.7910/DVN/XQTCHB.

Files downloaded (all 14):
- Stata do-files: `Replicate_Models_in_Table_1_and_2.do`, `Create_variables_from_EUROPOLIS_DATABASE.do`, `Create_variables_from_DQI_speechact_dataset.do`
- R scripts: `BJPS_DQI_IR_Bugs.R`, `BJPS_DQI_IR_Plots.R`
- Datasets (named `*.tab` on Dataverse but in fact Stata 13 `.dta` binaries — `file` reports "data" and the leading bytes show Stata's signature with variable names like `UniqueID`, `Apr 2016 09:27` timestamp, etc.): `SANDERS_Replication.tab` (the Table-2 dataset), `DQI_IR_Idealpoints_Habermas.tab` (Table-1 dataset), and several auxiliary Habermas/IR ideal-point files.
- `Codebook_Gerber_et_al.pdf`

### 4. Reproduction
The do-file `Replicate_Models_in_Table_1_and_2.do` includes the exact command for Table 2 Model 2:

```
xtmixed change_w3w2_log female age education workingclass catholic protestant religios leftrigh leftrigh2 ///
        v3q65_2 v3q65_3 v3q65_4 v3q65_5 know_change pressure_above_w2_pro pressure_below_w2_pro ///
        leftparty2 rightparty2 DQ_jlev || small_gr:, reml
```

with the comment `* DQ_jlev = group level variable (justification rationality)`.

**Environment-only edits made:**
- Renamed `SANDERS_Replication.tab` → `SANDERS_Replication.dta` (and the same for `DQI_IR_Idealpoints_Habermas.tab`). The files are bit-for-bit unchanged; only the file name extension was altered so Stata's `use` would accept them. Dataverse's "Tab" label is misleading: the binary content is Stata 13 `.dta` (verified with `file` and a hex dump showing Stata signature bytes and variable names embedded). No bytes were modified. This is a path/file-naming environment edit consistent with Push Button per the modification policy (analogous to fixing a working-directory path).
- Wrapped the focal regression command in a thin driver script `run_pushbutton.do` that `cd`s into the reproduction directory and `use`s `SANDERS_Replication.dta`. The regression specification is verbatim from the archive.

Command run:
```
/usr/local/bin/stata-mp -b do run_pushbutton.do
```
Runtime ~3 seconds. Output saved to `run_pushbutton.log`.

Reproduced output for the focal coefficient (Model 2b, dependent variable `change_w3w2_log`):
```
     DQ_jlev |     .13005   .0662074     1.96   0.049     .0002858    .2598142
```
plus `Number of obs = 174`, `Number of groups = 13`, `Std. Group Level sd = 9.14e-13` (paper: 0.000), `sd(Residual) = 0.2114` (paper: 0.211 — matches at printed precision).

For completeness I also reran Table 2 Model 1 (`w3pro` as dependent variable). Reproduced `DQ_jlev` coefficient there: 0.00845 → rounds to 0.008 (paper: 0.008); SE 0.1782 → rounds to 0.178 (paper: 0.178). Model 1 reproduces precisely too — useful sanity check that the dataset/spec are right.

### 5. Stochastic-method diagnostics
None. REML is deterministic; no seed handling required.

### 6. Classification
Bounds and verdicts as in the table above. The threshold p-value rule (p < 0.05): reproduced 0.04950 ≤ 0.05 → precise (more-significant-than-threshold reproductions also count as precise per the rubric, but here the reproduced p actually falls inside the threshold). Coefficient and effect size: reproduced 0.130 (rounded to paper precision) equals paper's 0.130 → precise. Sample size: identical → precise. Standard error is reported for transparency; SCORE rubric does not include SE as a sub-outcome (effect size is captured via `ser_method`/coefficient).

Overall verdict (unpatched): **precise.**

## Diagnostics — author-bug analysis
Diagnostics: none — unpatched run reproduces every reported sub-outcome to the paper's printed precision. No logic bug suspected. The single non-trivial usability friction is Dataverse's habit of relabeling Stata `.dta` files as `.tab`; this is a repository-side artifact, not an author code bug.

## Files in this folder
- `3WmY.pdf` — paper PDF
- `3WmY.txt` — `pdftotext -layout` output of paper
- `Codebook_Gerber_et_al.pdf` — codebook
- `Replicate_Models_in_Table_1_and_2.do` — author's regression script (verbatim)
- `Create_variables_from_EUROPOLIS_DATABASE.do`, `Create_variables_from_DQI_speechact_dataset.do` — author's variable-construction scripts
- `BJPS_DQI_IR_Bugs.R`, `BJPS_DQI_IR_Plots.R` — author's R scripts (Bayesian DQI ideal-point estimation, used for Tables in the appendix; not needed for Table 2)
- Author datasets (renamed from `.tab` to `.dta` for Stata to read; bytes unchanged):
  - `SANDERS_Replication.dta` (= `SANDERS_Replication.tab`) — focal Table 2 dataset
  - `DQI_IR_Idealpoints_Habermas.dta` (= `DQI_IR_Idealpoints_Habermas.tab`) — Table 1 dataset
- Other downloaded `.tab` files left as-is (not needed for the focal claim)
- `run_pushbutton.do` — driver that calls the author's specification on `SANDERS_Replication.dta`
- `run_pushbutton.log` — Stata batch log of the unpatched reproduction
