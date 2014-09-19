---
title: "README.md"
---

* R-Scripts which I created for analysis are "run_analysis.R" & "extractData.R".
* Codebook is titled as "codebook.md"
* Final Tidy dataset is can also be found in the folder

###Assumptions
* Input dataset is unzipped and available at the current working directory

##Functioning of analysis Script -- run_analysis.R
1. Reads the file "features.txt" from input dataset
2. Computes which features have the text "mean" -> This also includes features having text MeanFreq, but this should be eliminated
3. Computes which features have text "sd"
4. Computes which features have text "Mean Freq"
5. Computes columns containing only mean and SD and exclude columns that are measurements on Mean Frequency
6. Removes temporary variables that were created during the above computation
7. Reads the file "activity_labels.txt" from input dataset
8. Provides appropriate column names to the above dataset
9. Calls function extractData by passing arguments train folder path and columns to be extracted (this is computed from step 5)
10. Calls function extractData by passing arguments test folder path and columns to be extracted (this is computed from step 5)
11. Concatenates results from steps 9 & 10
12. Removes temporary variables that were created during the above computation
13. Creates appropriate column names for the combined dataset obtained in Step 11
14. Converts activity codes to corresponding descriptions for the dataset from Step 13
15. Creates independent tidy data set with the average of each variable for each activity and each subject
16. Writes the tidy dataset from Step 15 to a text file
##Functioning of analysis Script -- extractData.R [Arguments - train/test folder path & columns to be extracted]
1. Gets the file names for X, Y & Subject based on the folder path passed as first argument
2. It reads the X Test/Train data
3. Subsets X Test/Train data based on the second argument passed
4. Reads Y Test/Train data
5. Reads subject_Test/Train data
6. Concatenates Subject_Test/Train data with X subset of Test/Train data obtained in step 3
7. Concatenates result from step 6 with Y Test/Train Data
8. Returns data from Step 7