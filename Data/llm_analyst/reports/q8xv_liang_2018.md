# Reproduction Report — Liang, Wang, & Lazear (2018), "Demographics and Entrepreneurship"

**Paper:** Liang, James, Hui Wang, and Edward P. Lazear. 2018. "Demographics and Entrepreneurship." *Journal of Political Economy* 126 (S1): S140–S196. DOI: https://doi.org/10.1086/698750
**Paper IDs:** paper_id=q8xv; claims=q8xv_524ll2, q8xv_22jnnj, q8xv_827ww4, q8xv_d4r99j, q8xv_ryzpp8, q8xv_single-trace
**Reproduction type:** Push Button (env-only path edits: backslash → forward-slash for cross-platform)
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A — no patch needed

## Headline

All six claims reproduce **precisely** to the paper's printed precision on the second attempt with manually fetched author data and code. The data + code package (`Data/*.dta` and `Table*.do` files) was supplied by an RA after the first attempt could not penetrate the publisher's Cloudflare wall. Running the three relevant author do-files (`Table2_…do`, `Table3_…do`, `Table4_…do`) under Stata 16 MP, with only environment-only path-separator changes (Windows `Log\` and `Data\` → POSIX `Log/` and `Data/`), reproduces every printed coefficient, standard error, and N to all reported digits, and reproduces both qualitative Table 4 bushels ("negative and significant in virtually all cases" — 42/45 and 44/45 ages significant at p<.05 in cols 1 and 3 respectively).

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| q8xv_single-trace (Tbl 2 col 3, medage_20_64) | coef | -0.007 | -0.007 | -0.0073233 → -0.007 | [-0.00805, -0.00595] | precise |
| q8xv_single-trace | SE (→ test stat) | 0.001 (t=-7) | 0.001 (t≈-5.71 implied) | SE=0.00128, t=-5.71 | [-6.57, -4.86] for t=-5.71 | precise (SE rounds to .001) |
| q8xv_single-trace | p | <.01 (***) | 1.78e-7 | <.001 | (0.01, 0.06] approx | precise |
| q8xv_single-trace | N | 393 | 393 | 393 | [334, 452] | precise |
| q8xv_524ll2 (Tbl 3 col 1, r) | coef | -0.038 | -0.038 | -0.0382702 → -0.038 | [-0.0437, -0.0323] | precise |
| q8xv_524ll2 | SE (→t) | 0.007 (t=-5.49) | 0.007 | SE=0.006967, t=-5.49 | [-6.32, -4.67] | precise |
| q8xv_524ll2 | p | <.01 (***) | 4.43e-7 | <.001 | (0.01, 0.06] approx | precise |
| q8xv_524ll2 | N | 17,554 | 17,554 | 17,554 | [14921, 20187] | precise |
| q8xv_22jnnj (Tbl 3 col 3, s_age) | coef | 0.336 | 0.336 | 0.3357892 → 0.336 | [0.286, 0.386] | precise |
| q8xv_22jnnj | SE (→t) | 0.054 (t=6.17) | 0.054 | SE=0.05443, t=6.17 | [5.24, 7.10] | precise |
| q8xv_22jnnj | p | <.01 (***) | 2.56e-8 | <.001 | (0.01, 0.06] approx | precise |
| q8xv_22jnnj | N | 17,554 | 17,554 | 17,554 | [14921, 20187] | precise |
| q8xv_827ww4 (Tbl 3 col 3, a_age) | coef | -0.376 | -0.376 | -0.3757152 → -0.376 | [-0.432, -0.320] | precise |
| q8xv_827ww4 | SE (→t) | 0.057 (t=-6.57) | 0.057 | SE=0.05715, t=-6.57 | [-7.55, -5.58] | precise |
| q8xv_827ww4 | p | <.01 (***) | 4.41e-9 | <.001 | (0.01, 0.06] approx | precise |
| q8xv_827ww4 | N | 17,554 | 17,554 | 17,554 | [14921, 20187] | precise |
| q8xv_d4r99j (Tbl 4 col 1, qualitative) | direction-and-significance bushel across 44 ages | "negative and significant in virtually all cases" | NaN (qualitative) | All 44 r-coefs negative; 42/45 significant at p<.05 (ages 21–59 sig; 60, 62, 63 NS) | qualitative | precise |
| q8xv_ryzpp8 (Tbl 4 col 3, qualitative) | direction-and-significance bushel across 44 ages | "negative and significant in virtually all cases" | NaN (qualitative) | All 44 r-coefs negative; 44/45 significant at p<.05 (only one borderline NS) | qualitative | precise |

**Overall verdict (every reported sub-outcome precise):** **precise.**

## What I did

1. **Set-up.** Created `independent_reproductions/q8xv_liang_2018/`, copied `papers/q8xv.pdf` and `pdftotext -layout` output. Copied the RA-fetched data + code from `manually downloaded data/q8xv/` (`Data/*.dta`, `Table*.do`, `Figure*.do`, `Readme.doc`) into the reproduction directory, preserving the `Data/` and `Log/` subdirectory layout the do-files expect.

2. **Extraction check.** All six extracted values match the published version of record:
   - **Table 2** (PDF p. 29 / journal p. S166): col 3 — `medage_20_64 = -.007 [.001]***`, N = 393. ✓
   - **Table 3** (PDF p. 31 / journal p. S168): col 1 `r = -.038 [.007]***`, col 3 `s_age = .336 [.054]***`, `a_age = -.376 [.057]***`, N = 17,554. ✓
   - **Table 4** (PDF p. 32 / journal p. S172): age-specific `r` coefficients for cols 1 and 3, both qualitatively summarized as "negative and significant in virtually all cases". ✓

3. **Data/code source.** Manually delivered by RA at `manually downloaded data/q8xv/`. 19 entries: `Data/` (4 .dta files), `Figure/` placeholder, `Log/` placeholder, `Readme.doc`, and Stata do-files for Tables 1–9 plus Figures 1–4. The MATLAB `Figure2_Age_Distribution_Function.m` is for a figure not in our claim set. This appears to be the canonical author replication archive (originally hosted by JPE supplements).

4. **Reproduction.** Stata 16 MP (`/usr/local/bin/stata-mp`). One environment-only edit applied to all three claim-relevant do-files: `sed -i 's|Log\\|Log/|g; s|Data\\|Data/|g'` (Windows path separators → POSIX). No analysis logic touched. `.bak` files preserve originals. Commands:
   ```bash
   stata-mp -b do Table2_Country_Year_Entre_Regression.do
   stata-mp -b do Table3_Country_Year_Age_Entre_Regression.do
   stata-mp -b do Table4_Age_Specific_r.do
   ```
   Each ran in well under a minute. Logs in `Log/`. Top-level `Table*.log` mirrors are duplicates from a first attempt with the original Windows paths (now cleaned).

5. **Stochastic-method diagnostics.** N/A — all analyses are deterministic OLS.

6. **Classification.** Bounds computed from paper-printed values per the SCORE rubric. Every reproduced coefficient/SE/N rounds to the paper's printed precision exactly; every p<.01 threshold satisfied with reproduced p<.001; both Table 4 qualitative bushels confirmed (42/45 and 44/45 ages significant at p<.05 with the predicted negative sign — meets "virtually all cases"). Overall verdict **precise**.

## Diagnostics — author-bug analysis

Diagnostics: none — unpatched run reproduces every claim. No logic bug suspected. The only edit was a path-separator swap (Windows → POSIX), which is explicitly permitted as an environment-only edit under Push Button.

## Files in this folder

- `q8xv.pdf` — copy of paper.
- `q8xv.txt` — `pdftotext -layout` output.
- `Readme.doc` — author's documentation file.
- `Table2_Country_Year_Entre_Regression.do` (with `.bak` of original Windows-path version), `Table3_Country_Year_Age_Entre_Regression.do` (+ `.bak`), `Table4_Age_Specific_r.do` (+ `.bak`) — claim-relevant do-files.
- Other `Table*.do` and `Figure*.do` — author files for non-claim tables (unmodified, not run).
- `Data/GEM_Country_Year.dta`, `Data/GEM_Country_Age_Year.dta`, `Data/GEM-FESE_*.dta` — author-supplied analysis datasets.
- `Log/Table2_Country_Year_Entre_Regression.log`, `Log/Table3_Country_Age_Year_Entre_Regression.log`, `Log/Table4_Age_Specific_r.log` — Stata logs from this reproduction (unpatched run, env-only path edits).
- `Table2_Country_Year_Entre_Regression.log`, `Table3_*.log`, `Table4_*.log` (top-level) — leftover from first failed attempt before path fix; superseded by `Log/` versions.
- `REPRODUCTION_REPORT.md` — this file.
- `q8xv_summary_rows.csv` — one row per claim.

No patched-diagnostic artifacts (no patch was needed).
