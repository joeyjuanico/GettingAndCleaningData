### setup url and file name for the data source
fileurl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipname <- "./data/getdata-projectfiles-UCI HAR Dataset.zip"

# creates a folder for the rawdata
if (!file.exists("rawdata")) {
  dir.create("rawdata")
}

# download and unzip the file
if (!file.exists(zipname)){
  download.file(fileurl, destfile=zipname, mode="wb")
  unzip(zipname, exdir="./rawdata")
}

# 1. Merges the training and the test sets to create one data set.

xtrain <- read.table("./rawdata/UCI HAR Dataset/train/X_train.txt")
xtest <- read.table("./rawdata/UCI HAR Dataset/test/X_test.txt")
X <- rbind(xtrain, xtest)

subjecttrain <- read.table("./rawdata/UCI HAR Dataset/train/subject_train.txt")
subjecttest <- read.table("./rawdata/UCI HAR Dataset/test/subject_test.txt")
S <- rbind(subjecttrain, subjecttest)

ytrain <- read.table("./rawdata/UCI HAR Dataset/train/y_train.txt")
ytest <- read.table("./rawdata/UCI HAR Dataset/test/y_test.txt")
Y <- rbind(ytrain, ytest)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("./rawdata/UCI HAR Dataset/features.txt")
matchedfeatures <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, matchedfeatures]
names(X) <- features[matchedfeatures, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("./rawdata/UCI HAR Dataset/activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(S) <- "subject"
refined <- cbind(S, Y, X)

if (file.exists("refineddata.txt")){
  file.remove("refineddata.txt")
}
write.table(refined, "refineddata.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniqueSubjects = unique(S)[,1]
numSubjects = length(unique(S)[,1])
numActivities = length(activities[,1])
numCols = dim(refined)[2]
result = refined[1:(numSubjects*numActivities), ]

row = 1
for (s in 1:numSubjects) {
  for (a in 1:numActivities) {
    result[row, 1] = uniqueSubjects[s]
    result[row, 2] = activities[a, 2]
    tmp <- refined[refined$subject==s & refined$activity==activities[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}
if (file.exists("refineddata_average.txt")){
  file.remove("refineddata_average.txt")
}

write.table(result, "refineddata_average.txt")

