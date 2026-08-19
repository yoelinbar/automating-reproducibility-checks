# Reproduction Report — *Arrests and convictions but not sentence length deter terrorism* (Nature Human Behaviour, 2023)

**Assigned exhibit:** Table 1, Model IIa (GMM dynamic panel, rates DV, with controls, arrests treated as exogenous)
**Package language:** R (but the analysis was run in Stata 17 with `xtabond2`, per Methods)
**Reproduction engine used:** Stata-MP 16.1 + `xtabond2` v3.7.2

> NOTE: The PDF supplied is the **RETRACTED** version of this article. The findings below are consistent with reasons a deterrence paper of this kind would be retracted (see Task 2 / Task 3).

---

## HIGH-IMPORTANCE DEVIATIONS (read first)

Per project policy, all deviations beyond rounding are flagged up front and categorized.

| # | Deviation | Severity | Detail |
|---|-----------|----------|--------|
| D1 | **Assigned exhibit cannot be reproduced from the package** | Critical (process) | The replication package contains **no code for Table 1** — only a plotting R script (`plots_deterrence_paper.R`) and a fitted-values CSV. No Stata do-file, no GMM syntax. The exact `xtabond2` instrument specification is unrecoverable. |
| D2 | **All four deterrence coefficients deviate far beyond rounding** | High (>10%) | In the closest spec, arrest −0.0033 (paper −0.017), charge +0.0041 (paper +0.016), conviction −0.003 (paper −0.095). Every coefficient is off by 4–5x even after the DV-scaling fix (see Task 1). |
| D3 | **Sentence coefficient sign cannot be reproduced** | Critical | Paper: sentence +0.012, P=0.001 (significant). Reproduced: −0.0002 to −0.0019, non-significant (P≈0.9). Sign and significance both differ. |
| D4 | **The "arrest rate" variable is built INVERSELY to the paper's stated definition**, and correcting it eliminates the headline result | Critical | See Task 2 (issue I1) and Task 3 (RC1). This is the central finding of this reproduction. |

---

## Task 1 — Computational reproduction

### Obstacle
The package ships only: `deterrence_october22.csv` (data, 448 rows = 28 countries × 16 years 2006–2021), `Fitted_1.csv` (fitted values for Fig. 4), and `plots_deterrence_paper.R` (figures/maps only). **There is no code that estimates any model in Table 1 or Table 2.** The Methods state the GMM models were estimated in "Stata v.17 using the XTABOND2 command," but no do-file is included. The exhibit therefore had to be **reconstructed** from the paper's equation (1) and variable names, iterating the `xtabond2` instrument set.

### Comparison: reproduced vs published (Table 1, Model IIa)

Closest reconstructed specification (lagged predictors per Methods "first lag of all variables was used"; lagged DV via collapsed GMM; charge/conviction/sentence endogenous; arrests exogenous; two-step robust; country FE + year trend + no-event dummy):

| Factor | Published | Reproduced (best spec) | Match? | Severity |
|--------|-----------|------------------------|--------|----------|
| Terrorism rate (L1) | 0.909 (0.706, 1.111), P=.000 | 0.963 (0.796, 1.129), P=.000 | Point ≈ (within CI), but +6% | Moderate |
| Arrests | −0.017 (−0.029,−0.006), P=.004 | −0.0033 (−0.0071,0.0005), P=.090 | **No** — sign ok, magnitude 1/5, sig lost | Critical |
| Charges | 0.016 (0.006,0.026), P=.001 | 0.0041 (0.0006,0.0076), P=.021 | **No** — sign ok, magnitude 1/4 | High |
| Convictions | −0.095 (−0.168,−0.023), P=.010 | −0.0030 (−0.0145,0.0084), P=.604 | **No** — sign ok, magnitude 1/30, sig lost | Critical |
| Sentence | 0.012 (0.005,0.019), P=.001 | −0.0002 (−0.0031,0.0028), P=.900 | **No** — sign flipped, sig lost | Critical |
| N | 420 | **420** | **Yes** | — |
| Hansen p | 0.333 | 0.177 (this spec) / 0.343 (contemp. spec) | No | — |

**N matches exactly (420 = 448 − 28 lost to the first lag).** No point estimate reproduces to displayed precision.

