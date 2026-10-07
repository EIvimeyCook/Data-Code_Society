# split_papers.R
# Draws a stratified random sample of papers for review: 30 per journal for
# journals with a dedicated data editor, and 15 per journal for all others.
# Output: sampled_papers.csv (one row per sampled paper, same columns as input).

#load tidy
library(tidyverse)

# Full list of candidate papers
pubs <- read_csv("papers/total_papers_oct.csv")

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
  pubs |> filter(journal %in% data_editor_journals) |>
    slice_sample(n = 30, by = journal, replace = FALSE),
  # All other journals: up to 15 papers sampled within each journal.
  pubs |> filter(!journal %in% data_editor_journals) |>
    slice_sample(n = 15, by = journal, replace = FALSE)
) %>%
  # Save the combined sample. 
  write_csv("sampled_papers.csv")
