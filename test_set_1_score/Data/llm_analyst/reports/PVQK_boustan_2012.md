# Reproduction Report — Boustan (2012), School Desegregation and Urban Change

**Paper:** Boustan, Leah Platt. 2012. "School Desegregation and Urban Change: Evidence from City Boundaries." *American Economic Journal: Applied Economics* 4(1): 85-108. DOI: 10.1257/app.4.1.85
**Paper IDs:** paper_id=PVQK; claims=[PVQK_single-trace]
**Reproduction type:** Push Button (env-only edits: paths, log-file name, BOM strip)
**Headline verdict (unpatched):** approximate
**Verdict if patched:** N/A — see Diagnostics

## Headline (LEAD WITH DEVIATIONS — flagged per CLAUDE.md statistical-deviation rules)

The archived data and code (openICPSR project 113813) were obtained via manual fetch and the analysis ran cleanly as Push Button. The Table 5 row-3 col-3 specification (`areg lnavval yesbig1980 big1980 A* if tierno<2 [aw=house_ownocc], absorb(extra) cluster(jurcode)`) reproduces a coefficient of **-0.0595** (SE 0.0278, N=4352), against the paper's printed **-0.058** (SE 0.028, N=4386).

**Deviations from the paper requiring explicit flag (per CLAUDE.md):**

1. **MODERATE — coefficient.** Paper: -0.058 (3 dp). Reproduced: -0.0595169, which rounds to **-0.060** at 3 dp. Absolute gap = 0.0015 (2.6% of |orig|); within the 15% approximate band but outside paper-precision rounding. Sub-verdict: **approximate** (not precise).
2. **MODERATE — sample size.** Paper text (p. 33): "Regressions in row 3 contain **4386** observations, 2087 blocks from 1970 and 2299 blocks from 1980." Reproduced N = **4352** (a -34/-0.78% gap). Within the 15% approximate band but not the same. Sub-verdict: **approximate**.
3. **PRECISE — SE.** Paper 0.028, reproduced 0.0278 → rounds to 0.028. Sub-verdict: **precise**.
4. **PRECISE — p-value (threshold p<.05).** Reproduced p = 0.034 ≤ 0.05. Sub-verdict: **precise**.

Critically, my reproduced values **exactly match the author's own archived `.log` file** (`deseg_results_aej.log` shipped in the openICPSR archive — line 1847): -0.0595169 / 0.0278213 / N=4352. The deviation is therefore between the **archived author code+data** and the **published paper text** (i.e. an authorship/typesetting discrepancy or a silent revision between the working draft and the journal version), **not** between the archive and my reproduction. The PDF text dump even still bears a "Boustan / September 2010" working-draft footer on Table 5's page (PVQK.txt line 1649), which suggests the archived materials and the typeset paper drifted between draft and final.

Overall verdict (unpatched): **approximate** (at least one approximate sub-outcome, no `not`s).

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| PVQK_single-trace | Coefficient (Tbl 5, row 3, col 3) | -0.058 | -0.058 | **-0.0595169** (rounds to -0.060) | precise={-0.058}; approx [-0.0667, -0.0493] | **approximate** |
| PVQK_single-trace | SE (clustered, school district) | 0.028 | 0.028 | **0.0278213** (rounds to 0.028) | precise={0.028}; approx [0.0238, 0.0322] | **precise** |
| PVQK_single-trace | p-value (threshold) | < .05 | < .05 | **0.034** | precise = p≤.05; approx (.05, .10] | **precise** |
| PVQK_single-trace | Sample size | 4386 | 4386 | **4352** | precise={4386}; approx [3728, 5044] | **approximate** |

Extracted values match the paper's Table 5 row 3 col 3 exactly (PVQK.txt lines 1626-1641).

## What I did

