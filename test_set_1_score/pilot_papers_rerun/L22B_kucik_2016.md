# Reproduction Report — Kucik & Pelc (2016), Measuring the Cost of Privacy

**Paper:** Kucik, Jeffrey and Krzysztof J. Pelc. 2016. "Measuring the Cost of Privacy: A Look at the Distributional Effects of Private Bargaining." *British Journal of Political Science* 46(4): 861–889. DOI: 10.1017/S0007123414000520 (first published online 28 January 2015)
**Paper IDs:** paper_id=L22B; claims=L22B_4kyq5l, L22B_5o7kyk, L22B_yw9q1o, L22B_21yo9v, L22B_8rzko1, L22B_okzxnq, L22B_n39qon
**Reproduction type:** Push Button
**Headline verdict (unpatched):** not — for the paper as a whole, because one of the seven claims (L22B_5o7kyk) does not reproduce. Per-claim: 5 precise, 1 approximate, 1 not.
**Verdict if patched (only if applicable):** precise — for L22B_5o7kyk, once Model 3's sample filter is corrected. See Diagnostics. The other six claims need no patch.

## Headline

**The deviation: Table 1 Model 3 does not reproduce from the archived code.** The paper reports a Complainant coefficient of **0.062** (SE 0.136) on **N = 12,066**. Running the archived do-file unchanged produces **0.0516** (SE 0.133) on **N = 12,391** — the coefficient is **16.7 per cent below** the published value, which puts it **outside** the ±15 per cent approximate band ([0.0527, 0.0713]), so this claim is **not reproduced**. The sample size is off by 325 observations (2.7 per cent, within the approximate band). The cause is identifiable and is documented in Diagnostics: the archived do-file restricts Model 3 with `if outcome == 3`, whereas the paper's Model 3 is the exact complement of Model 2's `if earlysettle == 1`. Substituting `if earlysettle == 0` returns **0.062347** (→ 0.062), SE **0.136**, N **12,066** — matching every printed cell of the Model 3 column, and making Model 2 (6,027 obs / 45 clusters) plus Model 3 (12,066 obs / 77 clusters) sum exactly to Model 1 (18,093 obs / 122 clusters). That patch is a logic-level change to a sample-restriction condition, so per the modification policy it is **excluded from the headline verdict** and reported only as a parallel "verdict if patched."

**A second, smaller deviation:** Table 3 Model 6 prints `2.320**`, and with the table note's legend (`**p < 0.001`) the extracted claim records p < 0.001. The reproduced p-value is **0.009** — reproduced correctly to the coefficient and SE, but an order of magnitude above the threshold the star implies. Under the Criterion Guide's one-directional threshold rule this lands in the approximate band (0.001, 0.051], so L22B_8rzko1 is **approximate**, not precise. The likeliest explanation is a legend typo in the paper (the observed p-values are consistent with a `**p < 0.01` convention: Model 4's single-starred 0.804 has p = 0.018 and Model 6's double-starred 2.320 has p = 0.009), but the published legend is what the audit compares against.

The remaining five claims (Table 1 Model 2; Table 3 Models 4, 5, 7; Table 4 Model 8) reproduce **precisely** on every reported sub-outcome — coefficient, standard error, sample size and p-value threshold alike.

## Comparison table

