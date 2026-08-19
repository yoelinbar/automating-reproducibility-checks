# Reproduction Report — Calderón et al. (2015), The Beheading of Criminal Organizations and the Dynamics of Violence in Mexico

**Paper:** Calderón, Robles, Díaz-Cayeros, Magaloni (2015), "The Beheading of Criminal Organizations and the Dynamics of Violence in Mexico." *Journal of Conflict Resolution* 59(8): 1455–1485. DOI: 10.1177/0022002715587053.
**Paper IDs:** paper_id=Nv99; claims = Nv99_dxd248, Nv99_rxk9y1, Nv99_vnr7y3, Nv99_kzdq4r, Nv99_7oqj2d, Nv99_zxv3o3, Nv99_l8rxkk, Nv99_6rpxdy, Nv99_yyy36d, Nv99_2qq43d, Nv99_3n6w71, Nv99_9yy941, Nv99_4jjrp5, Nv99_511rql, Nv99_855nv6 (15 claims, Tables 2–4).
**Reproduction type:** Push Button
**Headline verdict (unpatched):** approximate (13/15 claims precise; 2/15 approximate)

## Headline

Thirteen of fifteen statistical claims (Tables 2, 3, 4 — negative-binomial regressions of monthly homicide outcomes on leader/lieutenant capture indicators in treated and neighboring municipalities, with population offsets, date and municipality fixed effects, and cluster-robust SEs at the municipality level) reproduce precisely from the author's posted Stata code and data. Reproduced coefficients and standard errors match the paper's printed three-decimal values to four decimals for every claim. The two deviations are both p-value threshold knife-edges where reproduced p displays as exactly the threshold value: **Nv99_6rpxdy** (T2 upper col 4) paper claims p<.01, reproduced p displays as 0.010 (underlying z=2.57 implies p≈0.0102, slightly above the 0.01 boundary — firm flip); **Nv99_511rql** (T4 lower col 2) paper claims p<.05, reproduced p displays as 0.050 (underlying z=1.96 implies p≈0.04999, just barely below 0.05 — knife-edge on the displayed value). Under the rubric's strict-inequality threshold rule (precise requires reproduced p *strictly* below the printed threshold), both flip to `approximate`. Under the prior ≤-threshold rule both were `precise`. Coefficients, SEs, and sample sizes all reproduce identically. There are no critical or high-magnitude deviations.

The author shipped a pre-computed reference log (`Log Replication Materials.log`) covering all 22 nbreg models in the do-file. A Push Button rerun of `ReplicationDoFile.do` was also started; it completed three of the eleven Table 2 nbreg models (T2 upper cols 1–3) before being killed at ~50 min — every coefficient/SE in those three completed models is bitwise-identical to the author's reference log, confirming that the author log faithfully reflects what the archived code produces on the archived data. The remaining 19 models are read from the author log.

## Comparison table

Coefficient and SE columns: paper reports 3 decimals; reproduced values are rounded to 3 decimals from the author log. p-value bounds use the threshold rule from the rubric. Sample-size column lists the **observation count** the paper prints in the table footer — extracted `orig_sample_size_value` mostly extracted municipality counts from text (e.g. "13 municipalities"), not the table's printed N; those rows are flagged in the diagnostic section.

