# Reproduction Report — Grose (2015), Explaining Explanations

**Paper:** Grose, Christian R. 2015. "Explaining Explanations: How Legislators Explain Their Policy Positions and How Citizens React." *American Journal of Political Science* 59(3): 724-743. DOI: 10.1111/ajps.12164
**Paper IDs:** paper_id=E0Q3; claims=[E0Q3_single-trace]
**Reproduction type:** Push Button
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A

## Headline
Clean push-button reproduction. The author's posted Stata do-file (`study1replication071414final.do`) executed without modification on the posted .tab/.dta data and exactly reproduced Table 2 column 2: 23.21% of senators mentioned pro-immigration actions when responding to pro-immigration constituents vs. 12.50% when responding to anti-immigration constituents (N=56), with exact McNemar significance probability p = 0.0703. Paper prints "23.2%", "12.5%", N=56, and "p = 0.07" — all match to printed precision. No deviations.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| E0Q3_single-trace | Sample size | 56 | 56 | 56 | precise=56; approx=[48,64] | precise |
| E0Q3_single-trace | p-value (exact, two-tailed McNemar) | 0.07 | 0.07 | 0.0703 → rounds to 0.07 | precise=0.07; approx=[0.02,0.12] | precise |
| E0Q3_single-trace | Pro-mentions to pro-letter (%) | 23.2% | n/a | 23.21% → 23.2% | secondary: precise to printed digits | precise |
| E0Q3_single-trace | Pro-mentions to anti-letter (%) | 12.5% | n/a | 12.50% → 12.5% | secondary: precise to printed digits | precise |

Coefficient / test statistic / effect size: not reported as focal numerics in the claim — the paper reports the exact McNemar p-value as the focal inferential test (the asymptotic χ²(1)=4.50 is shown by Stata but the paper text/table emphasizes the exact p only). Treated as non-outcome.

**Overall verdict: precise.**

## What I did
1. Set-up: created `independent_reproductions/E0Q3_grose_2015/`, copied PDF, ran `pdftotext -layout`.
2. Extraction check: located Table 2 (p. 731 of journal pagination, p. 9 of PDF) and surrounding text. Paper prints "23.2%", "12.5%", "p-value 0.07", "N 56" for column 2 ("Pro-Immigration" mentions). Matches the JSON extraction (`orig_p_value=0.07`, `orig_sample_size_value=56`).
3. Data/code source: Harvard Dataverse, doi:10.7910/DVN/26714. Downloaded `study1replication071414final.do` (datafile 2481721) and the original-format Stata `.dta` (datafile 2481720, ?format=original).
4. Reproduction: wrote `run_pushbutton.do` containing only the Table 2 column 2 commands (verbatim from author's do-file, plus a single `cd` and `use`). Ran via `/usr/local/bin/stata-mp -b do run_pushbutton.do`. No edits to analysis logic, package versions, or variables — pure environment-only setup (working directory + filename).
5. Stochastic-method diagnostics: none — exact McNemar is deterministic.
6. Classification: all reported sub-outcomes match the paper's printed values to printed precision → precise.

## Diagnostics — author-bug analysis
None — unpatched run reproduces exactly; no logic bug suspected.

## Files in this folder
- `E0Q3.pdf` — copy of paper
- `E0Q3.txt` — pdftotext -layout output
- `study1replication.do` — author's posted do-file (unmodified)
- `study1replication.dta` — author's posted Stata data (Dataverse "original" format)
- `study1replication.tab` — Dataverse-converted tab version (unused)
- `run_pushbutton.do` — minimal driver invoking just the Table 2 col-2 lines
- `run_pushbutton.log` — Stata log of the pushbutton run
- `REPRODUCTION_REPORT.md` — this file
