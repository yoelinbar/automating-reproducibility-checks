# Test Set 2 — Brodeur et al. (2026) comparison

The LLM analyst (Claude Opus 4.8 in Claude Code) re-ran the reproduction tasks
from Brodeur et al. (2026), *PNAS* (the AI replication games): reproduce the
assigned exhibit, hunt for coding errors and data irregularities, and run two
robustness checks, for each of the 12 assigned papers (one package was no
longer available; 11 were run).

| file | contents |
|---|---|
| `REPRODUCTION_PLAN.md` | the plan file given to the LLM analyst (mirrors Brodeur et al.'s team tasks) |
| `Reproduction Reports/00_OVERALL_REPORT.md` | run-level summary: reproduction outcomes, all 45 flagged issues, timings |
| `Reproduction Reports/NN_*.md` | the 11 per-paper reports |
| `major_error_coding.csv` | the 45 reported issues coded major/minor under Brodeur et al.'s standard (major = could, in theory, impact the claims tested); 12 major = 1.1 per paper |
| `CLAUDE.md` | project-level configuration active during the run (statistical-deviation reporting policy) |
