# Plan — Reproduction, error-detection, and robustness checks

This file instructs a Claude instance to evaluate the reproducibility of a set of published quantitative social-science papers, using each paper and its original replication package. Follow it literally. Each paper is an independent task.

---

## 0. Ground rules (read first)

- **Use only two sources for each paper: its PDF and its replication package (data + code).** Do not look anything else up. No web searches; do not consult other reproductions, critiques, errata, or retraction notices; do not rely on outside/recalled knowledge about a specific paper's known issues. Every finding must come from what is actually in the assigned paper and its package.
- **Do not read other files in this working directory** (existing reports, notes, plans, or other papers' materials). Work only from the assigned paper's PDF and its own replication package folder.
- If a package's data is **not included** (some packages ship code that pulls public data), follow the package's own README to obtain the public source data — this is part of the task. Do not contact the original authors.

---

## 1. What you receive (per paper)

- The **journal article** as a PDF: `pdfs/NN_<name>.pdf`
- The **original replication package** (data + code): `replication_packages/NN_<name>/`
- The **assigned exhibit to reproduce** (one specific table+column, or one figure) — see §7.

---

## 2. The protocol — three tasks, IN THIS ORDER

> Reproduce the result first; then look for errors; then do robustness checks. **Follow this order.**

**Task 1 — Computational reproduction.**
Using the original data and code, computationally reproduce the **assigned exhibit** (§7).
- Report whether the point estimate(s) and number of observations are the **same as in the article**.
- **For the two figure targets (Paper 03 = Figure 4, Paper 12 = Figure 2): you must render the ACTUAL figure** (save a real image, see §4) and visually compare it to the published figure — not just the underlying numbers.

**Task 2 — Look for coding errors and irregularities in the data.**
Open-ended. Inspect the data and code for coding errors, data irregularities, and discrepancies between what the paper says and what the code does (e.g., paper says clustering at one level but code clusters at another; mis-specified variables; wrong sample restrictions; merge problems; impossible/placeholder values; controls present in code but not described, etc.). For **each** issue, record a description, its **location** (file + line/table), and the **time you confirmed it** (see §3). You may note whether you believe each issue **could affect the paper's main claims** (your own judgment). Do not assume any exist; report only what you actually find.

**Task 3 — Robustness / sensitivity checks.**
Propose and implement **up to two** robustness checks (sensitivity analyses) for the main result. Each should be: feasible with the available data/code; **not already performed** by the original authors; and **relevant to the validity** of the empirical strategy (not mere heterogeneity splits). Briefly state the purpose, run it, and report the result.

**Working rules:**
- You may run the package's code locally in its native language (R / Stata / Python) and adjust file paths / install packages / fix your environment. Do **not** rewrite the authors' analysis to "fix" it for Task 1 — reproduce as-is. (Fixing is only relevant if you choose it as a Task-3 robustness check.)
- Time-box: aim to finish each paper within roughly **30 minutes of compute**; if blocked, report how far you got.

---

## 3. Timing & logging

- Record a **wall-clock start time** for each paper (`date +%s`) the moment you begin Task 1.
- For Task 1: log **minutes-from-start to a successful reproduction** (or "not reproduced").
- For Task 2: for each error, log **minutes-from-start when you confirmed it**.
- The orchestrating instance records an **overall wall-clock start and end** for the whole run and reports total wall time.

---

## 4. Deliverables

Write everything to a fresh output folder:

```
reproduction_run/
  reports/        NN_<name>.md      ← one per paper
  reports/00_OVERALL_REPORT.md
  figures/        03_figure4.png, 12_figure2.png   ← actual rendered figures
```

**Per-paper report (`reports/NN_<name>.md`) must contain:**
1. **Task 1 — Reproduction:** assigned exhibit; reproduced value(s) vs the article's reported value(s) in a comparison table; whether point estimates and N match (to displayed precision); minutes-to-reproduction; software/code path used. *(Apply the project's reporting policy in `CLAUDE.md`: any deviation beyond rounding is meaningful — flag and categorize Critical/High/Moderate.)* For figure targets: embed/reference the rendered PNG and state whether it visually matches.
2. **Task 2 — Errors/irregularities found:** a table of each issue (description · location file+line/table · detection time in minutes · your view on whether it could affect the main claims). If you found none, say so.
3. **Task 3 — Robustness checks:** the (up to) two checks, their purpose, and results.
4. Obstacles encountered.

