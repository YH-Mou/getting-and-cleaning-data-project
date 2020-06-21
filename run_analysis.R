library(dplyr)
# Read all txt files and use appropriate col.names
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Step1: Merges the training and the test sets to create one data set
merge_X <- rbind(x_train, x_test)
merge_Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
merge_data <- cbind(Subject, merge_Y, merge_X)

# Step2: Extracts only the measurements on the mean and 
    # standard deviation for each measurement
tidydata <- select(merge_data, subject, code, contains('mean'), contains('std'))

# Step3: Uses descriptive activity names to name the activities in the data set
tidydata$code <- activities[tidydata$code,2]

# Step4: Appropriately labels the data set with descriptive variable names
names(tidydata)[2] <- "activity"
names(tidydata) <- gsub("Acc", "accelerometer", names(tidydata))
names(tidydata) <- gsub("Gyro", "gyroscope", names(tidydata))
names(tidydata) <- gsub("BodyBody", "body", names(tidydata))
names(tidydata) <- gsub("Mag", "magnitude", names(tidydata))
names(tidydata) <- gsub("^t", "time", names(tidydata))
names(tidydata) <- gsub("^f", "frequency", names(tidydata))
names(tidydata) <- gsub("tBody", "timebody", names(tidydata))
names(tidydata) <- gsub("-mean()", "mean", names(tidydata), ignore.case = TRUE)
names(tidydata) <- gsub("-std()", "std", names(tidydata), ignore.case = TRUE)
names(tidydata) <- gsub("-freq()", "frequency", names(tidydata), ignore.case = TRUE)
names(tidydata) <- tolower(names(tidydata))

# Step5: From the data set in step 4, creates a second, independent tidy data set with 
  # the average of each variable for each activity and each subject
tidydata_output <- tidydata %>% 
                   group_by(subject, activity) %>% 
                   summarise_all(funs(mean))
write.table(tidydata_output, "tidydata_output.txt", row.name=FALSE)

