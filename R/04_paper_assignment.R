# paper_assignment.R
# draw sample for review: 30 per journal for
# journals with a dedicated data editor, and 15 per journal for all others.
# Output: sampled_papers.csv (one row per sampled paper, same columns as input).

# 36 papers in each gives 40 files
# 9 repeats is 25% repeated

# 10 DE journals
# 40 others
# 10 DE journals
# 39 others

# Fix the random number generator so the papers randomisation is the same every run.
set.seed(20261010)

## import list of articles randomised within published with IDs
randomised_pubs <- read.csv(file="Data/Raw/randomised_papers.csv")
rownames(randomised_pubs)<-randomised_pubs$paper_id

## extract the first 15 for non-data editor journals and 30 for data editor journals
n_journals <- 89
n_papers <- 15


## produce a list of articles, cycling through the journals, with a double representation of data editor journals. Data editor journals are 1:10 in the journal IDs -repeat these twice in the list so that they are doubly represented.
journal_numbers <- c(1:50,1:10,51:89)
journal_list <- rep(journal_numbers, n_papers)
paper_number <- rep(1:n_papers, each=length(journal_numbers)) + rep(rep(c(0,n_papers,0),c(50,10,39)),n_papers)
paper_ids <- paste(journal_list,paper_number,sep="_")

## some journals have less than 15 papers, so not all these ids exist in the dataset. Remove those that don't
paper_ids_exist<-paper_ids[paper_ids %in% randomised_pubs$paper_id]

## make papers lists 
#If all files made gets 45 papers, in an overlapping pattern, then all files should get a set of different journals, and not get repeated data editor journals.

# table with the start and end row numbers 
start_finish <- matrix(NA,nrow=40,ncol=2)
start_finish[1,] <- c(1,45)

for(i in 2:40){
	start<-start_finish[i-1,2]-8
	finish<-start+44
	start_finish[i,] <- c(start,finish)
}
start_finish
##

paper_sets<-lapply(1:40, function(x){
  paper_set<- randomised_pubs[paper_ids_exist[start_finish[x,1]:start_finish[x,2]],]
 	# remove any NAs
 	randomised <- paper_set[sample(nrow(paper_set), replace = FALSE),]
 	subset(randomised,!is.na(doi))[,c("paper_id","doi","title","journal")]
})

##checks
sapply(paper_sets,nrow)
sapply(paper_sets,function(x) length(unique(x$journal)))
table(table(do.call(rbind,paper_sets)$paper_id))

## write to seperate files
sapply(1:40, function(i) write.csv(paper_sets[i],file=paste("Data/article_sets/",i,".csv"), row.names=FALSE))
