# Go to base directory
setwd("C:/Teradata Docs/Coursera/Getting_Data_Clean")

# Download file to coursera3data directory
if(!file.exists("./coursera3data")){dir.create("./coursera3data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./coursera3data/Dataset.zip")

# Unzip downloaded data file
unzip(zipfile="./coursera3data/Dataset.zip",exdir="./coursera3data")

# Reading downloaded files.
datapath <- file.path("./coursera3data" , "UCI HAR Dataset")
filelist <-list.files(datapath, recursive=TRUE)


# Step 1
# Merge the training and test sets to create one data set
###############################################################################

# Train data files
x_train <- read.table(file.path(datapath, "train", "X_train.txt"))
y_train <- read.table(file.path(datapath, "train", "y_train.txt"))
subject_train <- read.table(file.path(datapath, "train", "subject_train.txt"))

traindata <- cbind(subject_train, y_train, x_train)

# Test data files
subject_test  <- read.table(file.path(datapath, "test" , "subject_test.txt")) 
y_test  <- read.table(file.path(datapath, "test" , "y_test.txt" ))
x_test  <- read.table(file.path(datapath, "test" , "X_test.txt" )) 
testdata <- cbind(subject_test, y_test, x_test)

# Task 1: 
# Merges the training and the test sets to create one data set.
# Merging X Dataset
x_data <- rbind(x_train, x_test)

# Merging Y Dataset
y_data <- rbind(y_train, y_test)

# Merging subject dataset
subject_data <- rbind(subject_train, subject_test)

# All merged data into single dataset
alldata <- cbind(x_data, y_data, subject_data)

# Task 2: 
# Extract only the measurements on the mean and standard deviation for each measurement
features <- read.table(file.path(datapath, "features.txt"))
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

# get only columns with mean() or std() in their names
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
x_data <- x_data[, mean_and_std_features]

# Descriptive correct the column names
names(x_data) <- features[mean_and_std_features, 2]

# Task 3:
# Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table(file.path(datapath, "activity_labels.txt"))

# Adding correct activity names to values
y_data[, 1] <- activityLabels[y_data[, 1], 2]

# Adding descriptive names
names(y_data) <- "activity"

# Task 4:
# Appropriately labels the data set with descriptive variable names.
names(subject_data) <- "subject"

# All merged data into single dataset
alldata <- cbind(x_data, y_data, subject_data)

# Task 5:
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(plyr)
averages_data <- ddply(alldata, .(Subject_data, Activity_data), function(x) colMeans(x[, 1:66]))
write.table(averages_data, "averages_data.txt", row.name=FALSE)
