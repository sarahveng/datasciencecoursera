This repository contains R code that accomplishes the tasks given in the "Getting and Cleaning Data Course Project"

Getting and Cleaning Data Course Project - original course assignment:
    
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
    
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
    
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following. Merges the training and the test sets to create one data set. Extracts only the measurements on the mean and standard deviation for each measurement. Uses descriptive activity names to name the activities in the data set Appropriately labels the data set with descriptive variable names. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. Good luck!


R script run_analysis.R abstract:
    
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


R script run_analysis.R details:

0. Preparation

Function: download.file(url), unzip, setwd

Download the zip file containing the dataset UCI HAR Dataset.zip into folder "data" and extracts the folder into the "UCI HAR Dataset" folder. Set the working directory to "UCI HAR Dataset" folder.


1. Loading and Merging the test sets

Here both training and test data sets are merged. Due to the fact that they reside in different subfolders the script addresses this. 
Load the main file X_train.txt (resp. X_test.txt) into a data frame x.train (resp. x.test) then append the Y_train.txt( resp. Y_test.txt) and subject_train.txt(resp. subject_test.txt) to the data frames using read.table().
First are merged x.train, subject.train, y.train (resp. x.test, subject.test, y.test), then the two resulting data frames are merged together (data frame "merged.data").


2. Variable Selection

Only the features that contain mean and standard deviation are selected. Read the file features.txt into a data frame called "features" using read.table(). 
Perform a search for strings containing "mean" or "std" on the features list and store the result in a vector called cols.in.scope. Thus the resulting vector can be used to extract only the measurements on the mean and standard deviation for each measurement. Keep also the last two columns (subject and activity) when extracting (data frame "data.extract")


3. Use Descriptive activity names (due to script design will be performed after step 4.)

The activity labels are declared in the file activity_labels.txt. Load file into a data frame "activity.Labels" using read.table(). Loop through the "data.extract" data frame and replace activity IDs with their matching labels in the "activity" data frame.


4. Label the data set with descriptive variable names

Alter the variable names with the use of gsub() function. For better readability, the following changes are made:
    
substitute "-mean" with ".mean"
substitute "-std" with ".std"
substitute "-meanFreq()" with ".mean.freq"
substitute "-" with "."
remove "()"

Are also added the column names "Subject" and "Activity".


5. Creating the tidy data set

Aggregate by grouping on "Activity" and "Subject" calculating the mean for each (numeric) variable and return the result.