dd<-read.csv("Data/Raw/Concensus_policy.csv")

## data and code policy separately
table(dd$Data)
table(dd$Code)

# proportion with a conflict
(nrow(dd)-table(dd$Data_Reason)[1])/nrow(dd)
(nrow(dd)-table(dd$Code_Reason)[1])/nrow(dd)

# make table to joint data and code policy
tab <- table(dd$Data,dd$Code)[c(2,1,3,4),c(2,1,3,4)]
tab2 <- cbind(tab,Total=rowSums(tab))
tab3 <- rbind(tab2,Total=colSums(tab2))
tab3


## include data editor as a level
dd$Data_DE <- ifelse(dd$Data=="Mandated",paste(dd$Data,dd$Data_editor),dd$Data)
dd$Code_DE <- ifelse(dd$Code=="Mandated",paste(dd$Code,dd$Data_editor),dd$Code)

# make table to joint data and code policy with data editors
tab_DE <- table(dd$Data_DE,dd$Code_DE)[c(3,2,1,4,5),c(3,2,1,4,5)]
tab_DE2 <- cbind(tab_DE,Total=rowSums(tab_DE))
tab_DE3 <- rbind(tab_DE2,Total=colSums(tab_DE2))
tab_DE3