# article_assignment.R
# draw sample for review: 30 per journal for
# journals with a dedicated data editor, and 15 per journal for all others.
# Output: set of files in data/article_sets, containing individual sets of articles for extraction

# 36 articles in each gives 40 files
# 9 repeats is 25% repeated

# 10 DE journals
# 40 others
# 10 DE journals
# 39 others

# Fix the random number generator so the articles randomisation is the same every run.
set.seed(20261010)

## import list of articles randomised within published with IDs
randomised_pubs <- read.csv(file="Data/Raw/randomised_articles.csv")
rownames(randomised_pubs)<-randomised_pubs$article_id

## extract the first 15 for non-data editor journals and 30 for data editor journals
n_journals <- 89
n_articles <- 15


## produce a list of articles, cycling through the journals, with a double representation of data editor journals. Data editor journals are 1:10 in the journal IDs -repeat these twice in the list so that they are doubly represented.
journal_numbers <- c(1:50,1:10,51:89)
journal_list <- rep(journal_numbers, n_articles)
article_number <- rep(1:n_articles, each=length(journal_numbers)) + rep(rep(c(0,n_articles,0),c(50,10,39)),n_articles)
article_ids <- paste(journal_list,article_number,sep="_")

## some journals have less than 15 articles, so not all these ids exist in the dataset. Remove those that don't
article_ids_exist<-article_ids[article_ids %in% randomised_pubs$article_id]

## make articles lists 
#If all files made gets 45 articles, in an overlapping pattern, then all files should get a set of different journals, and not get repeated data editor journals.

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

article_sets<-lapply(1:40, function(x){
  article_set<- randomised_pubs[article_ids_exist[start_finish[x,1]:start_finish[x,2]],]
 	# remove any NAs
 	randomised <- article_set[sample(nrow(article_set), replace = FALSE),]
 	subset(randomised,!is.na(doi))[,c("article_id","doi","title","journal")]
})

##checks
sapply(article_sets,nrow)
sapply(article_sets,function(x) length(unique(x$journal)))
table(table(do.call(rbind,article_sets)$article_id))

## write to separate files
sapply(1:40, function(i) write.csv(article_sets[i],file=paste0("Data/article_sets/",i,".csv"), row.names=FALSE))
