#                                                                     -*- sh -*-
# GETTING RAW DATA
# -----------------------------------------------------------------------------
#
# downloaading files
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="dataset.zip", method="curl")

# files accommodation
unzip("dataset.zip")


# CLEANING DATA
# -----------------------------------------------------------------------------
#
# get variable names (features)
features <- read.table("UCI HAR Dataset/features.txt", colClasses=c("NULL", NA))

# get indexes for mean and std. dev. variables of interest
features.idx <- grep("(mean|std)\\(", features[ , 1])

# create descriptive names
features.name <- features[features.idx, 1]
features.name <- as.character(sapply(features.name, sub,
                              pattern="(t|f)(Body|Gravity|Gyro)(.*)-(mean|std)\\(\\)-([XYZ])",
                              replacement="\\1_\\4_\\2_\\3_\\5"))
features.name <- as.character(sapply(features.name, sub,
                              pattern="(t|f)(Body|Gravity|Gyro)(.*)-(mean|std)\\(\\)",
                              replacement="\\1_\\4_\\2_\\3"))

# read activity names
activityName <- read.table("UCI HAR Dataset/activity_labels.txt")


# select columns to read
columnSelection <- rep("NULL", 561)
columnSelection[features.idx] = NA


# READING DATA
# -----------------------------------------------------------------------------
#
# read X_test and set variable names
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", colClasses=columnSelection)
setnames(X_test, features.name)

# read subject factor
X_test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")

# read activity factor
X_test.activity <- read.table("UCI HAR Dataset/test/y_test.txt")

# add subject and activity factors
X_test <- transform(X_test,
                    subject = as.factor(X_test.subject[ , 1]),
                    activity = activityName[X_test.activity[ , 1], 2])


# read X_train and set variable names
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", colClasses=columnSelection)
setnames(X_train, features.name)

# read subject factor
X_train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")

# read activity factor
X_train.activity <- read.table("UCI HAR Dataset/train/y_train.txt")

# add subject and activity factors
X_train <- transform(X_train,
                     subject = as.factor(X_train.subject[ , 1]),
                     activity = activityName[X_train.activity[ , 1], 2])


# PUTTING IT ALL TOGETHER
# -----------------------------------------------------------------------------
#
# X_data is the union of both data sets
X_data <- rbind(X_test, X_train)

# second data set
# with the average of each variable for each activity and subject
X_avg <- aggregate(X_data[ , 1:66],
                   by=list(X_data$subject, X_data$activity),
                   FUN=mean)
colnames(X_avg)[1:2] <- c("subject", "activity")
write.table(X_avg, file="X_avg.txt", row.names=FALSE)