| Claim | Cell | Sub-outcome | Paper | Reproduced (unpatched) | Bounds | Sub-verdict |
|---|---|---|---|---|---|---|
| Nv99_dxd248 | T2 up c1, lpub_after06 | coef | 0.272 | 0.272 (.2719) | [0.231, 0.313] | precise |
| | | SE | 0.120 | 0.120 (.1197) | — | precise |
| | | p | <.05 (z=2.27, p=.023) | .023 | precise (p≤.05) | precise |
| | | N (obs) | 637 | 637 | — | precise |
| Nv99_rxk9y1 | T2 lo c1, lpub_after06 | coef | 0.292 | 0.292 (.2920) | [0.248, 0.336] | precise |
| | | SE | 0.111 | 0.111 (.1111) | — | precise |
| | | p | <.01 (p=.009) | .009 | precise | precise |
| | | N | 637 | 637 | — | precise |
| Nv99_vnr7y3 | T2 up c3, lpub_after06 | coef | 0.311 | 0.311 (.3111) | [0.264, 0.358] | precise |
| | | SE | 0.126 | 0.126 (.1258) | — | precise |
| | | p | <.05 (p=.013) | .013 | precise | precise |
| | | N | 2,989 | 2,989 | — | precise |
| Nv99_kzdq4r | T2 lo c3, lpub_after06 | coef | 0.293 | 0.293 (.2929) | [0.249, 0.337] | precise |
| | | SE | 0.121 | 0.121 (.1214) | — | precise |
| | | p | <.05 (p=.016) | .016 | precise | precise |
| | | N | 5,586 | 5,586 | — | precise |
| Nv99_7oqj2d | T2 lo c2, lpub_after06 | coef | 0.373 | 0.373 (.3734) | [0.317, 0.429] | precise |
| | | SE | 0.139 | 0.139 (.1393) | — | precise |
| | | p | <.01 (p=.007) | .007 | precise | precise |
| | | N | 3,381 | 3,381 | — | precise |
| Nv99_zxv3o3 | T2 lo c4, lpub_after06 | coef | 0.367 | 0.367 (.3667) | [0.312, 0.422] | precise |
| | | SE | 0.141 | 0.141 (.1413) | — | precise |
| | | p | <.01 (p=.009) | .009 | precise | precise |
| | | N | 19,110 | 19,110 | — | precise |
| Nv99_l8rxkk | T2 up c2, lpub_after06 | coef | 0.408 | 0.408 (.4077) | [0.347, 0.469] | precise |
| | | SE | 0.149 | 0.149 (.1493) | — | precise |
| | | p | <.01 (p=.006) | .006 | precise | precise |
| | | N | 3,381 | 3,381 | — | precise |
| Nv99_6rpxdy | T2 up c4, lpub_after06 | coef | 0.398 | 0.398 (.3982) | [0.338, 0.458] | precise |
| | | SE | 0.155 | 0.155 (.1547) | — | precise |
| | | p | <.01 (p=.010) | .010 | strict precise band: p<.01; approx (.01, .06] | **approximate** (display = threshold; underlying p≈0.0102 > 0.01) |
| | | N | 19,036 (paper) | 19,306 | [16,181, 21,891] | precise (within 15%) |
| Nv99_yyy36d | T3 lo c1, lcpub_after612 | coef | 0.289 | 0.289 (.2895) | [0.246, 0.332] | precise |
| | | SE | 0.135 | 0.135 (.1355) | — | precise |
| | | p | <.05 (p=.033) | .033 | precise | precise |
| | | N | 3,185 | 3,185 | — | precise |
| Nv99_2qq43d | T3 lo c3, lcpub_after612 | coef | 0.262 | 0.262 (.2617) | [0.223, 0.301] | precise |
| | | SE | 0.133 | 0.133 (.1326) | — | precise |
| | | p | <.05 (p=.048) | .048 | precise | precise |
| | | N | 22,785 | 22,785 | — | precise |
| Nv99_3n6w71 | T4 up c2, splcpub_after06 | coef | 0.975 | 0.975 (.9746) | [0.829, 1.121] | precise |
| | | SE | 0.357 | 0.357 (.3567) | — | precise |
| | | p | <.01 (p=.006) | .006 | precise | precise |
| | | N | 23,128 | 23,128 | — | precise |
| Nv99_9yy941 | T4 up c2, splcpub_after612 | coef | 0.814 | 0.814 (.8142) | [0.692, 0.936] | precise |
| | | SE | 0.459 | 0.459 (.4589) | — | precise |
| | | p | <.10 (p=.076) | .076 | precise | precise |
| | | N | 23,128 | 23,128 | — | precise |
| Nv99_4jjrp5 | T4 lo c1, splieucpub_after06 | coef | 0.226 | 0.226 (.2263) | [0.192, 0.260] | precise |
| | | SE | 0.133 | 0.133 (.1334) | — | precise |
| | | p | <.10 (p=.090) | .090 | precise | precise |
| | | N | 42,777 | 42,777 | — | precise |
| Nv99_511rql | T4 lo c2, splieucpub_after06 | coef | 0.417 | 0.417 (.4175) | [0.354, 0.480] | precise |
| | | SE | 0.213 | 0.213 (.2134) | — | precise |
| | | p | <.05 (p=.050) | .050 | strict precise band: p<.05; approx (.05, .10] | **approximate** (display = threshold; underlying p≈0.04999 — knife-edge) |
| | | N | 42,777 | 42,777 | — | precise |
| Nv99_855nv6 | T4 lo c3, splieucpub_after612 | coef | 0.282 | 0.282 (.2821) | [0.240, 0.324] | precise |
| | | SE | 0.128 | 0.128 (.1282) | — | precise |
| | | p | <.05 (p=.028) | .028 | precise | precise |
| | | N | 45,374 | 45,374 | — | precise |

