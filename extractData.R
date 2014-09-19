extract_data <-function(path="",columnsToBeExtracted){
  #Get the File name for X_Train/Test, y_train/test & subject_train/test
  X_file_name <- list.files(path,pattern = "X")
  Y_file_name <- list.files(path,pattern = "y")
  subject_file_name <- list.files(path,pattern = "subject")
  if(length(X_file_name)==1 && length(Y_file_name)==1 && length(subject_file_name)==1){
    #Read X_Train/#Xtest dataset
    X <- read.table(paste(path,X_file_name[1],sep=""),quote="\"")
    #Extract only the columns required (that are measurements on the mean and standard deviation)
    X <- X[,columnsToBeExtracted]
    #Read Training Labels
    Y <- read.table(paste(path,Y_file_name[1],sep=""),quote="\"")
    #Read Subject Data
    subject <- read.table(paste(path,subject_file_name[1],sep=""),quote="\"")
    #Append Subject, training/test data & Y labels
    subject <- cbind(subject,X)
    subject <- cbind(subject,Y)
    #Remove temporary variables
    rm(X)
    rm(Y)
    #Return the appended dataset
    subject
  }
}