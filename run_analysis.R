
setwd("~/Documents/annajo/coursera/data_science_JH/3_Getting_and_Cleaning_data/wk4_ass/wk4_runanalysis")
library(dplyr) #using dplyr

# loading data into R
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

#str(X_train)

# Combining into one dataset with dplyr bind_cols: first column = subject, second column = y, the remainder is X
test_data <- bind_cols(subject_test,y_test,X_test)
train_data <- bind_cols(subject_train,y_train,X_train)
run_data <- bind_rows(test_data,train_data)

# Let's remove the large temporary datafiles, now that we have one large dataset
rm(subject_test,subject_train, y_test, y_train, X_test, X_train, test_data, train_data)

#find std and mean in features.txt
features <- read.table("UCI HAR Dataset/features.txt")
idx <- grepl("std", features[,2])|grepl("mean", features[,2]) 
run_idx <- c(TRUE, TRUE, idx) # add first two columns
run_data <- run_data[run_idx]

# activities are in second column denoted by number 1 to 6, while descriptions are in activity_labels.txt
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
# the value of the second column of run_data corresponds to the indices of the activity_labels
# change the whole second column V1...2 to the value in second column of activity_labels for given index 
run_data$V1...2 <- activity_labels$V2[run_data$V1...2]

#columns names are cryptically called V1...1 to V552, fortunately, features contains more descriptive labels
indices <- as.numeric(sub("V", "",names(run_data))) # we are interested only in the number as an index to features
# now find corresponding variable name from features second column
columnnames <- features$V2[indices]
columnnames[3] <- features$V2[1] # first column from X has gotten a different format

# the column names need some cleaning up
columnnames <- gsub("^t","time.", columnnames)
columnnames <- gsub("^f","freq.", columnnames)
columnnames <- gsub("[()]","",columnnames)
columnnames <- gsub("[-]",".", columnnames)

# fix the first two column names
columnnames[1] <- "Subject"
columnnames[2] <- "Activity"

# now set the column names to the rundata
colnames(run_data) <- columnnames
# names(run_data) # to check names
View(run_data)  # to view the data
#save(run_data, file = "run_data.Rdata")  # to save the data as R object
#write.table(run_data, file = "run_data.txt", row.name=FALSE)

# create a new dataset with average of measurements for each subject and activity , giving 180 groups
tidy_run_data <- group_by(run_data, Subject, Activity)
tidy_run_data <- summarize(tidy_run_data,across(everything(), list(mean)))

# columns names need some clean up, to remove _1 at end of the column name
colnames(tidy_run_data) <- gsub("(_1)$","", names(tidy_run_data))
View(tidy_run_data)

#save(tidy_run_data, file = "tidy_run_data.Rdata")  # to save the data                           
#write.table(tidy_run_data, file = "tidy_run_data.txt", row.name=FALSE)
