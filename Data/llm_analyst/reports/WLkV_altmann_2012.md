# Reproduction Report — Altmann (2012), Promotions and Incentives in Multistage Elimination Tournaments

**Paper:** Altmann, Steffen, Armin Falk, and Matthias Wibral. 2012. "Promotions and Incentives: The Case of Multistage Elimination Tournaments." *Journal of Labor Economics* 30(1): 149-174. DOI: 10.1086/662130
**Paper IDs:** paper_id=WLkV; claims=WLkV_single-trace
**Reproduction type:** Push Button
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A — no patch needed.

## Headline

Push-button reproduction succeeds exactly. Running the authors' Stata variable-definition do-file on the authors' supplementary `.dta` (manually retrieved by the RA from the JOLE supplement after publisher-side Cloudflare blocked automated download) and applying Stata's `ranksum` (Mann-Whitney U) to first-stage effort restricted to the OS (treat==1) and TS (treat==2) subsamples reproduces |z| = 2.536, Prob > |z| = 0.0112, N = 60 + 64 = 124 — identical to the paper's printed |z| = 2.536, p = .011, N = 124 (p. 14, lines 159-161 of the published article). All sub-outcomes are precise.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| WLkV_single-trace | Sample size (participants) | 124 | 124 | 124 | precise = 124; approx = [105.4, 142.6] | precise |
| WLkV_single-trace | Test statistic (\|z\|) | 2.536 | 2.536 | 2.536 | precise = 2.536 (3 dp); approx = [2.156, 2.916] | precise |
| WLkV_single-trace | p-value (exact, two-tailed) | .011 | 0.01121 | 0.0112 (rounds to .011 at 3 dp) | precise = .011 (3 dp); approx = [0, 0.061] | precise |
| WLkV_single-trace | Effect size (Cohen's d) | not printed | -0.530 (derived; not in paper) | n/a | n/a | non-outcome |

Means and medians by treatment also match exactly (OS: mean 71.65 → paper 71.7, median 75 → 75; TS: mean 84.8125 → 84.8, median 84 → 84).

## What I did

1. **Set-up.** Working directory `independent_reproductions/WLkV_altmann_2012/`. Copied `papers/WLkV.pdf` and `pdftotext -layout` output. The RA delivered the JOLE supplement files at `manually downloaded data/WLkV/` (`Data_complete_JOLE_110527.dta`, `Tournaments_VarDef_JOLE_110527.do`); I copied both into the reproduction directory.

2. **Extraction check.** Located the focal claim on p. 14 of the published article (line 624 of `WLkV.txt`):
   > "A Mann-Whitney U-test confirms that the treatment difference is statistically significant (|z| p 2.536, p p .011, two sided)."

   Descriptive statistics in the surrounding paragraph (means 84.8 vs 71.7; medians 84 vs 75) match table 2, columns 1-2. N = 60 + 64 = 124 from the OS + TS treatment cells of table 2. All extracted `orig_*` values match the paper to all reported digits. The Cohen's d in the extraction (-0.530) is derived; the paper itself does not print a standardized effect size for this test, so per SCORE rule it is `non-outcome`.

3. **Data/code source.** RA obtained the JOLE online supplement directly from the publisher (`journals.uchicago.edu`, the URL prior reproduction attempts could not access through automated fetching due to Cloudflare bot challenge). The supplement contains the full participant-level dataset (`Data_complete_JOLE_110527.dta`, 320 obs × 137 vars across all 5 treatments OSL/OS/TS/TSC/THS) and the variable-definition do-file used by the authors.

4. **Reproduction commands.**
   ```
   stata-mp -b do run_pushbutton.do
   ```
   `run_pushbutton.do` (a) loads the .dta, (b) runs the authors' `Tournaments_VarDef_JOLE_110527.do` unchanged via `do "Tournaments_VarDef_JOLE_110527.do"`, (c) tabulates `treat` and summarizes `effort_t1` by treat, (d) runs `ranksum effort_t1 if treat==1 | treat==2, by(treat)`. Runtime <2 seconds. No edits to the authors' code; the only addition is the `ranksum` invocation (the authors' supplement contains the variable-definition file but not a separate analysis do-file for table 2's text statistics, so I had to issue the `ranksum` command directly — this is the canonical Stata Mann-Whitney command and exactly mirrors the test the paper reports).

5. **Stochastic-method diagnostics.** N/A — exact rank-sum statistic, deterministic.

6. **Classification.**
   - Sample size: paper 124, reproduced 124 → precise.
   - Test statistic |z|: paper 2.536, reproduced 2.536 → precise.
   - P-value: paper .011 (3 dp), reproduced 0.0112 → rounds to .011 → precise.
   - Effect size: not printed in paper → non-outcome.
   - Overall: **precise**.

## Diagnostics — author-bug analysis

Diagnostics: none — push-button run reproduces exactly; no logic bug suspected.

## Files in this folder

- `WLkV.pdf` — paper (copied from `papers/`)
- `WLkV.txt` — `pdftotext -layout` output
- `Data_complete_JOLE_110527.dta` — author dataset (from publisher supplement, RA-fetched)
- `Tournaments_VarDef_JOLE_110527.do` — author variable-definition do-file (unchanged)
- `run_pushbutton.do` — push-button reproduction script (unpatched; calls the author do-file then runs `ranksum`)
- `run_pushbutton.log` — Stata log from the push-button run
- `REPRODUCTION_REPORT.md` — this file
- `WLkV_summary_rows.csv` — per-claim summary row
