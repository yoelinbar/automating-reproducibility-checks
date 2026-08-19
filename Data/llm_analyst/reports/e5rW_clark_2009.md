# Reproduction Report — Clark (2009), "Performance and Competitive Effects of School Autonomy"

**Paper:** Clark, Damon. 2009. "The Performance and Competitive Effects of School Autonomy." *Journal of Political Economy* 117(4): 745-783. DOI: 10.1086/605604
**Paper IDs:** paper_id=e5rW; claims=[e5rW_6rr1l5, e5rW_w7713v, e5rW_ppp6n8, e5rW_single-trace]
**Reproduction type:** Push Button (author's `main.do` code, run unchanged on author's `main_data.dta`)
**Headline verdict (unpatched):** **precise** (all four claims)
**Verdict if patched:** N/A — no patches needed.

## Headline

After the RA manually obtained the author's archived replication package from the publisher, this paper now reproduces **precisely**, with no deviations of any kind. The single-trace target (Table 1, Panel A, "Base+2", column 3) reproduces to **3.587043 (SE 1.148498), N=726** vs the paper's **3.587 (SE 1.148), N=726** — identical at the paper's printed precision. The three bushel claims (Table 1's headline that early post-vote performance gains are around 3 percentage points, and Table 4 Panel A's neighbor-school spillover regressions on pass rates and exam points) all reproduce exactly: every coefficient and standard error in Table 4 Panel A rows 1 and 2 (cols 3-6) matches to all printed digits. This is a clean push-button reproduction. The previous "not-attemptable" verdict reflected only the absence of an obvious public archive — the author had in fact deposited a complete data + code package which the RA retrieved manually.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| e5rW_single-trace | coef (Table 1, Panel A, "Base+2", col 3) | 3.587 | 3.587 | 3.587043 → rounds to 3.587 | precise = 3.587 (paper precision); approx = [3.049, 4.125] | **precise** |
| e5rW_single-trace | SE (Table 1, Panel A, "Base+2", col 3) | 1.148 | 1.148 | 1.148498 → rounds to 1.148 | precise = 1.148 (paper precision); approx = [0.976, 1.320] | **precise** |
| e5rW_single-trace | N (Table 1, Panel A, "Base+2") | 726 | 726 | 726 | precise = 726; approx = [617, 835] | **precise** |
| e5rW_6rr1l5 (bushel) | "around 3 percentage points 2 years after vote" (Table 1) | ≈3 | n/a (NaN) | 3.587 (rounds to 3 → "≈3"; same single-trace coef) | n/a — qualitative match | **precise** |
| e5rW_w7713v (bushel) | Table 4 Panel A row 1 (neighbor pass rates), cols 3-6 — coefs "close to zero" | -0.092 / 0.053 / 0.068 / -0.617 (with SEs .778, .822, 1.034, 1.548) | n/a (NaN) | -0.0920917 / 0.0534742 / 0.0677744 / -0.6173823 (SEs .7782601, .8216621, 1.033859, 1.547766) | exact to printed precision | **precise** |
| e5rW_ppp6n8 (bushel) | Table 4 Panel A row 2 (neighbor exam points), cols 3-6 — coefs "larger but not statistically different from zero" | 0.606 / 0.669 / 0.844 / 0.622 (with SEs .461, .504, .625, .918) | n/a (NaN) | 0.6056519 / 0.6686739 / 0.8439726 / 0.6224839 (SEs .4606741, .5043462, .6250778, .9177854) | exact to printed precision | **precise** |

**Extraction check vs paper:** All four extractions (where numeric values were extracted) match the paper exactly. The single-trace claim correctly identifies Table 1, Panel A, "Base+2" row, column 3 ("Linear" RD-ITT) on p. 762 of the article. The Table 4 Panel A values quoted above were re-read from the paper and are reproduced to all printed digits.

## What I did

1. **Set-up.** Created `independent_reproductions/e5rW_clark_2009/`. Copied `papers/e5rW.pdf`. The RA placed the author's archived replication materials in `manually downloaded data/e5rW/`. I copied all `.dta` files into `./data/` and all `.do` files into `./` so paths in the do-files (`use ... using data/main_data.dta`) resolve correctly.

