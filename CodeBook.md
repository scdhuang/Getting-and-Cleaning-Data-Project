#Getting and Cleaning Data Project
A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

[The source data for this project can be found here.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

#Merge the training and the test sets to create one data set.
Read tables the data located in
- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt
Assign column names and the merge with the initial training and test data set to create one data set.

#Extract only the measurements on the mean and standard deviation for each measurement. 
Create a logcal vector that contains TRUE values for the ID, mean and stdev columns and FALSE values for the others.
This new data set has only the necessary columns.

#Use descriptive activity names to name the activities in the data set
Merge data set with activityType table to inlude the descriptive activity names.

#Appropriately label the data set with descriptive activity names
Use gsub function clean up the data labels.

#Create a second, independent tidy data set with the average of each variable for each activity and each subject 
Produce a data set using write.table() and row.name=FALSEwith. The data set should have the average of each veriable for each activity and subject.