Rounding targets follow the paper's printed precision: coefficients and SEs to 3 decimals, N exactly. "ser_method" effect size = the focal coefficient.

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| **4kyq5l** (T1 M2, p. 878) | Coefficient, Complainant | 0.430 | 0.430 ✓ | .4300721 → **0.430** | precise iff = 0.430; approx [0.3655, 0.4945] | **precise** |
| 4kyq5l | Std. error | 0.180 | 0.180 ✓ | .1797067 → **0.180** | — | precise |
| 4kyq5l | Effect size (ser_method) | 0.430 | **0.180** ← extraction records the SE, not the coefficient | coef .4300721 → 0.430; SE .1797067 → 0.180 | either reading rounds to the paper's printed value | **precise** (both readings) |
| 4kyq5l | p-value | "*" = p < 0.05 | 0.050 less-than ✓ | **0.021** | precise iff < 0.05; approx (0.05, 0.10]; not > 0.10 | **precise** |
| 4kyq5l | Sample size | 6,027 | 6,027 ✓ | **6,027** | precise iff = 6,027; approx [5,123, 6,931] | **precise** |
| 4kyq5l | **Overall** | | | | | **precise** |
| **5o7kyk** (T1 M3, p. 878) | Coefficient, Complainant | **0.062** | 0.062 ✓ | **.0516309 → 0.052** | precise iff = 0.062; **approx [0.0527, 0.0713]** | **NOT** (−16.7%) |
| 5o7kyk | Std. error | 0.136 | 0.136 ✓ | .1332853 → 0.133 | — | (secondary) not same |
| 5o7kyk | Effect size (ser_method) | 0.062 | 0.062 ✓ | .0516309 → 0.052 | approx [0.0527, 0.0713] | **NOT** |
| 5o7kyk | Sample size | **12,066** | 12,066 ✓ | **12,391** | precise iff = 12,066; approx [10,256, 13,876] | **approximate** (+2.7%) |
| 5o7kyk | p-value | not reported (no star) | NA | (0.700) | — | non-outcome |
| 5o7kyk | **Overall** | | | | | **not** |
| **yw9q1o** (T3 M4 outcome eq., p. 883) | Coefficient, Third Parties | 0.804 | 0.804 ✓ | .8036965 → **0.804** | precise iff = 0.804; approx [0.6834, 0.9246] | **precise** |
| yw9q1o | Std. error | 0.340 | 0.340 ✓ | .340086 → **0.340** | — | precise |
| yw9q1o | Effect size (ser_method) | 0.804 | 0.804 ✓ | **0.804** | as above | **precise** |
| yw9q1o | p-value | "*" = p < 0.05 (text, p. 882: "p < 0.018") | 0.050 less-than ✓ | **0.018** | precise iff < 0.05; approx (0.05, 0.10] | **precise** |
| yw9q1o | Sample size | 5,272 | 5,272 ✓ | **5,272** (selected) | precise iff = 5,272; approx [4,481, 6,063] | **precise** |
| yw9q1o | **Overall** | | | | | **precise** |
| **21yo9v** (T3 M5 outcome eq., p. 883) | Coefficient, Third-Party Dummy | 3.434 | 3.434 ✓ | 3.434027 → **3.434** | precise iff = 3.434; approx [2.919, 3.949] | **precise** |
| 21yo9v | Std. error | 1.487 | 1.487 ✓ | 1.486571 → **1.487** | — | precise |
| 21yo9v | Effect size (ser_method) | 3.434 | 3.434 ✓ | **3.434** | as above | **precise** |
| 21yo9v | p-value | "*" = p < 0.05 | 0.050 less-than ✓ | **0.021** | precise iff < 0.05; approx (0.05, 0.10] | **precise** |
| 21yo9v | Sample size | 5,272 | 5,272 ✓ | **5,272** (selected) | precise iff = 5,272; approx [4,481, 6,063] | **precise** |
| 21yo9v | **Overall** | | | | | **precise** |
| **8rzko1** (T3 M6 outcome eq., p. 883) | Coefficient, Third Parties Logged | 2.320 | 2.320 ✓ | 2.319582 → **2.320** | precise iff = 2.320; approx [1.972, 2.668] | **precise** |
| 8rzko1 | Std. error | 0.894 | 0.894 ✓ | .8940606 → **0.894** | — | precise |
| 8rzko1 | Effect size (ser_method) | 2.320 | **0.894** ← extraction records the SE, not the coefficient | coef 2.319582 → 2.320; SE .8940606 → 0.894 | either reading rounds to the paper's printed value | **precise** (both readings) |
| 8rzko1 | p-value | **"**" = p < 0.001** per table note | 0.001 less-than ✓ | **0.009** | precise iff < 0.001; **approx (0.001, 0.051]**; not > 0.051 | **approximate** |
| 8rzko1 | Sample size | 5,272 | 5,272 ✓ | **5,272** (selected) | precise iff = 5,272; approx [4,481, 6,063] | **precise** |
| 8rzko1 | **Overall** | | | | | **approximate** |
| **okzxnq** (T3 M7 outcome eq., p. 883) | Coefficient, Third Parties Weighted | 0.065 | 0.065 ✓ | .0650514 → **0.065** | precise iff = 0.065; approx [0.05525, 0.07475] | **precise** |
| okzxnq | Std. error | 0.025 | 0.025 ✓ | .0254885 → **0.025** | — | precise |
| okzxnq | Effect size (ser_method) | 0.065 | 0.065 ✓ | **0.065** | as above | **precise** |
| okzxnq | p-value | "*" = p < 0.05 | 0.050 less-than ✓ | **0.011** | precise iff < 0.05; approx (0.05, 0.10] | **precise** |
| okzxnq | Sample size | 4,423 | 4,423 ✓ | **4,423** (selected) | precise iff = 4,423; approx [3,760, 5,086] | **precise** |
| okzxnq | **Overall** | | | | | **precise** |
| **n39qon** (T4 M8 outcome eq., p. 885) | Coefficient, Complainant | 0.469 | 0.469 ✓ | .4686892 → **0.469** | precise iff = 0.469; approx [0.3987, 0.5394] | **precise** |
| n39qon | Std. error | 0.222 | 0.222 ✓ | .2222779 → **0.222** | — | precise |
| n39qon | Effect size (ser_method) | 0.469 | 0.469 ✓ | **0.469** | as above | **precise** |
| n39qon | p-value | "*" = p < 0.05 | 0.050 less-than ✓ | **0.035** | precise iff < 0.05; approx (0.05, 0.10] | **precise** |
| n39qon | Sample size | 5,702 | 5,702 ✓ | **5,702** (selected) | precise iff = 5,702; approx [4,847, 6,557] | **precise** |
| n39qon | **Overall** | | | | | **precise** |

