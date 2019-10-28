
setwd("C:/Users/ENKHUY/Documents/TRAINING/R/DataTidy")

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
x_full <- rbind(x_train,x_test)

y_train <-read.table("Q/train/Y_train.txt",quote = "\"",stringsAsFactors =FALSE)
y_test <-read.table("Q/test/Y_test.txt",quote = "\"",stringsAsFactors =FALSE)

# Merging training and test date for y (ITEM1)
y_full <- rbind(y_train,y_test)


# Give the feature names.

features <- read.table("Q/features.txt",quote = "\"",stringsAsFactors =FALSE)
names(x_full)<- features$V2

subject_train <-read.table("Q/train/subject_train.txt",quote = "\"",stringsAsFactors =FALSE)
subject_test <-read.table("Q/test/subject_test.txt",quote = "\"",stringsAsFactors =FALSE)

# Merge subject info

subject_full <- rbind (subject_train,subject_test)

# Put activity labels

activity_labels <-read.table("Q/activity_labels.txt",quote = "\"",stringsAsFactors =FALSE)

for (i in 1:length(y_full$V1)) 
  {
       if (!is.na(y_full$V1[i]))
          {
            y_full$V1[i]<-activity_labels[y_full$V1[i],2]
       }
  }

# Rename V1 and V2 meaningfull names (ITEM4)
names(y_full)<-c("activity")
names(subject_full)<-c("subject")

#merge three data tables. (ITEM1)
full_data <- cbind(subject_full,x_full,y_full)

#remove symbols from names (ITEM3)
names(full_data)<-correctname(names(full_data))

# Put more meaningful names to features.
names(full_data)<-gsub("acc", "accelerometer", names(full_data))
names(full_data)<-gsub("gyro", "gyroscope", names(full_data))
names(full_data)<-gsub("bodybody", "body", names(full_data))
names(full_data)<-gsub("mag", "magnitude", names(full_data))
names(full_data)<-gsub("^t", "time", names(full_data))
names(full_data)<-gsub("^f", "frequency", names(full_data))
names(full_data)<-gsub("tBody", "timebody", names(full_data))
names(full_data)<-gsub("freq", "frequency", names(full_data))
names(full_data)<-gsub("angle", "angle", names(full_data))
names(full_data)<-gsub("gravity", "gravity", names(full_data))

#extract only mean and std (ITEM2)

mean <- full_data[,c(grep("activity|subject|mean",names(full_data)))]
std  <- full_data[,c(grep("activity|subject|std",names(full_data)))]


# Create tidy data set for each activity and subject (ITEM5)

mean_std <- full_data[,c(grep("activity|subject|mean|std",names(full_data)))]

tidy<-na.omit(mean_std)
# group by subject,activity
#
tidy <- tidy %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(tidy, "tidy.txt", row.name=FALSE)
