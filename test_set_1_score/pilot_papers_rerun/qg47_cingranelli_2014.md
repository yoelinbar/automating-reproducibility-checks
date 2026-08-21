# Reproduction Report — Cingranelli, Fajardo-Heyward & Filippov (2014), Principals, Agents and Human Rights

**Paper:** Cingranelli, David, Paola Fajardo-Heyward and Mikhail Filippov. 2014. "Principals, Agents and Human Rights." *British Journal of Political Science* 44(3): 605–630. DOI: 10.1017/S0007123413000070 (first published online 13 June 2013)
**Paper IDs:** paper_id=qg47; claims=qg47_single-trace
**Reproduction type:** Source Data Reproduction — the authors posted the analysis dataset but **no analysis code at all**, so the specification had to be rebuilt from the published table.
**Headline verdict (unpatched):** approximate
**Verdict if patched (only if applicable):** approximate — the patch fixes the sample size but breaks the coefficient. See Diagnostics.

## Headline

**The deviation is in the sample size, and no code was posted that could explain it.** The paper's Table 3, Equation (7) (random-effects ordered probit on the CIRI Physical Integrity Index, p. 620) reports Reliance on Taxes = **0.007** with robust SE **0.003** on **N = 1,718**. Rebuilding that specification from the posted data reproduces the focal statistics exactly — coefficient **0.0073202** (→ **0.007** at the paper's 3 decimals), robust SE **0.0031510** (→ **0.003**), p = **0.020**, comfortably under the printed `**p < 0.05` — but on **N = 1,739**, **21 observations more** than the paper prints (+1.22 per cent). That places the sample size in the approximate band rather than the precise one, so the overall verdict is **approximate** despite an otherwise digit-for-digit match on coefficient, standard error and significance.

I identified what the 21 observations are: every observation in the estimation sample where `tax_rev_new` — "Tax and Social Security Contributions as % of Total Government Revenue" — **exceeds 100 per cent**, which is out of range for a share. They are six Cyprus years, ten Nicaragua years, three Guatemala years and two Italy years, running as high as 113.0. Dropping them yields **N = 1,718 exactly**. But that patch does not fully reconcile the paper: with N = 1,718 the focal coefficient becomes **0.0076270**, which rounds to **0.008**, not the printed 0.007. So the two lenses trade one deviation for another — the un-filtered run matches the coefficient and misses the N; the filtered run matches the N and misses the coefficient. **Both land at `approximate` overall**, which is the one thing that is robust here. Since the authors posted no code, neither reading can be confirmed against what they actually ran, and this is exactly the kind of gap that a posted do-file would have closed in one line.

Two further checks strengthen the diagnosis rather than the verdict: the filtered run reproduces Table 3's Equation (5) (0.007, SE 0.002, pseudo R² 0.295) and Equation (6) (0.006, SE 0.002, pseudo R² 0.326) **exactly as printed, including both pseudo R² values**, while the un-filtered run misses Equation (5)'s coefficient (0.006 vs 0.007). And the Equation (7) result is not a numerical-integration artifact: re-estimating with 8, 12, 20 and 30 quadrature points moves the coefficient by less than 1 × 10⁻⁸.

## Comparison table

Rounding targets follow the paper's printed precision: coefficient and SE to 3 decimals, N exactly.

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| qg47_single-trace | Focal coefficient, Reliance on Taxes | **0.007** (Table 3, Eq. 7, p. 620) | 0.007 ✓ | **.00732016 → 0.007** | precise iff round(repro,3) = 0.007; approx ±15% = [0.00595, 0.00805] | **precise** |
| qg47_single-trace | Effect size (ser_method = focal coefficient) | **0.007** | 0.007 ✓ | **0.007** | as above | **precise** |
| qg47_single-trace | Robust standard error | **0.003** (Table 3, Eq. 7) | 0.003 ✓ | **.00315101 → 0.003** | — | **precise** |
| qg47_single-trace | Focal p-value | **`**` = p < 0.05** (Table 3 note: `***p < 0.01, **p < 0.05, *p < 0.1`) | 0.05 less-than ✓ | **0.020** (z = 2.32) | precise iff < 0.05; approx (0.05, 0.10]; not > 0.10 | **precise** |
| qg47_single-trace | Sample size | **1,718** (Table 3, "No. of observations") | 1,718 ✓ | **1,739** | precise iff = 1,718; approx ±15% = [1,460, 1,976] | **approximate** (+1.22%) |
| qg47_single-trace | Focal test statistic | not printed | NA | z = 2.32 | — | non-outcome |
| **Overall (unpatched)** | | | | | | **approximate** |

