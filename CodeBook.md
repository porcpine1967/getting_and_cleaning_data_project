---
title: "Summarized Smartphone Movement Data Code Book"
author: "Jeffrey Dettmann"
date: "August 23, 2015"
output: html_document
---

The data used in this project was published by UCI and measures various human activities with a smartphone worn at the user's waist. Details on the actual variables measured are in the last section of this document. The code in this project produces a data frame with data derived from this [source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

There are six movement types measured: WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING. A video of a subject making these movements is [available on youtube](http://www.youtube.com/watch?v=XOEN9W05_4A). In the data frame produced by this project, the activity is available as a factor variable named "activity"

Thirty people participated in the study and are identified only by number. The participant is identified in the derived data frame by the variable named "subject".

The variables in the derived data frame are the averages of the means and standard deviations of the various measurements listed below grouped by subject and activity. For example, the original data set includes a number measurements of each subject sitting, and in sitting one measurement is body acceleration. In the source data, a single instance of a subect sitting includes the mean and standard deviation of the body acceleration (in each coordinate plane) of the subject. There are a number of such means and standard deviations for each subject (and activity), and the data in the derived data frame will be the average of such data points grouped by subject and activity.

The naming template for these variables is as follows:
* For variables without an x, y, or z component: average\_of\_(mean|std)\__variable_. For example: "average\_of\_mean_tBodyAccJerkMag"
* For variables with an x, y, or z component: average\_of\_(mean|std)\__variable_\_(X|Y|Z). For example: "average\_of\_std_tBodyAcc_X"

## UCI Documentation on the actual variables
> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
> 
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
> 
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
> 
> These signals were used to estimate variables of the feature vector for each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
> 
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

From features.txt in the documentation included in the [UCI Data Set Zip File](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)