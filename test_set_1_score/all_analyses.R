# ============================================================================
# Reproduce the LLM-vs-Miske comparison, the adjudicated disagreement
# attribution, and every headline statistic + Table 1 reported in the
# manuscript
#
# Nothing is written to disk except Data/sankey_counts.csv, which the
# Python figure script (figure1_sankey.py) reads. All results stay in the
# environment as data frames you can inspect / View():
#
#   cmp                  one row per attempted claim (LLM + Miske verdicts,
#                        agreement)
#   disagree             the 47 disagreements, with the human "Errors in"
#                        adjudication
#   table1               verdict distributions at claim and paper level
#                        (Table 1)
#   paper_level          per-paper agreement and verdict rates, with
#                        paper-clustered bootstrap 95% CIs (ci_claim, ci_paper)
#   plus the scalar stats printed in the summary block at the end.
#
# Filter chain for SCORE project data:
#   1. pr_outcomes data_available == "Yes"          (publicly posted data)
#   2. + paper has >= 1 canonical reproduction row  (repro_version_of_record T)
#   3. + paper_metadata type == "J"                 (journal article)
#   4. + repro_version_of_record == "T"             (keep canonical row/claim)
# -> 76 papers / 359 claims; intersect with the LLM analyst's set (excludes 3
# papers / 19 claims with unretrievable data) -> 73 papers / 340 claims.
# ============================================================================

#### Load packages ####
library(dplyr)
library(readr)
library(tidyr)


#### Configuration (edit if your layout differs) ####

miske_dir    <- "Data/miske"
llm_summary  <- "Data/llm_analyst/summary.csv"
adjudication <- "Data/adjudicated_disagreements.csv"
sankey_out   <- "Data/sankey_counts.csv"   # the only file written

if (!dir.exists(miske_dir)) {
  stop("Cannot find '", miske_dir, "'. In RStudio use ",
       "Session > Set Working Directory > To Source File Location, ",
       "so the working directory is the reproduction_code/ folder.")
}

#### Load data ####

ar  <- file.path(miske_dir, "analysis_ready")
pm  <- read_csv(file.path(ar, "paper_metadata.csv"), show_col_types = FALSE)
pro <- read_csv(file.path(ar, "pr_outcomes.csv"),    show_col_types = FALSE)
ro  <- read_csv(file.path(ar, "repro_outcomes.csv"),
                col_types = cols(repro_version_of_record = col_character(),
                                 .default = col_guess()))
vor <- read_csv(file.path(miske_dir, "raw_data", "repro_vor.csv"),
                col_types = cols(repro_version_of_record = col_character(),
                                 .default = col_guess()))
llm <- read_csv(llm_summary,  show_col_types = FALSE)
adj <- read_csv(adjudication, show_col_types = FALSE)

#### Miske canonical audit set ####

rr_to_paper <- ro %>% distinct(rr_id, paper_id)

# repro_version_of_record is read as character: "T"/"F" in repro_vor.csv,
# "TRUE"/"FALSE" in repro_outcomes.csv. "T"/"TRUE" mark the canonical row.
audit_set <- vor %>%
  left_join(rr_to_paper, by = "rr_id") %>%
  left_join(pm  %>% select(paper_id, type, is_covid), by = "paper_id") %>%
  left_join(pro %>% distinct(paper_id, data_available), by = "paper_id") %>%
  filter(data_available == "Yes") %>%                                       # step 1
  group_by(paper_id) %>%
  filter(any(repro_version_of_record %in% c("T", "TRUE"))) %>%              # step 2
  ungroup() %>%
  filter(type == "J") %>%                                                   # step 3
  filter(repro_version_of_record %in% c("T", "TRUE")) %>%                   # step 4
  distinct(paper_id, claim_id)

# Map Miske's raw outcome into the LLM analyst's vocabulary
# ("push button" is operationally "precise").
miske_outcomes <- ro %>%
  filter(repro_version_of_record %in% c("T", "TRUE")) %>%
  distinct(claim_id, miske_raw = repro_outcome_overall) %>%
  mutate(miske = if_else(tolower(miske_raw) == "push button",
                         "precise", tolower(miske_raw)))

audit_set <- audit_set %>% left_join(miske_outcomes, by = "claim_id")

#### Comparison ####

opt_cols <- intersect(c("headline_note", "repro_type"), names(llm))

cmp <- llm %>%
  select(paper_id, claim_id, llm = outcome_overall, all_of(opt_cols)) %>%
  inner_join(audit_set %>% select(claim_id, miske, miske_raw), by = "claim_id") %>%
  mutate(agree = llm == miske) %>%
  arrange(paper_id, claim_id)

disagree <- cmp %>%
  filter(!agree) %>%
  left_join(adj %>% select(claim_id, errors_in = `Errors in`), by = "claim_id")

