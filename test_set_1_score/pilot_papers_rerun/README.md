# Pilot-papers re-run (sanitized plan)

Four audited papers (G4mp, L22B, qg47, Pxp7) were used for pilot testing, and
the reproduction plan's worked examples inadvertently referenced materials from
them. As a check, all 17 claims from these papers were re-run by a fresh LLM
analyst using a sanitized plan in which every such reference was replaced with
fictitious values, in a clean working directory containing only the sanitized
plan, the four papers' PDFs, and their rows of the claims file.

Contents: the re-run analyst's four per-paper reports and its per-claim verdict
summary (`summary.csv`, same schema as `../Data/llm_analyst/summary.csv`).

Outcome: verdicts were unchanged for 16 of 17 claims, including the one
disagreement with the SCORE record (G4mp). The single change (Pxp7_b4137v,
non-outcome → precise) was on a figure-based claim unrelated to the plan
examples and increased agreement with SCORE: the re-run analyst located the
effect sizes printed as figure labels in the PDF text layer. The re-run analyst
also independently rediscovered, from the archived materials alone, the code
issues the plan's examples had referenced (L22B's sample-filter clause and
qg47's out-of-range revenue-share observations).
