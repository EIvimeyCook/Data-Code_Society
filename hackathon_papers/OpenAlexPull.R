# =====================================================================
# OpenAlex pull: all 2026 journal-article works across the 90 target
# journals, via {openalexR}
# =====================================================================
#
# Requires a free OpenAlex API key (openalex.org -> Settings -> API),
# stored in .Renviron as:
#   openalexR.apikey = YOUR_KEY
#   openalexR.mailto = your_email@example.com   (optional but recommended --
#                                                 puts you in the "polite pool")

library(openalexR)
library(dplyr)
library(purrr)
library(stringr)

# ---------------------------------------------------------------------
# API key setup -- prompts you for a key if one isn't already set for
# this session, rather than requiring you to have edited .Renviron
# beforehand. Uses askpass::askpass() so the key is masked as you type
# it, both in RStudio and a plain R console.
#
# NOTE: readline()/askpass() only work in an INTERACTIVE R session --
# this block will error out if you try to run the script non-interactively
# (e.g. via Rscript from the command line). For that use case, set the
# key in .Renviron instead, as described in the earlier comment.
# ---------------------------------------------------------------------
if (!requireNamespace("askpass", quietly = TRUE)) {
  install.packages("askpass")
}

if (is.null(getOption("openalexR.apikey")) || !nzchar(getOption("openalexR.apikey"))) {
  key <- askpass::askpass("Enter your OpenAlex API key (openalex.org -> Settings -> API):")
  if (is.null(key) || !nzchar(key)) {
    stop(
      "An OpenAlex API key is required to run this script.\n",
      "Get a free one at https://openalex.org/settings/api"
    )
  }
  options(openalexR.apikey = key)
}

if (is.null(getOption("openalexR.mailto")) || !nzchar(getOption("openalexR.mailto"))) {
  mailto <- readline("Enter your email for OpenAlex's 'polite pool' (optional -- press Enter to skip): ")
  if (nzchar(mailto)) {
    options(openalexR.mailto = mailto)
  }
}

options(openalexR.mailto = "e.ivimeycook@gmail.com")

journals <- c(
  "African Journal of Range and Forage Science",
  "African Journal of Wildlife Research",
  "The American Naturalist",
  "Animal Behaviour",
  "Animal Conservation",
  "Applied Vegetation Science",
  "Aquatic Ecosystem Health & Management",
  "Archives of Sexual Behavior",
  "Austral Ecology",
  "Basic and Applied Ecology",
  "Behavior Genetics",
  "Behavioral Ecology",
  "Biogeographia – The Journal of Integrative Biogeography",
  "Biological Journal of the Linnean Society",
  "Biotropica",
  "Canadian Journal of Forest Research",
  "Cladistics",
  "Coastal Management",
  "Conservation Biology",
  "Conservation Letters",
  "Conservation Science and Practice",
  "Ecography",
  "Ecological Applications",
  "Ecological Monographs",
  "Ecological Research",
  "Ecology",
  "Ecology Letters",
  "Ecology and Society",
  "Ecosphere",
  "Environmental Science and Pollution Research",
  "Environmental Toxicology and Chemistry",
  "Estuarine Coastal and Shelf Science",
  "European Journal of Soil Science",
  "Evolution",
  "Evolution Letters",
  "Evolutionary Journal of the Linnean Society",
  "Freshwater Science",
  "Frontiers in Ecology and the Environment",
  "Functional Ecology",
  "ICES Journal of Marine Science",
  "Integrative and Comparative Biology",
  "International Journal of Remote Sensing",
  "Invasive Plant Science and Management",
  "Journal of Chemical Ecology",
  "Journal of Coastal Research",
  "Journal of Ecohydraulics",
  "Journal of Ecology",
  "Journal of Economic Entomology",
  "Journal of Evolutionary Biology",
  "Journal of Mammalian Evolution",
  "Journal of Pollination Ecology",
  "Journal of Sustainable Agriculture and Environment",
  "Journal of Threatened Taxa",
  "Journal of Vegetation Science",
  "Journal of Wildlife Management",
  "Landscape Ecology",
  "Natures Sciences Sociétés",
  "NeoBiota",
  "New Zealand Journal of Ecology",
  "Oikos",
  "Organisms Diversity & Evolution",
  "Pedosphere",
  "People and Nature",
  "Phytobiomes Journal",
  "Plant Ecology and Evolution",
  "Polish Journal of Ecology",
  "Population Ecology",
  "Primate Conservation",
  "Proceedings of the Royal Society B Biological Sciences",
  "Remote Sensing in Ecology and Conservation",
  "Systematic Biology",
  "Taxon",
  "Tropical Ecology",
  "Urban Ecosystems",
  "Vegetation Classification and Survey",
  "Web Ecology",
  "Weed Research",
  "Wetland Science and Practice",
  "Wetlands",
  "Wildlife Biology",
  "Zoological Journal of the Linnean Society",
  "African Journal of Ecology",
  "Ecological Solutions and Evidence",
  "Journal of Applied Ecology",
  "Personality and Individual Differences",
  "Restoration Ecology",
  "Conservation Physiology",
  "Frontiers of Biogeography",
  "Hormones and Behavior",
  "Wildlife Society Bulletin"
)

