# Reproduction Report — Alves (2018), A Cognitive-Ecological Explanation of Intergroup Biases

**Paper:** Alves, H., Koch, A., & Unkelbach, C. (2018). A Cognitive-Ecological Explanation of Intergroup Biases. *Psychological Science*, 29(7), 1126–1133. https://doi.org/10.1177/0956797618756862
**Paper IDs:** paper_id=AvOr; claims=AvOr_gdyrdr, AvOr_b7dlq4, AvOr_gzljvk, AvOr_ml3qr2
**Reproduction type:** Source Data Reproduction (no analysis code archived; only raw `.dat` files on OSF)
**Headline verdict (unpatched):** **precise**
**Verdict if patched:** N/A — no patch attempted; nothing to diagnose.

## Headline
All four claims reproduce precisely from the OSF raw data (`https://osf.io/qenhu/`). The chi-square tests for Experiments 1 and 3 match the paper's printed values to all reported digits (Exp 1: chi²=12.02, N=210; Exp 3 cond x pref: chi²=3.30, N=208; Exp 3 phi_bin x pref: chi²=6.94, p=.008, N=204). The Experiment 3 mediation analysis (claim AvOr_ml3qr2) matches lavaan-package output when the binary outcome is treated as continuous (linear-probability mediation under ML), reproducing all four printed coefficients (b=0.27, SE=0.11, Z=2.52, p=.012 for the focal phi→preference path) to ±0.01. No discrepancies beyond rounding at any sub-outcome.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| AvOr_gdyrdr (Exp 1) | N | 210 | 210 | 210 | precise: 210 | precise |
| AvOr_gdyrdr | chi² | 12.02 | 12.02 | 12.0229 → 12.02 | precise: 12.02 | precise |
| AvOr_gdyrdr | p | <.001 | 0.000526 | 0.000526 | precise (≤.001) | precise |
| AvOr_gdyrdr | phi (effect size) | -.24 (|0.24|) | 0.2392 | 0.2393 → 0.24 | precise: |0.24| | precise |
| AvOr_b7dlq4 (Exp 3 overall) | N | 208 | 208 | 208 | precise: 208 | precise |
| AvOr_b7dlq4 | chi² | 3.30 | 3.30 | 3.3016 → 3.30 | precise: 3.30 | precise |
| AvOr_b7dlq4 | p | .069 | 0.069 | 0.0692 → .069 | precise: 0.069 (±0.05 → [.019,.119]) | precise |
| AvOr_b7dlq4 | phi | -.13 | -0.13 | 0.1260 → 0.13 (sign convention) | precise: |0.13| | precise |
| AvOr_gzljvk (Exp 3 phi+/phi-) | N | 204 | 204 | 204 (after dropping 4 phi=0 rows w/ empty phi_bin) | precise: 204 | precise |
| AvOr_gzljvk | chi² | 6.94 | 6.94 | 6.9399 → 6.94 | precise: 6.94 | precise |
| AvOr_gzljvk | p | .008 | 0.008 | 0.00843 → .008 | precise: 0.008 (±0.05) | precise |
| AvOr_gzljvk | phi | -.18 | -0.18 | 0.1844 → 0.18 (sign convention) | precise: |0.18| | precise |
| AvOr_ml3qr2 (Exp 3 mediation; focal: phi→pref) | b | 0.27 | 0.27 | 0.266 → 0.27 | precise: 0.27 | precise |
| AvOr_ml3qr2 | SE | 0.11 | 0.11 | 0.105 → 0.11 | precise: 0.11 | precise |
| AvOr_ml3qr2 | Z | 2.52 | 2.52 | 2.522 → 2.52 | precise: 2.52 | precise |
| AvOr_ml3qr2 | p | .012 | 0.012 | 0.0117 → .012 | precise: .012 (±0.05) | precise |
| AvOr_ml3qr2 | N | 208 | 208 | 208 | precise: 208 | precise |

Sign of phi in the paper is reported as negative (the authors code condition with the more-positive-unique level as 0); the data file codes condition the other way (1 = positive shared / negative unique), giving `+phi` of identical magnitude. The SCORE rubric is magnitude-based; this is a coding convention, not a value disagreement.

## What I did

1. **Set-up.** Created `independent_reproductions/AvOr_alves_2018/`, copied `papers/AvOr.pdf` in, generated `AvOr.txt` via `pdftotext -layout`. Read the four claim rows from `paper_claims/AvOr.json`.

