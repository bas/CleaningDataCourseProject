run_analysis <- function() {
  ## ============================================================================
  ## get features to use as column names
  
  ## 561 rows with 2 variables for the id and feature (columns)
  ## we will use the features as column names, r will call make.names
  colnames <- as.character(read.table("./UCI HAR Dataset/features.txt")[, 2])
  
  ## ============================================================================
  ## The training set
  
  ## data set with 7532 observations and 561 variables
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = colnames)

  ## the subject code for each observation
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
  
  ## the activity code for each observation
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activity.id")
  
  ## merge the three data frames
  syx_train <- data.frame(subject_train, y_train, x_train)
  
  ## ============================================================================
  ## The test set
  
  ## data set with 2947 observations and 561 variables
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = colnames)
  
  ## the subject code for each observation
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
  
  ## the activity code for each observation
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activity.id")
  
  ## merge the three data frames
  syx_test <- data.frame(subject_test, y_test, x_test)
  
  ## ============================================================================
  ## 1. Merges the training and the test sets to create one data set.
  
  ## put the train and test sets together
  all <- rbind(syx_test, syx_train)

  ## check if all subjects are present
  cat("Merged set equal to the rows in train and test: ", nrow(all) == (nrow(syx_test) + nrow(syx_train)), "\n")
  cat("All 30 subjects present: ", length(sort(unique(all$subject))) == length(c(1:30)), "\n")

  ## ============================================================================
  ## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  
  ## I used grep to select the columns with mean, std and activity and subject
  colnames_subset <- names(all[grep("(\\.(mean|std)\\.(x|y|z)?|activity.id|subject)", names(all))])

  ## then got the columns from the data set
  mean_and_std <- all[, colnames_subset]

  ## ============================================================================
  ## 3. Uses descriptive activity names to name the activities in the data set
  
  ## 6 rows with 2 variables for the id and activity name
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("id","activity"))
  
  ## change activity names to lowercase for ease of use
  levels(activity_labels$activity) <- tolower(levels(activity_labels$activity))
  
  ## add the activity to the end of the columns
  mean_and_std <- merge(mean_and_std, activity_labels, by.x = "activity.id", by.y = "id")

  ## move activity to the front 
  mean_and_std <- mean_and_std[ , order(names(mean_and_std))]
  
  ## print to check
  cat("Rows in the mean and std set: ", nrow(mean_and_std), "\n")
  cat("Columns: ", ncol(mean_and_std), "\n")
  
  ## ============================================================================
  ## 4. Appropriately labels the data set with descriptive variable names.

  ## I used the features as basic names
  
  ## change the column names to lowercase for readability
  names(mean_and_std) <- tolower(names(mean_and_std))
  
  ## remove unnecessary dots from the column names for readability
  ## using gsub
  names(mean_and_std) <- gsub("\\.+", ".",  names(mean_and_std))
  names(mean_and_std) <- gsub("\\.+$", "",  names(mean_and_std))
 
  ## ============================================================================
  ## 5. From the data set in step 4, creates a second, independent tidy data set with 
  ## the average of each variable for each activity and each subject.
  ## table()
  
  ## I used dplyr for this task
  averages <- mean_and_std %>% group_by(activity, subject) %>% summarise_all(funs(mean))
}