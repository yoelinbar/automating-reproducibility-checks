# Reproduction Report — Brancati & Snyder (2013), "Time to Kill"

**Paper:** Brancati, Dawn and Jack L. Snyder. 2013. "Time to Kill: The Impact of Election Timing on Postconflict Stability." *Journal of Conflict Resolution* 57(5): 822–853. DOI: 10.1177/0022002712449328
**Paper IDs:** paper_id=V0PA; claims=[V0PA_single-trace]
**Reproduction type:** Extended Push Button (path edit + extraction of single command from one giant one-line do-file)
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A — no patch needed

## Headline
The reproduction matches the paper to all printed digits. Running the author's exact Model 8 specification on the author's posted dataset (`BS09_DATA_main.dta`) yields T2nemths1 (Election timing) coefficient = -0.0103388 (rounds to -0.01), robust clustered SE = 0.0047302 (rounds to 0.005), z = -2.19, p = 0.029 (paper reports p < .05 with `**`), N = 94, log-likelihood = -36.182. Every printed Model-8 cell I could compare matches. The paper's accompanying claim that going from a 1-year to 5-year postconflict election horizon reduces the predicted probability of new war by "about 0.09 points (or 31 percent)" also reproduces: at-means margins give P=0.306 at 12 months and P=0.211 at 60 months (Δ = -0.094, ≈30.8 percent decline).

## Comparison table

| Claim | Sub-outcome | Paper (Table 2, p. 839, Model 8) | Extracted (CSV `orig_*`) | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| V0PA_single-trace | Sample size | 94 | 94 | 94 | exact: 94; approx: [80, 108] | precise |
| V0PA_single-trace | Coefficient (logit, Election timing T2nemths1) | -0.01 | -0.01 | -0.0103 → rounds to -0.01 | exact: -0.01 (2 dp); approx: \|x\| ∈ [0.0085, 0.0115] | precise |
| V0PA_single-trace | SE (auxiliary, secondary) | 0.005 | 0.005 | 0.0047 → rounds to 0.005 | n/a (analyst-defined) | precise |
| V0PA_single-trace | p-value | < .05 (`**` in table) | 0.05 (less-than) | 0.029 (≤ 0.05) | precise: ≤ 0.05; approx: (0.05, 0.10]; not: > 0.10 | precise |
| V0PA_single-trace | Effect size (log-odds = coef) | -0.01 | -0.01 | -0.0103 → -0.01 | same as coef | precise |
| V0PA_single-trace | (Narrative) ΔP at 12 vs 60 months | -0.09 (≈31%) | n/a | -0.094 (≈30.8%) | n/a — narrative | (matches) |

**Overall verdict (unpatched): precise.**

## What I did

1. **Set-up.** Created `independent_reproductions/V0PA_brancati_2013/`, copied `papers/V0PA.pdf`, ran `pdftotext -layout` to `V0PA.txt`.

2. **Extraction check.** The claim row points to `p_value_pg = 18` (the article's pdf page 18 = journal page 839). Table 2 ("Effect of Postconflict National Election Timing (Calendar Time) on New Civil War Onset (Prematching)") column (8) prints: Election timing **-0.01\*\*** (SE 0.005); Observations 94; Log likelihood -36.18. The claim's `orig_coef_value = -0.01`, `orig_coef_se = 0.005`, `orig_sample_size_value = 94`, `orig_p_value = 0.05` (less-than), `orig_effect_size_value_repro = -0.01` (log_odds_ratio) all match the paper's printed values. **Extraction matches paper: yes.**

3. **Data/code source.** Author's website (http://www.dawnbrancati.com/, publications page) hosts `T2K_REPLICATION FILES.zip` (≈1.1 MB). Downloaded and unzipped to the reproduction directory. Includes Stata `.dta` data files and `BS09_ANALYSIS_P2.do` (the "Time to Kill" analysis script).

4. **Reproduction.** The posted `.do` file is one giant unbroken line (line endings stripped, all commands on one line) and uses Mac-only absolute paths under `/Users/brancati/...`. I extracted Model 8's exact command verbatim from `BS09_ANALYSIS_P2.do` into `run_model8.do`, with two environment-only edits:
   - data path changed to relative `T2K_REPLICATION FILES/DATA/BS09_DATA_main.dta`
   - removed `prvalue` postestimation (uses uninstalled `spostado` package — does not affect logit estimates).

   Command run (verbatim from author archive):
   ```stata
   logit nwar1 T2nemths1 nepolity1 postCW victory unintrvnALL UNneaid1 prop mixed unexec dcenEVR eventno2 if nENDinWAR !=1, cluster(countryname)
   ```
   Executed via `stata-mp -b do run_model8.do`. Runtime <1s. Output: `run_model8.log`.

   To reproduce the predicted-probability narrative claim (0.09 / 31% decline), I also ran `run_margins.do` (`margins, atmeans at(T2nemths1=(12 60))`) — output in `run_margins.log`.

5. **Stochastic-method diagnostics.** N/A — deterministic logit MLE.

6. **Classification.**
   - Coef: paper -0.01 (2 dp). Reproduced -0.0103388 → rounds to -0.01 → equal at paper precision → **precise.**
   - SE: paper 0.005 (3 dp). Reproduced 0.0047302 → rounds to 0.005 → **precise.**
   - p-value: paper threshold "p<.05" (the `**` annotation). Reproduced p = 0.029 ≤ 0.05 → **precise** (one-sided threshold rule).
   - N: paper 94. Reproduced 94 → **precise.**
   - Effect size: paper log-odds = -0.01; reproduced rounds to -0.01 → **precise.**
   - Overall: every reported sub-outcome is precise → **precise.**

## Diagnostics — author-bug analysis
Diagnostics: none — the unpatched run reproduces the published Table 2, Model 8 to all printed digits, and the in-text predicted-probability claim of "about 0.09 points (or 31 percent)" also reproduces (-0.0943, ≈30.8%). No logic bug suspected.

## Files in this folder
- `V0PA.pdf`, `V0PA.txt` — paper PDF and text extraction
- `T2K_REPLICATION_FILES.zip` — downloaded archive from http://www.dawnbrancati.com/
- `T2K_REPLICATION FILES/` — unpacked archive (CODE, DATA, CODEBOOKS, APPENDIX)
- `run_model8.do` / `run_model8.log` — exact Model 8 command from `BS09_ANALYSIS_P2.do`, run on posted data
- `run_margins.do` / `run_margins.log` — at-means margins to verify the 0.09/31% in-text claim
- `REPRODUCTION_REPORT.md` — this file
- `V0PA_summary_rows.csv` — one row, the canonical claim verdict