## What I did

**1. Set-up.** Created `independent_reproductions/L22B_kucik_2016/`, copied `papers/L22B.pdf` in, ran `pdftotext -layout L22B.pdf L22B.txt`.

**2. Extraction check.** Every `orig_*` value was traced to a specific table cell of the published version of record:
- **L22B_4kyq5l** → Table 1 ("How Does Privacy vs. Publicity Affect the Distribution of Benefits?"), **p. 878**, Model 2 ("Early Settlements (Privacy)"), row `Complainant_{j,d}`: **0.430\*** with **(0.180)** beneath it; row `N`: **6,027**. Table note: `*p < 0.05, **p < 0.001`. All extracted values match.
- **L22B_5o7kyk** → same Table 1, **p. 878**, Model 3 ("Rulings (Publicity)"), row `Complainant_{j,d}`: **0.062** with **(0.136)**; row `N`: **12,066**. No star, i.e. no p-value threshold is asserted. All extracted values match.
- **L22B_yw9q1o** → Table 3 ("Do Third Parties Increase Pay-offs to Non-participants?"), **p. 883**, Model 4 Outcome (Imports) column, row `Third Parties_d`: **0.804\*** with **(0.340)**; `N` = **5,272**. Corroborated by the text on **p. 882**: *"third parties have a significant, positive impact on post-dispute import levels for the membership (p < 0.018)."* All extracted values match.
- **L22B_21yo9v** → Table 3, **p. 883**, Model 5 Outcome column, row `Third-Party Dummy_d`: **3.434\*** with **(1.487)**; `N` = **5,272**. Corroborated by text on p. 882: *"imports grow by a factor of 3.43."* All extracted values match.
- **L22B_8rzko1** → Table 3, **p. 883**, Model 6 Outcome column, row `Third Parties Logged_d`: **2.320\*\*** with **(0.894)**; `N` = **5,272**. Under the table note (`**p < 0.001`) the extracted `p < 0.001` is the correct reading of the printed evidence. All extracted values match.
- **L22B_okzxnq** → Table 3, **p. 883**, Model 7 Outcome column, row `Third Parties Weighted_d`: **0.065\*** with **(0.025)**; `N` = **4,423**. All extracted values match.
- **L22B_n39qon** → Table 4 ("Do Complainants also Benefit from Third-Party Participation?"), **p. 885**, Model 8 Outcome column, row `Complainant_{j,d}`: **0.469\*** with **(0.222)**; `N` = **5,702**. All extracted values match.