Every extracted `orig_*` value matches the published version of record. There is no extraction error in this paper.

## What I did

**1. Set-up.** Created `independent_reproductions/qg47_cingranelli_2014/`, copied `papers/qg47.pdf` in, ran `pdftotext -layout qg47.pdf qg47.txt`.

**2. Extraction check.** All values trace to **Table 3, p. 620**: *"Human Rights, Reliance on Taxes, and Size of Government Revenue, 1981–2007 Time-Series Cross-Section Ordered Probit with Lagged Dependent Variable and Robust Standard Errors."* The claim's model is **Equation (7)**, headed "Random effects ordered probit" under the "Physical Integrity Index" panel:
- Row `Reliance on Taxes`, column (7): **0.007\*\*** with **(0.003)** on the line beneath → `orig_coef_value` = 0.007 ✓, `orig_coef_se` = 0.003 ✓, `orig_effect_size_value_repro` = 0.007 ✓.
- Table note: `Robust standard errors in parentheses. ***p < 0.01, **p < 0.05, *p < 0.1.` Two stars → **p < 0.05** → `orig_p_value` = 0.05, `orig_p_value_type` = less-than ✓.
- Row `No. of observations`, column (7): **1,718** → `orig_sample_size_value` = 1718 ✓.
- The CSV's `p_value_pg` = 16 corresponds to PDF page 16 = article page 620 ✓.
- Confirmed against the claim text: *"coefficient on Reliance on Taxes term = 0.007, robust SE = 0.003, p < 0.05."*

**Extraction verdict: matches the published version of record on every field.** No pseudo R² is reported for Equations (7) and (10) — the table prints "n/a" — so there is no additional numeric target there.

**3. Data/code source.** `pr_data_location` = "Publisher website"; `pr_code_available` = **No**, which I confirmed. The article's supplementary materials on Cambridge Core consist of exactly two files, which I downloaded:
- `https://static.cambridge.org/content/id/urn:cambridge.org:id:article:S0007123413000070/resource/name/S0007123413000070sup001.pdf` → `S0007123413000070sup001.pdf` (333,926 bytes) — a **3-page online appendix** on interaction effects, containing prose and two figures. No code.
- `https://static.cambridge.org/content/id/urn:cambridge.org:id:article:S0007123413000070/resource/name/S0007123413000070sup002.dta` → `S0007123413000070sup002.dta` (339,851 bytes) — the analysis dataset: **2,181 observations, 37 variables**, stamped 11 Feb 2013, with an embedded original path of `C:\Users\Toshiba\Dropbox\taxes\final taxes BJPS\Principals, A11 Fe...`.

**No do-file, R script, README or codebook is posted.** That makes Push Button and Extended Push Button impossible and forces a **Source Data Reproduction**: the model had to be reconstructed from the published table's row labels matched against the dataset's own variable labels.

**Specification transcription.** The mapping is unambiguous because the posted dataset's variable labels restate the table's row labels almost verbatim:

| Table 3 row | Dataset variable | Dataset variable label |
|---|---|---|
| (dependent variable) | `ciri_physint` | "Dependent variable Ciri Physical Integrity Index" |
| Reliance on Taxes | `tax_rev_new` | "Tax and Social Security Contributions as % of Total Government Revenue" |
| Size of Government Revenues | `tot_rev_new` | "Total Government Revenue" |
| Log of Population size | `log_pop` | "Log Population" |
| Income per Capita | `income` | "Income per Capita" |
| Democracy (Polity IV) | `p_democ` | "Democracy (Polity IV)" |
| External Conflict | `extconf` | "External Conf. PRIO" |
| Internal Armed Conflict | `intconf` | "Internal Armed Conflict" |
| UK Colony | `ukcol` | "UK Colony" |
| Lagged dependent variable | `ciri_physint_lag` | "Lagged Dependent Variable" |

