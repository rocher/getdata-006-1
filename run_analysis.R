
library(data.table)

# download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="dataset.zip", method="curl")

# extratc files
unzip("dataset.zip")

# rename 'UCI HAR Dataset' to 'data'
file.rename("UCI HAR Dataset", "data")


# get variable names (features)
features <- read.table("data/features.txt", colClasses=c("NULL", NA))

# get indexes for mean and std. dev. variables
features.idx <- grep("(mean|std)\\(", features[ , 1])
length(features.idx)


# create descriptive names
features.name <- sapply(features[features.idx, 1], sub,
                        pattern="(t|f)(Body|Gravity|Gyro)(.*)-(mean|std)\\(\\)-([XYZ])",
                        replacement="\\1_\\4_\\2_\\3_\\5")
features.name <- sapply(features[features.idx, 1], sub,
                        pattern="(t|f)(Body|Gravity|Gyro)(.*)-(mean|std)\\(\\)",
                        replacement="\\1_\\4_\\2_\\3")


# read activity names
activityName <- read.table("data/activity_labels.txt")


# select columns to read
columnSelection <- rep("NULL", 561)
columnSelection[features.idx] = NA


# read X_test
X_test <- data.table(read.table("data/test/X_test.txt", colClasses=columnSelection))
setnames(X_test, features.name)


# add 'subject' column
X_test.subject <- read.table("data/test/subject_test.txt")
X_test[ , subject:=as.factor(X_test.subject[,1])]


# add 'activity' column
X_test.activity <- read.table("data/test/y_test.txt")
X_test[ , activity:=activityName[X_test.activity[,1],2]]


# add 'origin' column  (in the figure, new blue column)
X_test[ , origin:="test"]


# read X_train
X_train <- data.table(read.table("data/train/X_train.txt", colClasses=columnSelection))
setnames(X_train, features.name)

# add 'aubject' column
X_train.subject <- read.table("data/train/subject_train.txt")
X_train[,subject:=X_train.subject]

# add 'activity' column
X_train.activity <- read.table("data/train/y_train.txt")
X_train[,activity:=activityName[X_train.activity[,1],2]]

# add 'origin' column  (in the figure, new blue column)
X_train[,origin:="train"]


# merge of both data sets
X_data <- merge(X_test, X_train, all=TRUE, by=names(X_test))

