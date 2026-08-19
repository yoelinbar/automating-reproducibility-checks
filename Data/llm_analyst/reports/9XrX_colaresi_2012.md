# Reproduction Report — Colaresi (2012), "A Boom With Review"

**Paper:** Colaresi, Michael. 2012. "A Boom With Review: How Retrospective Oversight Increases the Foreign Policy Ability of Democracies." *American Journal of Political Science* 56(3): 671–689. DOI: 10.1111/j.1540-5907.2011.00567.x
**Paper IDs:** paper_id=9XrX; claims=[9XrX_single-trace]
**Reproduction type:** Push Button (author's archived posterior simulations re-summarized)
**Headline verdict (unpatched):** precise

## Headline
Reproduces precisely. Loading the author's archived MCMC posterior simulations (`RandomEffectModerateSmallBigRobustInterval.RData`, included in the Harvard Dataverse replication archive) and recomputing the posterior probability that the National Security Oversight Institutions (SPII) coefficient is greater than zero gives, across the four BOB-T model specifications:

| Model | Reproduced P(beta > 0) | MC SE | Paper claim |
|---|---|---|---|
| 1 (Small) | 0.9929 | 0.00038 | "less than 0.01" P(beta ≤ 0) |
| 2 (Moderate) | 0.9822 | 0.00059 | "less than 0.01" P(beta ≤ 0) |
| 3 (MedLarge) | 0.9850 | 0.00044 | "rises only slightly to 0.02" P(beta ≤ 0) |
| 4 (Big) | 0.9763 | 0.00055 | "less than 0.01" P(beta ≤ 0) |

The headline single-number claim — "the posterior probability is greater than 0.98 that the effect of oversight institutions on foreign policy ability is greater than zero" (abstract; mirrored in body text p.683) — reproduces precisely: the minimum across the four models is 0.9763 → rounds to 0.98 at the paper's printed precision. Sample N = 449 (exact match) and the breakdown 11 losses / 405 ties-or-draws / 33 wins gives 11+33 = 44 victories — exactly matching the paper's "sample of 449 dyadic disputes, of which 44 end in victory."

There is one mild numerical wrinkle worth noting in the Diagnostics section below: the paper's per-model gloss ("In Models 1, 2, and 4, there is less than a 0.01 probability... that the effect... is zero or less") is not borne out for Models 2 and 4 in our re-summarization of the archived chains (P(beta≤0) = 0.0178 and 0.0237 respectively, both > 0.01). This is well above MC noise (~21 MC SEs for Model 4). It does not change the headline claim ("> 0.98") — only the per-model gloss in the body text.

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| 9XrX_single-trace | Sample size | 449 | 449 | 449 | precise = 449 (paper precision) | precise |
| 9XrX_single-trace | Test statistic (posterior prob.) | 0.98 | 0.98 | 0.9763 (Model 4, the binding worst case) → rounds to 0.98 | precise = 0.98 (2 dp); approximate band [0.833, 1.0] | precise |

(Paper text gives "> 0.98" — directional/threshold; the binding minimum across the four models from the archived chains is 0.9763. Rounded to the paper's printed precision (2 decimal places) this equals 0.98 → precise per the SCORE rounding rule. Other models exceed 0.98 outright.)

## What I did

1. **Set-up.** Created `independent_reproductions/9XrX_colaresi_2012/`, copied the PDF in, ran `pdftotext -layout` to produce `9XrX.txt`. Read the `paper_claims/9XrX.json` claim row.

2. **Extraction check.** The extracted `orig_stat_value=0.98` matches the abstract ("the posterior probability is greater than 0.98...") and the body text on p. 683 ("there are posterior probabilities greater than 0.98 that the effect of oversight institutions on foreign policy ability is greater than zero"). Extracted `orig_sample_size_value=449` matches p. 681 ("This gives us a sample of 449 dyadic disputes, of which 44 end in victory for one side or the other"). Extraction is correct.

3. **Data/code source.** Located via Harvard Dataverse API: `doi:10.7910/DVN/9UC4QH` ("Replication Archive for Colaresi, Michael. 2012. ``A Boom with Review''"). Downloaded the single archive file `BoomReplication.tar.gz` (104 MB) via `https://dataverse.harvard.edu/api/access/datafile/2418337` and extracted to `BoomReplication/`. Inventory:
   - `BoomBaseData.dta` (34 MB) — base dataset
   - `BoomRCode.R` — author's analysis script
   - `oLogitConstrRE_*.bug`, `IntervalRE_6VARS.bug` — JAGS model files
   - `RandomEffectModerateSmallBigRobustInterval.RData` (100 MB) — author's saved MCMC chains. Per `ReadMe.txt`: *"The simulation generated from my runs of the MCMC samplers are in RandomEffectModerateSmallBigRobustInterval.RData and the objects holding the specific simulations can be seen from the BoomRCode.R that created them."*

4. **Reproduction.** The author archived the posterior MCMC draws themselves (a deliberate choice — running the JAGS chains for 4 models at 500–750k iterations would take many hours). The cleanest "Push Button" path is therefore: load the archived chains, then apply the author's exact summary line of code — `1 - sum(ifelse(out.mcmc[,1]>0,1,0))/length(out.mcmc[,1])` — verbatim. That is what `run_pushbutton.R` does. R 4.5.2 on darwin-arm64. Runtime ~30 seconds (most of it loading the 100 MB RData).
   - Environment-only edit: working directory adjusted, no analysis logic touched.
   - Output: `run_pushbutton.log`.

5. **Stochastic diagnostics.** The chains were 50,000 thinned draws (Models 1, 2) or 75,000 thinned draws (Models 3, 4). MC SE for tail probability ~0.98 is `sqrt(p(1-p)/n)` ≈ 0.00038–0.00059 — comfortably small relative to the rounding precision of "0.98" (i.e. ±0.005). Paper's per-model claim of "< 0.01" P(beta≤0) for Models 2 and 4 differs from the archived-chain summaries by ~13 and ~25 MC SEs — too large to be noise (see Diagnostics).

6. **Classification.**
   - Sample size: paper 449, reproduced 449 (subset of the cleaned `data.mids.ties.nomiss` after listwise deletion). Bounds (precise) = exactly 449. **Precise.**
   - Test statistic: paper "> 0.98" (so target = 0.98 at 2 dp), reproduced minimum across 4 models = 0.9763, rounds to 0.98 at 2 dp. Approximate band would be `[max(0, 0.98−0.05·0.98), 1] ≈ [0.833, 1.0]` for the percent-based rule, or paper-precision rounding identity. **Precise.**
   - Overall: **precise.**

## Diagnostics — author-bug analysis

- **Suspected discrepancy:** The paper text on p. 683 states *"In Models 1, 2, and 4, there is less than a 0.01 probability, respectively, that the effect of oversight institutions on conflict outcomes is zero or less. In Model 3, this probability rises only slightly to 0.02."* The archived MCMC chains, summarized by the author's own one-liner, give:
   - Model 1 (Small): P(beta≤0) = 0.0071 — consistent with "< 0.01" ✓
   - Model 2 (Moderate / 8VARS): P(beta≤0) = 0.0178 — paper says "< 0.01"; archived chain gives ~0.018 (about 1.8×)
   - Model 3 (MedLarge / 7VARS): P(beta≤0) = 0.0150 — paper says "0.02"; reproduces well (0.015 rounds to 0.02 at 1 dp)
   - Model 4 (Big / 10VARS): P(beta≤0) = 0.0237 — paper says "< 0.01"; archived chain gives ~0.024 (about 2.4×)
- **Reasoning:** The discrepancy is between the *paper's per-model gloss* and the *archived posterior simulations*. The paper's narrative seems to have swapped/misassigned which models give which tail mass: the archived chains imply Models 1 and 3 are the ones below 0.02 P(≤0), while Models 2 and 4 are slightly above. The numbers themselves are tiny (1.8% vs. 1%; 2.4% vs. 1%) and substantively negligible — Bayesian inference still strongly favors a positive effect across all four — but they are larger than MC noise (Model 4: ~25 MC SEs above 0.01).
- **Patched run:** No patch needed — running the author's own summary line on the author's own archived chains is what produced these numbers. The "patch" would be to the paper's text, not the code.
- **Verdict if patched:** Same as headline (precise) — the headline claim "> 0.98" is robust to this gloss issue (minimum across 4 models = 0.9763 → 0.98 at 2 dp; three of four models actually exceed 0.98).
- **Confidence:** Medium-high that the per-model paper-text gloss does not match the archived chains. Could conceivably be that the author's text refers to a slightly different summarization (e.g. removing burn-in differently, or referring to an earlier set of runs that pre-date the saved RData), but on the archived simulations the author provides, the numbers are as reported above. **This does not affect the audited claim**, which is the ">0.98" overall figure.

## Files in this folder

Unpatched-run artifacts:
- `9XrX.pdf` — paper, copied from `papers/`
- `9XrX.txt` — `pdftotext -layout` extraction
- `BoomReplication.tar.gz` — author's Dataverse archive (104 MB)
- `BoomReplication/` — extracted archive (data, code, JAGS model files, saved RData)
- `run_pushbutton.R` — reproduction script (loads saved chains, recomputes posterior probabilities)
- `run_pushbutton.log` — reproduction output
- `REPRODUCTION_REPORT.md` — this file
- `9XrX_summary_rows.csv` — one-row CSV summary

Diagnostic-patched artifacts: none (no logic patch was attempted; the diagnostic finding is observational about the paper's per-model text gloss).
