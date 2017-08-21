# Create a tidy data of acceleromter data

#Get variables 
features <- read.table("./UCI HAR Dataset/features.txt")
#Ensure no duplicates
variables <- paste0(features$V1,"_",features$V2)

## Build the train data
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_train <- rename(subject_train, subjectID = "V1")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_train <- rename(y_train, activityCode = "V1")
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
names(x_train) <- variables
train <- cbind(subject_train,y_train,x_train)

## Build the test data
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_test <- rename(subject_test, subjectID = "V1")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_test <- rename(y_test, activityCode = "V1")
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
names(x_test) <- variables
test <- cbind(subject_test,y_test,x_test)

#Combine into one table
all_data <- rbind(test,train)

## Get all std and mean variables
mean_and_std_data <- cbind(select(all_data,subjectID, activityCode, contains("std", ignore.case = F)),select(all_data,contains("mean", ignore.case = F)))

#Get Activity Labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
labeled_mean_and_std_data <- merge(activityLabels, mean_and_std_data, by.x = "V1", by.y="activityCode")
labeled_mean_and_std_data <- rename(labeled_mean_and_std_data, activityCode="V1",activityLabel="V2")

##Clean up names to remove "_" for clarity
secondElement <- function(x) {x[2]}
clean_names <- sapply(strsplit(names(labeled_mean_and_std_data),"_"), secondElement)
## Maintain the activityCode, activityLabel and subjectID
clean_names[1]=names(labeled_mean_and_std_data)[1]
clean_names[2]=names(labeled_mean_and_std_data)[2]
clean_names[3]=names(labeled_mean_and_std_data)[3]
names(labeled_mean_and_std_data) <- clean_names

#Create tidy data set of mean data for each subject and activity
grouped <- group_by(labeled_mean_and_std_data, subjectID, activityLabel)
sum_table <- grouped %>% summarize_at(vars(`tBodyAcc-std()-X`:`fBodyBodyGyroJerkMag-meanFreq()`), mean, na.rm=T)

write.table(sum_table,"tidy_accell.txt")

View(sum_table)
