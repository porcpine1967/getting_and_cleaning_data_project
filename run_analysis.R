# External Libraries
library(dplyr)

# Utility Functions

# This function takes the variable names from the features.txt file
# and flags them as 'unimportant' if we are not interested in it
# or turns it instead into something that won't be transformed
# when turned into a column name.
rationalize_names <- function(feature_names) {
    # Build the empty headers vector in advance
    headers <- vector("character", length(feature_names))
    for (i in 1:length(feature_names)){
        # Do this if the name is something like tBodyAcc-mean()-X
        if (grepl("-mean\\(\\)", feature_names[i])){
            # Break the "-mean() part out (as well as a trailing hyphen, if it is there)
            split_header <- unlist(strsplit(feature_names[i], "-mean\\(\\)-?", fixed = FALSE))
            # If it does not have an axis component at the end, just make it mean_variableName
            if(length(split_header) == 1){
                headers[i] = paste("mean_", split_header[1], sep = "")
            # If it has an axis component at the end, make it mean_variableName_axis
            } else {
                headers[i] = paste("mean_", split_header[1], "_", split_header[2], sep = "")
            }
        # Do this if the name is something like tBodyAcc-std())-X
        } else if (grepl("-std\\(\\)", feature_names[i])){
            # Break the "-std() part out (as well as a trailing hyphen, if it is there)
            split_header <- unlist(strsplit(feature_names[i], "-std\\(\\)-?", fixed = FALSE))
            # If it does not have an axis component at the end, just make it std_variableName
            if(length(split_header) == 1){
                headers[i] = paste("std_", split_header[1], sep = "")
            # If it has an axis component at the end, make it std_variableName_axis
            } else {
                headers[i] = paste("std_", split_header[1], "_", split_header[2], sep = "")
            }
        } else {
            # Flag it as unimportant for later processing
            headers[i] <- paste("unimportant_", i, sep = "")
        }
    }
    headers
}

# This dynamically builds the R code that will generate the tidy data set
# Parameters
#  grouped_data_frame_name: the string that we would use to describe the grouped data frame
#                           for the summarize function
#             column_names: the column names we want in the tidy data set
build_summarize_expression <- function(grouped_data_frame_name, column_names) {
    # Build the empty vector to hold the summary functions in advance
    wrapped_column_names = vector("character", length(column_names));
    for (i in 1:length(column_names)) {
        # Assign a summary function with useful name for the subsequent variable like
        # "average_of_mean_tBodyAcc_X = mean(mean_tBodyAcc_X)"
        wrapped_column_names[i] <- paste("average_of_", column_names[i], " = mean(", column_names[i], ")", sep = '')
    }
    # Join all the summary functions by ', ', 
    # so get something like "mean(mean_tBodyAcc_X), mean(mean_tBodyAcc_Y)"
    column_arguments <- paste(wrapped_column_names, collapse = ', ')
    # get the full "summarize" expression
    paste("summarize(", grouped_data_frame_name, ", ", column_arguments, ")", sep = '')
}

## Variables used for both test and train data
# Get the variable names from the features.txt file
feature_names <- read.table("features.txt", stringsAsFactors = FALSE)[,2]
# Turn them into something pretty
column_names <- rationalize_names(feature_names)
# Get a list of the column names we are interested in for when we are ready to summarize
extractable_columns <- column_names[grep("unimportant", column_names, invert = TRUE)]

# Get the names of the activities from activity_labels.txt
activity_labels <- read.table("activity_labels.txt")[,2]

## Test data
# Get a vector of subject numbers that line up with the test data rows
test_subjects <- scan("test/subject_test.txt")
# Get a vector of activity numbers that line up with the test data rows
test_activities <- scan("test/y_test.txt")
# Turn these activities into factors so they are well labeled
test_activities_as_factor <- factor(test_activities, labels = activity_labels)
# Read in the test data
test_data <- read.table("test/X_test.txt", colClasses = "numeric", col.names = column_names)
# Add the subject numbers to the test data
test_data$subject <- test_subjects
# Add the activities to the test data
test_data$activity <- test_activities_as_factor

## Train data
# Get a vector of subject numbers that line up with the train data rows
train_subjects <- scan("train/subject_train.txt")
# Get a vector of activity numbers that line up with the train data rows
train_activities <- scan("train/y_train.txt")
# Turn these activities into factors so they are well labeled
train_activities_as_factor <- factor(train_activities, labels = activity_labels)
# Read in the train data
train_data <- read.table("train/X_train.txt", colClasses = "numeric", col.names = column_names)
# Add the subject numbers to the train data
train_data$subject <- train_subjects
# Add the activities to the train data
train_data$activity <- train_activities_as_factor

## Merged Data
# Bind the train and test data together, using the column names we already set as identical
total <- rbind(train_data, test_data)

# Generate the R code that will create the tidy data set
# By passing in the extractable_columns from above, we should get only the means and stds
dynamic_summary <- build_summarize_expression("group_by(total, subject, activity)", extractable_columns)

# Run the code that generates the tidy data set
tidy_data <- eval(parse(text = dynamic_summary))

# Write it to disk
write.table(tidy_data, "tidy.txt", row.names = FALSE)