**Overall report (`reports/00_OVERALL_REPORT.md`):**
- Top section: any reproduction discrepancies (beyond rounding), prominently, per `CLAUDE.md`.
- A summary table across all papers: reproduced? (Y/N) · minutes-to-reproduction · # errors/irregularities found · # robustness checks run.
- Aggregate stats on minutes-to-reproduction (min / median / max / mean).
- Total wall time for the whole run.

---

## 5. How to run (orchestrating instance)

1. Record global start: `date +%s` → save to `/tmp/reproduction_run_start.txt`.
2. Create `reproduction_run/reports` and `reproduction_run/figures`.
3. Spawn **one sub-agent per paper** (general-purpose), in parallel, each given the §6 template with the blanks filled from §7. (Skip Paper 09 — its replication package no longer exists; note this in the overall report.)
4. When all return, record end time, compute wall time, and write `00_OVERALL_REPORT.md` synthesizing the per-paper returns.

---

## 6. Per-paper sub-agent prompt template (copy verbatim, fill `<…>`)

```
You are a reproduction team in a research-reproducibility exercise. You have a published paper and its
original replication package. Work ONLY from these two sources — do NOT read any other files in the
working directory, do NOT search the web, and do NOT rely on outside knowledge about this paper. Base
every finding on what is actually in the assigned paper and its package.

PAPER: <title> (<journal> <year>)
PAPER PDF: /Users/yoel/reproducibility_assessment/pdfs/<NN_name>.pdf
REPLICATION PACKAGE: /Users/yoel/reproducibility_assessment/replication_packages/<NN_name>/
ASSIGNED EXHIBIT TO REPRODUCE: <Table X, column Y  |  Figure N>
PACKAGE LANGUAGE: <R | Stata | Python>

ENVIRONMENT: Stata-MP 16.1 at /usr/local/bin/stata-mp (`stata-mp -b do FILE.do`, read FILE.log);
R via Rscript (haven, fixest may be missing—install from https://cloud.r-project.org; sandwich, lmtest,
estimatr, plm, survey, data.table, tidyverse present); python3 (pandas, numpy, statsmodels, linearmodels,
pyreadstat). Install missing packages as needed; you may adjust file paths and your environment. If the
package ships SSC/Stata commands you lack, `ssc install NAME`. If the data is not in the package, follow
the package README to obtain the public source data.

Record a wall-clock start now (`date +%s`).

Do THREE tasks IN THIS ORDER (follow the order):
  TASK 1 — Computationally reproduce the ASSIGNED EXHIBIT using the original data + code (as-is; do not
    "fix" the analysis). Report whether the point estimate(s) and N match the article to displayed
    precision. Log minutes-from-start to a successful reproduction (or "not reproduced").
    >> IF THE ASSIGNED EXHIBIT IS A FIGURE: render the ACTUAL figure (run the package's figure code;
       export to PNG at <output figures path>/<NN>_<fig>.png) and visually compare it to the published
       figure, not just the numbers.
  TASK 2 — Look for coding errors and irregularities in the data. Open-ended: inspect data and code for
    coding errors, data irregularities, and discrepancies between the paper's description and the code.
    For each issue, record: description, location (file + line / table), the minutes-from-start when you
    confirmed it, and (your judgment) whether it could affect the paper's main claims. Do not assume any
    exist; report only what you actually find.
  TASK 3 — Propose and implement up to TWO robustness/sensitivity checks for the main result: feasible,
    NOT already done by the authors, and relevant to the validity of the empirical strategy. Run them and
    report results.

Apply the project reporting policy (CLAUDE.md): any reproduction deviation beyond rounding is meaningful —
flag it and categorize Critical (significance/sign changed) / High (>10% magnitude) / Moderate (.01–.02).

DELIVERABLE: write a markdown report to
  /Users/yoel/reproducibility_assessment/reproduction_run/reports/<NN_name>.md
with sections: Task 1 (comparison table: reproduced vs published; match Y/N; minutes-to-reproduction;
code path) — Task 2 (table of issues found w/ location + detection time + claim-impact judgment) — Task 3
(the checks + results) — Obstacles. For a figure target, reference the saved PNG and state visual match.

THEN return a compact summary: reproduced? (Y/N), minutes-to-reproduction, # issues found, # robustness
checks run, and the worst reproduction-discrepancy severity (if any).
Time-box ~30 min of compute. Don't contact the original authors.
```

