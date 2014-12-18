library(dplyr)
library(plyr)

## BEFORE RUNNING SCRIPT
        ## download data into working directory into folder named "UCI HAR Dataset"
        ## dataLoc <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
        

## GOALS
        ## Uses descriptive activity names to name the activities in the data set
        ## Appropriately labels the data set with descriptive variable names
        ## One observation per row, one variable per column, one type of observation per table

## Merges the training and the test sets to create one data set.
        ## import data files into R as data frames
        activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
        colnames(activity_labels) <- c("ActivityId", "ActivityName")
        features <- read.table("./UCI HAR Dataset/features.txt")
        rnames <- c("SubjectId", "ActivityId", as.character(features[,2]))
        
        X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
        Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
        sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

        X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
        Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
        sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

        ## Combine files into full test/train sets
        test_full <- cbind(sub_test, Y_test, X_test)
        train_full <- cbind(sub_train, Y_train, X_train)

        ##label training and test columns
        colnames(test_full) <- rnames
        colnames(train_full) <- rnames

        ## Tidy up the data set
        fulldata <- tbl_df(rbind(test_full, train_full)) ##combine and covert to table object
        tidy1 <- merge(fulldata, activity_labels, by = "ActivityId")  ##Add ActivityName
        colnames(tidy1)[4] <- "Feature"
        
                 
## Extracts only the measurements on the mean and standard deviation for each measurement. 
        # Note: took only column names containing "mean()" or "std()"
        # which omits columns containing names like meanFreq()
        mean_std_columns <- unique(c(grep("mean()", colnames(tidy1), fixed=T), grep("std()", colnames(tidy1), fixed=T)))
        tidy2 <- tidy1[, c(2, 564, mean_std_columns)]

## From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.
        tidy3 <- ddply(tidy2, c("SubjectId", "ActivityName"), colwise(mean))

        write.table(tidy3, ".tidydata_means.txt", sep="\t", row.name=FALSE)

