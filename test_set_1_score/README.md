# Test Set 1 — SCORE project audit: reproduction code

Reproduces every headline statistic, Table 1, and Figure 1 in "Automating Reproducibility Checks Using Large Language Models" 
from Miske et al.'s deposited data, the LLM
analyst's per-claim verdicts, and the human disagreement adjudication. All inputs are under `Data/`.

## Requirements

- **R** (>= 3.5) with **dplyr**, **readr**, **tidyr**:
  ```r
  install.packages(c("dplyr", "readr", "tidyr"))
  ```
- **Python 3** with **matplotlib** (only for the figure):
  ```bash
  pip install matplotlib
  ```

## How to run

`all_analyses.R` is written to be run interactively:

1. Open `all_analyses.R` in RStudio or another IDE.
2. Set the working directory to the file's folder:
   *Session > Set Working Directory > To Source File Location*.
3. Source it (Cmd/Ctrl-Shift-S) or step through it.

It prints the full headline-statistics summary to the console and leaves all
results in the environment as data frames:

| object | contents |
|---|---|
| `cmp` | one row per attempted claim: LLM + Miske verdicts, agreement flag |
| `disagree` | the 47 disagreements, with the human `Errors in` adjudication |
| `table1` | verdict distributions at claim and paper level (Table 1) |
| `paper_level` | per-paper agreement and verdict rates (73 papers) |
| `ci_claim`, `ci_paper` | paper-clustered bootstrap 95% CIs (B = 10,000, seed 20260819) |

The script writes out `Data/sankey_counts.csv`, because
the figure script needs it. Nothing else is written to disk.

Then build the figure (Python, reads that one file):

```bash
python figure1_sankey.py        # writes output/Figure1A_sankey_clean.{png,pdf}
```

## What the script does

**1. Derives Miske's canonical audit set** via the manuscript-SI filter chain:

1. `pr_outcomes$data_available == "Yes"` (publicly posted data)
2. paper has >= 1 canonical reproduction row (`repro_version_of_record` T)
3. `paper_metadata$type == "J"` (journal article)
4. keep only the canonical row per claim

76 papers / 359 claims; intersecting with the LLM analyst's per-claim set
(which excludes 3 papers / 19 claims whose deposited data could not be
retrieved) gives the audit pool of **73 papers / 340 claims**.

**2. Compares verdicts** — LLM `outcome_overall` vs Miske
`repro_outcome_overall`, mapping Miske's `"push button"` to `"precise"` (raw
value kept in `miske_raw`).

**3. Joins the human adjudication** — the 47 disagreements are joined to the
`Errors in` column of `Data/adjudicated_disagreements.csv` (SCORE / Neither /
LLM / Both) and tallied into the four-way attribution that drives Figure 1.

**4. Paper-level analysis** — per-paper agreement and verdict rates (equal
weight per paper), a paper-clustered bootstrap 95% CI on the claim-level
agreement rate (resampling the 73 papers with replacement, B = 10,000,
percentile intervals, seed 20260819), and the
within-paper clustering of disagreements.

## Configuration

Paths are set in the `configuration` block near the top of the script. Edit
them there if your layout differs (defaults assume the working directory is
this folder).

## Data provenance

```
Data/
  miske/                            redistributed verbatim from the SCORE /
    analysis_ready/{paper_metadata,pr_outcomes,repro_outcomes}.csv
    raw_data/repro_vor.csv          Miske et al. (2026) public deposit
  llm_analyst/summary.csv           LLM analyst per-claim verdicts (this work)
  adjudicated_disagreements.csv     human "Errors in" coding (this work)
```

See `Data/SOURCE.md` for full data provenance.