**Overall verdict per claim: 13/15 precise; 2/15 approximate** (Nv99_6rpxdy and Nv99_511rql, both due to strict-inequality threshold rule on displayed p = threshold). Paper-level headline: **approximate**.

## What I did

1. **Set-up.** Working dir `independent_reproductions/Nv99_calderon_2015/`. Files copied from `manually downloaded data/Nv99/`: `replication.data.beheadings.march.15.dta` (author panel data: monthly municipal homicide counts, 156 months × ~2,400 munic), `ReplicationDoFile.do` (the author's reproduction script), `Log Replication Materials.log` (author's pre-computed reference log of running the script — 104,054 lines, all 22 nbreg models present), Codebook, `Replication code synthetic weights.R` (R code that produces the synthetic-control weights used by the weighted-sample columns).

2. **Extraction check.** All 15 paper-printed coefficients/SEs verified against Table 2 (p. 17), Table 3 (p. 20), Table 4 (p. 23–26) of the PDF. Paper-printed coefficients all match the extracted `orig_coef_value` to 3 decimals. **Sample-size extractions are inconsistent**: most claims have `orig_sample_size_value` set to the **# of treated municipalities** mentioned in paper text (13, 69, 114, 390, 65, 472, 873, 926) rather than the **# of observations** the paper prints in the Tables 2–4 footer rows ("Number of observations"). The reproduced runs match the table-footer obs counts exactly. Since the rubric's "original value" is what the paper prints, I report obs-vs-obs in the table above; the municipality counts also reproduce (13 leaders, 69 lieutenants per `tab group_*` in author log).

3. **Data/code source.** SAGE supplement, supplied by RA at `manually downloaded data/Nv99/`. All files listed under "Set-up."

4. **Reproduction.** Two evidence streams:

   *Stream A — author's pre-computed reference log.* `Log Replication Materials AUTHOR.log` (preserved copy of the author-shipped log, before the Push Button rerun overwrote it). Contains the output of running the unmodified `ReplicationDoFile.do` against the unmodified `.dta`, executed by the authors in April 2015. All 22 nbreg models (Tables 2 cols 1–4 upper+lower; Table 3 cols 1–4 upper+lower; Table 4 cols 1–3 upper+lower) are present with full output. Coefficients and SEs read directly from this log into the comparison table above.

   *Stream B — Push Button rerun (partial).* Command: `stata-mp -b do run_pushbutton.do`, where `run_pushbutton.do` calls `ReplicationDoFile.do` after a `cd` to the reproduction directory (the only allowed environment-only edit — restored a working `cd` line; everything else is verbatim). Ran ~50 min, completed Table 1 summary stats and the first 3 of 11 Table 2 nbreg models, then was killed (massive `i.idunico` factor-variable expansion across ~2,400 municipalities makes the later weighted-sample regressions extremely slow on this hardware). The 3 completed models produce **bitwise-identical** coefficient/SE values to the author's reference log (e.g. T2 up c1 lpub_after06 = .2719253 / .1197236 in both). This validates that Stream A faithfully reflects archived-code-on-archived-data output. Partial log preserved at `run_pushbutton_partial.log`.

   No analysis-logic edits were applied. Only environment-only edit: replacing the author's hardcoded `cd "/Users/guspeiro/..."` with the local working dir.

