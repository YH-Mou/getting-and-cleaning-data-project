# getting-and-cleaning-data-project
The script run_analysis.R is used to get and clean the data set.
In the beginning, it will read all useful txt files and use appropriate col.names.
Then, it will clean the data set with 5 steps.
    Step1: Merges the training and the test sets to create one data set.
    Step2: Extracts only the measurements on the mean and standard deviation for each measurement.
    Step3: Uses descriptive activity names to name the activities in the data set.
    Step4: Appropriately labels the data set with descriptive variable names.
    Step5: From the data set in step 4, creates a second, independent tidy data set with 
           the average of each variable for each activity and each subject.
After these 5 steps, a new txt called "tidydata_output.txt" will be created, containing the new independent tidy data set.

Re. the original data set can be downloaded from:
    "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
