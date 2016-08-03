## Data Science Specialization Course 4 Project R script

## the zip file has already been downloaded, saved under the working directory, and unzipped manually

## read in test data
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## read in train data
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## read in features data
features <- read.table("./UCI HAR Dataset/features.txt")

## read in activitiy data
activity <- read.table("./UCI HAR Dataset/activity_labels.txt")

## Step 1: Merge the training and the test sets to create one data set
x <- rbind(xtest, xtrain)
y <- rbind(ytest, ytrain)
subject <- rbind(subjectTest, subjectTrain)
tidydata <- cbind(x, y, subject) ## tidydata is the merged dataset at this stage

## Step 2: extract only the measurements on the mean and standard deviation for each measurement
head(features)
index <- grep("mean\\(\\)|std\\(\\)", features[,2])
x <- x[,index]
tidydata <- cbind(x, y, subject) ## the merged dataset tidydata has been updated based on the requirement in Step 2

## Step 3: use descriptive activity names to name the activites in the dataset
head(activity)
names(activity) <- c("activity code", "activity name")
y[,1] <- activity[y[,1],2]
tidydata <- cbind(x, y, subject) ## the merged dataset tidydata has been updated based on the requirement in Step 3

## Step 4: appropriately label the datset with descriptive variable names
head(x)
xnames <- features[index, 2]
xnames <- gsub("\\(|\\)", "", xnames)
names(x) <- xnames
head(y) 
names(y) <- "activity"
head(subject) 
names(subject) <- "subject"
tidydata <- cbind(x, y, subject) ## the merged dataset tidydata has been updated based on the requirement in Step 4

## Step 5: from the dataset in step 4, create a 2nd independent tidy dataset
## with the average of each variable for each activity and each subject
library(data.table)
tidydata2 <- tidydata[, lapply(.SD, mean), by = 'subject,activity']
write.table(tidydata2, file = "tidy_data_2.txt", row.names = FALSE)
## tidydata2 is the final version of the tidy dataset (with the average of each variable for each activity and each subject)
