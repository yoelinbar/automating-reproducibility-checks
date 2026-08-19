# Overall Reproduction Report

**Exercise:** Computational reproduction, error-detection, and robustness checks across 11 published quantitative social-science papers, each from its own PDF + original replication package.
**Run date:** 2026-06-19
**Total wall time (whole run, all papers in parallel):** **657 seconds ≈ 11 minutes** (global start→end, orchestrating instance).
**Papers run:** 11 (Paper 09 *Sorting or Steering*, JPE 2022, **excluded** — replication package no longer available).
**Protocol per paper:** Task 1 reproduce assigned exhibit as-is → Task 2 open-ended error/irregularity hunt → Task 3 up to two robustness checks. One general-purpose sub-agent per paper, working only from that paper's PDF + package.

---

## ⚠️ TOP SECTION — REPRODUCTION DISCREPANCIES BEYOND ROUNDING (per `CLAUDE.md` policy)

Per project policy, **any deviation in statistics beyond rounding error is VERY meaningful** and is flagged and categorized here, prominently, regardless of whether the paper's headline survives.

**9 of 11 assigned exhibits reproduced exactly to displayed precision.** **2 did not reproduce as printed, and a 3rd reproduced point-estimates/SEs but not a published significance star.** All three are **CRITICAL** under the policy (a sign flip or a significance change).

### 🔴 CRITICAL — Paper 02 (Terrorism, NHB 2023): assigned exhibit NOT reproduced; headline reverses under corrected variable
- **Assigned:** Table 1, Model IIa (GMM dynamic panel). **Only N=420 matched.** No coefficient reproduced to displayed precision; the package **ships no estimation code** (only a plotting script), so the model had to be reconstructed.
- **Sign/significance deviations:** deterrence coefficients off by 4–5×; sentence-length coefficient differs in sign and significance.
- **Root cause (Task 2, Critical):** the "arrest rate" regressor is constructed **inverted** vs the paper's own definition — `asinh(attacks/(arrests+1))` (attacks-per-arrest), not arrests/attacks. Rebuilt as *described*, the arrest coefficient **flips to positive and loses significance (P=0.119)** — i.e., the headline "arrests deter terrorism" is an artifact of the inverted variable.
- **Note:** the supplied PDF is the **retracted** version of the article. (This was observed in the package/PDF itself, not looked up.)

### 🔴 CRITICAL — Paper 01 (Acquiescence, Political Analysis 2023): printed Table 2 col 3 not reproducible from shipped data; two sign flips + N mismatch
- Columns 1–2 reproduce exactly. **Column 3 (with covariates) does not match the printed table** — and the breakage is driven entirely by the shipped `education` variable (a 1–8 scale with 14 `-3105` miscodes; the printed coefficient 0.00002/SE 0.00001 is incompatible with a 1–8 variable).
- **Printed → reproduced (package code+data):** Pos-keyed main effect **0.170 → 0.069**; Education **0.00002 → −0.011 (sign flip)**; Pos-keyed×Education **−0.0001 → 0.024 (sign flip)**; **N 15,419 → 15,286**.
- The package's own shipped `_Table02.tex` matches the *code*, not the *printed paper*. Dropping the miscoded education term reproduces printed col 3 almost exactly (Pos keyed 0.171≈0.170; N=15,419) — i.e., the printed column was effectively estimated without the shipped education variable.
- **Mitigant:** the paper's *substantive* headline for this column (Pos-keyed × Aligned interaction = 0.025) does reproduce.

### 🔴 CRITICAL — Paper 11 (Savings, Economic Journal 2022): published significance star not reproducible
- Point estimates, SEs, mean of DV, and N **all reproduce exactly** (TT=0.0161, TC=0.0123, N=56,308 obs / 28,154 dyads).
- **But** the published 5% significance star on the **TC (one_treated)** coefficient (0.0123\*\*) is **not reproducible** from the package's own stated method (clustered wild bootstrap `boottest`): run as written it gives **p≈0.051–0.063** (→ 10% at best; 95% CI includes zero) under Rademacher, Webb, and jackknife weights. The published \*\* instead matches the plain asymptotic t-test (p=0.035), contradicting the rule stated in the table notes and README.
- **Mitigant:** the headline TT effect (0.0161\*\*\*, p≈0.004–0.007) is robust under every method; the affected claim is secondary.