1. **Set-up.** Reproduction directory `independent_reproductions/PVQK_boustan_2012/` already existed (with the published PDF and a prior "not attemptable" report from when the openICPSR archive was Cloudflare-walled). The RA delivered openICPSR project 113813 to `manually downloaded data/PVQK/`.
2. **Extraction check.** PDF text dump (PVQK.txt lines 1614-1643) confirms paper Table 5 row 3 col 3: coef=**-0.058**, SE=**0.028** (clustered by school district), N=**4386**, significance asterisk pattern consistent with **p<.05**. Extracted values in `paper_claims/PVQK.json` match the paper exactly.
3. **Data/code source.** Manually downloaded openICPSR project 113813 v1, hosted under `manually downloaded data/PVQK/`. Two `.dta` files needed for Table 5: `data/1980/blockdata_1980.dta` and `data/1970/Main/block_1970_withhs_aej.dta`, both copied into the reproduction directory. The unified do-file is `data/deseg_results_aej.do` (line endings were CR-only, converted to LF for the OS X / Stata 16 build to read each command).
4. **Reproduction commands.**
   - Converted `deseg_results_aej.do` to LF line endings (`tr '\r' '\n'`).
   - Edited two `use` paths (`~/Tract_block/1980/blockdata_1980.dta` → local `blockdata_1980.dta`; `~/Tract_block/OCR_school/Matt/block_1970_withhs_aej.dta` → local `block_1970_withhs_aej.dta`) and the log filename (`deseg_results_aej.log` → `run_pushbutton.log`). Stripped a UTF-8 BOM from the first line. Saved as `run_pushbutton.do`.
   - Ran `stata-mp -b do run_pushbutton.do`. Runtime: ~5 minutes. Log saved to `run_pushbutton.log`.
   - The do-file errors out at the very end (Table 10) on a `merge using ~/Tract_block/OCR_district/ELSEGIS_1970.dta` because that file is in a different sub-directory of the openICPSR archive and we did not copy it (Table 10 is unrelated to this claim). All Tables 1-9 ran to completion; Table 5 row 3 col 3 is at log lines 1842-1938.
   - These edits are environment-only (paths, log filename, line endings, BOM); none touch analysis logic.
5. **Stochastic-method diagnostics.** N/A — `areg` with cluster-robust SEs is deterministic.
6. **Classification.** See comparison table. Bounds were computed as `[|orig|×0.85, |orig|×1.15]` for coef/SE/N; precise = paper-precision-rounded equality. Coef rounds to -0.060 vs paper's -0.058 → not precise but within 2.6% → **approximate**. N differs by 34 obs (-0.78%) → not precise but well within 15% → **approximate**. SE and p-value both **precise**. Overall (unpatched): **approximate**.

## Diagnostics — author-bug analysis

**Suspected discrepancy:** the **archived openICPSR materials** (data + code) reproduce **N=4352**, **coef=-0.0595169**, **SE=0.0278213** for the regression that the paper's Table 5 row 3 col 3 describes. The paper prints **N=4386**, **coef=-0.058**, **SE=0.028**.

**Cross-check evidence (high confidence this is an archive-vs-paper drift, not my error):** my unpatched reproduction matches the **author's own archived log** (`data/deseg_results_aej.log` shipped inside openICPSR project 113813) byte-for-byte for the relevant regression (their line 1847 / my line 1938: `yesbig1980 | -.0595169 .0278213 -2.14 0.034`). So the archived code-on-archived-data combination produces the reproduced numbers, not the paper's printed numbers. Both author-archived and my fresh re-runs report N=4352.

**Reasoning.** Three plausible explanations, all consistent with the evidence:
- (a) Between the September-2010 working draft (whose footer still appears on Table 5's page in the published PDF — see PVQK.txt line 1649) and the final 2012 AEJ:Applied typesetting, the author re-ran the regression on a slightly larger sample (e.g. an upstream merge or filter change that added ~34 observations) but the openICPSR archive carries the older data/code combination.
- (b) Sample-construction adjustment: the do-file's filter chain (`drop if statefip==13`, `drop if borderno==44`, `drop if flag_lowpop_any==1`, "Drop borders if only one side has data in a given year", "Drop borders only present in 1970 or 1980") may have been written more conservatively in the archived code than in the version that produced the paper, dropping 34 extra blocks.
- (c) Typesetting: the printed N=4386 may itself be a typo (less likely, given the precise breakdown "2087 blocks from 1970 and 2299 blocks from 1980" sums exactly to 4386 — that is internally self-consistent paper-text, suggesting it really was the paper-time N).

**Patched run:** I did not attempt to chase the missing 34 observations through the data-prep chain. Doing so would require speculative edits to the upstream filters (none of which is "obviously wrong"), so any patch would be inferring author intent — not allowed for the headline. No patched verdict is reported.

**Confidence:** high that this is an author-archive-vs-paper drift, not a reproduction error: my numbers match the author's archived log exactly; the deviation is a fixed property of the archived materials.

## Files in this folder

- `PVQK.pdf` — published version-of-record PDF
- `PVQK.txt` — `pdftotext -layout` extraction of the PDF
- `blockdata_1980.dta` — 1980 block-level data (copied from openICPSR `data/1980/`)
- `block_1970_withhs_aej.dta` — 1970 block-level data (copied from openICPSR `data/1970/Main/`)
- `deseg_results_aej_orig.do` — author's unmodified do-file (LF line-endings only)
- `run_pushbutton.do` — author do-file with three environment-only edits (paths × 2, log filename, BOM stripped)
- `run_pushbutton.log` — full Stata 16 batch log of the unpatched run; Table 5 row 3 col 3 results at lines 1842-1938
- `REPRODUCTION_REPORT.md` — this report
- `PVQK_summary_rows.csv` — one summary row for the single claim
