
## Files Used -- further file description in the README file of the UCI HAR Dataset
	activity_labels.txt // mapping file translating the ActivityId into an ActivityName
	features.txt // name of signal measuremnts -- represents the columns names for the X_test and X_train sets
	subject_test.txt// represents the subject of each observation in test set
	X_test.txt // represents the in test set
	y_test.txt // represents the ActivitId of each observation in test set
	subject_train.txt // represents the subject of each observation in train set
	X_train.txt  // data values for each measurement and observation in train set
	y_train.txt // represents the ActivitId of each observation in train set

	
## Steps to transform original data files in UCI HAR Dataset into tidydata_means.txt
	1. Read all files into R with read.table()
	2. Create a complete data set from the training data: Combine the subject_test, y_test, X_test files using cbind
	3. Create a complete data set from the test data: Combine the subject_train, y_train, X_train files using cbind
	4. Label the columns of the two data sets using the features.txt file // Important to not reorder any of files
	5. Create a full data set by combining the complete training and test sets into one large data set using rbind()
	6. Rename the columns created from subject_test/train and y_test/train as SubjectId and ActivityId respectively
	7. Add a new column to describe the activity by merging the activity_labels and full data set joined on the ActivityId

	-- The data is now completely combined.  The following steps filter and summarize.

	8. Filter to keep only columns containing "mean()" and "std()" exactly.  Columns containing other variants of these functions like FreqMean() are omitted.  Use grep() to parse the column names.
		Also keep the SubjectId and ActivityName columns
	9. Reduce data to one row per SubjectId and ActivityName with an average of the observations for each feature
		Use ddply() to apply mean() to each column


