#Getting and Cleaning Data



<br>
## Introduction

This is my submission for the course project *Getting and Cleaning Data*
(<tt>getdata-006</tt>). I hope you enjoy my work, the way I've constructed
the data set and the `R` code provided here to make it.

The file you are reading, `README.md`, contains exactly the same `R` code
than the script file [run_analysis.R](run_analysis.R) provided to make the
assignment. Here the ideas are developed and explained in great detail,
whereas in the script you'll find `R` comments with references to the steps
followed all along the work.

Please note that I've included the **code book** in the present
repository. I've written it with *markdown*, so you can read it with the link
[CodeBook](CodeBook.md).

You can indistinctly run every single `R` in this file or run the script
file. The final result shall be the same.
<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc/generate-toc again -->
**Table of Contents**

- [Introduction](#introduction)
    - [The Big Picture](#the-big-picture)
    - [Omitting files](#omitting-files)
- [Getting Raw Data](#getting-raw-data)
    - [Downloading files](#downloading-files)
    - [Files accommodation](#files-accommodation)
    - [Preliminary data inspection](#preliminary-data-inspection)
- [Cleaning Data](#cleaning-data)
    - [Selecting columns by name](#selecting-columns-by-name)
    - [Setting descriptive names](#setting-descriptive-names)
    - [Selecting columns by position](#selecting-columns-by-position)
- [Reading data](#reading-data)
    - [X_test](#x_test)
    - [X_train](#x_train)
- [Putting it all together](#putting-it-all-together)
    - [Merging data.frames](#merging-dataframes)
    - [Writing tidy data set](#writing-tidy-data-set)

<!-- markdown-toc end -->


### The Big Picture

First of all, I'd like to start by providing a *big picture* of the data
set. Of course, reading the documentation that comes with the *zip* file is a
big help to understand how to organize data.

After reading the documentation and with a simple examination of the files,
it's quite easy to figure out that the data files contained in the zip must
be organized as follows:

<center>
![data scheme here](data-scheme.png)
</center>

Each data block can be extracted from the files indicated in the figure,
although more will be used during the construction process.


### Omitting files

I deliberately omit all files contained in the `test/Intertial Signals` and
`train/Intertial Signals` directories. The final dataset must contain only
those measurements on the mean and standard deviation for each measurement,
and neither of these directories contains such data. All measurements there
correspond to body acceleration, gyroscope and total acceleration, so there's
no need to worry about them.


<br>
## Getting Raw Data

Let's begin by the beginning.


### Downloading files

The very first thing to do is to download the zip file from the given URL:

```R
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="dataset.zip", method="curl")
```


### Files accommodation

I prefer to work with *unzipped* files both for reading from `R` and for
taking a look at them:

```R
unzip("dataset.zip")
```

This command results in the following directory structure populated with
files:

```
                                              Used to extract
UCI HAR Dataset/                              -----------------------------
  ├── activity_labels.txt ................... metadata: activity names
  ├── features_info.txt
  ├── features.txt .......................... metadata: measure names
  ├── README.txt
  ├── test/
  │   ├── Inertial Signals
  │   │   ├── body_acc_x_test.txt
  │   │   :
  │   │   └── total_acc_z_test.txt
  │   ├── subject_test.txt .................. data: test: subject factor
  │   ├── X_test.txt ........................ data: test: observations
  │   └── y_test.txt ........................ data: test: activity factor
  └── train/
      ├── Inertial Signals
      ├── body_acc_x_train.txt
      │   :
      │   └── total_acc_z_train.txt
      ├── subject_train.txt ................. data: train: subject factor
      ├── X_train.txt ....................... data: train: observations
      └── y_train.txt ....................... data: train: activity factor

4 directories, 28 files
```


### Preliminary data inspection

Just to test reading few lines from `X_test.txt` and to check the number of
columns:

```R
 X_test.head <- data.table(read.table("UCI HAR Dataset/test/X_test.txt", nrows=10))
 ncol(X_test.head)
[1] 561
```


<br>
## Cleaning Data

`X_test.txt` and `X_train.txt` are huge files. They contain 561 variables for
a total of 10,561 observations. According to the assignment specifications,
only 66 variables are needed (66? see below).

It's a clear waste of time and memory to read these two files in its
whole. It's better to use the `read.table` function to skip unneeded
columns. But for that, first it's crucial to know which are those *unneeded
columns*.

The plan is:

   + read the file `features.txt`
   + select those measurements matching *mean* and *std*
   + create a vector of factors to select columns, to be used by `read.table`


### Selecting columns by name

The file `features.txt` contains the names of the measures following a simple
convention. For example, some measures related to body acceleration `BodyAcc`
are named as follows:

| pefix | feature | suffix | axis    |
|:-----:|---------|--------|---------|
| t     | BodyAcc | energy | X, Y, Z |
| t     | BodyAcc | mean   | X, Y, Z |
| t     | BodyAcc | std    | X, Y, Z |
| t     | BodyAcc | sma    |         |

When `X`, `Y` and `Z` axis are present, there is a single measure for each
one.

We are only interested in names matching `mean` and `std`.

**Caution**: some variables also contain `mean` and `std` but aren't on the
mean or standard deviation of measures. For example, variables like:

   + `angle(tBodyAccMean,gravity)`
   + `angle(tBodyAccJerkMean),gravityMean)`
   + `angle(X,gravityMean)`

refer to *angles between forces*, not means. The same for variables like:

   + `fBodyAcc-meanFreq()-X`
   + `fBodyGyro-meanFreq()-X`
   + `fBodyBodyAccJerkMag-meanFreq()`

which are the *weighted average of the frequency components to obtain a mean
frequency*. Their *mean* counterpart already exist:

   + `fBodyAcc-mean()-X`
   + `fBodyGyro-mean()-X`
   + `fBodyBodyAccJerkMag-mean()`

The selected variables are those matching *mean* or *std* followed by
*()*. The `grep` function return the index of each match:

```R
features <- read.table("UCI HAR Dataset/features.txt", colClasses=c("NULL", NA))
features.idx <- grep("(mean|std)\\(", features[ , 1])
```

Variable `features.idx` contain the index of the target columns. Remaining
ones must be dropped. How many columns are there?

```R
length(features.idx)
[1] 66
```

### Setting descriptive names

The most important part of this step is to set descriptive names for
columns. The strings contained in file `features.txt` are quite descriptive,
but can be slightly improved with simple replacements:

  + Change *camelCaseNames* to *underscore_names*
  + Remove parenthesis from names
  + Separate `t` and `f` indicators (for *time* and *frequency*)
  + Separate descriptors `mean` and `std` from names
  + Separate keywords *Body*, *Gravity* and *Gyro* in the start of the name
  + Put the axis, if present, at the end prefixed with an underscore

For example, the name `tBodyAccJerk-mean()-Z` will become
`t_mean_Body_AccJerk_Z`. See the [CodeBook](CodeBook) for a complete list of
variables.

The changes are easy to *sapply* using `sub`. First, `features.name` contains
the name of the selected variables (according to `features.idx`):

```R
features.name <- features[features.idx, 1]
features.name <- as.character(sapply(features.name, sub,
                              pattern="(t|f)(Body|Gravity|Gyro)(.*)-(mean|std)\\(\\)-([XYZ])",
                              replacement="\\1_\\4_\\2_\\3_\\5"))
features.name <- as.character(sapply(features.name, sub,
                              pattern="(t|f)(Body|Gravity|Gyro)(.*)-(mean|std)\\(\\)",
                              replacement="\\1_\\4_\\2_\\3"))
```

The second part of this step consist to read names for activities. Later,
numbers will be replaced by these names:

```R
activityName <- read.table("UCI HAR Dataset/activity_labels.txt")
```

### Selecting columns by position

`read.table` function accepts a parameter called `colClasses` to indicate the
class of each column. It is possible to indicate `"NULL"` to skip columns and
`NA` (the default) to automatically use `type.convert`. With this, the vector
to read selected columns only is:

```R
columnSelection <- rep("NULL", 561)
columnSelection[features.idx] = NA
```

<br>
## Reading data

Now it's time to read `X_test` and `X_train` to create `X_data`.


### X_test

Few steps are needed to create `X_test`

   1. Read data columns
   2. Assign descriptive names to columns
   3. Read `subject` and `activity` factors
   4. Add them to `X_test`

In `R` language:

```R
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
```

### X_train

This is the same as for `X_test`:

```R
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
```


<br>
## Putting it all together

### Merging data.frames

The final data set `X_data` is the union of both data sets:

```R
X_data <- rbind(X_test, X_train)
```

### Writing tidy data set

The second data set must contain the average of each variable for each
subject and each activity. `X_avg` is then computed as an *aggregation* of
the variables selected in `X_data`:

```R
X_avg <- aggregate(X_data[ , 1:66],
                   by=list(X_data$subject, X_data$activity),
                   FUN=mean)
colnames(X_avg)[1:2] <- c("subject", "activity")
```

Finally, write and attach the data set obtained:

```R
write.table(X_avg, file="X_avg.txt", row.names=FALSE)
```

---

The original data set is copyright of its authors:
> *Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.*
> **Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.**
> International Workshop of Ambient Assisted Living (IWAAL 2012).
> Vitoria-Gasteiz, Spain. Dec 2012


<!--
Local Variables:
mode: markdown
mode: flyspell
End:
-->