The posted data carries no numeric country identifier, so the panel had to be constructed: `egen cid = group(cname)` then `xtset cid year`. That yields 115 countries in the estimation sample. **This is the only construction step not fully determined by the archive**, and it is forced — a random-effects estimator cannot run without a panel variable, and `cname` × `year` is the only candidate.

**4. Reproduction.** `run_sourcedata.do`, run as:

```
/usr/local/bin/stata-mp -b do run_sourcedata.do
```

Stata 16.0 MP. Runtime about one minute. It estimates all three Physical-Integrity models in Table 3 so that the focal one can be checked against its neighbours:

```
oprobit   ciri_physint tax_rev_new tot_rev_new ciri_physint_lag, vce(robust)                                  // Eq (5)
oprobit   ciri_physint tax_rev_new tot_rev_new log_pop income p_democ extconf intconf ukcol ciri_physint_lag, vce(robust)   // Eq (6)
xtoprobit ciri_physint tax_rev_new tot_rev_new log_pop income p_democ extconf intconf ukcol ciri_physint_lag, vce(robust)   // Eq (7) FOCAL
```

Focal output (`run_sourcedata.log`):

```
Random-effects ordered probit regression        Number of obs     =      1,739
Group variable: cid                             Number of groups  =        115
Integration method: mvaghermite                 Integration pts.  =         12
                                  (Std. Err. adjusted for 115 clusters in cid)
------------------------------------------------------------------------------
             |               Robust
ciri_physint |      Coef.   Std. Err.      z    P>|z|     [95% Conf. Interval]
-------------+----------------------------------------------------------------
 tax_rev_new |   .0073202    .003151     2.32   0.020     .0011443     .013496
 tot_rev_new |   .0178894   .0050857     3.52   0.000     .0079215    .0278573
     log_pop |  -.2093533   .0510804    -4.10   0.000     -.309469   -.1092376
      income |   6.73e-06   .0000118     0.57   0.570    -.0000165    .0000299
     p_democ |   .0764221   .0155552     4.91   0.000     .0459345    .1069096
     extconf |   .1750784   .2339534     0.75   0.454     -.283462    .6336187
     intconf |  -.4406571   .0743563    -5.93   0.000    -.5863928   -.2949214
       ukcol |   -.235489   .1236454    -1.90   0.057    -.4778295    .0068514
ciri_physi~g |   .4405686   .0475382     9.27   0.000     .3473955    .5337417
```

Focal statistics: **b = 0.007320159, SE = 0.003151010, z = 2.32, p = 0.020, N = 1,739, 115 country clusters.**

Non-focal coefficients in the same column are close to but not identical with the printed ones — Size of Government Revenues 0.0179 (paper 0.017), Log Population −0.209 (paper −0.208), Democracy 0.076 (paper 0.076), External Conflict 0.175 (paper 0.186), Internal Armed Conflict −0.441 (paper −0.446), UK Colony −0.235 (paper −0.225), lagged DV 0.441 (paper 0.444). This pattern of near-but-not-exact agreement across the column is what a small sample difference plus a possibly different RE-ordered-probit implementation would produce.

**5. Stochastic-method diagnostics.** No simulation, resampling or seed is involved, so there is no Monte Carlo error to report. The one non-analytic element is **numerical quadrature** in the random-effects ordered probit, and I tested its influence directly (`diagnostic_quadrature.do`): re-estimating with `intpoints(8)`, `intpoints(12)` (the default), `intpoints(20)` and `intpoints(30)` moves the focal coefficient by less than **1 × 10⁻⁸** in every case —

```
UNPATCHED intpoints=8   N=1739  b= 0.00732016  se= 0.00315100
UNPATCHED intpoints=12  N=1739  b= 0.00732016  se= 0.00315101
UNPATCHED intpoints=20  N=1739  b= 0.00732016  se= 0.00315101
UNPATCHED intpoints=30  N=1739  b= 0.00732016  se= 0.00315101
PATCHED   intpoints=8   N=1718  b= 0.00762702  se= 0.00312327
PATCHED   intpoints=12  N=1718  b= 0.00762703  se= 0.00312328
PATCHED   intpoints=20  N=1718  b= 0.00762703  se= 0.00312328
PATCHED   intpoints=30  N=1718  b= 0.00762703  se= 0.00312328
```

