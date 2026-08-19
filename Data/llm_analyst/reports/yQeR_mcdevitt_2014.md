# Reproduction Report — McDevitt (2014), "A" Business by Any Other Name

**Paper:** McDevitt, R. C. (2014). "'A' Business by Any Other Name: Firm Name Choice as a Signal of Firm Quality." *Journal of Political Economy*, 122(4), 909-944. DOI: [10.1086/676333](https://doi.org/10.1086/676333)
**Paper IDs:** paper_id=yQeR; claims=yQeR_j66kzq, yQeR_1rrdyx, yQeR_9oovx5, yQeR_4kk266, yQeR_5oo23w, yQeR_9vxx6n
**Reproduction type:** Push Button
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A — no patch needed

## Headline
All six claims (Table 2 panel A and Table 4 t-statistics + Ns) reproduce **precisely** when the author's archived do-file `estimations_for_abbaon.do` is executed unmodified on the author's archived `final_data.dta`. Every t-statistic rounds to the paper's printed two-decimal value, and the unconditional N values (1,998 + 295 = 2,293 for Table 2A; 461 + 82 = 543 for Table 4) match exactly. No environment edits or logic patches were required. The previously-blocked "publisher website" data hunt is resolved by RA-supplied JPE supplement files copied into the reproduction directory.

## Comparison table
| Claim | Sub-outcome | Paper (Table) | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| yQeR_j66kzq | t-stat (Complaints by A-name, Table 2A) | 6.79 | 6.79 | 6.7881 → 6.79 | precise band: rounds to 6.79; approx [5.77, 7.81] | precise |
| yQeR_j66kzq | N (Table 2A) | 2,293 | 2,293 | 2,293 (1,998 + 295) | precise (exact) | precise |
| yQeR_9vxx6n | t-stat (Ad spending, Table 2A) | 2.43 | 2.43 | 2.4291 → 2.43 | precise band: rounds to 2.43; approx [2.07, 2.79] | precise |
| yQeR_9vxx6n | N (Table 2A) | 2,293 | 2,293 | 2,293 | precise (exact) | precise |
| yQeR_9oovx5 | t-stat (Fixed fee level, Table 4) | 4.74 | 4.74 | 4.7364 → 4.74 | precise band: rounds to 4.74; approx [4.03, 5.45] | precise |
| yQeR_9oovx5 | N (Table 4) | 543 | 543 | 543 (461 + 82) | precise (exact) | precise |
| yQeR_4kk266 | t-stat (Hourly rate, Table 4) | 3.97 | 3.97 | 3.9713 → 3.97 | precise band: rounds to 3.97; approx [3.37, 4.57] | precise |
| yQeR_4kk266 | N (Table 4) | 543 | 543 | 543 | precise (exact) | precise |
| yQeR_1rrdyx | t-stat (Has fixed fee, Table 4) | 2.97 | 2.97 | 2.9702 → 2.97 | precise band: rounds to 2.97; approx [2.52, 3.42] | precise |
| yQeR_1rrdyx | N (Table 4) | 543 | 543 | 543 | precise (exact) | precise |
| yQeR_5oo23w | t-stat (2-hour price, Table 4) | 3.76 | 3.76 | 3.7565 → 3.76 | precise band: rounds to 3.76; approx [3.20, 4.32] | precise |
| yQeR_5oo23w | N (Table 4) | 543 | 543 | 543 | precise (exact) | precise |

All sub-outcomes precise. All extracted values match the paper's printed values exactly.

## What I did
1. **Set-up:** Reproduction directory `independent_reproductions/yQeR_mcdevitt_2014/` already contained `yQeR.pdf` and `yQeR.txt`. Copied the 17 RA-supplied files from `manually downloaded data/yQeR/` (15 `.dta` data files, 1 `.do` file `estimations_for_abbaon.do`, 1 `readme.pdf`) into the reproduction directory. Created `run_pushbutton.do` as an exact copy of `estimations_for_abbaon.do` (no edits).
2. **Extraction check:** Located all six claim values in the published PDF.
   - Table 2 panel A (page 921 / PDF page 13): complaints (No 0.248, Yes 1.339, t=6.79), ad spending (No 5,149.7, Yes 6,805.1, t=2.43), N = 1,998 + 295 = 2,293. All match extraction.
   - Table 4 (page 924 / PDF page 16): fixed fee (48.789 vs 85.634, t=4.74), hourly rate (100.173 vs 121.847, t=3.97), has fixed fee (.584 vs .756, t=2.97), 2-hour price (209.488 vs 251.591, t=3.76), N = 461 + 82 = 543. All match extraction.
3. **Data/code source:** RA-supplied JPE supplement (`manually downloaded data/yQeR/`, 17 entries including `final_data.dta` and `estimations_for_abbaon.do`).
4. **Reproduction commands:** `stata-mp -b do run_pushbutton.do` — Push Button. No environment-only edits required (the do-file uses bare filenames and the working directory contains all referenced `.dta` files).
5. **Stochastic-method diagnostics:** N/A (all are two-sample equal-variance t-tests on a fixed dataset).
6. **Classification:** Computed bounds for each t-stat using ±15% of the paper's printed value. Every reproduced t rounded to two decimals equals the paper's printed t, and every N equals the paper's printed N exactly. All sub-outcomes precise → overall verdict **precise**.

Reproduced values from `run_pushbutton.log`:
- Table 2A: `ttest complaints_2008, by(first_A)` → t = -6.7881, df = 2,291, N = 1,998 + 295 = 2,293.
- Table 2A: `ttest ad_spending, by(first_A)` → t = -2.4291, df = 2,291, N = 2,293.
- Table 4: `ttest fixedfee if in_survey==1, by(first_A)` → t = -4.7364, df = 541, N = 461 + 82 = 543.
- Table 4: `ttest hourlyrate if in_survey==1, by(first_A)` → t = -3.9713, df = 541, N = 543.
- Table 4: `ttest has_fixed_fee if in_survey==1, by(first_A)` → t = -2.9702, df = 541, N = 543.
- Table 4: `ttest total_price if in_survey==1, by(first_A)` → t = -3.7565, df = 541, N = 543.

(Sign of t is negative because Stata's `ttest ... , by(group)` computes mean(group=0) - mean(group=1), and the A-name group has the larger mean. The paper reports the absolute value as the magnitude of the difference test.)

## Diagnostics — author-bug analysis
Diagnostics: none — unpatched Push Button run reproduces all six claims to paper precision. No author bug suspected.

## Files in this folder
- `yQeR.pdf` — copy of the published paper
- `yQeR.txt` — pdftotext -layout extract used for verification
- `readme.pdf` — author's data/code readme (from JPE supplement)
- `estimations_for_abbaon.do` — author's analysis do-file (as archived)
- `run_pushbutton.do` — exact copy of the above, used for the headline run
- `run_pushbutton.log` — full Stata log of the Push Button run
- `final_data.dta` — primary dataset used for Tables 2, 4, 5, 6, 9 panel A
- `Table1Left.dta`, `Table1Right.dta`, `yelp_2009_homeservice.dta`, `yelp_2009_plumbers.dta`, `yelp_2009_restaurants.dta`, `yelp_2013_plumbers.dta`, `yelp_2013_users.dta`, `angieslist.dta`, `checkbookdotcom.dta`, `dunandbradstreet.dta`, `sf_permits.dta`, `plumbers_by_county_2005.dta`, `beauty_by_county_2005.dta` — auxiliary datasets for other tables/figures (untouched by the six claims under audit but used by other parts of the do-file)
- `REPRODUCTION_REPORT.md` — this report
- `yQeR_summary_rows.csv` — one row per claim
