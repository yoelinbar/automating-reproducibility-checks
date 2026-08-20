# Reproduction Report — Sliwka & Werner (2017), Wage Increases And The Dynamics Of Reciprocity

**Paper:** Sliwka, D., & Werner, P. (2017). "Wage Increases and the Dynamics of Reciprocity." *Journal of Labor Economics*, 35(2), 299-344. DOI: https://doi.org/10.1086/689189
**Paper IDs:** paper_id=VDJV; claims = VDJV_g45oy6, VDJV_m5yd7w, VDJV_my1z9y, VDJV_m8o6zo, VDJV_bon6z7, VDJV_bnoz9x, VDJV_b295y6
**Reproduction type:** Push Button (with environment-only `ssc install` calls; no logic edits)
**Headline verdict (unpatched):** precise

## Headline

With the JOLE supplement now in hand (delivered manually as `manually downloaded data/VDJV/`), the author's `Analyses_Data_Wage_Increases_JOLE.do` runs cleanly on `Data_Wage_Increases_JOLE.dta` and reproduces Table 2, Table 3, and all related figure-driving regressions exactly. The numerically-extracted claim VDJV_b295y6 (Table 3 col 1: T_Continuous coef = 0.148, SE = 0.070, p < .05, N = 211) reproduces to all printed digits (reproduction returns 0.148415 / 0.0696364 / p = 0.034 / N = 211). The six narrative bushels keyed to Figure 2 / Table 2 also reproduce: every period-by-treatment coefficient and significance star reported in the paper for the T_Sudden, T_Successive, and T_Continuous panels matches the rerun (Table 2 cols 1-3). No deviations of any magnitude observed.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| VDJV_g45oy6 | Figure 2 / Table 2 col(1), T_Sudden period 5 (TrPer5) ≈ "+23% vs Baseline" | TrPer5 = 0.227** (Table 2 col 1, p. 317) | NaN (narrative) | TrPer5 = 0.227, SE = 0.107, p = 0.036 (** = p<.05); exp(0.227)-1 = 25.5%, ≈ 23% on log-scale | n/a (qualitative) | precise (sign, sig, magnitude all match) |
| VDJV_m5yd7w | Figure 2 / Table 2 col(2), T_Successive: weakly+ sig in 3/4 increase periods (4,6,7; exception period 3) | TrPer3=0.079 ns, TrPer4=0.150*, TrPer6=0.157*, TrPer7=0.306*** (Table 2 col 2, p. 317) | NaN | TrPer3=0.079 ns, TrPer4=0.150*, TrPer6=0.157*, TrPer7=0.306*** | n/a | precise |
| VDJV_my1z9y | Figure 2 / Table 2 col(3), T_Continuous: sig in 4/8 periods, never lower | TrPer3=0.149**, TrPer5=0.220**, TrPer6=0.215***, TrPer7=0.218**; rest ns and never sig negative (Table 2 col 3, p. 317) | NaN | Identical: TrPer3=0.149**, TrPer5=0.220**, TrPer6=0.215***, TrPer7=0.218**; TrPer1,2 small negative but ns | n/a | precise |
| VDJV_m8o6zo | T_Sudden wear-off: period 6 still higher but ns; eventual return to Baseline | TrPer6=0.140 ns; TrPer7=0.109 ns; TrPer8=-0.012 ns (Table 2 col 1, p. 317) | NaN | TrPer6=0.140 ns, TrPer7=0.109 ns, TrPer8=-0.012 ns | n/a | precise |
| VDJV_bon6z7 | T_Successive (col 2) periods 2,5,8 dip relative to increase periods | TrPer2=-0.217*, TrPer5=0.095 ns, TrPer8=0.140 ns vs increase periods (4,6,7) which are larger and significant (Table 2 col 2) | NaN | Identical | n/a | precise |
| VDJV_bnoz9x | T_Continuous (col 3) period 3 already sig by ~15% | TrPer3 = 0.149** (Table 2 col 3, p. 317); exp(0.149)-1 = 16.1% ≈ "about 15%" | NaN | TrPer3 = 0.149, SE = 0.075, p ≈ 0.046 (**) | n/a | precise |
| VDJV_b295y6 (sample) | N (Table 3 col 1) | 211 | 211 | 211 | [180, 243] | precise |
| VDJV_b295y6 (coef) | T_Continuous coef (Table 3 col 1) | 0.148 | 0.148 | 0.148415 → rounds to 0.148 | [0.1258, 0.1702] | precise |
| VDJV_b295y6 (SE) | T_Continuous SE | 0.070 | 0.07 | 0.0696364 → rounds to 0.070 | [0.0595, 0.0805] | precise |
| VDJV_b295y6 (p) | p threshold "p<.05" (** in table) | p<.05 | p=0.05 (less-than) | p = 0.034 | reproduced p ≤ .05 = precise | precise |

