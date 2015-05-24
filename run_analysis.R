library(dplyr)

getData <- function() {
    ## Download and extract dataset
    
    zipdownload <- UCI_HAR_Dataset.zip
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
            zipDownload, method = "curl")
    unzip(zipDownload)
}


loadData <- function() {
    ## Step 1. Load and merge datasets
    ## Also Step 4. Apply descriptive labels to variables
    
    ## Load labels to apply to data
    labels <- read.table("UCI HAR Dataset/features.txt")[,2]
    
    ## Load activity labels to apply to data
    activities <<- read.table("UCI HAR Dataset/activity_labels.txt")
    
    ## Load and label a dataset, and merge with it's subject and activity
    prepData <- function(dataset) {
        directory <- paste("UCI HAR Dataset/",dataset,sep = "")
        
        data <- read.table(paste(directory,"/X_",dataset,".txt",sep = ""), 
                        col.names = labels)
        
        activity <- read.table(paste(directory,"/y_",dataset,".txt",sep = ""), 
                        col.names = "activity")
        
        subjects <- read.table(paste(directory,"/subject_",dataset,".txt",sep = ""), 
                        col.names = "subject")
        
        output <- cbind(subjects,activity,data)
        
        return(output)
    }
    
    ## Load both datasets
    testData <- prepData("test")
    trainData <- prepData("train")
    
    ## Merge and return datasets
    data <- rbind(testData, trainData)
    return(data)
}

narrowData <- function(data) {
    ## Step 2: Extract only measurements on mean and standard deviation
    ## Keep subject and activity in data for step 5
    return(data[,grep("mean|std|subject|activity", colnames(data))])
}

applyActivity <- function(data) {
    ## 3. Apply descriptive label to activities 
    ##    & change subject field to factors
    data$activity <- factor(data$activity, labels = activities[,2])
    data$subject <- factor(data$subject)
    
    return(data)
}

createTidy <- function(data) {
    ## 5. Create an independent dataset that includes the average of each
    ##    variable for each activity and subject. Write the result to a file
    
    dataOut <- group_by(data, subject, activity) %>% summarise_each(funs(mean))
    write.table(dataOut, file = "results.txt", row.names = FALSE)
    
    return(dataOut)
}

#getData()
data <- loadData()
data <- narrowData(data)
data <- applyActivity(data)
dataOut <- createTidy(data)