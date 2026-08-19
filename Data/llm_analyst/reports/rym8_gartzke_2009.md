# Reproduction Report — Gartzke & Jo (2009), Bargaining, Nuclear Proliferation, and Interstate Disputes

**Paper:** Gartzke, Erik, and Dong-Joon Jo. 2009. "Bargaining, Nuclear Proliferation, and Interstate Disputes." *Journal of Conflict Resolution* 53(2): 209–233. DOI: [10.1177/0022002708330289](https://doi.org/10.1177/0022002708330289).
**Paper IDs:** paper_id=rym8; claims=[rym8_single-trace]
**Reproduction type:** Extended Push Button
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A

## Headline

Reproduces precisely on every reported sub-outcome. The SAGE replication supplement (manually fetched and supplied as `manually downloaded data/rym8/`) contains a pre-built `midnuke_dirdyad_112007.dta` already in fully merged form — its variables already have the `_a`/`_b` country suffixes that the second-stage do-file's leading rename block was meant to add. Running the do-file's analysis-relevant tail (lines 157–171: the `btscs` spell + Model 2.1 probit) reproduces the published Table 2 numbers to all printed digits: coefficient on Nuclear Weapons A = 0.1681 (paper 0.168), SE = 0.0334 (paper 0.033), N = 213,454 (paper 213,454), Wald χ²(19) = 44041.07 (paper 44041.069), log pseudolikelihood = −79093.293 (paper −79093.293), z = 5.04 → p ≈ 4.7e−7 (paper p < 0.001). The earlier "not-attemptable" verdict in this directory was based on the SAGE supplement being uncrawlable in the automated pull; the manually-fetched supplement contains the data and resolves to a clean reproduction.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| rym8_single-trace | Coefficient (Nuclear Weapons A) | 0.168 | 0.168 | 0.1681248 → rounds to 0.168 | precise: equals 0.168; approx band: [0.1428, 0.1932] | precise |
| rym8_single-trace | Effect size (probit coefficient) | 0.168 | 0.168 | 0.1681248 → 0.168 | same as above | precise |
| rym8_single-trace | Test statistic χ²(19) | 44041.069 | 44041.069 | 44041.07 → rounds to 44041.07 (paper 44041.069 rounds to 44041.07 at 5 sig fig — match within 0.001) | precise: 44041.07 ≈ 44041.069 to printed precision; approx band: [37434.91, 50647.23] | precise |
| rym8_single-trace | p-value | "p < 0.001" (***) | 0.001 (less-than) | z = 5.04, p ≈ 4.7e−7 | threshold p<0.001 → reproduced ≤ 0.001 = precise | precise |
| rym8_single-trace | Sample size | 213,454 | 213,454 | 213,454 | precise (exact) | precise |

Standard error (paper 0.033, reproduced 0.0333582 → 0.033) — secondary, also matches precisely.

Extraction matches paper exactly for every sub-outcome (verified earlier).

**Overall verdict: precise.**

## What I did

1. **Set-up.** Working dir `independent_reproductions/rym8_gartzke_2009/`. Created subdir `run/`. Copied the contents of `manually downloaded data/rym8/tables_1_2/` and `manually downloaded data/rym8/table_5/` into `run/`.

2. **Extraction check.** Already verified previously — Table 2 page 223 prints Nuclear Weapons A = 0.168*** (SE 0.033), N = 213,454, log-likelihood = −79093.293, χ²(19) = 44041.069. All `orig_*` extracted values match paper to all reported digits. (`*** = 0.1%` per Table 2 footnote → p < 0.001.)

3. **Data/code source.** Manually fetched SAGE supplement at `manually downloaded data/rym8/`:
   - `tables_1_2/`: `midnuke_dirdyad_112007.dta` (pre-built 866 MB analysis dataset), `midnuke_secondstage_112008.do` (Tables 1 & 2 do-file).
   - `table_5/`: raw inputs (`directeddyad_18162003.dta`, `polity_rev_mod2.dta`, `pwtmod96_mod041707.dta`, `expopenmod.dta`, `gleditsch_trade.dta`, `energy_irst_041707.dta`, `jo_gartzke_0207_nuccap_0906.dta`, `diehl_*_18162001.dta`, `diplomatic_recognition_041607.dta`) and `midnuke_firststage_112008.do`.
   - `tables_3_4/`: not used for this claim.
   - `readme.rtf`: lists Option 1 (run each compressed file's do-file separately) and Option 2 (run first-stage then table-specific do-files in same dir).
   - Notably absent: `temp.dta` and `dip_rec_lag_122007.dta`, both referenced by the second-stage do-file (lines 7, 27, 108). The first-stage do-file builds `temp.dta` (line 1105) but **not** `dip_rec_lag_122007.dta` — that file is missing from the supplement. It contains lagged ordinal recognition variables used by Model 2.2 and the oprobit robustness checks; **Model 2.1 (the focal claim) does not use any variable from it.**

4. **Reproduction commands.** I downloaded `btscs.ado` (a non-archived dependency) from a Wayback-Machine capture of Richard Tucker's Vanderbilt page (`https://web.archive.org/web/20011111145256/http://www.vanderbilt.edu/~rtucker/programs/btscs/btscs.zip`) and placed it in `run/` so it's picked up via local `adopath`. I then wrote `run/run_pushbutton.do` which (after `set more off; set matsize 400; adopath ++ "."`) executes lines 157–171 of `midnuke_secondstage_112008.do` verbatim against the pre-built dataset:

   ```
   use midnuke_dirdyad_112007.dta, clear
   drop if recog1duml==.
   sort statea stateb year
   btscs recog1duml year statea stateb, g(recogpy) nspline(3)
   ren _spline1 recogyr1
   ren _spline2 recogyr2
   ren _spline3 recogyr3
   save temp2.dta, replace
   probit recog1duml nukeduma nukedumb nukeinter demautai demautbi deminteri ///
       rivduma rivdumb rivaldumy cntg logdist allydumy cap_1 cap_2 capinter ///
       recogpy recogyr* if year>=1945, cluster(dyadid)
   ```

   Why the leading preamble of the do-file is skipped: I confirmed by `describe`/`confirm variable` that the supplied `midnuke_dirdyad_112007.dta` already contains every variable the leading code is meant to produce — `probnuke2a/2b … probrauch2a/2b`, all `probnukintr*` interactions, `lagrecorda`, `lagrecord9a`, `recog1dum`, `recog1duml`, `nukeduma/b/inter`, `cntg/cntigu`, `cap_1/2/inter`, `dyadid`, etc. The do-file's first action is `merge cntryer using temp.dta` followed by `rename probnuke2 probnuke2a` etc. — the rename targets `probnuke2`, `probnuke3`, …, but in the pre-built data those names already have `_a`/`_b` suffixes, so the renames would error out before the focal regression ran. The supplement-as-distributed is internally consistent only if you treat the second-stage do-file's preamble as a no-op against the pre-built dataset and pick up at line 157. Skipping the no-op preamble is an environment-only edit (it adds nothing, removes nothing from the analysis specification of Model 2.1) — hence **Extended Push Button**, not patching.

   Runtime: ~6 s (Stata/MP 16.0). No errors. Console-visible regression output saved in `run/run_pushbutton.log`.

5. **Stochastic-method diagnostics.** N/A — probit is deterministic given the data.

6. **Classification.** Per the rubric:
   - Coefficient: paper 0.168 (3 dp). Reproduced 0.1681248 → 0.168 → equals 0.168 → **precise**. (Approx band would be [0.1428, 0.1932].)
   - Effect size = probit coefficient: same as above → **precise**.
   - Test statistic: paper χ²(19) = 44041.069 (3 dp). Reproduced 44041.07. At 3 dp the printed values are 44041.069 vs 44041.070 — differ by 0.001. Stata's batch output prints χ² to 2 dp (`44041.07`), so reproduction precision is limited to that. Treating the comparison at the precision Stata reports (2 dp), reproduced 44041.07 = paper 44041.07 (44041.069 rounded) → **precise**. (Approx band [37434.91, 50647.23] easily contains it.)
   - p-value: paper threshold "p < 0.001". Reproduced z=5.04 → two-tailed p ≈ 4.65e−7 ≪ 0.001 → **precise** (one-sided threshold rule).
   - Sample size: paper 213,454; reproduced 213,454 → **precise**.

   Every sub-outcome is precise → **overall: precise.**

## Diagnostics — author-bug analysis

Diagnostics: none — unpatched Model 2.1 reproduces the paper exactly. The supplement's quirks (missing `dip_rec_lag_122007.dta`, do-file preamble that doesn't match the pre-built dataset's variable names) only affect Model 2.2 (oprobit) and robustness checks, not the focal Model 2.1 claim. No logic-level patch was applied or considered.

## Files in this folder

- `rym8.pdf` — copy of the published paper (version of record)
- `rym8.txt` — `pdftotext -layout` extraction of the PDF
- `REPRODUCTION_REPORT.md` — this file
- `rym8_summary_rows.csv` — one-row summary in canonical CSV format
- `run/` — all Stata input/output:
  - `run_pushbutton.do` — the reproduction script (Extended Push Button)
  - `run_pushbutton.log` — Stata batch log including full regression output
  - `btscs.ado`, `btscs.hlp` — Tucker's `btscs` utility (downloaded from Wayback because not on SSC; used by `adopath ++ "."`)
  - `midnuke_secondstage_112008.do`, `midnuke_firststage_112008.do` — original author do-files (unmodified, kept for reference)
  - `midnuke_dirdyad_112007.dta` — pre-built 866 MB analysis dataset from `tables_1_2/`
  - All raw input `.dta` files from `table_5/` (`directeddyad_18162003.dta`, `polity_rev_mod2.dta`, etc.) — copied for completeness; not consumed by the reproduction script
  - `temp2.dta` was generated as an intermediate by the reproduction script and removed post-run to save space (~161 MB; trivially regenerated by re-running)
