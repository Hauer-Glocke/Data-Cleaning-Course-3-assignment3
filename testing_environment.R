#Clear Working Environment
rm(list=ls())
cat("\f")

#Loading necessary libraries
library(readr)
library(dplyr)

#Reading data, adjust classes and clear environment
loc <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(loc,temp)

###NEW###
con <- unz(temp, "UCI HAR Dataset/features.txt")
cur <- read.table(con, sep="")
features_list <- as.vector(cur[,2]) ##Size=561


####STOP NEW####

####Loading and manipulating the signal vectors for the test data

con <- unz(temp, "UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
total_acc_x_test <- read.table(con, sep="")

con <- unz(temp, "UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
total_acc_y_test <- read.table(con, sep="")

con <- unz(temp, "UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")
total_acc_z_test <- read.table(con, sep="")

con <- unz(temp, "UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
body_acc_x_test <- read.table(con, sep="")

con <- unz(temp, "UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
body_acc_y_test <- read.table(con, sep="")

con <- unz(temp, "UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
body_acc_z_test <- read.table(con, sep="")

con <- unz(temp, "UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_x_test <- read.table(con, sep="")

con <- unz(temp, "UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_y_test <- read.table(con, sep="")

con <- unz(temp, "UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
body_gyro_z_test <- read.table(con, sep="")

#Creating List of vectors out of Matrices
x <- matrix(1:10,ncol=2)
z  <- as.list(split(x, rep(1:nrow(x), each = ncol(x)))); z
y <- as.list(tapply(x,rep(1:nrow(x),each=ncol(x)),function(i)i)); w
w <- as.list(lapply(seq_len(nrow(x)), function(i) x[i,])); w 

##other old stuff
con <- unz(temp, "UCI HAR Dataset/test/X_test.txt")
test_df <- read_delim(con, 
                col_names=FALSE,
                delim=" ")

con <- unz(temp, "UCI HAR Dataset/test/y_test.txt")
test_df_activity <- read_delim(con,
                col_names=FALSE,
                delim=" ")
con <- unz(temp, "UCI HAR Dataset/train/y_train.txt")
train_df_activity <- read_delim(con,
                               col_names=FALSE,
                               delim=" ")
con <- unz(temp, "UCI HAR Dataset/activity_labels.txt")
activity_labels <- read_delim(con,
                                col_names=FALSE,
                                delim=" ")

con <- unz(temp, "UCI HAR Dataset/test/subject_test.txt")
test_df_subjects <- read.table(con, sep="")

#Creation of the Activity Labels for the test and train data
#Inclusion of step 3
con <- unz(temp, "UCI HAR Dataset/activity_labels.txt")
activity_labels <- read.table(con, sep="")

con <- unz(temp, "UCI HAR Dataset/test/y_test.txt")
cur <- read.table(con, sep="")
test_df_activity <- activity_labels[cur$V1,]
test_df_activity <- as.data.frame(test_df_activity[,2])
names(test_df_activity) <- "activities"

con <- unz(temp, "UCI HAR Dataset/train/y_train.txt")
cur <- read.table(con, sep="")
train_df_activity <- activity_labels[cur$V1,]
train_df_activity <- as.data.frame(train_df_activity[,2])
names(train_df_activity) <- "activities"

df_activity <- rbind(test_df_activity,train_df_activity)

rm(cur, test_df_activity, train_df_activity, activity_labels)

#Load the subject identifier
con <- unz(temp, "UCI HAR Dataset/test/subject_test.txt")
test_df_subjects <- read.table(con, sep="")
names(test_df_subjects) <- "subject"

con <- unz(temp, "UCI HAR Dataset/train/subject_train.txt")
train_df_subjects <- read.table(con, sep="")
names(train_df_subjects) <- "subject"

df_subjects <- rbind(test_df_subjects, train_df_subjects)

rm(test_df_subjects, train_df_subjects)

#Load the data files, including step 2
con <- unz(temp, "UCI HAR Dataset/test/X_test.txt")
test_df_data <- read.table(con, sep="")

con <- unz(temp, "UCI HAR Dataset/train/X_train.txt")
train_df_data <- read.table(con, sep="")

df_data <- rbind(test_df_data,train_df_data)
df_data$mean <- apply(df_data,
                      1, function(x) { mean(x, na.rm=TRUE) })
df_data$sd <- apply(df_data,
                    1, function(x) { sd(x, na.rm=TRUE) })

rm(test_df_data,train_df_data)

#Create complete dataframe - Step 1 and 4
df <- cbind(df_subjects, df_activity, df_data$mean, df_data$sd)
names(df)[3:4] <- c("mean", "sd")

#Create Summary Dataset - Step 5
df_summary <- df %>%
        select(1:3) %>%
        group_by(subject,activities) %>%
        summarize(avrg=mean(mean))

#Finish the tasks
unlink(temp)
rm(con, loc, temp)