**Extraction anomaly worth logging (does not change any verdict):** `orig_effect_size_value_repro` is inconsistent across this paper's rows. For yw9q1o, 21yo9v, okzxnq and n39qon it equals the focal coefficient (0.804, 3.434, 0.065, 0.469), which is what `ser_method` should be. But for **4kyq5l it is 0.180** and for **8rzko1 it is 0.894** — in both cases the *standard error*, not the coefficient. I classified both rows under both readings; the reproduction matches the paper's printed value to the printed precision either way, so the sub-verdict is `precise` on both readings and the overall verdicts are unaffected.

**Paper-internal inconsistency noted (not a claim):** the text on **p. 882** states that for Model 4 *"the χ² statistic is 58.12 (χ² < 0.000)"*, but Table 3 prints **119.95\*\*** for the same model, and the reproduction gives **119.95**. The table and the reproduction agree with each other; the in-text 58.12 agrees with neither.

**3. Data/code source.** `pr_data_location` = "Publisher website". The replication materials are attached to the article on Cambridge Core as supplementary files; I retrieved the direct asset URLs from the article page and downloaded:
- `https://static.cambridge.org/content/id/urn:cambridge.org:id:article:S0007123414000520/resource/name/S0007123414000520sup001.do` → `S0007123414000520sup001.do` (4,274 bytes, Stata do-file, header `* BJPS REPLICATION MATERIALS`, footer `* End. 10/22/2014`)
- `https://static.cambridge.org/content/id/urn:cambridge.org:id:article:S0007123414000520/resource/name/S0007123414000520sup002.dta` → `S0007123414000520sup002.dta` (16,166,524 bytes, Stata Release 117 dataset, 49,463 observations)

These two files are the entire archive. No README, no codebook.

**4. Reproduction.** `run_pushbutton.do` is the archived do-file with **two lines prepended and nothing else changed**:

```
cd "<this directory>"
use "S0007123414000520sup002.dta", clear
```

This edit was necessary because the archived do-file begins at `set more off` / `sort dispute respondentID partnerID year` and never loads its own data — it assumes the dataset is already in memory. Setting the working directory and loading the posted data file is a working-directory/file-path fix, explicitly permitted under Push Button, and it touches no analysis logic. Every `xtreg`, `heckman`, `margins`, `hausman` and `lrtest` line is byte-identical to the archive. Command run:

```
/usr/local/bin/stata-mp -b do run_pushbutton.do
```

Stata 16.0 MP. Runtime: about two minutes (the Heckman models iterate through long "not concave" stretches but all converge). No errors; the log contains no `r(###);` return codes.

Focal output (`run_pushbutton.log`):

```
* Model 2  (line 195)  N = 6,027    1.complain~t |   .4300721   .1797067    2.39   0.021
* Model 3  (line 247)  N = 12,391   1.complain~t |   .0516309   .1332853    0.39   0.700   <-- paper: 0.062 (0.136), N=12,066
* Model 4  (line 414)  Selected = 5,272    thirdparties     |   .8036965   .340086    2.36   0.018
* Model 5  (line 485)  Selected = 5,272    thirdparti~m     |  3.434027   1.486571    2.31   0.021
* Model 6  (line 610)  Selected = 5,272    lnthird          |  2.319582   .8940606    2.59   0.009   <-- paper star implies p<0.001
* Model 7  (line 676)  Selected = 4,423    lntp_average     |  .0650514   .0254885    2.55   0.011
* Model 8  (line 800)  Selected = 5,702    complainant      |  .4686892   .2222779    2.11   0.035
```

Model 1 (not a claim, but a useful control on the data build) also reproduces exactly: 0.1857402 → **0.186** with SE **0.113** on N = **18,093**, against the paper's 0.186 (0.113), N 18,093.

