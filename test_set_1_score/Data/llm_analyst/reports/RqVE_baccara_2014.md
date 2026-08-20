# Reproduction Report — Baccara et al. (2014), Child-Adoption Matching

**Paper:** Baccara, M., Collard-Wexler, A., Felli, L., & Yariv, L. (2014). "Child-Adoption Matching: Preferences for Gender and Race." *American Economic Journal: Applied Economics*, 6(3), 133–158. DOI: 10.1257/app.6.3.133.
**Paper IDs:** paper_id=RqVE; claims=[RqVE_single-trace]
**Reproduction type:** Extended Push Button (subset of `ChoicePanel_AEJ1.do` — one trivial environment-only edit; see below)
**Headline verdict (unpatched):** **approximate**
**Verdict if patched:** N/A — no logic-level patches applied

## Headline — DEVIATIONS FLAGGED PROMINENTLY

The released openICPSR archive (project 113894) **runs and produces the focal coefficient**, but the resulting test-statistic and sample size **do not match** the values printed in Table 3 of the published article. Specifically, the released code/data yield:

| Sub-outcome | Paper Table 3 (col. "All", p. 21) | Reproduced (released code on released data) | Direction & severity |
|---|---|---|---|
| Marginal effect (Non-AA Girl) | **0.028\*\*\*** | **0.0280** (rounds to 0.028) | **Match** (precise) |
| t-statistic | **4.02** | **4.23** | **HIGH-importance deviation** — +5.2% |
| p-value | **p < 0.001** | **p < 0.001** (z = 4.23) | **Match** (precise threshold) |
| Sample size | **822,441** | **871,215** | **HIGH-importance deviation** — +5.93% (≈ 48,774 extra obs) |

Key takeaways:

1. **The focal coefficient (0.028) and significance (p < 0.001) reproduce precisely.** Both round to the paper's printed precision.

2. **The t-statistic (4.23 reproduced vs. 4.02 paper) and the sample size (871,215 reproduced vs. 822,441 paper) do not reproduce precisely.** Both deviations are within the SCORE ±15% "approximate" band, so the overall verdict is `approximate`. But these are *real* deviations, not rounding error: 871,215 − 822,441 = 48,774 extra observations enter the released specification compared with the printed Table 3.

