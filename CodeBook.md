#Course Project Code Book
Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The attached R script (run_analysis.R) performs the following to clean up the data:

Merges the following training and test sets.
1.) train/X_train.txt and test/X_test.txt - data of 10299 rows and 561 columns.
2.) train/subject_train.txt and test/subject_test.txt - data of 10299 rows and 1 column (subject ids)
3.) train/Y_train.txt and test/Y_test.txt - data of 10299 rows and 1 column (activity ids)

Reads features.txt and extracts only the measurements on the mean and standard deviation for each measurement. 
This filters to 10299 rows and 66 columns (out of the original 561)

Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set.

The script also refines the data by adding labels with descriptive names. All feature names (attributes) and activity names are converted to lower case, underscores and brackets () are removed. Then it merges the 10299x66 data frame containing features with 10299x1 data frames containing activity labels and subject IDs. The result is saved as refineddata.txt, a 10299x68 data frame such that the first column contains subject IDs, the second column activity names, and the last 66 columns are measurements. Subject IDs are integers between 1 and 30 inclusive. 

Finally, the script creates a 2nd, independent tidy data set with the average of each measurement for each activity and each subject. The result is saved as refineddata_average.txt, a 180x68 data frame, where as before, the first column contains subject IDs, the second column contains activity names (see below), and then the averages for each of the 66 attributes are in columns 3...68. There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.