All ratios reflect the SCORE rubric's paper-precision rounding rule.

## What I did

1. **Set-up.** Working dir `independent_reproductions/VDJV_sliwka_2017/`. PDF and pdftotext output were already present from the prior pass. Copied the manually-downloaded supplement files (`Analyses_Data_Wage_Increases_JOLE.do`, `Analyses_Survey_JOLE.do`, `Data_Wage_Increases_JOLE.dta`) into the reproduction directory.
2. **Extraction check.** Re-read the published article. Table 2 (p. 317) and Table 3 (p. 321) match the do-file outputs exactly. The numeric extraction in `paper_claims/VDJV.json` (claim VDJV_b295y6: coef=.148, SE=.070, p<.05, N=211) matches Table 3 col (1) verbatim. The other six claims have NaN for `orig_*` numeric fields — they are narrative bushels keyed to Figure 2 description (pp. 317-318) and the period-by-period interaction terms in Table 2 (p. 317).
3. **Data/code source.** Manually delivered by RA at `manually downloaded data/VDJV/` (9 files; the JOLE / UChicago Press supplement). Copied to reproduction dir.
4. **Reproduction commands.**

   ```
   cd <repro_dir>
   /usr/local/bin/stata-mp -b do run_pushbutton.do
   ```

   `run_pushbutton.do` performs three environment-only operations and then `do`s the unedited author script:
   - `cd` to the reproduction directory.
   - `capture ssc install outreg2 / parmest / eclplot / sencode` — the author's script depends on these user packages for output export and figure construction. They are environment, not logic. (`capture` ensures any "already installed" returns are non-fatal.)
   - `do Analyses_Data_Wage_Increases_JOLE.do` — author's archived do-file, byte-for-byte unchanged.

   Runtime ~5 seconds. No errors. Generated `Table2.rtf/.txt`, `Table3.rtf/.txt`, `Table4-6/A2-A7.rtf/.txt`, plus the six Figure-2 sub-graphs (`Wage{1,2,3}.gph`, `Tr{1,2,3}.gph`).

5. **Stochastic-method diagnostics.** N/A — the analysis is deterministic OLS / xtreg with cluster-robust SEs.
6. **Classification.** All seven claims reproduce precisely under the SCORE rubric, with bounds applied where the claim has eligible numeric content (VDJV_b295y6 only). The six narrative bushels resolve as `non-outcome` for any quantitative sub-outcome that the paper only carries through Figure 2 visuals or the qualitative period-by-period text — but the underlying period-by-treatment regressions (which are the source the paper cites) reproduce exactly, so each narrative claim is supported by precisely-matching numerics.

## Diagnostics — author-bug analysis

Diagnostics: none — unpatched run reproduces; no logic bug suspected. The only edits made were `cd`, four `ssc install` calls under `capture`, and `set more off` — all explicitly allowed under Push Button per the modification policy.

## Files in this folder

Unpatched-run artifacts (this run):
- `run_pushbutton.do` — wrapper (env-only edits; cd + ssc install + invokes author do-file).
- `run_pushbutton.log` — full Stata batch log (117 KB).
- `logAnalyses_Data_Wage_Increases.log` — author's `log using` output (116 KB).
- `Table2.rtf` / `Table2.txt` — Table 2 (Treatment Effects per Period); reproduces paper p. 317 exactly.
- `Table3.rtf` / `Table3.txt` — Table 3 (Overall Treatment Effect); reproduces paper p. 321 exactly.
- `Table4.rtf` / `Table4.txt`, `Table5.*`, `Table6.*`, `TableA2-A7.*` — additional tables produced by the same do-file (not in audit's claim set).
- `Tr{1,2,3}.gph`, `Wage{1,2,3}.gph` — Figure 2 sub-panels.

Author code/data (manually downloaded):
- `Analyses_Data_Wage_Increases_JOLE.do` — author's primary analysis script (unedited).
- `Analyses_Survey_JOLE.do` — author's survey-analysis script (not invoked; not needed for the 7 claims).
- `Data_Wage_Increases_JOLE.dta` — author's data file.

Documentation:
- `VDJV.pdf`, `VDJV.txt` — copy of the paper and pdftotext output.
- `REPRODUCTION_REPORT.md` — this report.
- `VDJV_summary_rows.csv` — one row per claim (all `precise`).

No diagnostic-patched files (none needed).
