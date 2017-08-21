Raw data is: the data set contained here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It's a collection of data from accelerometers on 30 subjects engaging in 6 different activities in two sets, a training set and a test set. 
The goal was create a tidy data set of the standard deviation and mean data, broken down by average value for each subject per activity.

Codebook: The training sets and test sets are built and variables labeled according to the features.txt file in the data.  The activities
are named "activityCode" and the subjects "subjectID."  One large data set in built by combining the training and test data sets.  A 
data set is then built of only the standard deviation and mean data.  A variable for acitivity descriptions is added "activityLabels" whose
values are taken from the activity_labels.txt file.  Finally a table is created with the average value per subject and activityLabel which
is written as a table to "tidy_accel.txt"