— so the 0.00732 vs 0.00763 gap between the two samples is a real sample difference, not integration noise.

**6. Classification (headline run only).**
- *Coefficient:* paper 0.007 at 3 dp. Reproduced 0.00732016 → rounds to 0.007 → equals the paper → **precise**. (Approximate band, not needed: [0.00595, 0.00805].)
- *Effect size (`ser_method`, i.e. the coefficient itself):* same computation → **precise**.
- *Standard error:* paper 0.003. Reproduced 0.00315101 → rounds to 0.003 → **precise**.
- *p-value:* the paper reports a **threshold**, `**` = p < 0.05, not an exact value. Per the Criterion Guide's one-directional threshold rule: precise if reproduced p < 0.05; approximate on (0.05, 0.10]; not above 0.10. Reproduced p = 0.020 < 0.05 → **precise**. (The rule is applied only toward larger p; being more significant than the threshold is not penalised.)
- *Sample size:* paper 1,718. Reproduced 1,739. Not equal → not precise. Approximate band = 1,718 × [0.85, 1.15] = **[1,460, 1,976]**; 1,739 is inside → **approximate**. Difference = +21 observations = **+1.22 per cent**.
- *Test statistic:* not printed in the paper → **non-outcome**, excluded from the combination.
- *Combination:* no sub-outcome is `not`; at least one (sample size) is `approximate` → **overall approximate**.

## Diagnostics — author-bug analysis

### The 21-observation gap: out-of-range values of the focal independent variable

**Suspected bug.** The posted dataset contains **21 observations for which `tax_rev_new` exceeds 100** — that is, tax and social-security contributions recorded as more than 100 per cent of total government revenue, which is impossible for a share. All 21 fall inside the estimation sample I built. The paper never mentions excluding them, and with no posted code there is nothing to inspect. Listing them (`diagnostic_patched.log`):

```
  |     cname   year   tax_rev_new |
  |    Cyprus   1999   107.1698 |   (Cyprus 1999-2004, six years, up to 109.01)
  | Guatemala   1998   100.1135 |   (Guatemala 1998-2000, three years)
  |     Italy   1986   103.1101 |   (Italy 1986-1987, two years)
  | Nicaragua   1996   106.7637 |   (Nicaragua 1996-2005, ten years, up to 113.00)
```

**Reasoning.** Three points support the view that the authors dropped exactly these:
1. `count if e(sample) & tax_rev_new>100` returns **21**, and 1,739 − 21 = **1,718**, the paper's printed N to the observation.
2. I checked and eliminated the obvious alternatives (`diagnostic_sample.do` / `explore_sample.do`): restricting to the table title's stated window 1981–2007 changes nothing (only 3 observations are dated 2008 and none has a non-missing DV); dropping single-observation panels removes 2, not 21; rebuilding the lag as a true panel lag `L.ciri_physint` instead of the supplied `ciri_physint_lag` removes **80** (N = 1,659), not 21, and the supplied lag agrees with the true panel lag on every row where both exist.
3. Under this filter the paper's **other two Physical Integrity columns reproduce exactly, pseudo R² included**: Eq (5) → 0.00653092 (→ **0.007**, paper 0.007), SE 0.00202144 (→ **0.002**, paper 0.002), pseudo R² **0.2950** (paper **0.295**); Eq (6) → 0.00615804 (→ **0.006**, paper 0.006), SE 0.00219586 (→ **0.002**, paper 0.002), pseudo R² **0.3261** (paper **0.326**). Without the filter, Eq (5) on the common sample gives 0.0063896 → **0.006**, missing the paper's 0.007.

**Patched run.** `diagnostic_patched.do` / `diagnostic_patched.log`. The single edit is adding `if tax_rev_new<=100`:

```
EQ5-PATCHED N=1718 b= 0.00653092 se= 0.00202144 pR2=0.2950
EQ6-PATCHED N=1718 b= 0.00615804 se= 0.00219586 pR2=0.3261
EQ7-PATCHED N=1718 groups=115 b= 0.00762703 se= 0.00312328 z=  2.4420 p= 0.0146
```

