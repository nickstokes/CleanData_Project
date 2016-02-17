library(data.table)
library(dplyr)
library(stringr)


# Download and unzip data files. Currently Commented out to save bandwidth. 
# Uncomment the next three lines to enable download and extraction of the dataset
# data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(data_url, destfile = "Dataset.zip")
# unzip("Dataset.zip")

# read in activity labels.
activity.labels <- fread("UCI HAR Dataset/activity_labels.txt",
                         col.names = c("activity.id","activity.name"))

# read in features column names
features <- fread("UCI HAR Dataset/features.txt",
                  col.names = c("feature.col","feature.name"))

# filter features to only those with mean() or std()
features.import <- features[grepl("mean\\(\\)|std\\(\\)",feature.name),]

# make feature names more readable
features.import[,feature.name := str_replace_all(feature.name, "\\(\\)", "")]
features.import[,feature.name := str_replace_all(feature.name, "-", ".")]

# import test set, only selecting features with mean() and std()
test.data <- fread("UCI HAR Dataset/test/X_test.txt",
                   select = features.import$feature.col,
                   col.names = features.import$feature.name)

# import test subjects
test.subjects <- fread("UCI HAR Dataset/test/subject_test.txt",
                       col.names = "subject.id")

# import test activity_ids
test.activities <- fread("UCI HAR Dataset/test/y_test.txt",
                         col.names = "activity.id")

# bind test data, activities, and subjects into one table
test.data <- cbind(test.activities, test.subjects, test.data)



# import training set, selecting only features with mean() or std()
train.data <- fread("UCI HAR Dataset/train/X_train.txt",
                   select = features.import$feature.col,
                   col.names = features.import$feature.name)

# import training subjects
train.subjects <- fread("UCI HAR Dataset/train/subject_train.txt",
                       col.names = "subject.id")

# import training activity.ids
train.activities <- fread("UCI HAR Dataset/train/y_train.txt",
                         col.names = "activity.id")

# bind test data, activities, and subjects into one table
train.data <- cbind(train.activities, train.subjects, train.data)

# combine test and training data
join.data <- rbind(test.data, train.data)

# merge the activity names
join.data <- merge(activity.labels, join.data, by="activity.id")
# group the data by activity and subject
join.data <- group_by(join.data, activity.id, activity.name, subject.id)

# get the average of all the variables for each activity and subject
tidy.data <- summarise_each(join.data, funs(mean))

write.table(tidy.data, file = "data_summary.txt", row.names = FALSE)