**5. Stochastic-method diagnostics.** None applicable. Every model here is deterministic — fixed-effects OLS and maximum-likelihood Heckman selection models. No simulation, resampling or seed is involved anywhere in the archive, so no Monte Carlo SE is needed and repeated runs return identical numbers.

**6. Classification (unpatched run only).** Bounds are computed from the **paper's** value in every case, using ±15 per cent for coefficients / effect sizes / sample sizes and the Criterion Guide's one-directional threshold logic for p-values. The per-sub-outcome arithmetic is in the Comparison table above. Combining:
- 4kyq5l: all sub-outcomes precise → **precise**
- 5o7kyk: coefficient `not` → **not** (a single `not` forces the overall verdict regardless of the approximate sample size)
- yw9q1o: all precise → **precise**
- 21yo9v: all precise → **precise**
- 8rzko1: coefficient/SE/N precise, p-value approximate → **approximate**
- okzxnq: all precise → **precise**
- n39qon: all precise → **precise**

Paper-level headline: **not**, since at least one claim in the bushel fails to reproduce.

## Diagnostics — author-bug analysis

### Bug 1 — Model 3 uses the wrong sample restriction (affects L22B_5o7kyk)

**Suspected bug.** `S0007123414000520sup001.do`, the line under `* Model 3. How do complainants do when going to a ruling?`:

```stata
xtreg imports_post i.complainant imports_tminus1 ln_gdp_resp ln_gdp_part dempair ln_total_imports if outcome == 3, fe i(dispute_combined) cluster(dispute_combined)
```

The restriction should be `if earlysettle == 0`, not `if outcome == 3`.

**Reasoning.** Four independent lines of evidence:

1. **The paper defines Model 3 as the complement of Model 2.** Text, p. 879: *"We re-estimate the same model as above on disputes that do not settle early."* Model 2 in the same do-file is restricted with `if earlysettle == 1`. The complement of that is `earlysettle == 0`, not `outcome == 3`.
2. **The partition arithmetic is exact.** Running all three: Model 1 (no restriction) = 18,093 obs / 122 clusters; Model 2 (`earlysettle==1`) = 6,027 / 45; `earlysettle==0` = 12,066 / 77. **6,027 + 12,066 = 18,093** and **45 + 77 = 122**, to the observation and to the cluster. The archived `outcome==3` gives 12,391 / 78, which over-counts by 325 obs and one cluster and does not partition Model 1.
3. **`outcome==3` is not the complement of early settlement in this dataset.** Cross-tabulating (`diagnostic_patched.log`): among `outcome==3` rows, **700 have `earlysettle==1`** — i.e. the archived filter pulls 700 early-settlement observations into the "rulings" model — while **2,579 rows with `earlysettle==0` have `outcome` missing** and are therefore dropped. The net +325 is the difference.
4. **The patched run matches the published column on every single cell, not just the focal one.** Paper Model 3 vs patched reproduction: Complainant 0.062 vs **0.062347** (SE 0.136 vs **0.13630**); Defendant GDP 1.457 vs **1.457236** (0.035 vs **0.03544**); Partner GDP 0.089 vs **0.089490** (0.032 vs **0.03193**); Democratic Pair −0.065 vs **−0.065450** (0.101 vs **0.10083**); Disputed Imports_{t−1} 0.807 vs **0.806738** (0.023 vs **0.02333**); Total Imports 0.138 vs **0.138249** (0.034 vs **0.03379**); Constant −39.297 vs **−39.29657** (1.177 vs **1.17692**); N 12,066 vs **12,066**. The unpatched `outcome==3` run matches *none* of these to the printed precision. A seven-for-seven coefficient match cannot be coincidence.

**Patched run.** `diagnostic_patched.do` / `diagnostic_patched.log`. The single edit is `if outcome == 3` → `if earlysettle == 0`; every other token of the command is unchanged. Result:

```
Fixed-effects (within) regression               Number of obs     =     12,066
                                                Number of groups  =         77
1.complain~t |   .0623475   .1363023     0.46   0.649    -.2091221     .333817
PATCHED b =   0.06234746  se =   0.13630229  N = 12066  groups = 77
```