### Moderate / cosmetic reproduction notes (no numeric deviation)
- **Paper 03 (Policymakers):** Figure 4 reproduces exactly (all 18 point estimates match; PNG visually matches). The only deviation is a **Moderate cosmetic** one — the shipped code's x-axis factor ordering (Least/Somewhat/Most) does not match the published left-to-right ordering (Somewhat/Least/Most); labeled values are identical.
- **Paper 04 (Waiting):** the published *numbers* reproduce exactly, but the **shipped code as-written does not** produce printed col 6 (it restricts to `if any_time==1`, N=107,749, p=0.011; the printed col 6 is full-sample N=210,586, p=0.066), and the corrected income variables referenced by the tables code don't exist in the shipped cleaned data. Classified Moderate (code/data mismatch, not a numeric deviation in the printed exhibit).

---

## Summary table across all papers

| NN | Paper (journal, year) | Assigned exhibit | Reproduced? | Min-to-repro | # issues | # robustness | Worst repro-discrepancy |
|----|----------------------|------------------|:-----------:|:-----------:|:--------:|:-----------:|------------------------|
| 01 | Acquiescence (Pol. Analysis '23) | Table 2, col 3 | **N** | not reproduced* | 5 | 2 | 🔴 Critical |
| 02 | Terrorism (NHB '23) | Table 1, Model IIa | **N** | not reproduced | 6 | 2 | 🔴 Critical |
| 03 | Policymakers (APSR '21) | Figure 4 | Y | ~2 | 3 | 2 | Moderate (cosmetic) |
| 04 | Waiting (NHB '23) | Table 1, Panel A | Y | ~7 | 5 | 2 | Moderate (code/data) |
| 05 | Gambling (AEJ:Applied '21) | Table 3, col 2 | Y | ~1 | 1 | 2 | None |
| 06 | Mortality (RESTUD '24) | Table 1, col 6 | Y | ~2 | 5 | 2 | None |
| 07 | Electricity (Econ. Journal '22) | Table 2, col 2 | Y | ~3 | 4 | 2 | None (repro exact)† |
| 08 | Gratitude (Psych. Science '24) | Table 1, Model 2 | Y | ~1 | 3 | 2 | None |
| 10 | Price is Right (Econ. Journal '24) | Table 1, col 6 | Y | ~2 | 3 | 2 | None |
| 11 | Savings (Econ. Journal '22) | Table 1, col 3 | Y‡ | <1 | 5 | 2 | 🔴 Critical (sig star) |
| 12 | Tax pass-through (Econ. Journal '22) | Figure 2 | Y | ~3 | 5 | 2 | None (repro exact)† |

\* Paper 01: cols 1–2 reproduce exactly in ~1 min; printed col 3 is not reproducible from shipped data.
† Papers 07 & 12 reproduce the assigned exhibit exactly, but carry a **High**-severity Task-2 issue whose *fix* materially changes inference (see below) — these are error/robustness findings, not reproduction deviations.
‡ Paper 11: point estimates/SEs/N reproduce exactly; a published significance star does not.

**Totals:** Reproduced **9/11** (exhibit numbers) · **45** issues/irregularities flagged · **22** robustness checks run (2 per paper).

---

## Aggregate stats — minutes-to-reproduction (the 9 papers reproduced)

Values (min): 1, 1, 1, 2, 2, 2, 3, 3, 7.

- **Min:** 1
- **Median:** 2
- **Mean:** ~2.4
- **Max:** 7 (Paper 04 — required recovering the authors' cleaned ATUS data after BLS blocked automated downloads)

(Papers 01 and 02 excluded — not reproduced.)

---

## Notable Task-2 findings that could affect main claims (beyond the reproduction discrepancies above)

These reproduced *exactly* but the error hunt surfaced specification issues whose correction moves inference:

- **🟠 Paper 07 (Electricity) — High:** the paper states all regressions include quarterly dummies, but the IV columns (2/6) **omit them** (only the OLS col 1 includes `i.trim`). Adding them moves the headline Reform coefficient **−0.123 → −0.170 (+38% magnitude)**; sign/significance unchanged.
- **🟠 Paper 12 (Tax pass-through) — inference level:** treatment is assigned at the **province** level (4 of 8 provinces) but SEs are clustered at the **gas-station** level. A province-level wild-cluster bootstrap (Webb) leaves the point estimate unchanged but pushes the full-sample p-value from <0.001 to **≈0.17** (CI spans zero). Significance is fragile under design-appropriate inference; leave-one-province-out keeps the point estimate robust.
- **🟡 Paper 06 (Mortality):** paper text vs code disagree on 1921 timing (text "after 1921" / 1921 is the event-study reference year, but DD codes `year >= 1921` as treated). Recoding 1921 as pre-period: −0.048 → −0.0504, still \*\*\*. No impact on the claim.
- **🟡 Paper 10 (Price is Right):** Table 1 note mislabels `Male` ("=1 if fourth bidder is female"; code defines Male=1 for males — note wording only, estimates correct); a dead-code control (`Cutoff_cumsum_biddinground` always 0, unused).
- **🟡 Paper 04 (Waiting):** `somcol` coded from partner's education (`parteduc`) instead of respondent's (`peeduca`); cleaning pipeline references several undefined variables and can't run end-to-end from raw ATUS.

---

## Robustness check highlights (22 checks; 2/paper)

- **Main results that held up:** 03 (HC2 SEs, t-crit), 05 (two-way clustering, drop no-expenditure), 06 (recode 1921, drop NYC+Chicago), 07 (2SLS vs LIML, just-identified IV), 08 (HC0–HC4, drop high-influence), 10 (cluster-robust SEs, logit), 12 (leave-one-province-out).
- **Results weakened/qualified by a robustness check:**
  - 02 — rebuilding the arrest variable as *described* flips its sign and kills significance (headline does not survive).
  - 11 — design-appropriate wild bootstrap puts the TC star at the 10% margin (CI includes zero).
  - 12 — province-level bootstrap inference takes the full-sample effect to p≈0.17.
  - 07 — adding the omitted quarterly dummies changes the headline magnitude by +38% (significance kept).
  - 01 — Don't-know recoded 0 vs 0.5 leaves the headline interaction's magnitude stable (0.023 vs 0.024) but loses significance (p=.115); 08 — interaction magnitude shrinks ~20% dropping high-influence points (stays significant).

---

## Figures rendered (figure targets)

- **Paper 03 — Figure 4:** `reproduction_run/figures/03_figure4.png` — **visual match** to published 3×2 panel (axes, CIs, group markers); all 18 point estimates match to displayed precision.
- **Paper 12 — Figure 2:** `reproduction_run/figures/12_figure2.png` — **visual match** to the published competition-effect coefplot; all six point estimates (0.0117/0.0111/0.0106/0.0092/0.0083/0.0077) and subsample N's (72/99/121/137/147/178) match to 4 decimals. (Headless Stata lacked the PNG translator; exported to PDF then rasterized via `pdftoppm` — intermediate `12_figure2.pdf` also present.)

---

## Obstacles encountered (cross-cutting)

- **Paper 02:** no estimation code shipped (plotting script only) — model reconstructed from the paper's equation; full point-estimate reproduction never achieved.
- **Paper 04:** BLS blocks automated ATUS downloads (403); the agent recovered the authors' cleaned `atusall0319.dta` from the truncated README Dropbox zip by parsing the file header and validating its CRC. Shipped tables code also referenced income variables absent from the shipped cleaned data.
- **Paper 01:** shipped `education`/`lucid_education` are identical and on a scale inconsistent with the printed table; no continuous education column exists in the package.
- **Paper 07:** hard-coded Windows path + a missing `data.dta`; reproduced off the shipped prebuilt `data_to_run_DOFILE3.dta`.
- **Paper 08:** CSV data files referenced by the code are missing; worked around using the included `.sav`. `age` stored as bins, so the paper's reported age M/SD/range can't be reproduced; no codebook.
- **Paper 12:** headless Stata lacked the `Graph2png` translator (PDF→PNG workaround).
- **Papers 06/07/12:** multi-GB packages — used shipped prebuilt/intermediate data rather than rebuilding from raw to stay in the time box.

---

*Per-paper detail is in `reproduction_run/reports/NN_<name>.md`. All findings derive solely from each paper's PDF and its own replication package, per the ground rules; no external sources were consulted.*
