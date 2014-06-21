CodeBook for R script run_analysis.R
====================================

## Variables
* features : contains data of file features.txt
* v_features : vector of 2nd col. of features, thereby contains feature facts (==column names for resulting tidy data)
* activity_labels : contains data of file activity_labels.txt
* testdata_raw : contains test dataset, column names are being set by v_features
* testdata_stripped : contains just columns with name 'mean' or 'std' from testdata_raw
* testdata_subject : contains data from file subject_test.txt
* testlabels : contains the activity_labels for the test data set, gathered by file y_test.txt
* traindata_raw, traindata_stripped, traindata_subject and trainlabels : same purpose as variables test*, but related to the training data set
* testdata_merge1 : testdata_subject added to data frame 'testdata_stripped'
* testdata_merge2 : testlabels added to data frame 'testdata_merge1' (now there are all required columns in this data frame for the test data)
* traindata_merge1 : traindata_subject added to data frame 'traindata_stripped'
* traindata_merge2 : trainlabels added to data frame 'traindata_merge1' (now there are all required columns in this data frame for the training data)
* mergeddata : concatenation of traindata_merge2 and testdata_merge2 (==combine both data frames to one)
* meltedLabelData : create a long column version of mergeddata and insert column 'label'
* labelMeans : create a wide column version of meltedLabelData and calculate the mean of each measurement grouped by label

## Data processing steps
1. read the 'base' data from activity_labels.txt and features.txt to be able to extend the data sets afterwards
2. use ```read.table``` to import the training and test data sets and set the column names to the corresponding feature names accordingly using parameter col.names
3. by using ```grepl(...)``` all columns with names not including mean or std are removed from data frame *_raw
4. Each data set consists of 3 files (X_*.txt, y_*.txt and subject_*.txt) which needs to be combined to one data frame before the training- and test data set are being concatenated itself. Putting the files together is done via ```cbind``` functionality, additional columns are added to the right end of the data frame
5. The training- and test dataset are merged by using ```rbind``` to create one data frame consisting of both training and test data
6. To replace the label ID by the corresponding label name the function ```match(...)``` is used
7. The creation of the resulting tidy data is a 2-step process
  * melting the data frame to a long column version and add the column 'label'. All other columns are the so called 'variables' for casting in the next step
  * calculating the means of each measurement (==variables) grouped by 'label' by using function ```dcast```
8. writing the tidy data set to a file in the current directory by using ```write.table```
  