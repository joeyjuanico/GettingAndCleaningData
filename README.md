#Getting and Cleaning Data
This is a repository of the projects for Getting and Cleaning Data
#Course Project
The run_analysis.R script should be saved in the working directory. 
This script will download the file from the given url and then unzip it. 
The downloaded and unzipped file can be found in the rawdata folder within your working directory.

fileurl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipname <- "./data/getdata-projectfiles-UCI HAR Dataset.zip"

This script then outputs the following result into your working directory.
1.) refineddata.txt
2.) refineddata_average.txt

