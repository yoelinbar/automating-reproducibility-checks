# Reproduction Report — Usmani (2018), "Democracy and the Class Struggle"

**Paper:** Usmani, Adaner. 2018. "Democracy and the Class Struggle." *American Journal of Sociology* 124(3): 664-704. DOI: https://doi.org/10.1086/700235
**Paper IDs:** paper_id=GJe4; claims=GJe4_single-trace
**Reproduction type:** Extended Push Button (one environment-only edit: top-level `set.seed(23)` to substitute for the missing per-iv seed files in `files/`, which the archived `00_replicate.R` tries to load but which are never produced by `00_replicate.R` itself — they are produced as a side effect of `10_mainmods.R`).
**Headline verdict (unpatched):** approximate
**Verdict if patched (only if applicable):** N/A — no logic patch attempted.

## Headline

The focal long-run multiplier for Disruptive Capacity in Table 4 (Electoral Democracy), Model 6, reproduces as **2.797** vs the paper's **2.812** — a ~0.5% gap that fails the rounding-precision test (2.797 rounded to 3 decimals ≠ 2.812) but lands well inside the ±15% approximate band [2.39, 3.23]. The reproduced 95% CI is [0.68, 5.02] vs the paper's [.69, 5.08]; both overlap zero on neither side, both indicate p < 0.01. Sample size N=4,013, 64 countries, 1901–2003 reproduce **exactly** to all printed digits. The deterministic ratio `Σβ_iv / (1 − Σβ_lagdv)` × within-country SD yields **2.793**, so the ~0.019 gap from the paper is consistent with — but slightly larger than — the Monte Carlo noise of the median across 10K simulation draws (across 5 alternative seeds the reproduced mu varies from 2.787 to 2.797). The discrepancy is small but real; possible causes are software-version drift in `plm`/`vcovHC` defaults (R 4.5.2 today vs R 3.4.1 in 2018) or a minor difference in how the within-country SD is computed when scaling. None of this changes the inferential conclusion.

## Comparison table

