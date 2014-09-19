#Read the features file to extract features that are measurements on the mean and standard deviation for analysis
features <- read.table("./UCI HAR Dataset/features.txt", quote="\"",colClass=c("numeric","character"))
#Extract columns that are measurments on mean
columns_containing_mean <- grepl("-mean()",features$V2)
#extract the columns that are measurements on SD
columns_containing_sd <- grepl("std()",features$V2)
#extract columns that are measurements on mean frequency
columns_containing_mean_frequency <- grepl("meanFreq",features$V2)
#Include columns containing only mean and SD and exclude columns that are measurements on Mean Frequency
columns_to_extract <- (columns_containing_mean|columns_containing_sd)&!(columns_containing_mean_frequency)
#Remove temporary variables created
rm(columns_containing_mean)
rm(columns_containing_mean_frequency)
rm(columns_containing_sd)
#Read and Store all activity Labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"")
colnames(activity_labels) <- c("V1","activity_description")
source("extractData.R")
#Extract training & test data
train_dataset <- extract_data("./UCI HAR Dataset/train/",columns_to_extract)
test_dataset <- extract_data("./UCI HAR Dataset/test/",columns_to_extract)
#Concatenate both the training & test datasets
complete_dataset <- rbind(train_dataset,test_dataset)
#Remove unecessary datasets
rm(train_dataset)
rm(test_dataset)
#Change column names for the concatenated dataset to facilitate easy manipulation
#Get the column names from features
column_names <- subset(features,columns_to_extract,select = c("V2"))
column_names <- column_names$V2
#Append Subject & activity labels at appropriate positions
column_names <- c("subject",as.character(column_names),"activity_label")
#Add these column names to the combined dataset
colnames(complete_dataset) <- column_names
# Represent activity labels with descriptive activity names
# Merge complete dataset & activity labels dataset
complete_dataset <- merge(complete_dataset,activity_labels,by.x="activity_label",by.y="V1")
#Remove activity code, if it exists in the resulting data frame
complete_dataset <- subset(complete_dataset, select = - c(activity_label))
#create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_dataset <- aggregate(.~subject+activity_description,data=complete_dataset,mean)
#Order the dataset based on subject & activity description
tidy_dataset <- tidy_dataset[order(tidy_dataset$subject,tidy_dataset$activity_description),]
#remove row names
row.names(tidy_dataset) <- NULL
#write tidy dataset to a file
write.table(tidy_dataset,file = "tidy_dataset.txt")

