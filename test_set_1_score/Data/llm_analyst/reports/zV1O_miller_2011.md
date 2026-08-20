# Reproduction Report — Miller & Elgün (2011), Diversion and Political Survival in Latin America

**Paper:** Miller, Ross A., and Özlem Elgün. 2011. "Diversion and Political Survival in Latin America." *Journal of Conflict Resolution* 55(2): 192–219. DOI: 10.1177/0022002710381064
**Paper IDs:** paper_id=zV1O; claims=[`zV1O_single-trace`]
**Reproduction type:** Push Button
**Headline verdict (unpatched):** precise
**Verdict if patched (only if applicable):** N/A — no patches required

## Headline
Push-button reproduction succeeds exactly. Running the authors' supplied `cdsimeq` two-stage probit/OLS routine on `scamerica5.dta` (with their bundled `cdsimeq.ado`) yields, for the focal Coup-risk coefficient in the dispute-initiator equation of Table 3 with Maddala-corrected SEs: coef = 2.958612, SE = 1.51288, z = 1.96, p = 0.051, N = 798. After rounding to the paper's printed precision (2 decimals for coef and SE, 3 decimals for p, integer N), every reported sub-outcome matches the paper exactly: 2.96 / 1.51 / .051 / 798. No deviations, no patches considered. (The replication archive — three files including a logged transcript of the original run — was previously unobtainable due to a Cloudflare challenge on the SAGE supplement page; the user supplied it manually for this re-reproduction.)

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| zV1O_single-trace | Coefficient (Coup risk) | 2.96 | 2.96 | 2.958612 → 2.96 | precise = 2.96 (2 dp); approx [2.516, 3.404] | precise |
| zV1O_single-trace | Std. error (Maddala) | 1.51 | 1.51 | 1.51288 → 1.51 | precise = 1.51 (2 dp) | precise (paper-matching) |
| zV1O_single-trace | p-value (exact, two-tailed) | .051 | 0.051 | 0.051 | precise = .051 (3 dp); approx [0.001, 0.101] | precise |
| zV1O_single-trace | Sample size | 798 | 798 | 798 | precise = 798; approx [678, 918] | precise |
| zV1O_single-trace | Test statistic (z) | not printed | n/a | 1.96 | n/a | non-outcome |
| zV1O_single-trace | Effect size | not printed | n/a | n/a | n/a | non-outcome |

**Overall verdict (unpatched): precise.**

## What I did

1. **Set-up.** Created `independent_reproductions/zV1O_miller_2011/`. Unzipped the manually-fetched SAGE supplement `manually downloaded data/zV1O/Miller_.Elgun_JCR_Replication.zip` into the repro dir: `scamerica5.dta`, `cdsimeq.ado`, `Replication_readme_log.doc` (converted to `.txt` via macOS `textutil`). Paper PDF and pdftotext output already present from the prior attempt.

2. **Extraction check.** The single claim cites Table 3 (paper p. 205; lines 583–599 of `zV1O.txt`). Paper prints "Coup risk 1.51 (.051)*** | 2.96 | 1.07 (.006)**" — i.e. coef = 2.96, Maddala SE = 1.51 with p = .051; the cluster-robust column has SE = 1.07, p = .006. Sample size N = 798 is given by `cdsimeq`'s output (also documented in the readme log). The extracted JSON matches the paper exactly: 2.96 / 1.51 / .051 / 798.

3. **Data/code source.** SAGE replication archive distributed via the journal's article supplement page, manually downloaded by the user (the publisher landing pages are Cloudflare-protected). Three files: `scamerica5.dta` (Stata dataset, 99 KB), `cdsimeq.ado` (the user-written 2SPLS routine of Keshk 2003, 16 KB), `Replication_readme_log.doc` (164 KB; Stata commands plus a logged transcript of the original run that exactly matches the paper's tables).

4. **Reproduction.** Wrote `run_pushbutton.do` (3 statements: `clear all` / `adopath ++ "."` so the bundled `cdsimeq.ado` is found before any installed copy / `use scamerica5.dta` / one `cdsimeq` call with the equation specifications copied verbatim from the readme). Stata 16.0 MP, batch mode: `/usr/local/bin/stata-mp -b do run_pushbutton.do`. Runtime ≪ 1 second. Log saved as `run_pushbutton.log`. **No edits to analysis logic; the only environment-only edit is `adopath ++ "."`** to ensure the local archive `cdsimeq.ado` is used. The relevant block (log lines 179–192) reads:

   ```
       originit |      Coef.   Std. Err.      z    P>|z|
   continuous~t |   2.958612    1.51288     1.96   0.051
   ```

   exactly matching the readme's archived log (Replication_readme_log.txt line 147).

5. **Stochastic-method diagnostics.** None applicable — `cdsimeq` is deterministic.

6. **Classification.** All four reported sub-outcomes (coef, SE, p, N) round to the paper's printed precision and equal the paper's printed value → all `precise`. The test statistic is not printed for this Table 3 cell (paper reports only coef, SE, p), so coded `non-outcome` per the rubric's "non-inferential numeric evidence in the paper" rule. **Overall: precise.**

## Diagnostics — author-bug analysis

Diagnostics: none — unpatched run reproduces the paper exactly. No logic bug suspected.

## Files in this folder

- `zV1O.pdf` — paper (copy of `papers/zV1O.pdf`)
- `zV1O.txt` — `pdftotext -layout` extraction
- `scamerica5.dta` — author dataset (from manually-fetched SAGE supplement)
- `cdsimeq.ado` — author-bundled ado-file for `cdsimeq` (from supplement)
- `Replication_readme_log.doc` — author readme + logged transcript (from supplement)
- `Replication_readme_log.txt` — text conversion of the above
- `run_pushbutton.do` — push-button reproduction script (this analysis; unpatched)
- `run_pushbutton.log` — Stata batch log (unpatched run)
- `REPRODUCTION_REPORT.md` — this report
- `zV1O_summary_rows.csv` — one-row summary
