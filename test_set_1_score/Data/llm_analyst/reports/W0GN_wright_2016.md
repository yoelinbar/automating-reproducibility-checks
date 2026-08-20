# Reproduction Report — Wright & Diehl (2016), Unpacking Territorial Disputes

**Paper:** Wright, Thorin M., and Paul F. Diehl. 2016. "Unpacking Territorial Disputes: Domestic Political Influences and War." *Journal of Conflict Resolution* 60(4): 645–669. DOI: 10.1177/0022002714553105
**Paper IDs:** paper_id=W0GN; claims=[W0GN_single-trace]
**Reproduction type:** Push Button (single environment-only edit: `cd` set to local directory)
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A

## Headline
Clean push-button reproduction. The focal interaction term `Territorial MID × mixed regime dyad` from Table 2, model (1), reproduces exactly to the paper's three-decimal precision (coef = 0.769, SE = 0.220), with the same N (2,788) and the same significance level (p < 0.01; reproduced p ≈ 0.0005). One incidental observation: in Table 2 the paper prints positive values for the `Mixed regime dyad`, `Rivalry`, and `Constant` rows, while the Stata output gives the same magnitudes with negative signs. This is a paper-side display/typesetting issue (the substantive direction of those non-focal coefficients in the text discussion is consistent with the negative-sign output) and does not affect the focal claim being reproduced here.

## Comparison table
| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| W0GN_single-trace | Coefficient (terrXmixed) | 0.769 | 0.769 | 0.7691273 → rounds to 0.769 | precise: 0.769 (paper precision); approx: [0.65365, 0.88435] | **precise** |
| W0GN_single-trace | Coefficient SE | 0.220 | 0.220 | 0.2204754 → rounds to 0.220 | precise: 0.220 (paper precision) | **precise** (reported as part of coef sub-outcome; not separately scored in rubric but matches) |
| W0GN_single-trace | p-value (threshold) | p < 0.01 | 0.01 (less-than) | p ≈ 0.000485 (z = 3.49) | precise: ≤ 0.01; approx: (0.01, 0.06]; not: > 0.06 | **precise** |
| W0GN_single-trace | Sample size | 2,788 | 2,788 | 2,788 | precise: 2,788; approx: [2,370, 3,206] | **precise** |
| W0GN_single-trace | Test statistic | not reported as such | NaN | z = 3.49 | n/a | **non-outcome** |
| W0GN_single-trace | Effect size | not reported (this row) | NaN | n/a | n/a | **non-outcome** |
| W0GN_single-trace | Overall | — | — | — | — | **precise** |

## What I did

1. **Set-up.** Created `independent_reproductions/W0GN_wright_2016/`, copied `papers/W0GN.pdf` in, ran `pdftotext -layout` to produce `W0GN.txt`.
2. **Extraction check.** The claim concerns Table 2 ("Logits of Mixed Dyads, Territory, and War, 1816–2001"), column (1) "All dyads / war/five years" (paper p. 658, line 604–622 of the layout text). The printed row reads: `Territorial MID × mixed regime dyad   0.769*** (0.220)` and `Observations 2,788`. Sig key (line 624): `***p < 0.01`. All extracted `orig_*` values match the paper exactly.
3. **Data/code source.** Located on Harvard Dataverse: Wright & Diehl, 2015, "Replication Data for: Unpacking Territorial Disputes: Domestic Political Influences and War" (doi:10.7910/DVN/A2OVBN). Downloaded all 5 files: two `.dta` (Stata 13 / release 117), the do-file `Wright_Diehl_2014_JCR_ReplicationScript.do`, the online appendix PDF, and the original SMCL log.
4. **Reproduction.** Wrote `run_pushbutton.do` containing only (a) `cd` to the local directory, (b) `use "Wright_Diehl_2014_JCR_1816-2001.dta"`, (c) the exact Table 2 model (1) command verbatim from line 38 of the author do-file: `logit cow5yrwi mixed terrXmixed territor jtdem caprat terrcount rival`. Ran with `stata-mp -b do run_pushbutton.do`. Runtime < 1s. Log saved as `run_pushbutton.log`. Only environment-only edit: setting the working directory; no analysis logic touched.
5. **Stochastic-method diagnostics.** N/A — straight logit, deterministic.
6. **Classification.**
   - Coefficient: paper 0.769 (3 dp). Reproduced 0.7691273 → rounds to 0.769 at 3 dp → equals 0.769 → **precise**. Approximate band [0.85·0.769, 1.15·0.769] = [0.65365, 0.88435]; reproduced is inside, but the precise check fired first.
   - p-value: threshold p < 0.01. Reproduced p ≈ 0.000485 ≤ 0.01 → **precise** under the one-direction threshold rule.
   - Sample size: paper 2,788. Reproduced 2,788 → **precise**.
   - Overall: **precise** (every reported sub-outcome precise).

## Diagnostics — author-bug analysis

Diagnostics: none for the focal claim — unpatched run reproduces precisely.

Incidental, non-focal observation about the same table: Stata returns *negative* signs for the `mixed`, `rival`, and `_cons` rows where Table 2 column (1) prints them as positive (0.525, 0.224, 1.895). The magnitudes and SEs match exactly. Reading the paper's substantive interpretation (e.g., text on p. 658 says outcomes increase with territorial MIDs but does not commit on the sign of `mixed regime` alone in column 1), this looks like a typesetting error in Table 2 where leading minus signs were dropped for those rows — confirmed by the original SMCL log shipped with the data, which also shows the negative signs. This does not bear on the focal claim (`Territorial MID × mixed regime dyad` is positive in both paper and reproduction).

## Files in this folder

Unpatched-run artifacts:
- `W0GN.pdf` — paper PDF (copied from `papers/`)
- `W0GN.txt` — `pdftotext -layout` output
- `Wright_Diehl_2014_JCR_1816-2001.dta` — replication data, 1816–2001 (Stata 13)
- `Wright_Diehl_2014_JCR_1946-1999.dta` — replication data, 1946–1999 (Stata 13; not used for this claim)
- `Wright_Diehl_2014_JCR_ReplicationScript.do` — author's full replication do-file
- `WrightDiehl_JCR_OnlineAppendix.pdf` — author's online appendix
- `WrightDiehl_JCRreplication_log.smcl` — author's original Stata log
- `run_pushbutton.do` — minimal do-file actually executed for this reproduction (env-only edits)
- `run_pushbutton.log` — Stata batch-mode log of the push-button run
- `REPRODUCTION_REPORT.md` — this file

No patched-diagnostic artifacts (none needed).
