==================================================================
Getting and Cleaning Data
Coursera
==================================================================
Cameron Law
20220415
https://github.com/clawsar/Getting_And_Cleaning_Data.git
==================================================================

The request was to upload a script that could use data at:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

to then:
1) Merges the training and the test sets to create one data set.

2) Extracts only the measurements on the mean and standard deviation for each measurement. 

3) Uses descriptive activity names to name the activities in the data set

4) Appropriately labels the data set with descriptive variable names. 

5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

run_analysis.R in this repo loads in the x, y, and subject data for both train and test folders.  Unfortunately for some ridiculous reason, the x test and train files are best loaded
with a fixed width file of 16 characters repeated 562 (!!!) times.  This is a terrible way to share data.  Loading these files in, as well as the features text file allowed me to
combine all the data into a single data frame with useful column labels.

Extracting the mean and standard deviation measurements required the use of grep on the column names for mean() and std(), but was a fairly simple subset from that.  Similarly,
the activity labels was a sequence of gsub exercises for 1-6 based on the input in the activity text file.  Piping may have been useful, but it only would have saved a slight amount
of space and is not necessarily easier for me to read.  The descriptive variable names was taken care of with the initial upload of data, as it should to avoid confusion or poor data 
integrity.  The second data set was simply made from the the existing dataframe that only retained the mean and standard deviation (as well as the activity and subject) using the
group_by and summarise_all commands of dplyr.  

End.