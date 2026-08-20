# Reproduction Report — Robertson (2017), Political Orientation, Information and Perceptions of Election Fraud (Russia)

**Paper:** Robertson, Graeme. 2017. "Political Orientation, Information and Perceptions of Election Fraud: Evidence from Russia." *British Journal of Political Science* 47(3): 589–608. DOI: 10.1017/S0007123415000356
**Paper IDs:** paper_id=qggQ; claims=[qggQ_single-trace]
**Reproduction type:** Source Data Reproduction (no code posted; data + supplementary table specifies the model)
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A — no patches considered

## Headline
The single claim — that opposition voters who can correctly identify Golos are about twice as likely to express skepticism about the elections, with p<.05 (Figure 2 in the paper) — reproduces precisely. Re-running the corresponding ordered-logit (Supplementary Appendix Table F3, Model 1, "Opposition Voters") on the author's posted Stata file recovers an odds ratio of 1.8456 (paper: 1.85), z = 2.53 (paper: 2.53), N = 1,728 (paper: 1,728), and p = 0.012 (paper: p<0.05). Every single non-focal coefficient in Table F3 Model 1 also matches to the paper's printed precision. No deviations of any kind.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| qggQ_single-trace | p-value (focal: Opp Voter Knows Golos) | p < 0.05 (text p.598; implied by z=2.53 in Table F3 Model 1) | p<0.05 | p = 0.012 | precise = p ≤ 0.05; approx = (0.05, 0.10] | **precise** |
| qggQ_single-trace | Effect size / odds ratio (focal) | 1.85 (Table F3 Model 1) — text says "approximately 2"; paper p.598 | not extracted | 1.8456 → rounds to 1.85 | precise = 1.85; approx = [1.5725, 2.1275] | **precise** (non-claim sub-outcome, reported for completeness) |
| qggQ_single-trace | Test statistic (focal z) | z = 2.53 (Table F3 Model 1) | not extracted | z = 2.526 → rounds to 2.53 | precise = 2.53; approx = [2.1505, 2.9095] | **precise** (non-claim sub-outcome) |
| qggQ_single-trace | Sample size | N = 1,728 (Table F3 Model 1) | not extracted | N = 1,728 | precise = 1,728; approx = [1469, 1987] | **precise** (non-claim sub-outcome) |

The CSV extraction for this claim only specifies `orig_p_value=0.05` (less-than) and that's the rubric-binding sub-outcome. All other reported quantities also match precisely.

## What I did

### 1. Set-up
Created `independent_reproductions/qggQ_robertson_2017/`, copied the PDF, ran `pdftotext -layout` on it.

### 2. Extraction check
- Claim is described in main text p.598 (`qggQ.txt` lines 635–641): "those among the opposition who know about Golos are still about twice as likely to express skepticism about the elections than opposition voters who could not correctly identify the organization (odds ratio is approximately 2, with a 95 per cent confidence interval that does not cross 0 [see Figure 2])."
- Figure 2 (p.598) is a coefficient plot — the original numeric value behind the focal opposition-voter dot is reported in **Supplementary Appendix Table F3** (`supp_appendix.txt` lines 1281–1333): Model 1 ("Opposition Voters"), row "Opp Voter Knows Golos" → odds ratio = 1.85, z = 2.53, N = 1,728.
- The CSV `orig_p_value=0.05` (less-than, two-tailed) is consistent with the paper's "p<0.05" inference; the implied exact p from z=2.53 is 0.0114. Extraction matches paper.

### 3. Data/code source
- `pr_data_location` = "Publisher website, Online repository". No code was posted (`pr_code_available=No`).
- Data found at Harvard Dataverse: `doi:10.7910/DVN/OL9VD3` (BJPolS dataverse, Robertson 2015, "Replication Data for: Political Orientation, Information and Perceptions of Election Fraud: Evidence from Russia"). One file: `election monitors BJPS.tab` (Stata 13 original, 2,432 obs × 26 vars). Downloaded via the Dataverse access API.
- Supplementary appendix (containing Table F3) downloaded from Cambridge: `https://static.cambridge.org/content/id/urn:cambridge.org:id:article:S0007123415000356/resource/name/S0007123415000356sup001.pdf`.

### 4. Reproduction
Because no code was posted, I had to reconstruct the model from the paper text and Appendix F3 column headings. The dataset already contains six pre-built indicator variables (`non_dont_know`, `non_do_know`, `regime_dont_know`, `regime_do_know`, `opp_dont_know`, `opp_do_know`) which are mutually exclusive partition cells. The paper says (p.598): "The regressions use different excluded categories so that we can distinguish the effect of knowledge of Golos within groups." For Model 1 (Opposition Voters), the omitted category is `opp_dont_know`, and the focal coefficient is `opp_do_know`. Saturated controls per Appendix F3 column ordering are: `polnews state_tv vkont odno livej facebook org_empl fin_stat educ sex age moscow famecon round`.

Stata command (`run_repro.do`):
```
ologit fraud_ordered non_dont_know non_do_know regime_dont_know regime_do_know opp_do_know ///
    polnews state_tv vkont odno livej facebook org_empl fin_stat educ sex age moscow famecon round, or
```

Run via `/usr/local/bin/stata-mp -b do run_repro.do` (~2 s). Output in `run_repro.log`.

This is a Source Data Reproduction (no code archive, model reconstructed from the published model spec). I treated this as the lightest viable reproduction; no environment-only edits relative to the (nonexistent) author code are at issue.

### 5. Stochastic-method diagnostics
Not applicable — ordered logit MLE is deterministic.

### 6. Classification — bounds and verdict
- Focal p (paper: p<0.05, threshold form). Reproduced p = 0.012. Threshold-precise iff reproduced p ≤ 0.05 → **precise.**
- Other reported quantities likewise match to the paper's printed precision: OR 1.85=1.85, z 2.53=2.53, N 1,728=1,728.

Overall verdict (unpatched): **precise.**

## Diagnostics — author-bug analysis
Diagnostics: none. Every reported quantity in Table F3 Model 1 (Opposition Voters) — focal coefficient, focal z, all 14 control coefficients with their z-stats, both cutpoints (`/cut1=-5.493`, `/cut2=-3.397`), and N — matches the paper to printed precision. As a spot check, I also notice that the F3 columns "Model 2 Regime", "Model 1 Non-Voters", etc. share identical control-coefficient and z-stat values across the three regressions in the table because they are algebraically equivalent re-parametrizations of the same fitted model with different reference categories — the author's table reflects this correctly. No bug suspected.

## Files in this folder
- `qggQ.pdf` — paper PDF
- `qggQ.txt` — `pdftotext -layout` output of paper
- `supp_appendix.pdf` / `supp_appendix.txt` — Cambridge supplementary appendix (Table F3 underlying Figure 2)
- `election_monitors_BJPS.dta` — original Stata-13 file from Dataverse (DOI 10.7910/DVN/OL9VD3)
- `election_monitors_BJPS.tab` — tab-separated version of the same file
- `run_repro.do` — reconstructed do-file (Source Data Reproduction)
- `run_repro.log` — Stata log of the reproduction run
- `REPRODUCTION_REPORT.md` — this report
- `qggQ_summary_rows.csv` — one-row claim summary