#### Statistics ####

n_claims  <- nrow(cmp)
n_papers  <- n_distinct(cmp$paper_id)
n_agree   <- sum(cmp$agree)
n_dis     <- nrow(disagree)

# Table 1: per-analyst verdict distributions at the claim level (counts and
# percentages) and the paper level (mean of within-paper percentages, equal
# weight per paper, as in Miske et al.). "other" collapses non-outcome /
# none / not-attemptable.
buckets <- c("precise", "approximate", "not", "other")

verdicts_long <- cmp %>%
  transmute(paper_id, `LLM analyst` = llm, `SCORE canonical` = miske) %>%
  pivot_longer(-paper_id, names_to = "analyst", values_to = "v") %>%
  mutate(bucket = factor(if_else(v %in% c("precise", "approximate", "not"),
                                 v, "other"), levels = buckets))

table1_claim <- verdicts_long %>%
  count(analyst, bucket, .drop = FALSE) %>%
  mutate(cell = sprintf("%d (%.1f%%)", n, 100 * n / n_claims)) %>%
  select(-n) %>%
  pivot_wider(names_from = bucket, values_from = cell) %>%
  mutate(level = sprintf("Claim level (n = %d)", n_claims), .before = analyst)

# Per-paper share of each verdict bucket, averaged across papers. The mean
# shares sum to 100% within analyst because each paper's shares do.
paper_dist <- verdicts_long %>%
  count(paper_id, analyst, bucket, .drop = FALSE) %>%
  group_by(paper_id, analyst) %>%
  mutate(share = n / sum(n)) %>%
  ungroup() %>%
  group_by(analyst, bucket) %>%
  summarise(mean_share = mean(share), .groups = "drop")

table1_paper <- paper_dist %>%
  mutate(cell = sprintf("%.1f%%", 100 * mean_share)) %>%
  select(-mean_share) %>%
  pivot_wider(names_from = bucket, values_from = cell) %>%
  mutate(level = sprintf("Paper level (n = %d)", n_papers), .before = analyst)

table1 <- bind_rows(table1_claim, table1_paper)

# Disagreement attribution: ensure all four categories are present even if a
# bucket happens to be empty, then read the counts off by name.
errs <- disagree %>%
  mutate(errors_in = coalesce(errors_in, "(uncoded)")) %>%
  count(errors_in) %>%
  complete(errors_in = c("SCORE", "Neither", "LLM", "Both"),
           fill = list(n = 0L))
ev <- setNames(errs$n, errs$errors_in)
n_score <- ev[["SCORE"]]; n_neither <- ev[["Neither"]]
n_llm   <- ev[["LLM"]];   n_both    <- ev[["Both"]]
llm_err_total   <- n_llm + n_both
score_err_total <- n_score + n_both

sankey_counts <- tibble(
  key   = c("TOTAL", "AGREE", "DISAGREE", "ERR_SCORE", "ERR_NEITHER",
            "ERR_LLM", "ERR_BOTH"),
  value = c(n_claims, n_agree, n_dis, n_score, n_neither, n_llm, n_both)
)

#### Paper-level analysis ####

# Claims are nested within papers, and verdict errors are typically
# paper-level events (one coding error propagates to every claim it
# touches), so papers -- not claims -- are the natural unit of independence.
paper_level <- cmp %>%
  group_by(paper_id) %>%
  summarise(n_claims        = n(),
            agree_rate      = mean(agree),
            llm_precise     = mean(llm == "precise"),
            llm_approx_up   = mean(llm %in% c("precise", "approximate")),
            miske_precise   = mean(miske == "precise"),
            miske_approx_up = mean(miske %in% c("precise", "approximate")),
            .groups = "drop")

paper_mean_agree <- mean(paper_level$agree_rate)
n_perfect       <- sum(paper_level$agree_rate == 1)
n_single        <- sum(paper_level$n_claims == 1)

# Paper-clustered bootstrap (percentile) 95% CIs: resample papers with
# replacement, recompute the statistic from the resampled papers' claims.
set.seed(20260819)
B <- 10000
clusters   <- split(cmp$agree, cmp$paper_id)
boot_claim <- replicate(B, {
  s <- sample(names(clusters), length(clusters), replace = TRUE)
  mean(unlist(clusters[s], use.names = FALSE))
})
ci_claim <- quantile(boot_claim, c(.025, .975))
boot_paper <- replicate(B, {
  s <- sample(seq_len(nrow(paper_level)), nrow(paper_level), replace = TRUE)
  mean(paper_level$agree_rate[s])
})
ci_paper <- quantile(boot_paper, c(.025, .975))