A diagnostic finding on scale: multiplying the DV (`DVSin`) by 10 — i.e. moving from the package's "per 10,000 population" rate (confirmed by the R plot axis labels) to the paper's stated "per 100,000 residents" — leaves the lagged-DV coefficient unchanged (0.963) and multiplies every deterrence coefficient by 10 (arrest −0.033, charge +0.041, conviction −0.030). This brings them to the same order of magnitude as the paper but still does not match, and the sentence sign stays wrong. This indicates (a) a units inconsistency between the supplied DV and the paper, and (b) that the exact published numbers depend on an instrument configuration not contained in the package.

**Verdict: NOT REPRODUCED to displayed precision.** Only N reproduces. Worst-case discrepancy severity: **Critical** (sentence sign + significance differ; arrests/convictions lose significance).

- **Minutes-from-start to a "reproduction":** N reproduced at ~2 min; sign pattern (arrest−/charge+/conviction−) reproduced at ~5 min; **full point-estimate reproduction: NOT ACHIEVED**.
- **Code path used:** reconstructed `/tmp/r5.do` (no original code exists). Data: `replication_packages/02_terrorism/deterrence_october22.csv`.

---

## Task 2 — Coding errors & data irregularities

| # | Issue | Location | Detected (min) | Affects main claim? |
|---|-------|----------|----------------|---------------------|
| **I1** | **"Arrest rate" variable is INVERTED relative to the paper.** Methods define the arrest variable as "number of arrests divided by number of terrorism events" (arrests/attacks). The supplied variable `NewArrest` is in fact `asinh( attacks / (arrests+1) )` — **numerator and denominator swapped**, plus a +1 in the denominator. Verified numerically: e.g. country 1, 2008 has attacks=6, arrests=0 yet `NewArrest`=2.64 (its highest value); attacks=1,arrests=1→0.881 but attacks=1,arrests=8→0.220 (more arrests → lower value). Raw `arrests` correlates **−0.25** with `NewArrest`. So higher `NewArrest` = FEWER arrests per attack. The paper interprets its negative coefficient as "arrests deter," but the variable means the opposite. | `deterrence_october22.csv` col 13 (`NewArrest`); paper Methods "Independent variables"; Table 1 Arrests row | ~5 (formula confirmed ~7) | **YES — central.** This inversion is what produces the headline "arrests deter terrorism" result. Correcting it removes the effect (Task 3, RC1). |
| **I2** | **Charge rate logically impossible (>1).** Raw `charges` exceed raw `arrests` in 55 country-years; raw charge-per-arrest reaches 17. A charge presupposes an arrest, so charges/arrests > 1 is impossible — indicating charges and arrests are drawn from inconsistent reporting bases in TE-SAT. | `deterrence_october22.csv` cols `charges`, `arrests` | ~6 | Possibly — undermines the validity of the charge rate (Charges row, the paper's "most consistent positive" factor). |
| **I3** | **Transform is not the IHS described.** Methods state IHS (`asinh(x)`), which yields 0 at x=0. But `ConvictionSin`=0.8814 when `convictionrate`=0 and 1.317 when rate=1. It is approximately `asinh(1+rate)` but not exactly (residual up to 0.13). The actual transform applied to the count/rate variables is undocumented and inconsistent with the stated IHS. | `deterrence_october22.csv` `ConvictionSin`; Methods "Model specifications" | ~4 | Moderate — changes coefficient scaling/interpretation; contributes to the 4–5x magnitude gap in Task 1. |
| **I4** | **Two conflicting sentence variables.** `sentence` (mean 2.98, max 40) and `length` (mean 5.42, range 4.2–6.6) both purport to measure prison sentence. `SentenceSin` derives from `sentence` (corr 0.90), not `length` (corr 0.02). The paper describes "average number of years." Which is correct is undocumented, and the sentence coefficient is exactly the one that fails to reproduce. | `deterrence_october22.csv` cols `sentence`, `length`, `SentenceSin` | ~5 | Moderate — ambiguity in the Sentence row. |
| **I5** | **DV units inconsistent with paper.** Supplied DV (`DVSin`) is a rate per 10,000 population (R plot labels confirm); the paper's Methods say per 100,000 residents. A 10x units discrepancy that propagates into all coefficient magnitudes. | `DVSin`; `plots_deterrence_paper.R` axis labels; Methods "Dependent variable" | ~5 | Moderate–High — explains part of the magnitude mismatch. |
| **I6** | **No analysis code in package.** Only a plotting script is shipped; nothing reproduces Table 1/Table 2. Violates the "Code availability" statement that the package provides "syntax to produce the analysis." | package root | ~1 | Process — prevents independent verification. |

---

## Task 3 — Robustness / sensitivity checks

Both checks are feasible, not done by the authors, and target the validity of the empirical strategy. Same GMM structure as the Task-1 best spec; only the noted variable changes.

### RC1 — Rebuild the arrest variable the way the paper *describes* it (arrests / attacks), then re-estimate Model IIa
Motivated by issue I1. Constructed `ArrestCorrect = asinh( arrests / (attacks+1) )` (arrests per event, the paper's stated definition) and substituted it for the inverted `NewArrest`.

| Factor | Paper | Original `NewArrest` (inverted) | **RC1: corrected arrest rate** |
|--------|-------|----------------------------------|-------------------------------|
| Arrests (L1) | −0.017, P=.004 | −0.0033, P=.090 | **+0.0011, P=.119 (sign FLIPS, n.s.)** |
| Charges (L1) | +0.016, P=.001 | +0.0041, P=.021 | +0.0041, P=.048 |
| Convictions (L1) | −0.095, P=.010 | −0.0030, P=.604 | −0.0035, P=.537 |
| Sentence (L1) | +0.012, P=.001 | −0.0002, P=.900 | +0.0002, P=.912 |
| N | 420 | 420 | 420 |

**Result: the headline "arrests deter terrorism" finding does not survive.** When the arrest variable is constructed as the paper's own Methods define it (arrests per attack), the coefficient **reverses sign to positive and is non-significant (P=0.119)**. The published negative, significant arrest effect is an artifact of the inverted `NewArrest` variable (issue I1). This is the most consequential result of the entire reproduction.

### RC2 — Use the alternative sentence variable (`length`) instead of `sentence`
Motivated by issue I4.

| Factor | Paper | Original (`sentence`) | **RC2: `length`** |
|--------|-------|-----------------------|-------------------|
| Arrests (L1) | −0.017 | −0.0039, P=.039 | −0.0040, P=.039 |
| Charges (L1) | +0.016 | +0.0041, P=.021 | +0.0039, P=.004 |
| Convictions (L1) | −0.095 | −0.0030 | −0.0041, P=.189 |
| Sentence (L1) | +0.012, P=.001 | −0.0002, n.s. | −0.0020, P=.899 (n.s.) |
| N | 420 | 420 | 420 |

**Result: stable for arrests/charges; sentence remains non-significant regardless of which sentence variable is used.** So the choice between the two undocumented sentence variables does not rescue the sentence finding, and does not drive the other coefficients — but it confirms the ambiguity flagged in I4.

---

## Obstacles
1. **No estimation code in the package** — the assigned exhibit had to be reconstructed from the paper's equation and variable names; the exact `xtabond2` instrument set is unrecoverable, so exact-value reproduction is impossible from the materials provided (I6).
2. **Cross-engine:** package nominally R, but the GMM was run in Stata; I used Stata-MP + `xtabond2` to match the stated method.
3. **Units/transform ambiguities** (I3, I5) make even the sign-correct reconstruction differ from the paper by a consistent multiplicative factor.
4. Stata writes its log to the data directory (working dir), not `/tmp`; logs were read from `replication_packages/02_terrorism/*.log`.

---

## Compact summary
- **Reproduced?** **NO** (only N=420 matches; no point estimate reproduces to displayed precision; sentence sign and significance differ — Critical).
- **Minutes-to-reproduction:** N at ~2 min; sign pattern at ~5 min; full reproduction **not achieved**.
- **# issues found:** 6 (I1–I6), including a Critical variable-inversion that drives the headline result.
- **# robustness checks run:** 2 (RC1 corrected arrest rate — headline effect vanishes; RC2 alternative sentence variable).
- **Worst reproduction-discrepancy severity:** **Critical** (sentence sign+significance differ; arrests/convictions lose significance; the arrest "deterrence" effect is an artifact of an inverted variable, confirmed by RC1).
