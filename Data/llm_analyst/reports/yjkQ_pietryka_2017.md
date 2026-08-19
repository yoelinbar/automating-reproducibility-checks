# Reproduction Report — Pietryka (2017), Networks, Social Proximity to Elites, and Voting

**Paper:** Pietryka, M. T., & DeBats, D. A. (2017). It's Not Just What You Have, but Who You Know: Networks, Social Proximity to Elites, and Voting in State and Local Elections. *American Political Science Review*, 111(2), 360-378. DOI: 10.1017/S000305541600071X
**Paper IDs:** paper_id=yjkQ; claims=[yjkQ_single-trace]
**Reproduction type:** Push Button
**Headline verdict (unpatched):** precise

## Headline
Push-button reproduction precisely reproduces the focal claim. Running the author's posted R script (`Pietryka_DeBats_APSR2017_Models.R`) on the posted data (`Alexandria_Data.tsv`) without any edits yields Alexandria Model 3 (Table 1) with coefficient on `z1elite_avgprox` (social proximity to elites, Z score) = 0.5566 (rounds to 0.557), SE = 0.1253 (rounds to 0.125), z = 4.44, p = 8.85e-6 (< 0.05), N = 2216 — identical to all printed values in the paper to the paper's reported precision.

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| yjkQ_single-trace | Coefficient | 0.557 | 0.557 | 0.5566 → rounds to 0.557 | precise=0.557; approx [0.473, 0.641] | precise |
| yjkQ_single-trace | SE (effect-size proxy, ser_method) | 0.125 | 0.125 | 0.1253 → rounds to 0.125 | precise=0.125; approx [0.106, 0.144] | precise |
| yjkQ_single-trace | p-value | < 0.05 (threshold) | 0.05 (less-than) | 8.85e-6 | precise ≤ 0.05 | precise |
| yjkQ_single-trace | Sample size | 2216 | 2216 | 2216 | precise=2216; approx [1884, 2548] | precise |
| yjkQ_single-trace | Test statistic | (not printed) | NaN | z = 4.44 | n/a | non-outcome |

Overall verdict: **precise**.

## What I did
1. **Set-up:** Created `independent_reproductions/yjkQ_pietryka_2017/`, copied PDF, ran `pdftotext -layout`.
2. **Extraction check:** The claim value (coef=0.557, SE=0.125, p<0.05, N=2216) corresponds to Table 1, Model 3, Alexandria column, row "Social proximity to elites (Z score)" (paper p. 367 / page 9 of PDF). Star annotation is `*` indicating p<0.05. Extracted values match paper exactly.
3. **Data/code source:** Harvard Dataverse, doi:10.7910/DVN/UTAP1V (American Political Science Review Dataverse). Three files: `Alexandria_Data.tsv`, `Newport_Data.tsv`, `Pietryka_DeBats_APSR2017_Models.R`. Downloaded via Dataverse file API.
4. **Reproduction:** `Rscript Pietryka_DeBats_APSR2017_Models.R` from the reproduction directory. No edits needed — code ran clean using locally-installed `readr`, `dplyr`, `texreg`. Runtime ~5 seconds. Output saved to `run_pushbutton.log`. Alexandria Model 3 line from log: `z1elite_avgprox   0.556577   0.125256   4.444 0.0000088497061 ***`.
5. **Stochastic-method diagnostics:** N/A — deterministic GLM.
6. **Classification:** Paper prints coef to 3 decimals (0.557); reproduced 0.5566 rounds to 0.557 → precise. SE printed as 0.125; reproduced 0.1253 → 0.125 → precise. Threshold p<0.05; reproduced 8.85e-6 ≤ 0.05 → precise. N matches exactly. Overall: precise.

## Diagnostics — author-bug analysis
Diagnostics: none — unpatched run reproduces the published value to all reported digits; no logic bug suspected.

## Files in this folder
- `yjkQ.pdf` — paper PDF
- `yjkQ.txt` — pdftotext extraction
- `Alexandria_Data.tsv` — Alexandria dataset (Harvard Dataverse)
- `Newport_Data.tsv` — Newport dataset (Harvard Dataverse)
- `Pietryka_DeBats_APSR2017_Models.R` — author's R script (unmodified)
- `run_pushbutton.log` — full output of `Rscript Pietryka_DeBats_APSR2017_Models.R`
- `REPRODUCTION_REPORT.md` — this report
- `yjkQ_summary_rows.csv` — summary row(s)
