Course Project (Getting&Cleaning Data @Coursera)
================================================

The working directory contains the file 'run_analysis.R' and all the required data files for the test set, the training set as well as the subjects and activity_labels, each in a seperate .txt file.
The .txt files needs to be in the same folder as the .R script to be imported successfully.
The output of the script run_analysis.R is the cleaned, tidy data set in the output file 
 
The script 'run_analysis.R' performs the following actions on the underlying data sets:

## Read in the features (to set them as col.names afterwards) and the activity_labels (to replace the id with the corresponding name for that column values)
## Extract just the columns containing "mean" or "std" in the column name for each dataframe (training and test)
## Concatenate the training-, and test-datasets based on the available raw .txt data files. Add the subject (file subject*.txt) and the activity_label (file y_*.txt) to the training-, and test-dataset and set their columnname accordingly.
## Combine the two data sets (training and test data frames) into one
## Replace the activity label ids with corresponding activity names
## Perform the shaping of the data to form the desired output 
## Write the tidy data to the output file 'tidyData.csv'

