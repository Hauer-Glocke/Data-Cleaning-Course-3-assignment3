#Clear Working Environment
rm(list=ls())
cat("\f")

#Loading necessary libraries
library(readr)
library(dplyr)

#Loading the Dataset into a temporary folder
loc <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(loc,temp)

#Merging of test and train data and add correct names
#Step 1
con <- unz(temp, "UCI HAR Dataset/test/X_test.txt")
test_df_data <- read.table(con, sep="")

con <- unz(temp, "UCI HAR Dataset/train/X_train.txt")
train_df_data <- read.table(con, sep="")

df_data <- rbind(test_df_data,train_df_data)

con <- unz(temp, "UCI HAR Dataset/features.txt")
cur <- read.table(con, sep="")
names_df <- as.vector(cur[,2])

names(df_data) <- names_df

rm(con,cur,names_df,test_df_data,train_df_data)

#Subset on collumn names, only means and standard deviations
#Step 2
cur <- sort(c(grep("mean", names(df_data)),grep("std", names(df_data))))

df_data <- df_data[,cur]

rm(cur)

#Add Activity Labels and Subject Names (Step 3)
#Activity Labels
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

#Subject Identifier
con <- unz(temp, "UCI HAR Dataset/test/subject_test.txt")
test_df_subjects <- read.table(con, sep="")
names(test_df_subjects) <- "subject"

con <- unz(temp, "UCI HAR Dataset/train/subject_train.txt")
train_df_subjects <- read.table(con, sep="")
names(train_df_subjects) <- "subject"

df_subjects <- rbind(test_df_subjects, train_df_subjects)

rm(test_df_subjects, train_df_subjects)

#Merging data
df <- cbind(df_subjects, df_activity, df_data)

rm(df_subjects, df_activity, df_data)

#Appropriate Label Names
#Step 4
df_temp <- gsub("()","",names(df),fixed=TRUE)
df_temp <- gsub("-","_",df_temp,fixed=TRUE)
df_temp <- gsub("BodyBody","Body",df_temp,fixed=TRUE)
df_temp <- gsub("tBody","time_body_",df_temp,fixed=TRUE)
df_temp <- gsub("tGravity","time_gravity_",df_temp,fixed=TRUE)
df_temp <- gsub("fBody","freq_body_",df_temp,fixed=TRUE)
df_temp <- gsub("meanF","mean_f",df_temp,fixed=TRUE)
df_temp <- tolower(df_temp)

names(df) <- df_temp

rm(df_temp)

#Create Summary Dataset
#Step 5
df_summary <- df %>%
        group_by(subject,activities) %>%
        summarise_each(funs(mean))

#Cleaning up and Create txt-file
rm(con, loc, temp)

write.table(df_summary, file="tidy_data_step5.txt", row.name=FALSE)
