## Project Description

This is an attempt to clean up data from activity measurements on smartphone [1], for 30 subjects (volunteers) doing 6 activities, to a dataset containing the average of all measurements of std and mean variables, for each subject and for each activity. 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Please refer to the above article and the data for information about data collection.

##Creating the tidy datafile

### create the datafile

Data is downloaded from coursera website.
Unzip to folder named "UCI HAR Dataset" in working directory.
Folder contains text files with activity_labels.txt, features.txt which will be used for renaing the data, andsome more info. The test and train contain data of the measurements:
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Inertial Signals will not be used.

The subject, X and y data is loaded into dataframes. 
X_test: 2947 obs. of  561 variables (observations of measurement data)
y_test: 2947 obs. of  1 variable (refer to activity)
subject_test: 2947 obs. of  1 variable (refer to subject (volunteer))
X_train: 7352 obs. of  561 variables (observations of measurement data)
y_train: 7352 obs. of  1 variable (refer to activity)
subject_train: 7352 obs. of  1 variable (refer to subject (volunteer))

Combined to a large dataframe run_data, which contains all observations with subject and activity label: 10299 obs. of 563 variables.


###Cleaning of the data
Refer to README.md for detailed description.
Variables with only the mean and standard deviation for each measurement are selected, resulting in 81 variables. Activity labels are changed from number to description in activity_labels.txt. Column names are derived from feature.txt, cleaned.
A second dataset is created that averages values for the selected columns, for each subject and each activity. Resulting in tidy_run_data, 180 observations of 81 variables.

##Description of the variables

### run_data
dataframe, 10299 observations, 81 variables

First two columns label Subject and Activity, the other columns give normalized value between -1 and 1 of selected time and frequency data, refer to features_info.txt

### tidy_run_data
dataframe, 180 observations, 563 variables

As run_data, first two columns label Subject and Activity, the other columns give normalized value between -1 and 1 of selected time and frequency data, refer to features_info.txt. The data is grouped by Subject (30) and Activity (6), only an average value of the measurement data is given for each, resulting in 180 observations.