Bounds it lands in: coefficient 0.0623475 → **0.062** at the paper's 3 decimals = the paper's 0.062 → precise. SE 0.1363023 → **0.136** = paper's 0.136 → precise. N 12,066 = paper's 12,066 → precise. p not reported in the paper for this cell → non-outcome.

**Verdict if patched:** **precise** (parallel verdict; the headline for L22B_5o7kyk remains **not**).

**Confidence: high.** This is a filter-clause bug in the posted code, not a specification disagreement. The patch is not inferred from the paper's prose — it is pinned by the exact partition arithmetic and by the seven-coefficient match, and `earlysettle` is a variable the do-file already uses in the immediately preceding model. Note per the modification policy that this is precisely the disallowed-for-headline category ("Filter clauses, model specifications, sample-restriction conditions"), which is why it is confined to this section.

### Bug 2 — Table 3 significance legend understates Model 6's p-value (affects L22B_8rzko1)

**Suspected bug.** Table 3's note (p. 883) reads `*p < 0.05, **p < 0.001`, and Model 6's `Third Parties Logged_d` carries two stars: `2.320**`. The reproduced p-value for that coefficient is **0.009**, which is not below 0.001.

**Reasoning.** The coefficient and SE reproduce to the printed digit (2.319582 → 2.320; 0.8940606 → 0.894), so this is not an estimation discrepancy — only the star's threshold is wrong. Across Table 3, every double-starred coefficient I reproduced has p ≤ 0.01 but not necessarily p ≤ 0.001 (e.g. selection-equation `thirdparties` = −0.236\*\* has p = 0.000, but outcome-equation `lnthird` = 2.320\*\* has p = 0.009), while single-starred ones sit between 0.01 and 0.05 (0.804 → 0.018; 3.434 → 0.021; 0.065 → 0.011). That pattern is consistent with the authors applying a **`**p < 0.01`** convention and the table note being mistyped as `p < 0.001`.

**Patched run.** No code patch is possible or needed — the estimate itself is correct. If the legend is read as `**p < 0.01`, the reproduced p = 0.009 is below 0.01 and the sub-outcome becomes **precise**, making L22B_8rzko1 **precise** overall.

**Verdict if patched (legend read as `p < 0.01`):** **precise** (parallel verdict; the headline for L22B_8rzko1 remains **approximate**, because the published legend says 0.001 and the published legend is the version of record).

**Confidence: medium.** I am confident the reproduced p = 0.009 is correct, and confident that 0.009 contradicts a `p < 0.001` star. I am less certain the note is a typo rather than an error in which star was applied — both produce the same published text, and I cannot distinguish them from the archive.

### Nothing else to diagnose

For the other five claims (Table 1 Model 2; Table 3 Models 4, 5, 7; Table 4 Model 8) the unpatched run reproduces the published values exactly; no logic bug is suspected.

## Files in this folder

| File | What it is |
|---|---|
| `L22B.pdf` | Published version of record (copied from `papers/`) |
| `L22B.txt` | `pdftotext -layout` extraction, used for the extraction check |
| `S0007123414000520sup001.do` | Author's replication do-file, as downloaded from Cambridge Core (unmodified) |
| `S0007123414000520sup002.dta` | Author's replication dataset, as downloaded from Cambridge Core (unmodified) |
| `run_pushbutton.do` | **Unpatched run script** — archived do-file with only a `cd` and a `use` line prepended |
| `run_pushbutton.log` | **Unpatched run output** — the headline verdict is computed from this file alone |
| `diagnostic_model3.do` | Diagnostic scan: variable inventory and Model 3 re-estimated under four candidate sample filters |
| `diagnostic_model3.log` | Output of the above — shows `earlysettle == 0` → N = 12,066, b = 0.062347 |
| `diagnostic_patched.do` | **Patched-diagnostic run** — Model 3 with `if earlysettle == 0`, plus the partition check and the `outcome × earlysettle` cross-tab |
| `diagnostic_patched.log` | **Patched-diagnostic output** — full patched Model 3 column and partition arithmetic |
| `REPRODUCTION_REPORT.md` | This report |