2. **Extraction check (page references).**
   - `e5rW_single-trace`: Table 1, Panel A, "Base+2 (N=726)" row, column 3 ("Linear" RD-ITT) → paper prints `3.587` with `(1.148)` SE. Confirmed.
   - `e5rW_6rr1l5`: bushel summary of Table 1 — "around 3 percentage points 2 years after vote" — anchors on the same 3.587 coefficient.
   - `e5rW_w7713v`: Table 4, Panel A, row 1 (neighbor pass rates `n_gcse`).
   - `e5rW_ppp6n8`: Table 4, Panel A, row 2 (neighbor exam points `n_points`).

3. **Data/code source.** RA-fetched archive at `manually downloaded data/e5rW/` containing 11 do-files and 8 `.dta` files plus `read_me.pdf`. The 3 student-level files (`ycs_data.dta`, `npd_data.dta`, `primary_data.dta`) are not included (restricted-access UK administrative data per the readme), but those data underlie Table 3 and Figure 5 — none of the four claims here require them. The four claims here all use `main_data.dta`, which is included.

4. **Reproduction.** Wrote `run_pushbutton.do`, which copies the relevant Table 1 Panel A and Table 4 Panel A blocks from the author's `main.do` (lines 519-541 and 635-673) verbatim — same model specifications, same `xi:` factor expansion, same `robust` / `cluster(pc_id)` SEs, same `i.gm_attempt1_ballot_year_term` / `i.school_type` / `i.year` controls, same `lose_vote`/`win_vote`/`lose_vote_2`/`win_vote_2` polynomial controls. The only changes from `main.do` are (a) wrapping the relevant blocks in `di` headers so the log is human-readable, and (b) skipping the figure-export and `outreg` lines (which are output-only, not analysis-affecting). Replaced `quietly` with display so the regression tables print. **No analysis-logic edits.** Ran via `/usr/local/bin/stata-mp -b do run_pushbutton.do`. Runtime ≈ a few seconds. Output: `output/run_pushbutton.log` (~3,600 lines).

5. **Stochastic-method diagnostics.** N/A — all OLS / 2SLS, deterministic.

6. **Classification (unpatched).**
   - Single-trace: 3.587043 rounds to 3.587 = paper. SE 1.148498 rounds to 1.148 = paper. N 726 = paper. All three sub-outcomes **precise**. Overall **precise**.
   - 6rr1l5 bushel: same coefficient drives the "≈3 pp" qualitative claim — **precise**.
   - w7713v bushel: each of the four reported Table 4 Panel A row 1 coefficients (cols 3-6) reproduces exactly to printed precision; SEs also exact. Qualitative claim ("close to zero") trivially holds (max |coef| = 0.617). **precise**.
   - ppp6n8 bushel: each of the four reported Table 4 Panel A row 2 coefficients reproduces exactly; SEs also exact. Qualitative claim ("larger but not statistically different from zero") holds — all four t-stats < 2. **precise**.

## Diagnostics — author-bug analysis

**Diagnostics: none.** Unpatched run reproduces every sub-outcome to all printed digits. No bug to diagnose.

One earlier flag is now resolved: the previous report noted that `pr_data_location="Publisher website"` was misleading because no archive could be found at the JPE article page in 2026. The actual archive does exist (the RA obtained it), so the location flag was correct in spirit — the publisher's hosting may have moved or become harder to discover via scripted access. Manual fetch succeeded.

## Files in this folder

**Unpatched-run artifacts:**
- `run_pushbutton.do` — the do-file actually run (mirrors author's `main.do` lines 519-541 and 635-673 verbatim).
- `output/run_pushbutton.log` — full Stata log, ~3,600 lines.

**Author materials (RA-fetched, copied verbatim):**
- `main.do`, `attempt.do`, `circle.do`, `dissim.do`, `district.do`, `non_gm.do`, `npd.do`, `primary.do`, `teachers.do`, `time_series.do`, `ycs.do` — author's original do-files.
- `data/main_data.dta`, `data/attempt_data.dta`, `data/circle_data.dta`, `data/dissim_data.dta`, `data/district_data.dta`, `data/non_gm_data.dta`, `data/teachers_data.dta`, `data/time_series.dta` — author's data files (8 included; 3 student-level files restricted-access and not needed for these claims).
- `read_me.pdf` — author's readme.

**Paper materials:**
- `e5rW.pdf` — published article.
- `e5rW.txt` — `pdftotext -layout` extraction of the article.

**Report and summary:**
- `REPRODUCTION_REPORT.md` — this report.
- `e5rW_summary_rows.csv` — one row per claim for the audit summary.
