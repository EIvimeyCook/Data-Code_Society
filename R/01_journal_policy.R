dd<-read.csv("Data/Raw/Concensus_policy.csv")

table(dd$Data)
table(dd$Code)

paste(dd$Data,Data_editor)
paste(dd$Code,Data_editor)

(nrow(dd)-table(dd$Data_Reason)[1])/nrow(dd)
(nrow(dd)-table(dd$Code_Reason)[1])/nrow(dd)

tab<-table(dd$Data,dd$Code)[c(2,1,3,4),c(2,1,3,4)]

tab2 <- cbind(tab,Total=rowSums(tab))

tab3 <- rbind(tab2,Total=colSums(tab2))

table(paste(dd$Data,dd$Data_editor),paste(dd$Code,dd$Data_editor))[c(3,2,1,4,5),c(4,3,2,1,6,5,7)]