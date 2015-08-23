---
title: "Summarized Smartphone Movement Data"
author: "Jeffrey Dettmann"
date: "August 23, 2015"
---

The code available in this repository creates a data frame with each row representing the mean and average values of all data available in the UCI Human Activity Recognition Using Smartphones Data Set for every user-activity combination.

## Instructions
To generate a data frame of summarized smartphone movement data, follow the instructions below.

1. Clone this repository into a directory we will henceforth refer to as "the working directory".
2. Download the zip archive of the aforementioned data set and accompanying documentation from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
3. Unzip this archive into the working directory.
4. In R, set the R working directory to the working directory.
5. Execute the code in run\_analysis.R. This code will create a data frame with the name "tidy\_data" as well as create a file with this data in the working directory with the name "tidy_data.txt".

Note: In subsequent sessions, you will not need to run the code, but you can simply load the tidy data by running `tidy_data <- read.table("tidy.txt")`.

## What the code does
_Note: all files referred to in this section are files found within the working directory._

First, using the variable names available in features.txt, the code creates more "R appropriate" names for column headers  for variables related to mean and standard deviation (for example, changing "tBodyAcc-mean()-X" to "mean\_tBodyAcc\_X"), while flagging other variables as unimportant

The code creates two data frames from the test and training data (test/X_test.txt and train/X_train.txt, respectively) using the column headers from the first step.

The code draws the subject identity numbers from test/subject\_test.txt and train/subject\_train.txt. These are added as variables to their respective data frames.

The code draws the human-readable list of activities from activity\_labels.txt in the working directory. It uses this list of activities to turn the numbers available in both test/y\_test.txt and train/y_train.txt into factors, which are then added as variables to their respective data frames.

The code then merges the two data frames into a single frame.

Finally, the code finds the means of the variables related to mean and standard error grouped by subject and activity and creates a data frame with this information.