# ---------------------------------------------------------------------
# Step 1: resolve each journal title to an OpenAlex Source ID
# ---------------------------------------------------------------------
# OpenAlex's "sources" entity is looked up with a fuzzy display_name.search
# (unlike WoS's exact-phrase SO=), so this is much more forgiving of
# ampersands, "and" vs "&", accents, etc. We take the top-ranked match
# per journal and keep the matched name alongside it so you can eyeball
# whether it actually matched the journal you meant.
resolve_journal_source <- function(name) {
  res <- tryCatch(
    oa_fetch(
      entity = "sources",
      display_name.search = name,
      verbose = FALSE
    ),
    error = function(e) NULL
  )

  if (is.null(res) || nrow(res) == 0) {
    return(tibble(
      query = name, source_id = NA_character_,
      matched_name = NA_character_, issn_l = NA_character_
    ))
  }

  top <- res[1, ]
  tibble(
    query = name,
    source_id = top$id,
    matched_name = top$display_name,
    issn_l = top$issn_l
  )
}

source_lookup <- map_dfr(journals, resolve_journal_source)

# Check these before proceeding -- NA means no match at all, and it's
# worth a manual glance at any row where matched_name looks like it
# might be the wrong journal (e.g. a similarly-named but different title).
resolve_journal_interactive <- function(journals, n_candidates = 5) {
  results <- vector("list", length(journals))

  for (i in seq_along(journals)) {
    name <- journals[i]
    cat("\n==============================\n")
    cat("Journal", i, "of", length(journals), ":", name, "\n")

    candidates <- tryCatch(
      oa_fetch(
        entity = "sources",
        display_name.search = name,
        verbose = TRUE
      ),
      error = function(e) {
        message("  ERROR while fetching '", name, "': ", conditionMessage(e))
        NULL
      }
    )

    if (is.null(candidates) || nrow(candidates) == 0) {
      cat("  No candidates found at all.\n")
      results[[i]] <- tibble(
        query = name, source_id = NA_character_,
        matched_name = NA_character_, issn_l = NA_character_
      )
      next
    }

    candidates <- candidates[seq_len(min(n_candidates, nrow(candidates))), ]
    has_works_count <- "works_count" %in% names(candidates)

    for (j in seq_len(nrow(candidates))) {
      line <- str_c(
        "  ", j, ": ", candidates$display_name[j],
        " | ISSN-L: ", candidates$issn_l[j] %||% "NA"
      )
      if (has_works_count) {
        line <- str_c(line, " | works: ", candidates$works_count[j])
      }
      cat(line, "\n")
    }
    cat("  0: None of these / skip this journal\n")

    choice <- suppressWarnings(as.integer(readline("  Select match number: ")))

    if (is.na(choice) || choice == 0) {
      results[[i]] <- tibble(
        query = name, source_id = NA_character_,
        matched_name = NA_character_, issn_l = NA_character_
      )
    } else {
      chosen <- candidates[choice, ]
      results[[i]] <- tibble(
        query = name, source_id = chosen$id,
        matched_name = chosen$display_name, issn_l = chosen$issn_l
      )
    }
  }

  bind_rows(results)
}

# Review just a handful -- e.g. the ones you've already spotted as wrong
# from the automatic pass -- and merge your picks back into source_lookup:
journals_to_review <- c(
  "Behavioral Ecology",
  "Coastal Management",
  "Tropical Ecology",
  "Wildlife Society Bulletin",
  "Wetland Science and Practice"
)

manual_matches <- resolve_journal_interactive(journals_to_review)

source_lookup <- source_lookup %>%
  rows_update(manual_matches, by = "query")

source_lookup

library(tidyverse)
library(openalexR)

issns <- c("0012-9658", "1461-023X", "0962-8452") # your ISSNs

pubs <- split(source_lookup$issn_l, ceiling(seq_along(source_lookup$issn_l) / 50)) |>
  map_dfr(\(x) oa_fetch(entity = "sources", issn = x)) |>
  select(any_of(c("display_name", "issn_l", "host_organization_name", "host_organization")))

pubs

# ---------------------------------------------------------------------
# Step 2: pull all 2026 journal-article works from those sources
# ---------------------------------------------------------------------
get_2026_papers <- function(source_lookup, year = 2026) {
  ids <- source_lookup$source_id[!is.na(source_lookup$source_id)]

  works <- oa_fetch(
    entity = "works",
    primary_location.source.id = ids,
    publication_year = year,
    type = "article",
    verbose = TRUE
  )

  if (is.null(works) || nrow(works) == 0) {
    return(tibble(
      title = character(), doi = character(),
      journal = character(), publication_date = as.Date(character())
    ))
  }

  # doi sometimes comes back as its own column, sometimes only nested in
  # `ids` -- this covers both without assuming which one you'll get.
  doi_vals <- if ("doi" %in% names(works)) {
    works$doi
  } else if ("ids" %in% names(works)) {
    map_chr(works$ids, ~ .x[["doi"]] %||% NA_character_)
  } else {
    NA_character_
  }

  works %>%
    mutate(doi = doi_vals) %>%
    transmute(
      title = display_name,
      doi = doi,
      journal = source_display_name,
      publication_date = as.Date(publication_date)
    )
}

papers_2026 <- get_2026_papers(source_lookup)

papers_2026 |> write.csv("papers/total_papers_oct.csv", row.names = F)

unique(papers_2026$journal)

# ---------------------------------------------------------------------
# Step 3: count papers by journal and month of publication (wide format
# -- one row per journal, one column per month)
# ---------------------------------------------------------------------
library(lubridate)
library(tidyr)

paper_counts_wide <- papers_2026 %>%
  mutate(month = month(publication_date, label = TRUE, abbr = TRUE)) %>%
  count(journal, month, name = "n_papers") %>%
  pivot_wider(
    names_from = month,
    values_from = n_papers,
    values_fill = 0
  )

paper_counts_wide %>% write.csv("papers/2026_journals_oct.csv")
