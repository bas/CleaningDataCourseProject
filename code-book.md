# Code Book

## Data set
The original data set used is the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The steps are coded in a function called `run_analysis` in the R script [run_analysis.R]("run_analysis.R"). The script return the data set from step 5.

## Merged training and test sets to create one data set (step 1)

There data set is separated into two data sets:

- One for the train subjects (`X_train.txt`)
- One for the test subjects (`X_test.txt`)

- For both sets the data is merged:
1. Column names were added based on the `features.txt` list with parentheses replaced by dots.
2. The subjects were added (`subject_train.txt` and `subject_test.txt`).
3. The activity id's were added (`Y_train.txt` and `Y_test.txt`).
4. The two data sets were combined into one large data set (train and test combined).

## Extracted measurements on the mean and standard deviation for each measurement (step 2)

The mean and standard deviation for each feature was then extracted for the following column names:

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

Where XYZ means there are variables for every direction X, Y and Z.

The following two variables were also included:

- activity.id
- subject

The subset was created based on the following regular expression:

```
"(\\.(mean|std)\\.(x|y|z)?|activity.id|subject)"
```

The subset has 68 columns:
- 8 * 3  = 24 for the XYZ variables (mean and std) = 48
  - fBodyAcc-XYZ
  - fBodyAccJerk-XYZ
  - fBodyGyro-XYZ
  - tBodyAcc-XYZ
  - tGravityAcc-XYZ
  - tBodyAccJerk-XYZ
  - tBodyGyro-XYZ
  - tBodyGyroJerk-XYZ
- 9 * 2 for the remaining variables (mean and std) = 18
  - tBodyAccMag
  - tGravityAccMag
  - tBodyAccJerkMag
  - tBodyGyroMag
  - tBodyGyroJerkMag
  - fBodyAccMag
  - fBodyAccJerkMag
  - fBodyGyroMag
  - fBodyGyroJerkMag
- 2 Added fields for subject and activity:
  - subject
  - activity_id

## Descriptive activity names to name the activities in the data set (step 3)

- A column was then added by merging in the activity labels using the activity id in a variable `activity` taking the data set to 69 columns.
- The column is moved to the first row in the data set

## Appropriately labels the data set with descriptive variable names (step 4)

- The `features.txt` data set was already used to label the columns
- For readability:
  - The labels were translated to lower case.
  - Dots (`.`) were replaced by single underscores (`_`) and any trailing dots were removed.

## The average of each variable for each activity and each subject (step 5)

Finally a new data set was created using `dplyr` to create the average of each variable for each activity and each subject.
