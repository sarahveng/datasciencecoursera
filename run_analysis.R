#Download file and unzip in work directory
#
#url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#
#download.file(url, destfile = "/Users/Sarah/Desktop/Online courses/
#                    Data Science specialization/3_Getting and Cleaning Data/data/
#                    UCI HAR Dataset.zip", method="curl")
#
#unzip("/Users/Sarah/Desktop/Online courses/Data Science specialization/3_Getting 
#      and Cleaning Data/data/UCI HAR Dataset.zip", exdir = "/Users/Sarah/Desktop/
#      Online courses/Data Science specialization/3_Getting and Cleaning Data/data/", 
#      unzip = "internal")
#
#setwd("/Users/Sarah/Desktop/Online courses/Data Science specialization/3_Getting 
#      and Cleaning Data/data/UCI HAR Dataset")


#Load train data

subject.train <- read.table("train/subject_train.txt")
x.train <- read.table("train/X_train.txt")
y.train <- read.table("train/y_train.txt")

train.data <- cbind(x.train, subject.train, y.train)


#Load test data

subject.test <- read.table("test/subject_test.txt")
x.test <- read.table("test/X_test.txt")
y.test <- read.table("test/y_test.txt")

test.data <- cbind(x.test, subject.test, y.test)


#Step 1 - Merge train and test data

merged.data <- rbind(train.data, test.data)


#Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement

features <- read.table("features.txt", col.names = c("id", "name"))
cols.in.scope <- grep("*mean*|*std*", features$name)
data.extract <- merged.data[, c(cols.in.scope, ncol(merged.data)-1, ncol(merged.data))]


#Step 3 - Uses descriptive activity names to name the activities in the data set

activity <- read.table("activity_labels.txt", col.names = c("id","name"))
activity$name <- as.character(activity$name)

for (i in  data.extract[, ncol(data.extract)]) {
    data.extract[, ncol(data.extract)] <- gsub(i, activity[i,2], data.extract[, ncol(data.extract)])
}


#Step 4 - Appropriately labels the data set with descriptive variable names

features <- features[cols.in.scope, ]

features$name <- gsub("-mean()", ".mean", features$name)
features$name <- gsub("-std()", ".std", features$name)
features$name <- gsub("-meanFreq()", ".mean.freq", features$name)
features$name <- gsub("[-]", ".", features$name)
features$name <- gsub("[()]", "", features$name)

colnames(data.extract) <- c(features$name, "Subject", "Activity")


#Step 5 - From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.

tidy <- aggregate(data.extract[, 1:79], by=list(activity = data.extract$Activity, subject=data.extract$Subject), mean)