Bounds it lands in, for the focal Eq (7): coefficient 0.00762703 → **0.008** at 3 decimals ≠ the paper's 0.007 → **not precise**; inside the approximate band [0.00595, 0.00805] → **approximate**. SE 0.00312328 → **0.003** = paper → **precise**. p = 0.0146 < 0.05 → **precise**. N = **1,718** = paper → **precise**.

**Verdict if patched: approximate** — the same overall verdict as the headline, reached by a different route. The patch converts an approximate sample size into a precise one while converting a precise coefficient into an approximate one.

**Confidence: medium.** I am confident that (a) 21 out-of-range observations exist, (b) removing them gives the paper's exact N, and (c) removing them makes Equations (5) and (6) match the published column exactly including both pseudo R² values. I am **not** confident this is the whole story, because the patched Equation (7) coefficient (0.00763 → 0.008) then misses the printed 0.007, and quadrature settings are ruled out as the explanation. Two possibilities I cannot separate with the archive in hand: the authors applied a slightly different exclusion that happens also to number 21, or they estimated the random-effects ordered probit with a different routine. On the latter — the online appendix states the analysis used **Stata 12**, but Stata's official `xtoprobit` command (which I used) was introduced in Stata 13, so the authors must have used a user-written estimator such as `reoprob` or `gllamm`, whose likelihood approximation and standard-error handling need not agree with `xtoprobit` to the third decimal. I could not test that: neither package is installed here and neither is part of the archive. **This uncertainty is a direct consequence of no code being posted**, and it is the reason this reproduction is Source Data rather than Push Button.

**Note on the modification policy.** Adding a sample-restriction filter that is not in posted code — even one that brings N to the printed value — is explicitly excluded from the headline verdict, which is why the `tax_rev_new<=100` result lives only in this section. The headline above reflects the faithful transcription of the published specification with no filter beyond what the paper's own table and text state.

### Secondary observation (not verdict-relevant)

Column (7)'s non-focal coefficients differ from the printed values in the third decimal (e.g. External Conflict 0.175 vs 0.186; UK Colony −0.235 vs −0.225). These are not part of the claim and are not classified, but they are consistent with the same underlying sample/estimator gap rather than with a transcription error on my side, since the focal coefficient, SE and both neighbouring equations line up.

## Files in this folder

| File | What it is |
|---|---|
| `qg47.pdf` | Published version of record (copied from `papers/`) |
| `qg47.txt` | `pdftotext -layout` extraction, used for the extraction check |
| `S0007123413000070sup001.pdf` | Author's online appendix as downloaded from Cambridge Core (prose + 2 figures; **no code**) |
| `S0007123413000070sup001.txt` | `pdftotext -layout` extraction of the appendix |
| `S0007123413000070sup002.dta` | Author's analysis dataset as downloaded from Cambridge Core (unmodified) |
| `inspect_data.do` / `inspect_data.log` | Dataset inventory: `describe, fullnames` and `summarize`, used to map table rows to variables |
| `run_sourcedata.do` | **Headline run script** — Table 3 Equations (5), (6), (7) transcribed from the published table |
| `run_sourcedata.log` | **Headline run output** — the headline verdict is computed from this file alone |
| `explore_sample.do` / `explore_sample.log` | Diagnostic: year-window restrictions tested against the 1,739 vs 1,718 gap |
| `explore_sample2.do` / `explore_sample2.log` | Diagnostic: supplied lag vs true panel lag, missingness audit, singleton panels |
| `diagnostic_sample.do` / `diagnostic_sample.log` | Diagnostic: candidate restrictions; identifies `tax_rev_new<=100` → N = 1,718 |
| `diagnostic_patched.do` / `diagnostic_patched.log` | **Patched-diagnostic run** — Eqs (5)–(7) with `if tax_rev_new<=100`, plus the listing of the 21 excluded observations |
| `diagnostic_quadrature.do` / `diagnostic_quadrature.log` | Diagnostic: quadrature sensitivity (8/12/20/30 integration points, patched and unpatched) |
| `REPRODUCTION_REPORT.md` | This report |
