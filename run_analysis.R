# Cameron Law
# 20220413
# Getting and Cleaning Data

# Data is extracted and placed in UCI HAR Dataset folder within the working directory

library(dplyr)
library(tidyr)

## Merge the training and test data set into one dataset
# Load the x train dataset.  Through stupid iteration, found this was a fix width file like a neanderthal would use and set the widths appropriately.
x_train <- read.fwf(".//train//x_train.txt", widths=c(rep(16, 562)), header=FALSE)

# Load the y train dataset
y_train <- read.csv(".//train//y_train.txt", header=FALSE)

# Load the subject data for training
read.csv(".//train//subject_train.txt", header=FALSE)->train_sub

# Load the x test dataset
x_test <- read.fwf(".//test//X_test.txt", widths=c(rep(16,562)), header=FALSE)

# Load the y test dataset
y_test <- read.csv(".//test//y_test.txt", header=FALSE)

# Load the subject data for test
read.csv(".//test//subject_test.txt", header=FALSE)->test_sub

# Load the labels
m.labels <- read.csv("features.txt", sep="\n", header=FALSE)
# Again this is a stupid way to keep the information 
m.labels[,1] <- gsub("^\\d+\\s", "", m.labels[,1])
m.names <- c("Activity", "Subject", m.labels[[1]], "Origin")

# Create a dataframe that is all the information of the datasets
m.train <- cbind(y_train, train_sub, x_train, rep("Train", length(y_train[,1])))
m.train <- subset(m.train, select=-V562)
colnames(m.train) <- m.names
m.test <- cbind(y_test, test_sub, x_test, rep("Test", length(y_test[,1])))
m.test <- subset(m.test, select=-V562)
colnames(m.test) <- m.names
m.df <- rbind(m.train, m.test)


## Extracts only the measurements on the mean and standard deviation for each measurement
m.df <- m.df[,grepl("Activity|Subject|mean()|std()",colnames(m.df))]


## Uses descriptive activity names to name the activities in the data set
m.df$Activity <-gsub(1, "WALKING", m.df$Activity)
m.df$Activity <-gsub(2, "WALKING_UPSTAIRS", m.df$Activity)
m.df$Activity <-gsub(3, "WALKING_DOWNSTAIRS", m.df$Activity)
m.df$Activity <-gsub(4, "SITTING", m.df$Activity)
m.df$Activity <-gsub(5, "STANDING", m.df$Activity)
m.df$Activity <-gsub(6, "LAYING", m.df$Activity)

## Appopriately labels the data set with descriptive variable names
# Done in the data uploading above


## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

m.newdf <- m.df %>% group_by(Activity, Subject) %>% summarise_all(funs(mean))



