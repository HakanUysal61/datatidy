setwd("C:/Users/ENKHUY/Documents/TRAINING/R/DataTidy")
getwd()
library(tidyr)
library(dplyr)
library(reshape2)
library(data.table)
library(tidyselect)

correctname <- function(s="name")
{
  r<- tolower(s)
  r<- gsub(".","",r,fixed=TRUE)
  r<- gsub("_","",r,fixed=TRUE)
  r<- gsub("-","",r,fixed=TRUE)
  r<- gsub(" ","",r,fixed=TRUE)
  r<- gsub("(","",r,fixed=TRUE)
  r<- gsub(")","",r,fixed=TRUE)
  r<- gsub(",","",r,fixed=TRUE)
}


x_train <-read.table("Q/train/X_train.txt",quote = "\"",stringsAsFactors =FALSE)
x_test <-read.table("Q/test/X_test.txt",quote = "\"",stringsAsFactors =FALSE)

# Merging training and test data (ITEM1)
x_full <- bind_rows(x_train,x_test)

# Give the feature names.

features <- read.table("Q/features.txt",quote = "\"",stringsAsFactors =FALSE)
names(x_full)<- features$V2

subject_train <-read.table("Q/train/subject_train.txt",quote = "\"",stringsAsFactors =FALSE)
subject_test <-read.table("Q/test/subject_test.txt",quote = "\"",stringsAsFactors =FALSE)

# Merge subject info

subject_full <- bind_rows(subject_train,subject_test)

# Put activity labels

activity_labels <-read.table("Q/activity_labels.txt",quote = "\"",stringsAsFactors =FALSE)
subject_activity <- full_join(subject_full,activity_labels)

# Rename V1 and V2 meaningfull names (ITEM4)
colnames(subject_activity)<-c("subject","activity")


#merge two data tables. (ITEM1)
full_data <- cbind(x_full,subject_activity)

#remove symbols from names (ITEM3)
names(full_data)<-correctname(names(full_data))


# Resolve duplicate names

k<-length(names(full_data))
for (i in 1:(k-1))
{
  for (j in (i+1):k)
  {
    if (names(full_data)[i]==names(full_data)[j])
    {
      #duplicate name found
      names(full_data)[i]<-paste0(names(full_data)[i],j)
    }
  }
}



#extract only mean and std (ITEM2)

means<- select(full_data,contains("mean"))
std  <- select(full_data,contains("std"))

# Create tidy data set for each activity and subject (ITEM5)

mean_std<-cbind(means,std)
tidy<-na.omit(cbind(mean_std,subject_activity))
write.table(tidy,file="tidy.txt",row.names=FALSE)


