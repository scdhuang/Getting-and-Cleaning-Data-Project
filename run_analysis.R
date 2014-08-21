#set working directory to the folder where the data is hold
setwd("~/Desktop/Data_Science/Getting_and_cleaning_data/UCI HAR Dataset")
#Read training data
features     = read.table('./features.txt',header=FALSE); 
activityType = read.table('./activity_labels.txt',header=FALSE); 
subjectTrain = read.table('./train/subject_train.txt',header=FALSE); 
xTrain       = read.table('./train/x_train.txt',header=FALSE); 
yTrain       = read.table('./train/y_train.txt',header=FALSE); 
#Assign column names to training data
colnames(activityType)  = c('activityId','activityType');
colnames(subjectTrain)  = "subjectId";
colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "activityId";
#Final training set
trainingData = cbind(yTrain,subjectTrain,xTrain);
#Read test data
subjectTest = read.table('./test/subject_test.txt',header=FALSE); 
xTest       = read.table('./test/x_test.txt',header=FALSE); 
yTest       = read.table('./test/y_test.txt',header=FALSE);
#Assign column names to test data
colnames(subjectTest) = "subjectId";
colnames(xTest)       = features[,2]; 
colnames(yTest)       = "activityId";
#Final test set 
testData = cbind(yTest,subjectTest,xTest);
# Combine training and test data to final data
finalData = rbind(trainingData,testData);
# Create a vector for column name of final data
colNames  = colnames(finalData); 

#Create a logical Vector that contains TRUE and FALSE values
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));
#Subset finalData table based on the logicalVector 
finalData = finalData[logicalVector==TRUE];

#Merge the finalData set with the acitivityType table
finalData = merge(finalData,activityType,by='activityId',all.x=TRUE);
#Update colNames vector 
colNames  = colnames(finalData); 

#Cleaning up the variable names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};
#Reassign the new column names to final data set
colnames(finalData) = colNames;

#Create a finalDataNoActivityType table without the activityType column
finalDataNoActivityType  = finalData[,names(finalData) != 'activityType'];
#Summerize the finalDataNoActivityType table to include just the mean of each variable for each activity and each subject
tidyData    = aggregate(finalDataNoActivityType[,names(finalDataNoActivityType) != c('activityId','subjectId')],by=list(activityId=finalDataNoActivityType$activityId,subjectId = finalDataNoActivityType$subjectId),mean);
#Merge the tidyData with activityType to include descriptive acitvity names
tidyData    = merge(tidyData,activityType,by='activityId',all.x=TRUE);
#Export the tidyData set 
write.table(tidyData, './tidyData.txt',row.names=FALSE,sep='\t');