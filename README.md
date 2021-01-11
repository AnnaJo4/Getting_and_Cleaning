=========
Getting and Cleaning Data
Tidying the data for accelerometers from the Samsung Galaxy S smartphone
=========

For the Getting and Cleaning Data course, a dataset is cleaned.

The data is from this publication: 
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

30 volunteers performing six activities wearing a smartphone on the waist.
The data of 70% of the volunteers make up training data and 30% test data. 
For each record it is provided in the raw data:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

=====================================


We use the 561 vectors, for test and training set, which have a label for subject and activity. The goal of this script is to combine selected measurement values into one set with average values of the measurements per subject and activity. Descriptive labels of the columns and activities are given.

====================================

The folder with unzipped data should be in the working directory.
The run_analysis.R script does the following:

#1 Merges the training and the test sets to create one data set.
X_train and X_test are 7352 and 2946 observations resp., with 561 variables, these are 561 features (time and frequency data) described in features.txt y_test, y_train, subject_train and subject_test are labels for each observation of the X-data.

Combining them using bind (dplyr), gives large dataset with first column subject, second column y, and remainder of the columns X (observation data), subsequently test_data and train_data are combined.

#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
We are interested only in values describing mean and std, descriptions are found in features.txt By using grep, the indices of columns containing std or mean are found and then subset into run_data.
run_data is now a datafame containing observations of mean and std, from both train and test datasets.

#3 Uses descriptive activity names to name the activities in the data set
'activity' is in second column (y) with a number 1 to 6.
Descriptive activity names are found in activity_labels.txt. The second column used as indices for selecting the label of the activity.

#4 Appropriately labels the data set with descriptive variable names.
The columns names of run_data are called V1 ...to  V552, they are changed into the  tidied names of the measured variables as was given in features.txt

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Finally, this dataset is grouped by subject and activity, and then average is calculated for each of these combinations, and saved as tidy_run_data

The resulting datasets were saved as txt file.