The claim references Table 4, Model 6 (electoral democracy). The reported sub-outcomes the paper provides numerically are: (i) the long-run-multiplier coefficient (2.812), (ii) its 95% CI (the paper's effect-size analog), (iii) significance level via `**` ⇒ p < 0.01, (iv) N=4,013, (v) 64 countries.

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| GJe4_single-trace | Coefficient (long-run multiplier) | 2.812 | NaN (not in CSV) | 2.797 | precise=2.812 exactly; approx=[2.3902, 3.2338] | approximate |
| GJe4_single-trace | 95% CI lower | 0.69 | NaN | 0.68 | (treated as supplemental) | approximate |
| GJe4_single-trace | 95% CI upper | 5.08 | NaN | 5.02 | (treated as supplemental) | approximate |
| GJe4_single-trace | p-value (threshold) | p < 0.01 (`**`) | NaN | "at alpha=0.01" (i.e. p < 0.01) | precise=≤0.01; approx=(0.01,0.06] | precise |
| GJe4_single-trace | Sample size (obs) | 4,013 | NaN | 4,013 | precise=4013 exactly; approx=[3411,4615] | precise |
| GJe4_single-trace | Countries | 64 | NaN | 64 | precise=64 exactly; approx=[55,74] | precise |
| **OVERALL** |  |  |  |  |  | **approximate** |

Note: the input claim row has all `orig_*` numeric extraction fields as NaN; the only numeric anchor is the `claim_result_text` string "b = 2.812, CI: .69 - 5.08". I therefore treat the paper's printed Table 4, Model 6 row as the canonical original values.

## What I did

1. **Set-up.** Created `independent_reproductions/GJe4_usmani_2018/`, copied `papers/GJe4.pdf` in, ran `pdftotext -layout GJe4.pdf GJe4.txt`. Read `paper_claims/GJe4.json`.

2. **Extraction check.** The claim points at Table 4, Model 6 (Electoral Democracy, preferred specification). Located in the PDF on the page containing "TABLE 4 — Long-Run Estimates, Electoral Democracy" (text-extraction line 1041–1067 of `GJe4.txt`). Verified the printed values exactly:
   - Disruptive capacity LRM: `2.812**`, CI `[.69, 5.08]`
   - Observations: `4,013`
   - Countries: `64`
   - Range: `1901–2003`
   - Average Ni: `62.7`
   - Adjusted R²: `.926`
   The `**` convention is established elsewhere in the paper as α = 0.01 (see lines 1149–1190 of `GJe4.txt`, e.g. "landlord capacity is statistically significant at α = 0.01 in the bivariate, social forces, and preferred specifications (cols. 2, 3, and 6 of tables 3 and 4)").
   The CSV row's `orig_*` numeric fields are all NaN; the `claim_result_text` string ("b = 2.812, CI: .69 - 5.08") matches the paper exactly. No extraction mismatch to flag.

3. **Data/code source.** WebSearch found `https://github.com/ausmani23/demclass` (linked from author's Harvard Scholar page). Cloned into `demclass/`. Repo contains `data/demdfs.RDS` (the prepared panel), `code/00_replicate.R` (focused replication of Tables 3 and 4), and a long pipeline (`10_mainmods.R` … `99_*.R`) for the full paper. README explicitly identifies `00_replicate.R` as the file to run for the main democratization regressions.

4. **Reproduction.** Ran `code/00_replicate.R` after one environment-only edit: the script tries to `readRDS()` per-iv seed files from a `files/` directory that does not exist in the cloned repo (those files are generated by `10_mainmods.R` only when it runs the preferred annual specification). Per the modification policy, "Adding a `set seed` call when the posted code is non-deterministic and didn't set one" is permitted under Extended Push Button. I added `set.seed(23)` once at the top (matching the value used at the top of `10_mainmods.R`) and disabled the per-iv `readRDS(seed.fname)` block. The edited script lives at `run_pushbutton.R` (also copied into `demclass/code/run_pushbutton.R` to satisfy `find_root`). Command:

   ```
   cd demclass/code && Rscript run_pushbutton.R > run_pushbutton.log 2>&1
   ```

   Runtime: < 30 s. Output (`demclass/output/repests.csv`, also captured in `run_pushbutton.log`) row 8 (dv = `v2x_polyarchy`, iv = `L.highcapratio`, the focal cell of Table 4 Model 6):
   ```
   mu=2.79723646, mu.min=0.67355757, mu.max=5.07009982, pval.class="at alpha=0.01"
   ```
   Also confirmed independently in `diagnostic_check.R` (also saved): the deterministic LRM = `Σβ_iv / (1 − Σβ_lagdv) × within-country SD of iv` = `0.8732778 × 3.198284` = `2.79299`, so `mu` is the median of the MC distribution centered at the deterministic value. Sample is `nrow=4013`, 64 countries, year range 1901-2003.

5. **Stochastic-method diagnostics.** The CIs and the reported `mu` come from a Monte Carlo simulation with `reps = 10000` draws of `MASS::mvrnorm`. Across five alternative top-level seeds (23, 42, 99, 7, 12345) the reproduced `mu` ranged 2.787–2.797 and the CI bounds ranged [0.65, 0.69] for the lower and [5.02, 5.14] for the upper. Monte Carlo SE on the median of ~10K draws from this distribution is on the order of 0.005, so the gap between the reproduced ~2.793 (deterministic) and the paper's 2.812 is roughly 4 MC SEs. This means the gap is unlikely to be pure simulation noise — but it is also tiny in absolute and percentage terms (0.7%) and well inside the 15% approximate band. Most likely software-version differences in `plm` / `vcovHC` defaults (the script was written for R 3.4.1; I ran it in R 4.5.2) produce a slightly different point estimate, possibly via tiny differences in within-transformation handling or in how `tapply` / `mean(na.rm=T)` aggregates the within-country SD scaling factor.

6. **Classification.**
   - **Coefficient (long-run multiplier 2.812):** reproduced 2.797 ≠ 2.812 at the paper's 3-decimal precision → not "precise". |2.812 − 2.797| / 2.812 = 0.53% ≤ 15% → **approximate**.
   - **Sample size (4,013):** reproduced 4,013 = paper exactly → **precise**.
   - **p-value threshold (p < 0.01, `**`):** reproduced p-class is "at alpha=0.01" (lowest band reachable from the simulation, equivalent to a reproduced p ≤ 0.01) → **precise**.
   - **CI bounds:** treated as a secondary effect-size sub-outcome paralleling the coefficient; both bounds round differently than printed (.69→.68, 5.08→5.02) but match within ~1.5%; not load-bearing on overall verdict.
   - **Overall (unpatched):** at least one approximate, none "not" → **approximate**.

## Diagnostics — author-bug analysis

Diagnostics: none — the unpatched run reproduces the focal sub-outcomes very closely, with no logic bug in the released code. The only environment edit needed was substituting a top-level `set.seed(23)` for the missing per-iv `*_seed.RDS` files (which `00_replicate.R` expects but which are only ever created as a by-product of running `10_mainmods.R`). I considered whether running `10_mainmods.R` first to generate the actual archived seeds would push the reproduced `mu` from 2.797 to exactly 2.812, but: (a) across 5 alternative top-level seeds the reproduced `mu` only varies by ~0.01, and the median of the MC distribution converges to the deterministic LRM × within-country SD ≈ 2.793 regardless of seed; so (b) the 0.019 gap to 2.812 is not seed-driven, it reflects either a tiny software-version difference in `plm`/`vcovHC` between R 3.4.1 and R 4.5.2 or a minor difference in within-country SD aggregation. Either way the overall verdict (approximate) does not change.

## Files in this folder

- `GJe4.pdf` — copy of the paper (input)
- `GJe4.txt` — `pdftotext -layout` output of the paper
- `REPRODUCTION_REPORT.md` — this report
- `GJe4_summary_rows.csv` — one-row summary for the audit
- `run_pushbutton.R` — Extended Push Button script (= author's `00_replicate.R` + the two-line environment edit described above)
- `run_pushbutton.log` — full console output of running `run_pushbutton.R`
- `diagnostic_check.R` — small standalone re-derivation of the focal cell with multiple seeds + the deterministic LRM (used to verify the MC noise / point-estimate decomposition)
- `demclass/` — the cloned author replication repo (https://github.com/ausmani23/demclass), unchanged except for `code/run_pushbutton.R` (a copy of the edited script needed for `find_root` to locate the project root) and `output/repests.csv` (output of the run)
