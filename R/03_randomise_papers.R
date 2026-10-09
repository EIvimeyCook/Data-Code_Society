# 02_randomise_papers.R
# numbers and randomise the articles within each journal
# Output: randomised_papers.csv (one row per article paper, same number as rows as input, same columns as input).


# Full list of candidate papers; must contain a `journal` column whose values
pubs <- read.csv("Data/Raw/total_papers_oct_rerun.csv")

# Fix the random number generator so the same papers are drawn every run.
set.seed(20261009)

## journal list
journals <- unique(pubs$journal)

# Journals that employ a data editor; these are sampled more heavily.
# match the names in `data_editor_journals` exactly (case and punctuation).
data_editor_journals <- c(
  "The American Naturalist", "Behavioral Ecology", "Ecology Letters",
  "Journal of Evolutionary Biology",
  "Proceedings of the Royal Society B Biological Sciences",
  # ESA journals
  "Ecological Applications", "Ecological Monographs", "Ecology",
  "Ecosphere", "Frontiers in Ecology and the Environment"
)
all(data_editor_journals %in% journals)

## for convenience, assign journals ID numbers, with data editor journals first (1:10)
journals_ordered <- journals[order(journals%in%data_editor_journals,decreasing=TRUE)]
journal_number <- 1:length(journals_ordered)


## within each journal, randomise papers, and then, make IDs
## these IDs enable us to make sample more papers as needed
randomised_pubs<- do.call(rbind,c(lapply(split(pubs,pubs$journal), function(dat){
  dat_random <- dat[sample(nrow(dat), replace = FALSE),]
  dat_random$journal_id <- journal_number[journals_ordered==dat_random$journal[1]]
  dat_random$paper_in_journal <- 1:nrow(dat)
  dat_random$paper_id <- paste(dat_random$journal_id,dat_random$paper_in_journal, sep="_")
  rownames(dat_random)<-dat_random$paper_id
  return(dat_random)
}),make.row.names=FALSE))
tail(randomised_pubs)

write.csv(randomised_pubs,file="Data/Raw/randomised_papers.csv", row.names=FALSE)