2. **Extraction check.**
   - Claim AvOr_gdyrdr — paper p.4 (printed pg 1129), Exp 1 Results: "χ²(1, N = 210) = 12.02, p < .001; ϕ = −.24". Counts: cond pos-shared/neg-unique → first 68 / second 36; cond neg-shared/pos-unique → first 44 / second 62. Extracted matches paper.
   - Claim AvOr_b7dlq4 — paper p.5 (printed pg 1130), Exp 3 Results: "χ²(1, N = 208) = 3.30, p = .069; ϕ = −.13". Counts: pos-freq → first 65 / second 39; neg-freq → first 52 / second 52. Extracted matches paper.
   - Claim AvOr_gzljvk — paper p.5 (printed pg 1130), Exp 3 phi-binned analysis: "χ²(1, N = 204) = 6.94, p = .008; ϕ = −.18". Counts: phi+ → first 64 / second 33; phi− → first 51 / second 56. Extracted matches paper.
   - Claim AvOr_ml3qr2 — paper p.5 (printed pg 1130), Exp 3 lavaan mediation. The focal sub-outcome (phi→preference) prints b=0.27, SE=0.11, Z=2.52, p=.012. Extracted matches paper.

3. **Data/code source.** No analysis code is archived. Raw data on OSF project `qenhu` (linked from the paper's Open Practices section: `https://osf.io/qenhu/?view_only=a214ad4886e64dcf8a57048fbde1dfbb`). Downloaded all four files via OSF API:
   - `Exp1.dat` (N=210; columns `condition`, `preference_first`)
   - `Exp2.dat` (N=223; not used by any verified claim, run as sanity check; chi²=8.69 reproduces the paper's Exp 2 result)
   - `Exp3.dat` (N=208; columns `condition`, `phi`, `preference_first`, `phi_bin`)
   - `variables.txt` (codebook)

4. **Reproduction commands and runtime.**
   - Python 3 + scipy/statsmodels: `python3 run_repro.py` (≈1 s) — produced `run_repro.log`. Used `scipy.stats.chi2_contingency(..., correction=False)` (without Yates) to match the paper's reported values; with Yates correction, chi² values are smaller (e.g., 11.08 vs 12.02 for Exp 1), confirming the paper used uncorrected chi². No environment-only edits beyond standard data ingest.
   - R 4.5.2 + lavaan 0.6.21: `Rscript run_lavaan.R` (≈1 s) — produced `run_lavaan.log`. Two SEM specifications run: (a) `sem(model, data=dat, ordered="preference_first")` produces probit-scaled coefficients on a different scale (b=0.679 for phi→pref) — this does NOT match the paper. (b) `sem(model, data=dat)` with binary outcome treated as continuous (linear-probability) reproduces the paper's printed b=0.27, SE=0.11, Z=2.52, p=.012 to ±0.01. The paper does not state which lavaan estimator was used, but the continuous/ML output is what matches.

5. **Stochastic-method diagnostics.** None — all analyses are deterministic.

6. **Classification.**
   - Bounds for each sub-outcome are paper-precision rounding bounds plus the 15% (or ±0.05 for p) approximate band per the SCORE Criterion Guide.
   - Every sub-outcome reproduced lands within the precise band when rounded to the paper's printed precision.
   - Overall verdicts (per claim, combining sub-outcomes): **precise** for all four claims.
   - Overall paper verdict: **precise** (every reported sub-outcome on every claim is precise).

## Diagnostics — author-bug analysis

Diagnostics: none — unpatched run reproduces every claim. No logic-level patch considered, attempted, or required.

A note on the lavaan estimator choice: the paper does not specify an estimator and the binary-outcome path is conventionally fit as probit when `ordered=` is set, but the printed coefficients (b=0.27 etc.) are clearly on the linear-probability scale. Using `lavaan::sem` with the outcome treated as continuous (the default ML path with no `ordered=` argument) reproduces the paper's numbers exactly. This is a specification clarification, not a bug.

## Files in this folder

Unpatched-run artifacts (all there is):
- `AvOr.pdf` — copy of the paper
- `AvOr.txt` — `pdftotext -layout` output
- `Exp1.dat`, `Exp2.dat`, `Exp3.dat`, `variables.txt` — author data + codebook from OSF
- `run_repro.py` — Python re-implementation of all four chi-squares (and Exp 2 sanity)
- `run_repro.log` — its output
- `run_lavaan.R` — R/lavaan reproduction of the Exp 3 mediation
- `run_lavaan.log` — its output
- `REPRODUCTION_REPORT.md` — this report
- `AvOr_summary_rows.csv` — per-claim summary rows for the audit
