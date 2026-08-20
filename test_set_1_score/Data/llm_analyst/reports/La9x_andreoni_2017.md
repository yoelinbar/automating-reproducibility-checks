# Reproduction Report — Andreoni (2017), Avoiding the Ask

**Paper:** Andreoni, James, Justin M. Rao, and Hannah Trachtman. 2017. "Avoiding the Ask: A Field Experiment on Altruism, Empathy, and Charitable Giving." *Journal of Political Economy* 125(3): 625-653. DOI: 10.1086/691703
**Paper IDs:** paper_id=La9x; claims=[La9x_single-trace]
**Reproduction type:** Push Button (path edits only)
**Headline verdict (unpatched):** precise
**Verdict if patched:** N/A

## Headline

**Precise reproduction.** Running the authors' archived `Analysis.do` (openICPSR project 112570; supplied via manually downloaded data) on the archived `data2009.csv` and `data2013.csv` raw files reproduces Table 2, column 1 exactly. The Ask1 coefficient is **4.0625** (rounds to **4.06** at the paper's 2-decimal precision), the cluster-robust SE is **1.135369** (rounds to **1.135** at the paper's 3-decimal precision), and the analytic p = 0.003 (< 0.01, matches the paper's `***` threshold). N = 64 sessions matches exactly. No deviations beyond rounding.

## Comparison table

| Claim | Sub-outcome | Paper | Extracted | Reproduced (unpatched) | Bounds (computed) | Sub-verdict |
|---|---|---|---|---|---|---|
| La9x_single-trace | Coefficient (Ask1) | 4.06 | 4.06 | 4.0625 → 4.06 | precise iff rounds to 4.06; approx in [3.451, 4.669] | precise |
| La9x_single-trace | SE (clustered by block) | 1.135 | 1.135 | 1.135369 → 1.135 | precise iff rounds to 1.135 | precise |
| La9x_single-trace | p-value | < .01 (`***`) | 0.01 (less-than) | 0.003 | precise iff p ≤ .01; approx (.01, .06] | precise |
| La9x_single-trace | Sample size | 64 | 64 | 64 | precise iff = 64; approx [55, 73] | precise |
| La9x_single-trace | Effect size (= regression coefficient) | 4.06 | 4.06 | 4.0625 → 4.06 | precise iff rounds to 4.06 | precise |

Overall (unpatched): **precise**.

## What I did

1. **Set-up.** Working in `independent_reproductions/La9x_andreoni_2017/`. Copied the authors' replication archive (openICPSR 112570, manually downloaded by the RA) — `do/Analysis.do`, `raw/data2009.csv`, `raw/data2013.csv`, plus pre-built `dta/`, `tabfig/` outputs — into this directory.
2. **Extraction check.** Located Table 2 on paper page 638 (text page near line 557 of `La9x.txt`). Column (1) "Number of Givers per 23-Minute Session": Ask1 coefficient `4.06***`, cluster-robust SE `1.135` (in parentheses below), Observations row N = 64. Footnote: `*** p<.01`. All extracted values in `paper_claims/La9x.json` match the printed values exactly.
3. **Data/code source.** openICPSR project 112570, accessed via the RA-provided copy in `manually downloaded data/La9x/`. Files: `do/Analysis.do` (613 lines); `raw/data2009.csv`, `raw/data2013.csv`; pre-built `.dta` files in `dta/`; pre-built figures/tables in `tabfig/`.
4. **Reproduction commands and runtime.**
   - Created `run_pushbutton.do` from `do/Analysis.do` with **path-only edits**:
     - `global master "C:\Users\Hannah\Box Sync\Personal\Projects\AvoidingTheAsk\Stata\Hannah\Final"` → `global master "/Users/yoel/.../La9x_andreoni_2017"`
     - All Windows backslash path separators (`\`) converted to forward slashes (`/`) for macOS Stata. Note this incidentally turned LaTeX-escaped `\&` inside outreg2 string arguments into `/&`, which only affects cosmetic labels in exported `.tex` files (not regression output).
   - Installed required user-written packages: `outreg2` (SSC), `renvars` (SJ-5-4 dm88_1), `svmatf` (SSC), `svmat2` (STB-56 dm79). All are environment-only dependencies; no analysis logic edits.
   - Ran: `stata-mp -b do run_pushbutton.do`. Completed without error in ~10 seconds.
   - Output saved to `run_pushbutton.log`.
5. **Stochastic-method diagnostics.** N/A — OLS with cluster-robust SE is deterministic.
6. **Classification.**
   - Coef: paper prints 4.06 (2 dp). Reproduced 4.0625 → rounds to 4.06 → **precise**.
   - SE: paper prints 1.135 (3 dp). Reproduced 1.135369 → rounds to 1.135 → **precise**. (Note: SE was treated as the eligible "test statistic" sub-outcome for this claim since the paper reports SE in the table cell rather than t/F. The implied t = 4.0625/1.135369 = 3.578 also has p = 0.003.)
   - p: paper prints `***` = "p < .01" (threshold). Reproduced p = 0.003 ≤ 0.01 → **precise** (one-sided threshold rule).
   - N: paper prints 64. Reproduced 64 → **precise**.
   - Effect size: same as coefficient (paper reports coefficient as the effect size) → **precise**.
   - Overall: every reported sub-outcome is precise → **precise**.

The Ask1 coefficient corresponds to the claim's substantive interpretation: relative to the Opp1 mean (`local mean_M1` ≈ 7.31 givers per session in the M1 cell), an additional 4.0625 givers is ~55.6% — matching the paper's "raised the number of donors by 55 percent" claim exactly.

## Diagnostics — author-bug analysis

Diagnostics: none — unpatched run reproduces precisely; no logic bug suspected. The only edits required were the path replacement and slash conversion (Push Button) plus installation of four user-written packages (environment-only).

## Files in this folder

**Unpatched-run artifacts:**
- `run_pushbutton.do` — Analysis.do with path-only edits
- `run_pushbutton.log` — full Stata log of the unpatched run
- `do/Analysis.do` — original author do-file (verbatim)
- `raw/data2009.csv`, `raw/data2013.csv` — author raw data
- `dta/` — author pre-built intermediate dta files (also overwritten by the run)
- `tabfig/` — author pre-built tables/figures (also overwritten by the run)

**Documentation:**
- `La9x.pdf` — paper PDF
- `La9x.txt` — pdftotext-layout extraction
- `REPRODUCTION_REPORT.md` — this report
- `La9x_summary_rows.csv` — one-row claim summary

**Patched-diagnostic artifacts:** none (no patches applied).
