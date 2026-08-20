# Automating Reproducibility Checks Using Large Language Models — code and data

Deposit for Inbar & Tannenbaum, "Automating Reproducibility Checks Using Large
Language Models." The paper reports two test sets, mirrored here as two
parallel folders:

| folder | test set | contents |
|---|---|---|
| `test_set_1_score/` | **Test Set 1: SCORE project audit** — the LLM analyst vs. the SCORE project's human reproducibility audit (Miske et al., 2026; 340 claims, 73 papers) | analysis code (`all_analyses.R`), Figure 1 script, input data (SCORE deposit extracts, LLM verdicts, disagreement adjudication), the LLM analyst's 73 per-paper reports, and the reproduction plan |
| `test_set_2_brodeur/` | **Test Set 2: Brodeur et al. (2026)** — the LLM analyst re-running the reproduction tasks from Brodeur et al.'s AI replication games (12 assigned results) | reproduction plan, the 11 per-paper reports plus overall report, and the major-error coding table |

See `test_set_1_score/README.md` for how to run the analysis code, and each
folder's `REPRODUCTION_PLAN.md` for the instructions the LLM analyst received.
