# datatidy
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

# The Definition of data set is at the below link
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Data Set includes test and training data.
# 561 different features are observed for 2.947 test and 7.352 training cases.
# 30 different subjects are used for the test.
# 6 different activity (WALKING,WALKING_UPSTAIRS,WALIKNG_DOWNSTAIRS,SITING,STANDING and LAYING.

# Meanings of variable names in the script

# correctname	: A function that makes all characters string and reduces ()-_., characters and spaces from the string
# x_train     	: training data
# x_test      	: test data
# x_full	: merged data for test and training
# features	: feature names
# subject_train : subjects for training observations
# subject_test	: subjects for test observations
# subject_full  : merged subject data for training and test
