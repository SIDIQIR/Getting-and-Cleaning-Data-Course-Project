Code Book
This code book summarizes the resulting data fields in tidy.txt.


variables :

# Reading the tables, data frame type:
readxtrain <- read.table("./dataset/UCI HAR Dataset/train/X_train.txt") 
readytrain <- read.table("./dataset/UCI HAR Dataset/train/y_train.txt")
readsubjecttrain <- read.table("./dataset/UCI HAR Dataset/train/subject_train.txt")
readxtest <- read.table("./dataset/UCI HAR Dataset/test/X_test.txt")
readytest <- read.table("./dataset/UCI HAR Dataset/test/y_test.txt")
readsubjecttest <- read.table("./dataset/UCI HAR Dataset/test/subject_test.txt")

# reading the feature table
readfeatures <- read.table("./dataset/UCI HAR Dataset/features.txt")

# reading activity table
readactivityLabels <- read.table("./dataset/UCI HAR Dataset/activity_labels.txt")

# labeling the data set tables

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

#reading the tidy file
readTidyfile <- read.table("tidy.txt")



Identifiers
subject - The ID of the test subject
activity - The type of activity performed when the corresponding measurements were taken
Measurements
tBodyAccMeanX
tBodyAccMeanY
tBodyAccMeanZ
tBodyAccStdX
tBodyAccStdY
tBodyAccStdZ
tGravityAccMeanX
tGravityAccMeanY
tGravityAccMeanZ
tGravityAccStdX
tGravityAccStdY
tGravityAccStdZ
tBodyAccJerkMeanX
tBodyAccJerkMeanY
tBodyAccJerkMeanZ
tBodyAccJerkStdX
tBodyAccJerkStdY
tBodyAccJerkStdZ
tBodyGyroMeanX
tBodyGyroMeanY
tBodyGyroMeanZ
tBodyGyroStdX
tBodyGyroStdY
tBodyGyroStdZ
tBodyGyroJerkMeanX
tBodyGyroJerkMeanY
tBodyGyroJerkMeanZ
tBodyGyroJerkStdX
tBodyGyroJerkStdY
tBodyGyroJerkStdZ
tBodyAccMagMean
tBodyAccMagStd
tGravityAccMagMean
tGravityAccMagStd
tBodyAccJerkMagMean
tBodyAccJerkMagStd
tBodyGyroMagMean
tBodyGyroMagStd
tBodyGyroJerkMagMean
tBodyGyroJerkMagStd
fBodyAccMeanX
fBodyAccMeanY
fBodyAccMeanZ
fBodyAccStdX
fBodyAccStdY
fBodyAccStdZ
fBodyAccMeanFreqX
fBodyAccMeanFreqY
fBodyAccMeanFreqZ
fBodyAccJerkMeanX
fBodyAccJerkMeanY
fBodyAccJerkMeanZ
fBodyAccJerkStdX
fBodyAccJerkStdY
fBodyAccJerkStdZ
fBodyAccJerkMeanFreqX
fBodyAccJerkMeanFreqY
fBodyAccJerkMeanFreqZ
fBodyGyroMeanX
fBodyGyroMeanY
fBodyGyroMeanZ
fBodyGyroStdX
fBodyGyroStdY
fBodyGyroStdZ
fBodyGyroMeanFreqX
fBodyGyroMeanFreqY
fBodyGyroMeanFreqZ
fBodyAccMagMean
fBodyAccMagStd
fBodyAccMagMeanFreq
fBodyBodyAccJerkMagMean
fBodyBodyAccJerkMagStd
fBodyBodyAccJerkMagMeanFreq
fBodyBodyGyroMagMean
fBodyBodyGyroMagStd
fBodyBodyGyroMagMeanFreq
fBodyBodyGyroJerkMagMean
fBodyBodyGyroJerkMagStd
fBodyBodyGyroJerkMagMeanFreq
Activity Labels
WALKING (value 1): subject was walking during the test
WALKING_UPSTAIRS (value 2): subject was walking up a staircase during the test
WALKING_DOWNSTAIRS (value 3): subject was walking down a staircase during the test
SITTING (value 4): subject was sitting during the test
STANDING (value 5): subject was standing during the test
LAYING (value 6): subject was laying down during the test