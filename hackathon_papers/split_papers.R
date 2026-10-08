# split_papers.R
# Draws a stratified random sample of papers for review: 30 per journal for
# journals with a dedicated data editor, and 15 per journal for all others.
# Output: sampled_papers.csv (one row per sampled paper, same columns as input).

# load tidy
library(tidyverse)

# Full list of candidate papers; must contain a `journal` column whose values
# match the names in `data_editor_journals` exactly (case and punctuation).
pubs <- read_csv("papers/total_papers_oct_rerun.csv")

# Fix the seed so the same papers are drawn every run.
set.seed(1)

# Journals that employ a data editor; these are sampled more heavily.
data_editor_journals <- c(
  "The American Naturalist", "Behavioral Ecology", "Ecology Letters",
  "Journal of Evolutionary Biology",
  "Proceedings of the Royal Society B Biological Sciences",
  # ESA journals
  "Ecological Applications", "Ecological Monographs", "Ecology",
  "Ecosphere", "Frontiers in Ecology and the Environment"
)


sampled_papers <- bind_rows(
  # Data-editor journals: up to 30 papers sampled within each journal.
  # If a journal has fewer than 30 papers, all of them are kept.
  pubs |>
    filter(journal %in% data_editor_journals) |>
    slice_sample(n = 30, by = journal, replace = FALSE),
  # All other journals: up to 15 papers sampled within each journal.
  pubs |>
    filter(!journal %in% data_editor_journals) |>
    slice_sample(n = 15, by = journal, replace = FALSE)
) %>%
  # Number papers within each journal in the order they were drawn:
  # 1-30 for data-editor journals, 1-15 for the rest.
  mutate(sample_no = row_number(), .by = journal) %>%
  # Save the combined sample.
  readr::write_excel_csv("papers/hackathon_papers.csv")
