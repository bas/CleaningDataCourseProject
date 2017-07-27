# CleaningDataCourseProject
This repository is the submission for the Coursera Getting and Cleaning Data Course Project.

The assignment is based on the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

To run the script:

- Download and extract the [data set](http://archive.ics.uci.edu/ml/machine-learning-databases/00240/)
- Source and run the script:

```
source("run_analysis.R")
run_analysis()
```

- The [run_analysis.R](run_analysis.R) script assumes the data set is extracted in `./UCI HAR Dataset`.
- The five assignment steps are included as comments:
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement.
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
- A separate [code book](code-book.md) describes the data and data cleaning and summarizing steps.
