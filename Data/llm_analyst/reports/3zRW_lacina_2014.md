# Reproduction Report — Lacina (2014), India's Federal Reorganization

**Paper:** Lacina, Bethany. 2014. "How Governments Shape The Risk Of Civil Violence: India's Federal Reorganization, 1950-56." *American Journal of Political Science* 58(3): 720-738. DOI: 10.1111/ajps.12074
**Paper IDs:** paper_id=3zRW; claims=[3zRW_single-trace]
**Reproduction type:** Push Button
**Headline verdict (unpatched):** precise

## Headline
The unpatched archived Stata code reproduces the focal claim exactly. Table 5, Model 1, violence outcome: paper prints coefficient on Ln relative INC representation squared = -0.341 (SE 0.104), N=63, p<0.10. The reproduction yields -0.3413929 (SE 0.1036756), N=63, exact p=0.001 — which round to -0.341 and 0.104 at the paper's printed precision and falls under the p<0.10 threshold. No deviations.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| 3zRW_single-trace | Coefficient | -0.341 | -0.341 | -0.3413929 (rounds to -0.341) | precise: rounds to -0.341; approx band [-0.392,-0.290] | precise |
| 3zRW_single-trace | Coefficient SE (effect-size proxy / secondary) | 0.104 | 0.104 | 0.1036756 (rounds to 0.104) | precise: rounds to 0.104 | precise |
| 3zRW_single-trace | p-value | p < 0.10 | p < 0.10 (less-than) | exact p = 0.001 | precise: 0.001 ≤ 0.10 (one-sided threshold) | precise |
| 3zRW_single-trace | Sample size | 63 | 63 | 63 | precise: identical | precise |
| 3zRW_single-trace | Test statistic | not reported in claim | NaN | z = -3.29 (computed) | n/a | non-outcome |
| 3zRW_single-trace | Effect size | not reported | NaN | n/a | n/a | non-outcome |

**Overall verdict (unpatched): precise.**

## What I did

1. **Set-up.** Created `independent_reproductions/3zRW_lacina_2014/`, copied PDF, ran `pdftotext -layout` to produce `3zRW.txt`.

2. **Extraction check.** The claim references Table 5, Model 1, violence outcome row "Ln relative INC representation sq." (page 730, the eleventh page of the article PDF). The paper prints -0.341 with SE 0.104 in parentheses, marked with `*` (defined in note as p<0.10), with N=63 enclaves. The extracted `orig_coef_value=-0.341`, `orig_coef_se=0.104`, `orig_p_value=0.1`/`less-than`, and `orig_sample_size_value=63` all match the paper exactly. **Extraction matches paper.**

3. **Data/code source.** Harvard Dataverse: doi:10.7910/DVN/5CVUVU ("Replication data for: How governments shape the risk of civil violence: India's federal reorganization, 1950–56"). Files downloaded:
   - `LacinaAJPSreplication.do` (Stata script)
   - `LacinaAJPSreplication.tab` → renamed to `LacinaAJPSreplication.dta` (the Dataverse "tab" download is the original Stata binary file; it was a `.dta` returned with a `.tab` extension by the Dataverse API)
   - `LacinaAJPS_SupportInfo_CensusvLSI.tab` → renamed to `.dta` (auxiliary, not used for Table 5)
   - `lacina_ajpsfinal_supplement.pdf`

4. **Reproduction.** Copied the do-file to `run_pushbutton.do` unchanged. Ran:
   ```
   /usr/local/bin/stata-mp -b do run_pushbutton.do
   ```
   in the reproduction directory. Runtime ~5 sec. No edits required (the do-file `use`s `LacinaAJPSreplication.dta`, which is the file we have under that name; no path edits needed). All `mlogit`, `mlogtest`, and ancillary commands ran cleanly.

   Model 1 result for outcome=3 (violence), variable `lnrelgrepnm2`:
   ```
   Coef. = -.3413929   Std. Err. = .1036756   z = -3.29   P>|z| = 0.001
   N = 63   Log pseudolikelihood = -35.063725
   ```
   These match Table 5 Model 1 violence column exactly. The Log likelihood (-35.06 → paper rounds to -35) and the IIA chi-squared statistics for violence (6.71 → paper prints 6.71) also match.

5. **Stochastic-method diagnostics.** None — `mlogit` is deterministic.

6. **Classification.**
   - Coefficient: paper -0.341 (3 decimals); reproduced -0.3413929 → rounds to -0.341 → **precise**. Approximate band ±15% = [-0.3922, -0.2899] (reproduced value also inside).
   - SE / coef-SE (treated as secondary numeric outcome since the claim text reports it): paper 0.104 (3 decimals); reproduced 0.1036756 → rounds to 0.104 → **precise**.
   - p-value: paper threshold p<0.10; reproduced p=0.001 ≤ 0.10 → **precise** (one-sided threshold rule).
   - Sample size: paper 63; reproduced 63 → **precise**.
   - Test statistic and effect size: not reported in the claim → **non-outcome**, skipped.

   Combined: every reported sub-outcome is **precise** → overall **precise**.

## Diagnostics — author-bug analysis

Diagnostics: none — unpatched run reproduces the paper to all reported digits. No logic bug suspected.

## Files in this folder

- `3zRW.pdf` — copy of the paper.
- `3zRW.txt` — `pdftotext -layout` output.
- `lacina_ajpsfinal_supplement.pdf` — author's online supplement (downloaded; not required for the focal claim).
- `LacinaAJPSreplication.do` — author's Stata replication script (as posted on Dataverse).
- `LacinaAJPSreplication.dta` — author's Stata data file (Dataverse delivered with `.tab` extension; this is the original Stata binary).
- `LacinaAJPS_SupportInfo_CensusvLSI.dta` — auxiliary support-info data (not used for Table 5).
- `run_pushbutton.do` — copy of the author's do-file used for the unpatched run (no edits).
- `run_pushbutton.log` — Stata log of the unpatched run.
- `REPRODUCTION_REPORT.md` — this report.
- `3zRW_summary_rows.csv` — single-row summary CSV for the audit.
