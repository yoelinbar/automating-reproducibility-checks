# Reproduction Report — Gambling, Saving, and Lumpy Liquidity Needs (AEJ: Applied 2021)

**Assigned exhibit:** Table 3, Column 2 ("IHST", no individual FE)
**Package language:** Stata (run with Stata-MP 16.1)

## Headline
- **Reproduced: YES — exact match to displayed precision** on every reported figure (point estimates, SEs, Mean Y, N, R²).
- **Worst reproduction discrepancy: NONE** (no deviation beyond display rounding).
- Issues found: 1 minor wording/transparency note (not an error, does not affect claims). No coding errors affecting the main result.
- Robustness checks run: 2 — both confirm the result.

---

## Task 1 — Computational Reproduction

Table 3, Col 2 corresponds to model `m2` in `do/Analysis-1.do` (lines 96–101):
```stata
replace ct = ih_ct
reghdfe ih_btm ct ct0 lmeaninc ih_inc betprop if srvrd>2, a(srvrd week ntx) vce(cluster id)
```
The dependent variable is the IHS-transformed median betting payout target; `ct` (=`ih_ct`) is the IHS-transformed desired-expenditure target price (ETP).

| Quantity | Published (Table 3, col 2) | Reproduced | Match? |
|---|---|---|---|
| Expenditure target price (ETP) coef | 0.0771 | 0.0771294 | Y |
| ETP SE | (0.0225) | 0.0224935 | Y |
| log(mean income) coef | 0.1275 | 0.1274811 | Y |
| log(mean income) SE | (0.0508) | 0.0508010 | Y |
| Mean Y | 3.574 | 3.5737 | Y |
| Individual fixed effects | No | No | Y |
| Observations | 3,602 | 3,602 | Y |
| R² | 0.6494 | 0.6494 | Y |

- **Minutes-to-reproduction: ~1 minute** (from wall-clock start; single Stata run succeeded on first attempt).
- **Code path:** `replication_packages/05_gambling/do/Analysis-1.do` (model `m2`); driver/reproduction script: `reproduction_run/repro_t3c2.do`; log: `reproduction_run/repro_t3c2.log`.
- **Path adjustments only:** the package's hard-coded Windows/Dropbox paths were repointed to the local package; the data file is named `Panel-Clean.dta` (code references `Panel Clean.dta`). The cleaning do-files were not re-run — the supplied cleaned `Panel-Clean.dta` already contains all derived variables (cleaning steps are commented out in `Master.do`). No analysis logic was altered.

**Result: exact reproduction, no deviations of any severity.**

---

## Task 2 — Coding Errors / Irregularities

| # | Description | Location | Detected (min from start) | Affects main claims? |
|---|---|---|---|---|
| 1 | **Scale of the "IHST" columns vs. table note (transparency, not an error).** The table note says cols 2/4/6 "apply the IHST conversion to these two raw variables," with "Prop" cols scaling by mean income. In the code, the IHST dependent variable `ih_btm` and regressor `ih_ct` are the inverse-hyperbolic-sine of the **USD** values (`bet_lastweek_medtarget/3500` and `cons_27_tot/3500`), NOT of the income-scaled "prop" variables used in cols 1/3/5. Verified directly: `corr(ih_btm, IHS(USD target)) = 1.0000`. This is an internally consistent and defensible modeling choice (both LHS and the ETP regressor are USD-IHS), but "raw" in the note is ambiguous (it means USD, not the prop versions). | `do/Cleaning-and-Data-Prep---Panel.do:1276–1300`; Table 3 note | ~6 | No — consistent transform on both sides; result reproduces exactly. |

Items inspected and found clean (no error):
- **IHS formula** — `asinh(ct_usd)` and `log(x+sqrt(x²+1))` are both correct, identical IHS transforms (`Panel.do:1279,1296`).
- **No-expenditure coding** — `ct0 = ct_prop==0` correctly flags the 471 genuine zero-target observations; `.==0` is false in Stata so missing targets are dropped (target var is missing), not mis-coded as zero. The "zero value + dummy" treatment of NoExp is standard and matches the paper's `NoExpTarget` term.
- **Winsorization / cap ordering** — `btm` is capped at the company max (2000 USD) and IHS'd in USD before being rescaled to mean income; the prop version is separately winsorized at p99. Order is internally consistent.
- **Lag construction** — `xtset id visnum` then `L1.cons_27_tot` produces the t−1 desired expenditure ("two weeks earlier"); `id`×period is unique (no duplicate id-period rows: `duplicates report` shows 0 surplus).
- **Hard-coded data fix** `id==1081` (`Panel.do:427`) is a documented single-respondent data-entry correction, not a systematic manipulation.
- **`meaninc`** uses all study weeks (`Panel.do:228`); the `srvrd<4` partial mean at line 230 is computed then dropped unused (harmless dead code).

No coding error capable of changing the sign, significance, or magnitude of the Table 3, col 2 result was found.

---

## Task 3 — Robustness / Sensitivity Checks

Both checks are feasible, not done by the authors for this specification, and relevant to the empirical strategy. Script: `reproduction_run/robust.do` (log `robust.log`).

**Check 1 — Two-way clustering (id × week).** The paper clusters SEs only at the individual level; betting targets across respondents within a calendar week may be correlated (common shocks / bookmaker odds). Re-clustering by id and week:

| Spec | ETP coef | ETP SE | p | N |
|---|---|---|---|---|
| Baseline (id cluster) | 0.0771 | 0.0225 | 0.001 | 3,602 |
| Two-way (id + week) | 0.0771 | 0.0188 | 0.001 | 3,602 |

The SE actually **tightens** slightly; significance and magnitude unchanged. **Robust.**

**Check 2 — Drop no-expenditure observations.** Instead of coding NoExp targets as zero + a dummy (`ct0`), exclude those 471 respondent-periods entirely and estimate on the subsample with a reported desired expenditure. This tests whether the ETP slope is an artifact of the zero-coding convention.

| Spec | ETP coef | ETP SE | p | N |
|---|---|---|---|---|
| Baseline | 0.0771 | 0.0225 | 0.001 | 3,602 |
| Drop NoExp | 0.0798 | 0.0227 | 0.000 | 3,146 |

ETP coefficient is essentially unchanged (+3.4%, within sampling noise) and remains highly significant. **Robust.**

Both checks support the paper's conclusion that payout targets rise significantly with anticipated desired expenditures (in the no-fixed-effects IHST specification).

---

## Obstacles
- Only cosmetic: package paths are hard-coded to the author's Windows Dropbox; data filename uses a hyphen (`Panel-Clean.dta`) while the do-files reference a space (`Panel Clean.dta`). Repointed paths; no logic changed.
- Cleaning do-files were not re-run (they are commented out in `Master.do` and the cleaned `.dta` is shipped). Variable-construction review for Task 2 was therefore done by reading the cleaning code and validating against the shipped cleaned data, not by re-executing cleaning end-to-end. This is sufficient because the analysis files consume the shipped cleaned data, which reproduced the table exactly.
- Well within the ~30-minute compute budget.