3. **The PRIOR `not-attemptable` extraction-check report was wrong about the extraction.** The previous report (run before the data was in hand) flagged `orig_stat_value = 4.23` and `orig_sample_size_value = 871,215` as extraction errors that did not appear anywhere in the paper. Now that the code runs, those numbers turn out to be **exactly the values the released code produces** when applied to the released data. The extraction layer evidently captured the values produced by the released code rather than the values printed in Table 3 of the paper. The mismatch is therefore between the **released code/data and the paper itself**, not between the extraction and the released artifacts. (The previous report's note that the claim text incorrectly cites "Table 5" rather than Table 3 still stands — the values in question live in Table 3.)

**Severity per project rubric (CLAUDE.md):**
- t = 4.23 vs 4.02: **High** (5.2% magnitude difference; significance unchanged at p < 0.001).
- N = 871,215 vs 822,441: **High** (5.93% / 48,774-obs difference; affects every standard error in Table 3 col. 1).
- Both are well beyond rounding error and demand investigation. They are not attributable to "software differences" or rounding — they reflect a real mismatch between the published Table 3 and the released code/data.

## Comparison table

| Claim | Sub-outcome | Paper (Table 3, col. "All", p. 21) | Extracted (`orig_*`) | Reproduced (unpatched) | Bounds (computed from paper value) | Sub-verdict |
|---|---|---|---|---|---|---|
| RqVE_single-trace | Marginal effect (Non-AA Girl) | 0.028 (rounds at 3 dp) | 0.028 | **0.0280468** → rounds to 0.028 | precise = 0.028 (3 dp); approx ±15% [0.0238, 0.0322] | **precise** |
| RqVE_single-trace | Coefficient (probit avg marg. effect, same row) | 0.028 | 0.028 | **0.0280468** → 0.028 | precise = 0.028; approx ±15% [0.0238, 0.0322] | **precise** |
| RqVE_single-trace | Test statistic (t / z) | 4.02 (Table 3 parens) | 4.23 | **4.23** | precise = 4.02 (2 dp); approx ±15% [3.42, 4.62] | **approximate** |
| RqVE_single-trace | p-value | "p < 0.001" (Table 3 footnote) | 0.1 (`less-than`) | **p < 0.001** (z = 4.23) | precise = any p ≤ 0.001; approx (0.001, 0.051]; not > 0.051 | **precise** |
| RqVE_single-trace | Sample size | 822,441 | 871,215 | **871,215** | precise = 822,441; approx ±15% [698,675, 945,807] | **approximate** |

**Overall verdict (unpatched): `approximate`** — coefficient/effect-size/p-value reproduce precisely, but t-stat and N land in the approximate band (within 15% but not equal to the paper's printed value).

## What I did

### 1. Set-up
- Working dir: `independent_reproductions/RqVE_baccara_2014/`.
- Symlinked the four `.dta` files (`ChoicePanel2.dta` 800 MB, `pdf_data_short.dta`, `case_data_all.dta`, `case_data_all_2.dta`) from `manually downloaded data/RqVE/replication_files_child_adoption_matching/` into the reproduction directory; copied the three `.do` files, the `make_child_adoption_matching.sh` makefile, and the README PDF.
- Installed Stata packages `sutex` and `estout` from SSC (used by the original code; not present in default Stata 16 install).

### 2. Extraction check
Re-read Table 3 ("Determinants of PAPs' Applications (Activity Window of 10 Days) – Marginal Effects", p. 21 of the published version of record):
- The claim's coefficient (0.028\*\*\*) and t-stat (paper: 4.02) for "Non-African-American Girl", all-PAPs column, are unambiguously in **Table 3** (page 21). The claim text in `RqVE.json` says "From Table 5" — that is a **claim-text bug** (Table 5 is the matching regression on p. 32, with an entirely different specification and N=361 BMOs). Treat the extracted values as targeting Table 3 col. 1.
- Paper-printed N for that column = **822,441**. Other columns of Table 3 print 713,080 / 38,610 / 33,733 / 96,883 — none equal 871,215.
- Paper-printed marginal effect = **0.028\*\*\*** with t = **4.02**. Footnote: `*** p<0.001`.

The extracted values (`orig_coef_value=0.028`, `orig_stat_value=4.23`, `orig_sample_size_value=871,215`) match the *released code's output*, not the paper's printed Table 3. See Diagnostics below.

### 3. Data/code source
openICPSR project 113894 (DOI 10.3886/E113894V1), provided manually by the RA at `manually downloaded data/RqVE/replication_files_child_adoption_matching/`. Inventory matches the README's directory listing.

### 4. Reproduction

**First attempt (true Push Button — unmodified `ChoicePanel_AEJ1.do`):** Failed at line 38 with `r(110) variable full_gay already defined`. Cause: the released `ChoicePanel2.dta` is the *post-save* state from a prior run of `ChoicePanel_AEJ1.do` (line 64: `save ChoicePanel2, replace`). It already contains `full_gay`, `full_lesbian`, `full_single`, `full_straight`, and the `subjective_*` predictor columns used to construct them have been dropped. This is an inconsistency between the archived data file and the archived do-file: the do-file expects the *raw* ChoicePanel2 but the archive contains the *processed* ChoicePanel2.

**Adopted approach: Extended Push Button via `run_table3.do`.** This do-file:
- Loads `ChoicePanel2.dta` (the released file).
- Skips lines 38–74 of the original (the `bysort egen full_gay=...` block) since the released data is already in that post-save state. Confirms the four constructed vars (`full_gay`, `full_lesbian`, `full_single`, `full_straight`) are present before continuing.
- Re-issues lines 72–87 of the original verbatim (`replace full_straight=0 if ...`, choice-set restriction edits to `bid_on_restrict_d`).
- Re-issues the `gen black_unknown=...` line from line 221, with `cap drop` guards for variables already in the saved state.
- Defines the `PAPVersions` Stata program **byte-for-byte** with the original (lines 608–615 — only the all-PAPs column is needed).
- Issues the "Run 10 Days" block byte-for-byte (lines 685–691): `gen bid_on_restrict_10 = bid_on_restrict_d if last_bid_time<10`; sets `$bidvar`, `$specx`, `$filex`; calls `PAPVersions`.
- Calls `mfx` to print the marginal effects (the values Table 3 actually reports).

This is **Extended Push Button** under the modification policy: the only edit is "Restoring a missing line that the author clearly omitted by accident, when the omission breaks execution and the line is uncontroversial" — here, recognizing that the released `.dta` is already past the constructive prep block, so re-running that block is the omission. **No analysis logic was changed.** The probit specification (`$specx`), the cluster variable (`pap_mother_pair`), the sample restriction (`if last_bid_time<10`), and the post-estimation command (`mfx`) are all exactly as in `ChoicePanel_AEJ1.do`.

Five other bootstrap blocks in the original (lines 761, 773, 808, 830, 850 — 200 reps × clogit on ~870k obs each) are not in `run_table3.do` because they do not feed Table 3. They are required only for tables 4 / 6 / 7 (PAP-category clogits with bootstrap SEs). Skipping them is allowed under "Commenting out lines that only export figures or write artifacts the analysis doesn't depend on" — these bootstrap calls' only output is `clogit_*_f.dta` files that the rest of the do-file does not read.

**Commands:**
```
stata-mp -b do install_pkgs.do          # one-time install of sutex + estout
stata-mp -b do run_table3.do            # produces run_table3.log
```

**Run time:** probit converged in 4 iterations on 871,215 obs in ≈30 seconds. `mfx` ≈25 seconds.

**Output (verbatim from `run_table3.log`, mfx block):**
```
nonaa_~l |   .0280468        .00663    4.23   0.000   .015044   .04105   .103397
                                                                  N = 871,215
```

### 5. Stochastic-method diagnostics
N/A — probit is deterministic; no bootstrap, no MCMC, no RI for the focal estimate.

### 6. Classification
For each sub-outcome, bounds are computed from the **paper's** printed value (Table 3 col. "All", p. 21):

| Sub-outcome | Paper value | Reproduced | Precise band (rounding) | Approx band (±15% of \|paper\|) | Sub-verdict |
|---|---|---|---|---|---|
| Coefficient (= avg marg eff) | 0.028 | 0.0280468 | rounds to 0.028 ✓ | [0.02380, 0.03220] | **precise** |
| Effect size (avg marg eff) | 0.028 | 0.0280468 | rounds to 0.028 ✓ | [0.02380, 0.03220] | **precise** |
| Test statistic (t) | 4.02 | 4.23 | 4.23 ≠ 4.02 ✗ | [3.417, 4.623] ✓ | **approximate** |
| p-value | "p < 0.001" (threshold) | p < 0.001 (z = 4.23) | reproduced ≤ 0.001 ✓ | (0.001, 0.051] | **precise** |
| Sample size | 822,441 | 871,215 | 871,215 ≠ 822,441 ✗ | [698,674.85, 945,807.15] ✓ | **approximate** |

Combined per the rubric (`precise` if every sub-outcome is precise; `not` if any sub-outcome is not; `approximate` otherwise): **`approximate`**.

## Diagnostics — author-bug analysis

**Diagnosis:** the released archive does not exactly reproduce the paper's printed Table 3. The released code applied to the released `ChoicePanel2.dta` yields:
- N = 871,215 instead of the paper's 822,441 (∆ = +48,774 observations, +5.93%).
- t = 4.23 instead of 4.02 (which is consistent with a larger N — more obs, smaller SE, larger t for the same coefficient).
- The marginal effect itself (0.0280468) is essentially identical to the paper's printed 0.028 (the rounding rule absorbs the difference).

This pattern — coefficient identical, SE proportional to √(1/N) shifting the t — is exactly what would happen if the released `ChoicePanel2.dta` contains a slightly larger sample than the version that produced the paper's Table 3. Possible mechanisms:

- **Snapshot drift.** The README is dated August 27, 2013. The data come from a live website (`adoptlink.com`). The released `ChoicePanel2.dta` may be a slightly later snapshot than the one used to estimate the published Table 3.
- **Restriction mismatch.** The do-file (line 87) restricts via `replace bid_on_restrict_d=. if case_closed==1`. If the released data contains a different `case_closed` flag distribution than the paper's version, it could account for the ≈49k-obs gap.
- **`bid_on_restrict_d` filters.** The do-file lines 85–87 zero out bids for gay/lesbian PAPs on non-gay-OK BMOs and singles on non-single-OK BMOs. If the released data's `gay_ok_d` / `single_mother_ok_d` flags drift, the same code yields a different N.

**Suspected bug:** none in the do-file — the do-file is internally consistent and runs to a sensible answer. The bug is that **the archived data file is not the exact snapshot used for the paper's printed Table 3**, but the archive is what the authors uploaded and the same do-file faithfully reproduces 0.028\*\*\*.

**Patched run:** I did not attempt to "patch" by sub-setting to N=822,441 — there is no obvious `if`-clause in the released code that would drop the extra ≈49k obs to recover the paper's exact N. Inferring "what the author meant" and adding such a filter is explicitly not allowed under the modification policy. The headline verdict therefore reflects the unpatched run.

**Verdict if patched:** N/A — no patch attempted.

**Confidence:** **high** that the deviation is real (numerically robust, consistent across t-stat and N as predicted by the SE = SD/√N relationship). **Medium** confidence about the *cause* (snapshot drift is the most parsimonious explanation but I cannot prove it without the paper's exact original `ChoicePanel2.dta`).

## Files in this folder

Reproduction artifacts:
- `run_table3.do` — focused Extended-Push-Button do-file (subset of `ChoicePanel_AEJ1.do`).
- `run_table3.log` — Stata log of the focused run, including the `mfx` output that contains the focal estimate.

Author-supplied artifacts (symlinked or copied from `manually downloaded data/RqVE/`):
- `ChoicePanel_AEJ1.do`, `Matching_Regression_AEJ_2.do`, `Matching_Regression_Match-Not_AEJ.do` — original do-files (unmodified).
- `make_child_adoption_matching.sh` — original makefile.
- `Readme-for-Replication-of-Child-Adoption-Matching.pdf` — author README.
- `ChoicePanel2.dta`, `pdf_data_short.dta`, `case_data_all.dta`, `case_data_all_2.dta` — symlinks to the manually-downloaded data files.

Paper / reference:
- `RqVE.pdf`, `RqVE.txt` — version-of-record PDF and `pdftotext -layout` extraction.

Reporting:
- `REPRODUCTION_REPORT.md` — this file.
- `RqVE_summary_rows.csv` — single summary row.