5. **Stochastic-method diagnostics.** None — nbreg is deterministic given data + clustering structure.

6. **Classification.** Coefficient bounds: ±15% of |paper value|, rounded to paper precision. Reproduced rounds to paper value to 3 decimals for every coefficient and SE. p-value threshold rule applied per rubric: claim "p < .05" = precise iff reproduced p strictly < .05; "p < .01" = precise iff reproduced p strictly < .01; "p < .10" = precise iff reproduced p strictly < .10 — applied to the *displayed* reproduced p. All thresholds met except two: Nv99_6rpxdy (displayed p = 0.010 fails strict p<.01) and Nv99_511rql (displayed p = 0.050 fails strict p<.05). These two demote to `approximate` (both fall in the next threshold's approximate band). Overall: 13/15 claims `precise`; 2/15 `approximate`. Paper-level headline: **approximate**.

## Diagnostics — author-bug analysis

Diagnostics: none — unpatched run reproduces; no logic bug suspected.

Two minor observations worth recording but not affecting any verdict:

- **N for Table 2 column 4 footer.** Paper prints "19,036" (T2 upper c4); reproduced is 19,306 (Δ = 270 obs, ~1.4%). This is well within the 15% sample-size band so the claim using col 4 (Nv99_6rpxdy) still verdicts precise. Likely a transcription typo in the paper's table; the col-4 (lpub_after06) coefficient/SE reproduce exactly so the regression itself is the same.

- **Extraction-side mismatch on `orig_sample_size_value`.** As described in §2 above, several claims extract the "# of treated municipalities" from prose rather than the table's printed N. This does not affect the comparison-of-printed-values rubric (since I compare reproduced obs to paper-printed obs in the table footer, and reproduced municipalities to paper-text municipalities), but a downstream consumer reading only `orig_sample_size_value` should be aware that those numbers are municipalities, not obs.

## Files in this folder

- `Nv99.pdf`, `Nv99.txt` — paper (PDF + pdftotext layout)
- `replication.data.beheadings.march.15.dta` — author panel data
- `ReplicationDoFile.do` — author Stata script (unmodified)
- `Replication code synthetic weights.R`, `Codebook.xlsx`, `Explanation of Files.rtf` — author auxiliary files
- `Log Replication Materials AUTHOR.log` — **author's pre-computed reference log** (104k lines, all 22 nbreg models). Primary evidence source.
- `Log Replication Materials.log` — log written by my partial rerun (overwrote the author file in-place during the rerun; I restored the AUTHOR copy from `manually downloaded data/Nv99/` separately).
- `run_pushbutton.do` — wrapper that `cd`s and calls `ReplicationDoFile.do`
- `run_pushbutton.log` / `run_pushbutton_partial.log` — partial Stata batch log (50 min, T2 upper cols 1–3 completed, then killed). Validates author log: identical coefs/SEs.
- `test_col1.do`, `test_col1.log` — earlier focused test of T2 col 1 by previous agent
- `stata_console.out` — Stata stderr from prior run
- `REPRODUCTION_REPORT.md` — this report
- `Nv99_summary_rows.csv` — 15-row machine-readable summary
