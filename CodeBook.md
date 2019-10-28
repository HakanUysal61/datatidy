# This document is to explain how "run_analysis" R script works.
# This script developed on R3.6.1.
# This script is developed as part of "Getting and Cleaning Data" JHU course by Coursera as Course Project.
# Written by Hakan Uysal.
# Human Activity Recognition Using Smart Phones Data Set is used the link is below.

# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This data to be loaded to local directory under working directory 
# Working directory can be changed by changing 1st line of the code 
# setwd("C:/Users/ENKHUY/Documents/TRAINING/R/DataTidy")
# It is assumed that unzipped files are put to Q directory on the working directory. If this needs to be changed line 21-22 of code should be changed.
# x_train <-read.table("Q/train/X_train.txt",quote = "\"",stringsAsFactors =FALSE)
# x_test <-read.table("Q/test/X_test.txt",quote = "\"",stringsAsFactors =FALSE)

# Data Set includes test and training data.
# 561 different features are observed for 2.947 test and 7.352 training cases.
# 30 different subjects are used for the test.
# 6 different activity (WALKING,WALKING_UPSTAIRS,WALIKNG_DOWNSTAIRS,SITING,STANDING and LAYING.

# Meanings of variable names in the script

# correctname	: A function that makes all characters string and reduces ()-_., characters and spaces from the string
# x_train     	: training data
# x_test      	: test data
# x_full	: merged data for test and training
# y_test	: test activity code
# y_train	: training activity codes
# features	: feature names
# subject_train : subjects for training observations
# subject_test	: subjects for test observations
# subject_full  : merged subject data for training and test
# full_data     : merged of subject_full,x_full and y_full
# means		: only mean results  from full_data
# std		: only std results from full_data
# mean_std	: merged of means and std
# tidy 		: subject and activity added to mean_std and NA values omitted grouped by subject,activity


# 1st working directory and related libraries loaded.
# A function to remove "()-_." (correctname) is defined.
# Training and test data has been read from test and training directories (X_train.txt and X_test.txt)
# Test and trainin data is merged
# feature names read and added from "features.txt"
# Subject information is added.
# Activity labels are read from (activity_labels.txt) and added to Y.
# Column names are corrected as "subject" and "activity"
# Subject and merged test-training x,y data is merged
# correctnames function is applied to make names lower case and no symbols
# feature names are changed with more meaningfull names
# means data is selected from this final data set using contains function
# std is selected with similar approach
# mean and std data is merged
# NA values are removed
# data written to tidy.txt as new tidy file with grouped subject,activity