# Within-paper clustering of disagreements (papers x disagreement count).
dis_clustering <- cmp %>%
  group_by(paper_id) %>%
  summarise(n_dis = sum(!agree), .groups = "drop") %>%
  count(n_dis)

#### Sensitivity analysis ####

# Pilot-test papers: four audited papers (G4mp, L22B, qg47, Pxp7) were used
# for pilot testing, and the reproduction plan's worked examples
# inadvertently reference materials from them. The SI reports agreement
# excluding all claims from these papers.
sens_plan_papers <- c("G4mp", "L22B", "qg47", "Pxp7")

sens_d <- cmp %>% filter(!paper_id %in% sens_plan_papers)
sens_b <- list(agree = sum(sens_d$agree), n = nrow(sens_d))

#### Summary ####

# Assemble the whole summary as one character vector and emit it with a
# single writeLines() call, so interactive (RStudio) output is one clean
# block rather than one echoed command per line.
summary_report <- c(
  "",
  "Headline statistics (reproduced from deposited data + adjudication)",
  "===================================================================",
  "",
  sprintf("Audit pool: %d papers, %d claims", n_papers, n_claims),
  "",
  "Claim-level agreement:",
  sprintf("  %d / %d  (%.1f%%) agree",    n_agree, n_claims, 100 * n_agree / n_claims),
  sprintf("  %d / %d  (%.1f%%) disagree", n_dis,   n_claims, 100 * n_dis   / n_claims),
  "",
  "Table 1 - verdict distributions, claim and paper level:",
  capture.output(print(as.data.frame(table1), row.names = FALSE)),
  "",
  "Disagreement attribution (human 'Errors in' adjudication):",
  sprintf("  SCORE error only : %2d  (%.1f%% of attempted)", n_score,   100 * n_score   / n_claims),
  sprintf("  Neither error    : %2d  (%.1f%% of attempted)", n_neither, 100 * n_neither / n_claims),
  sprintf("  LLM error only   : %2d  (%.1f%% of attempted)", n_llm,     100 * n_llm     / n_claims),
  sprintf("  Both errored     : %2d  (%.1f%% of attempted)", n_both,    100 * n_both    / n_claims),
  sprintf("  -> total disagreements: %d", n_score + n_neither + n_llm + n_both),
  "",
  sprintf("LLM-side error  (LLM + Both):   %d / %d = %.1f%%",
          llm_err_total, n_claims, 100 * llm_err_total / n_claims),
  sprintf("SCORE-side error (SCORE + Both): %d / %d = %.1f%%",
          score_err_total, n_claims, 100 * score_err_total / n_claims),
  "",
  "Paper-level analysis:",
  sprintf("  claims per paper: median %d, range %d-%d; %d of %d papers contribute 1 claim",
          median(paper_level$n_claims), min(paper_level$n_claims),
          max(paper_level$n_claims), n_single, n_papers),
  sprintf("  claim-level agreement %.1f%%, paper-clustered bootstrap 95%% CI [%.1f%%, %.1f%%]",
          100 * n_agree / n_claims, 100 * ci_claim[1], 100 * ci_claim[2]),
  sprintf("  paper-level mean agreement %.1f%%, bootstrap 95%% CI [%.1f%%, %.1f%%]",
          100 * paper_mean_agree, 100 * ci_paper[1], 100 * ci_paper[2]),
  sprintf("  papers with perfect agreement: %d / %d (%.1f%%)",
          n_perfect, n_papers, 100 * n_perfect / n_papers),
  sprintf("  verdict rates, equal weight per paper (claim-level in parens):"),
  sprintf("    LLM:   precise %.1f%% (%.1f%%); at least approximate %.1f%% (%.1f%%)",
          100 * mean(paper_level$llm_precise),   100 * mean(cmp$llm == "precise"),
          100 * mean(paper_level$llm_approx_up), 100 * mean(cmp$llm %in% c("precise", "approximate"))),
  sprintf("    SCORE: precise %.1f%% (%.1f%%); at least approximate %.1f%% (%.1f%%)",
          100 * mean(paper_level$miske_precise),   100 * mean(cmp$miske == "precise"),
          100 * mean(paper_level$miske_approx_up), 100 * mean(cmp$miske %in% c("precise", "approximate"))),
  "",
  "  disagreements per paper (papers x count):",
  capture.output(print(as.data.frame(dis_clustering), row.names = FALSE)),
  "",
  "Sensitivity analysis (claim-level agreement):",
  sprintf("  excluding pilot-test papers (%s): %d/%d = %.1f%%",
          paste(sens_plan_papers, collapse = ", "),
          sens_b$agree, sens_b$n, 100 * sens_b$agree / sens_b$n),
  ""
)
writeLines(summary_report)

### Data for figure1_sankey.py ####
write_csv(sankey_counts, sankey_out)