---

## 7. Assigned exhibits

| NN_name | Paper (journal, year) | Assigned exhibit | Language | Figure? |
|---|---|---|---|---|
| 01_acquiescence | Acquiescence bias inflates estimates of conspiratorial beliefs… (Political Analysis, 2023) | **Table 2, column 3** | R | |
| 02_terrorism | Arrests and convictions but not sentence length deter terrorism… (Nature Human Behaviour, 2023) | **Table 1, Model IIa** | R | |
| 03_policymakers | Do Policy-makers Listen to Experts?… (APSR, 2021) | **Figure 4** | R | **figure → render PNG** |
| 04_waiting | Examining inequality in the time cost of waiting (Nature Human Behaviour, 2023) | **Table 1, Panel A** | Stata | |
| 05_gambling | Gambling, Saving, and Lumpy Liquidity Needs (AEJ: Applied, 2021) | **Table 3, column 2** | Stata | |
| 06_mortality | How the Other Half Died: Immigration and Mortality in US Cities (RESTUD, 2024) | **Table 1, column 6** | R | |
| 07_electricity | Major Reforms in Electricity Pricing… (Economic Journal, 2022) | **Table 2, column 2** | Stata | |
| 08_gratitude | Mindful-Gratitude… Collective Narcissism (Psychological Science, 2024) | **Table 1, Model 2** | R | |
| 09_steering | Sorting or Steering… (JPE, 2022) | Table 5, column 2 | — | **SKIP — no package** |
| 10_priceisright | Taste-Based Gender Favouritism… The Price is Right (Economic Journal, 2024) | **Table 1, column 6** | R | |
| 11_savings | The Interplay Among Savings Accounts and Network-Based… (Economic Journal, 2022) | **Table 1, column 3** | Stata | |
| 12_taxpass | The heterogeneous tax pass-through… (Economic Journal, 2022) | **Figure 2** | R/Stata | **figure → render PNG** |

(11 papers to run; Paper 09 excluded — replication package no longer available.)

---

## 8. Environment notes

- **Stata-MP 16.1** at `/usr/local/bin/stata-mp` — batch: `stata-mp -b do "FILE.do"`, then read the `.log`. Quote paths with spaces.
- **R** at `Rscript` — present: haven, sandwich, lmtest, estimatr, plm, survey, data.table, tidyverse; install missing (e.g. fixest, lfe, margins) from `https://cloud.r-project.org`.
- **Python 3** — pandas, numpy, statsmodels, scipy, linearmodels, pyreadstat.
- Figures: Stata `graph export ... .png` may fail in headless batch — export to PDF then rasterize with `pdftoppm`/`sips`. R: `ggsave(..., dpi=150)`.
- Replication packages are multi-GB for 06/07/12 — find the minimal path to the assigned exhibit; use prebuilt/intermediate data if shipped rather than rebuilding from raw.
