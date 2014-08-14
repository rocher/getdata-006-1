# Getting and Cleaning Data

## Introduction

This is my submission for the course project *Getting and Cleaning Data* (<tt>getdata-006</tt>). I hope you enjoy my work, the way I've constructed the data set and the `R` code provided here to make it.


### The Big Picture

First of all, I'd like to start by providing a *big picture* of the data set. Of course, reading the documentation that comes with the *zip* file is a big help to understand how to organize data.

After reading the documentation and with a simple examination of the files, it's clear that all the data contained must be organized as follows:

<center>
![data scheme here](data-scheme.png)
</center>

Each data block can be extracted from the files indicated in the figure, although more will be used during the construction process.
Please note two unamed blue columns in the figure. They correspond to a new factor variable I'll introduce later called `origin`. The purpose of this variable is to keep track of the origin of each row. Obvious possible values are `test` or `train`.


## Getting Data

### Downloading files
The very first thing to do is to download the zip file from the given URL:

```R
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="dataset.zip", method="curl")

```

### Files accomodation
I prefer to work with *unzipped* files, for both reading from `R` and taking a look at them. I prefer short directory names, too  (and without spaces):

```R
unzip("dataset.zip")
file.rename("UCI HAR Dataset", "data")
```

Now it's time to look at the documentation

## Cleaning Data
`X_test.txt` and `X_train.txt` are big files. They contain 561 variables and we only need 79 of them. It's clearly a waste of time and memory to read these two files in its whole. It's better to use the `read.table` function to skip uneeded columns. But for that, first it's important to know which are those *uneeded columns*.

The plan is:

   + read the file `features.txt`
   + select those features matching *mean* and *std*
   + create a vector of factors to select columns

### Selecting features

The `X_data` data set under construction must contain only those variables that are the *mean* and *std* (standard deviation) of other features. Fortunately, there is a file named `features.txt` containing the names of the features. These names follow a simple convetion. for example, some features related to body acceleration `BodyAcc` are named as follows:

| pefix | feature | suffix | axis    |
|:-----:|---------|--------|---------|
| t     | BodyAcc | energy | X, Y, Z |
| t     | BodyAcc | mean   | X, Y, Z |
| t     | BodyAcc | std    | X, Y, Z |
| t     | BodyAcc | sma    |         |

When `X`, `Y` and `Z` axis are present, there is a single feature for each one.

We are only interested in those 

### Fetching variable names
This step is crucial to select the columns to be read from `X_test.txt` and `X_train.txt` files.


