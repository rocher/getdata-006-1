# Getting and Cleaning Data

## Introduction

This is my submission for the course project.I hope you enjoy my work


### The Big Picture

First at all I'd like to start by providing a *big picture* of the data set. Of course, reading the documentation that comes with the zip file was of a big help to understand how to organize data. 

After reading the documentation and with a simple examination of the files, it's clear that all the data contained must be organized as follows:

![data scheme here](data-scheme.png)


## Getting Data

```R
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="dataset.zip", method="curl")

```


## Cleaning Data
