# Plan — Independent Reproducibility Checks of 76 Published Papers

## Context

This is an independent reproducibility-audit task. You will be given a list of statistical claims from 76 published social/behavioural-science papers, and your job is to obtain each paper's data and code, rerun the analysis, and judge whether each claim reproduces — using the fixed rubric defined in this plan.

Your verdicts must be derived solely from (a) the published paper, (b) the data and code that paper's authors posted, and (c) the rubric below. Do not consult any prior reproducibility-study results or third-party reproduction databases — even if you happen to find them while looking for data and code, do not let them influence your verdicts.

## Inputs

Two inputs in your working directory:

| Path | What's in it | Use |
|---|---|---|
| `claims_for_verification_clean.csv` | 411 rows × 36 cols. `paper_id`, `claim_id`, paper bibliographic info, claim text, `orig_*` extracted statistics from the paper, `pr_data_location`, `is_published_vor`, `repro_version_of_record`. **No reproduction values.** | Primary input — the work list. |
| `papers/<paper_id>.pdf` | Published-version-of-record PDFs for all 76 papers. | Read these for extraction verification. |

Filter the CSV to `is_published_vor == True` AND `repro_version_of_record == TRUE` → **359 claims across 76 papers**. These are the work units. Process them paper-by-paper (one paper, one report, all of that paper's claims handled together).

The two filters are conjunctive but capture different things:
- `is_published_vor` — paper-level: journal-type, non-COVID, paper has a recognized version of record.
- `repro_version_of_record` — claim-level: this is the canonical reproduction-attempt row. For the 27 claims with multiple analyst attempts, exactly one row is TRUE per claim; that's the row whose `orig_*` extraction defines the comparison target. Some single-attempt claims are also flagged FALSE because they were not canonicalized. Excluding those keeps the audit aligned with the comparison set.

Tooling available:
- Stata at `/usr/local/bin/stata-mp` (run via `stata-mp -b do <file>`)
- R via `Rscript`
- Python with `pandas`, `pyreadstat`, `statsmodels`, `numpy`, `requests`
- `pdftotext -layout` for PDF text extraction
- Standard curl, OSF API (`api.osf.io/v2/nodes/{id}/files/osfstorage/`), Harvard Dataverse API

## Coding rubric — use the exact SCORE Criterion Guide rules

Source: the SCORE program's Reproduction Preregistration Criteria Template (Criterion Guide). **Use these rules verbatim.** Do not improvise; do not soften; do not relax.

For each claim, classify each reported sub-outcome as `precise`, `approximate`, `not`, or `non-outcome` (when not reported in the paper), then combine into an overall verdict per the rules below.

### The official precise / approximate / not bands

| Criterion | Precise (= "Same as original") | Approximate | Not Reproduced |
|---|---|---|---|
| **Sample size** | Same as original | Within 15% of original | > \|15%\| of original |
| **Focal variable p-value** | Same as original | Within 0.05 of original | ≥ \|0.05\| of original |
| **Focal variable coefficient** | Same as original | Within 15% of original | > \|15%\| of original |
| **Focal test statistic** | Same as original | Within 15% of original | > \|15%\| of original |
| **Effect size of focal variable** | Same as original | Within 15% of original | > \|15%\| of original |
| **Secondary Outcomes** | Same as original | [Provided by the analyst] | [Provided by the analyst] |

### What "Same as original" means (the rounding rule)

> **"'Same' means that the number reported in the original paper is identical to the number from the reproduction analysis with rounding to the same number of reported digits."**

This is a **paper-precision rounding rule, not an analyst-precision rounding rule.** Round your reproduced value to the same number of decimal places the paper printed. Then compare to the paper's value.

- Paper prints β = 0.03 (2 decimals); you reproduced 0.0300752 → round to 0.03 → equals 0.03 → **precise.**
- Paper prints β = 0.354 (3 decimals); you reproduced 0.3616 → round to 0.362 → does not equal 0.354 → not precise. Then check approximate: \|0.3616 − 0.354\| / 0.354 = 2.1% ≤ 15% → **approximate.**
- Paper text says "approximately 0.25" (2 decimals); you reproduced 0.2454 → round to 0.25 → equals 0.25 → **precise.** (Do not invent a finer-precision target by going to a figure when the text gives a round number — see worked example below.)

Do not round the paper's value, and do not round to your reproduction's higher precision. The paper's reported precision is the comparison threshold.

### How to compute the approximate band (worked, per criterion)

For sample size, coefficient, test statistic, effect size:
- **Approximate band:** reproduced ∈ `[|orig| × 0.85, |orig| × 1.15]` (i.e., ±15% of \|orig\|).
- **Not:** outside that band.

For p-values, the Criterion Guide gives explicit case logic:

> "**For exact p values:** if the exact p-value is 0.06, precisely reproducing this criterion means 0.06, approximately reproducing this criterion means 0.01 to 0.11, and not reproducing this criterion means ≥ 0.11."
>
> "**For p-value thresholds instead of exact values** — e.g. p < 0.01 — as anything below 0.01 is effectively 'precisely reproduced', we can only apply the approximately and not reproduced criteria in one direction: approximately reproducing this criterion would be 0.01 to 0.06, and not reproducing this criterion would be ≥ 0.06."

So:
- **Exact p-value reported (e.g. p = 0.043):** precise = same to paper's printed precision; approximate = `[max(0, orig − 0.05), orig + 0.05]`; not = outside.
- **Threshold reported (e.g. "p < 0.01"):** any reproduced p < 0.01 = precise. Approximate = `(0.01, 0.06]`. Not = > 0.06.
- **Threshold "p < 0.001":** any reproduced p < 0.001 = precise. Approximate = `(0.001, 0.051]`. Not = > 0.051.
- **Threshold "p < 0.05":** any reproduced p < 0.05 = precise. Approximate = `(0.05, 0.10]`. Not = > 0.10.

Apply the threshold rule **only in one direction** (toward larger reproduced p-values). Do not penalize a reproduction for being more significant than the threshold.

### What evidence is eligible as the original value

Direct quote from the Criterion Guide:

> **"All criteria, including secondary outcomes, are restricted to numeric evidence, i.e., non-inferential numeric evidence is eligible, like descriptive stats, but non-numeric evidence is not, like describing a plot/figure; the latter should be captured only in the analyst success criteria."**

Apply this strictly. The "original value" anchoring your bounds must be a numeric value the paper actually prints. If the paper's only quantitative source for a sub-outcome is a coefficient plot with no numerically labeled axis points, treat that sub-outcome as `non-outcome` for the rubric and address it through analyst success criteria narrative — do **not** read off a number with graphreader and treat that as the original value. (See worked example below.)

When **both** text and figure carry the value, use the text. The text is unambiguously numeric; figure-reading introduces measurement error.

### Non-outcome and the overall verdict

If a sub-outcome isn't reported in the paper for that claim, classify it `non-outcome` and skip it when combining into the overall verdict.

After classifying all reported sub-outcomes:
- `precise` if every reported sub-outcome is `precise`.
- `not` if any sub-outcome is `not`.
- `approximate` otherwise (at least one `approximate`, none `not`).

### Worked example — the rounding rule applied

Paper text: *"the coefficient is approximately 0.25."*
Paper's coefficient plot (a separate figure): visual reading via graphreader is ~0.24.
Author's regression code, run on author's data: coefficient = 0.2454.

**Correct application of the rubric:**
- Original value = 0.25 (from text, 2 decimals).
- Reproduced 0.2454 → rounds to 0.25 at 2 decimals → equals 0.25 → **precise.**

**Incorrect application** (the cautionary case): use graphreader to extract 0.24 from the figure, then defend a `precise` verdict by arguing 0.245 ≠ 0.25 if rounded up. This inverts the rounding rule (round to *paper's* precision, not analyst's), introduces graphreader measurement error into the comparison target, and bypasses the canonical text-derived value. The verdict still might come out `precise` but for the wrong reason — and the same path on a less forgiving claim could flip the verdict.

### Reproduction types (pick the lightest one that works)
- **Push Button** — authors' code on authors' data, no modification
- **Extended Push Button** — minor edits (paths, package versions, deprecated syntax)
- **Source Data Reproduction** — rebuild the analysis from public raw data because no runnable code was posted
- **Author Data Reproduction** — restricted data, request from author

## Modification policy — run code as-archived for the headline verdict

The audit's headline verdict must reflect **running the archived analysis as-archived and judging what it produces.** This is a deliberately conservative posture and disagrees with a "fix it until it matches" instinct. Without this discipline the audit answers a different question than the SCORE protocol does and headline rates become incomparable. The empirical pattern in SCORE: analysts modified environment freely, modified analysis logic rarely, and *diagnosed* author bugs constantly without patching them.

### Allowed under Push Button (no edits)
Run the posted code on the posted data unchanged. If it errors out because of an obviously environment-only issue, you may still call it Push Button after fixing only:
- Working directory / file paths.
- A missing `library()` / `require()` / `use` line where the package is installed.
- A package that has been renamed (e.g. R `Design` → `rms`) where the API is identical.
- Commenting out lines that only export figures or write artifacts the analysis doesn't depend on.

### Allowed under Extended Push Button (minor logic-adjacent edits)
- Replacing a deprecated function name with its current equivalent, when the documented behavior is unchanged (e.g. `aggregate.data.frame` → `aggregate`).
- Updating a syntax that changed across software versions (e.g. Stata `xi: regress` → factor-variable notation), when the statistical specification is unchanged.
- Adding a `set seed` call when the posted code is non-deterministic and didn't set one (note this prominently — it changes which exact draw you get).
- Substituting an updated package version when the API or default arguments changed.
- Restoring a missing line that the author clearly omitted by accident, when the omission breaks execution and the line is uncontroversial (e.g. reinstating a `factor()` call that's needed for an ANOVA to run).
- Trivial recoding rearrangements when the posted analysis returns the right magnitude with the wrong sign because of a `0`/`1` column-order convention.

### NOT allowed for the headline verdict (even if you spot the bug)
- Patching analysis logic. Filter clauses, model specifications, sample-restriction conditions, variable names that point to the wrong column.
- Changing which variable enters the regression even if the posted variable is "obviously" wrong.
- Re-deriving an N-restriction from the paper text when the posted code's N differs from the paper's printed N.
- Inferring "what the author meant" and substituting that.
- Adding a filter that's not in the posted code, even if it brings N to the printed value.

If you do any of these, **the headline verdict must reflect running the unpatched code.** Diagnosis goes in the diagnostic section below, not in the verdict.

### Diagnostic section (required when there's anything to diagnose)
Every report must include a `## Diagnostics — author-bug analysis` section beneath the comparison table, separate from the headline verdict, containing:

1. **What the unpatched run produced** (already in the comparison table).
2. **What you suspect is the bug** in the author's code or the released data, with file/line references.
3. **What a patched run would produce** if you applied the fix. Run it; report the numbers; do not promote them into the verdict.
4. **A clear "verdict if patched"** alongside the headline verdict, so a reader can see both lenses.

This separation matters: it preserves protocol-comparability for the headline rate while still surfacing what the audit *learned* about the paper. Diagnose extensively (sample-size typos, sign-convention errors, missing exclusions, code-version mismatches) but keep those diagnoses out of the verdict.

### Worked patterns
- **Author do-file references a wrong filter clause / variable name.** If the posted do-file has `outcome==3` but the variable that produces the paper's N is `earlysettle==0`, *running unpatched* (with the wrong filter) is your headline. Patch in the diagnostic section, report a "verdict if patched."
- **Author's released data has extra rows the paper excluded.** If the released `.dta` has rows with `tax_rev_new > 100` that the paper's printed N excludes but the posted code does not contain that filter, *do not add the filter for the headline verdict.* Headline keeps the unpatched-N result; diagnostic section reports what the filter does.
- **Author's R code uses a deprecated package with a renamed equivalent (identical API).** Substituting in the renamed package is allowed under Extended Push Button — note the edit in the report but keep the verdict.
- **Trivial environment fixes** (commenting out `graph export ... .png` lines that need an image translator, reinstating a `library()` call for an installed package): allowed under Push Button or Extended Push Button — note in the report.

## Per-paper workflow

For each `paper_id` in the filtered list:

### 1. Set up reproduction directory
Create `independent_reproductions/<paper_id>_<firstauthorlast>_<year>/` (e.g. `independent_reproductions/Pxp7_paler_2013/`). All work for this paper goes here. Copy `papers/<paper_id>.pdf` in. If the PDF is missing, mark the paper blocked and move on; do not invent paper content.

### 2. Verify the extraction against the paper
Pull all rows for this `paper_id` from `claims_for_verification_clean.csv`. For each claim, find the corresponding statistic in the actual PDF — table, in-text result, or wherever the paper reports it. Confirm the `orig_coef_value`, `orig_stat_value`, `orig_p_value`, `orig_sample_size_value`, and `orig_effect_size_value_repro` printed in the paper match the extracted values to all reported digits.

This step is non-optional. Some papers exist in multiple published versions (preprint v1 → v2 → … → journal article) where statistics changed silently between versions. If the extraction does not match what the paper currently prints, you must record that mismatch in your report — the published version is authoritative for this audit.

### 3. Get the data and code
`pr_data_location` field gives a starting hint. Common sources: OSF, Harvard Dataverse, AEA replication archive, journal supplementary materials, author website, ICPSR. Save what you obtain into the paper's reproduction directory. If data is genuinely unavailable from these sources, mark the paper not-attemptable and move on.

### 4. Run the reproduction
Pick the lightest reproduction type that works (see list above). Stata `.do`/`.ado` files run via `stata-mp -b do <file>`. R via `Rscript`. SPSS `.sps` syntax is read-only — re-implement in Python (`pyreadstat.read_sav`) or R (`haven::read_sav`). Save all outputs (logs, intermediate `.dta`/`.RData`, console output) into the paper's reproduction directory.

### 5. Compare three values per sub-outcome
For each reported sub-outcome you have a number for, record three values:
- **Paper** — what the published article actually prints (you re-read it in step 2)
- **Extracted** — what's in the input CSV (`orig_*`)
- **Reproduced** — what your run produced

If extracted ≠ paper, the upstream extraction is wrong — log it prominently. If reproduced ≠ paper, the data/code does not yield the published value — log it prominently. Apply the rubric only to *reproduced vs paper*; the extraction comparison is a separate diagnostic.

For stochastic reproductions (randomization inference, bootstrap, Bayesian MCMC, etc.), report the Monte Carlo SE of your estimate (`√(p(1−p)/n_reps)` for tail probabilities) so the reader can see whether a paper-vs-reproduced gap is consistent with simulation noise or not. A gap larger than ~3 MC SEs is not noise.

### 6. Classify per the rubric
For each sub-outcome compute the bounds from the paper's value, classify as precise / approximate / not / non-outcome, then combine into the overall verdict per the rules above. Record the bounds you computed and the reproduced value's position relative to them.

### 7. Write `REPRODUCTION_REPORT.md` in the paper's reproduction directory
Required structure:

```
# Reproduction Report — <FirstAuthor> (<Year>), <ShortTitle>

**Paper:** full citation, DOI
**Paper IDs:** paper_id=<X>; claims=<list of claim_ids>
**Reproduction type:** Push Button | Extended Push Button | Source Data | Author Data | Not attemptable
**Headline verdict (unpatched):** precise | approximate | not | not-attemptable
**Verdict if patched (only if applicable):** precise | approximate | not — see Diagnostics

## Headline
One paragraph on the most important finding, especially any deviation. Lead with the deviation; do not bury it. The headline verdict must reflect running the archived code unpatched (modulo the environment-only edits permitted under Push Button / Extended Push Button per the modification policy).

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |

## What I did
1. Set-up: directory, files copied/downloaded
2. Extraction check: which paper page/table/equation each claim came from, whether the extracted value matches
3. Data/code source: where obtained, file inventory
4. Reproduction: exact commands run, runtime, output snippets. Note any environment-only edits (paths, package renames, missing `library()` lines) and confirm they don't touch analysis logic.
5. Stochastic-method diagnostics (if any): MC SE, n_reps, seed handling
6. Classification: bounds computed, sub-verdicts, overall verdict — for the unpatched run only

## Diagnostics — author-bug analysis (required when applicable)
Use this section, and only this section, for any logic-level patches you considered or applied. Do not let these promote into the headline verdict.

- **Suspected bug:** what's wrong in the posted code or released data, with file/line references. Quote the offending line.
- **Reasoning:** why you think it's a bug (e.g. "filter clause `outcome==3` references a variable that doesn't exist; `earlysettle==0` is the variable that produces the paper's N").
- **Patched run:** the exact edit, the new output, the bounds it lands in.
- **Verdict if patched:** precise / approximate / not — recorded as a parallel verdict, not the headline.
- **Confidence:** how sure you are that this is a bug versus a legitimate spec disagreement (low / medium / high). If the patch requires inferring author intent from the paper text, flag that.

If there is nothing to diagnose, say so explicitly: `Diagnostics: none — unpatched run reproduces / does not reproduce; no logic bug suspected.`

## Files in this folder
List everything saved. Distinguish unpatched run artifacts from patched-diagnostic run artifacts (e.g. `run_pushbutton.do` / `run_pushbutton.log` vs `diagnostic_patched.do` / `diagnostic_patched.log`).
```

## Output structure

```
independent_reproductions/
  <paper_id>_<firstauthor>_<year>/
    <paper_id>.pdf
    <paper_id>.txt                  # pdftotext output
    <author-data-and-code-files>
    run_*.do | run_*.R | run_*.py
    *.log
    REPRODUCTION_REPORT.md
  _summary.csv                       # one row per claim
```

`_summary.csv` columns:
`paper_id`, `claim_id`, `repro_type`, `paper_value`, `extracted_value`, `reproduced_value` (unpatched), `extraction_matches_paper` (yes/no), `bounds_lb`, `bounds_ub`, `outcome_sample`, `outcome_coef`, `outcome_stat`, `outcome_p`, `outcome_effect`, `outcome_overall` (unpatched), `outcome_overall_if_patched` (`NA` if no patch was tried), `headline_note`.

## Failure modes to watch for

- **Multiple paper versions.** Preprint v1 vs v2 vs journal article can differ silently. Always work from the published version of record. If the version-of-record's printed statistics differ from the extracted ones, that's a finding — log it, don't paper over it.
- **Stochastic methods.** Randomization inference, bootstrap, MCMC, etc. produce a different number every run. Report Monte Carlo SE alongside any rerun. A gap > 3 MC SEs from the paper's published value is real, not stochastic noise — even if the original code does set a seed, the seed handling is sometimes broken (e.g. `set seed` inside a `simulate` loop resets the RNG every iteration).
- **Code that doesn't match the posted analysis.** Some authors post simplified or partial code — running it does not always reproduce the table they claim it produces. If the reproduction differs from the paper but the code matches what the author says it does, report that gap; don't try to reverse-engineer the "true" code.
- **Variable-name drift.** Posted code may reference column names that no longer exist in the posted data (renamed, recoded). Check that the variables the code touches actually exist with those names.
- **Listwise vs case-wise N.** The N in a paper's table may be after listwise deletion on the regression, while the dataset has more rows that don't have all the predictors. Match the paper's N exactly before trusting downstream coefficients.

## Verification — how the user will spot-check

The user will pick 2–3 random papers from the agent's output and re-read the report against the paper PDF and the data/code. The agent passes the spot-check if:
- Each claim's `orig_*` value is correctly traced to a specific page/table/equation of the published paper.
- The reproduction commands listed are actually what was run, and their output is in the directory.
- The classification follows the rubric mechanically — bounds computed correctly from the paper's value, reproduced value plotted against them.
- Any deviation between paper and reproduction is highlighted in the headline, not buried.
- The headline verdict reflects the unpatched run; any logic-level patches live in the Diagnostics section with a separate "verdict if patched" call.
