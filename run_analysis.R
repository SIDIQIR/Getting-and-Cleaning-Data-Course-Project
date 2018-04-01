
# setting working directory
setwd("C:/Coursera/DATA CLEANING")

# downloading the dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="Dataset.zip")

# Unzipping the data file to dataset folder 
unzip(zipfile="Dataset.zip",exdir="./dataset")

# Reading the tables:
readxtrain <- read.table("./dataset/UCI HAR Dataset/train/X_train.txt")
readytrain <- read.table("./dataset/UCI HAR Dataset/train/y_train.txt")
readsubjecttrain <- read.table("./dataset/UCI HAR Dataset/train/subject_train.txt")
readxtest <- read.table("./dataset/UCI HAR Dataset/test/X_test.txt")
readytest <- read.table("./dataset/UCI HAR Dataset/test/y_test.txt")
readsubjecttest <- read.table("./dataset/UCI HAR Dataset/test/subject_test.txt")

readfeatures <- read.table("./dataset/UCI HAR Dataset/features.txt")


readactivityLabels <- read.table("./dataset/UCI HAR Dataset/activity_labels.txt")

colnames(readxtrain) <- readfeatures[,2] 
colnames(readytrain) <-"activityId"
colnames(readsubjecttrain) <- "subjectId"
colnames(readxtest) <- readfeatures[,2] 
colnames(readytest) <-"activityId"
colnames(readsubjecttest) <- "subjectId"


colnames(readactivityLabels) <- c("activityId","activityType")

# merging training files and testing files separately by colums
mergetrain <- cbind(readytrain,readsubjecttrain, readxtrain)
mergetest <- cbind(readytest,readsubjecttest, readxtest)



# merging testing and training files by rows

mergeall <- rbind(mergetrain, mergetest)


# finding mean() or std() columns

meanorstd <- grepl("mean\\(\\)", colnames(mergeall)) |
  grepl("std\\(\\)", colnames(mergeall))


# only keep subjectID and activity colunms
meanorstd[1:2] <- TRUE

# updating the whole data set with only needed columns 
mergeall <- mergeall[, meanorstd]

# labeling the activities

mergeall$activityId <- factor(mergeall$activityId, labels=c("Walking",
        "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

# creating tidy set

Tidys <- aggregate(. ~subjectId + activityId, mergeall, mean)
Tidys <- Tidys[order(Tidys$subjectId, Tidys$activityId),]
# saving the Tidy file

write.table(Tidys, "tidy.txt", row.name=FALSE)

readTidyfile <- read.table("tidy.txt")