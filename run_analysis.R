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




#Create txt-file
write.table(df_summary, file="tidy_data_step5.txt", row.name=FALSE)