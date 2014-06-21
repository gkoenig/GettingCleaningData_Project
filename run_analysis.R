# run_analysis.R
# 2014-06-21 by Gerd Koenig
#
library(reshape2)
# read 'common' files
features = read.table(file="./features.txt",sep="",header=FALSE)
# extract the feature names to use it for column names
v_features <- as.vector(features$V2)
activity_labels = read.table(file="./activity_labels.txt",sep="",header=FALSE)

# read the testdata stuff
testdata_raw = read.table(file="./X_test.txt",sep="",header=FALSE,col.names=v_features)
# extract the *mean* and *std* columns
testdata_stripped <- testdata_raw[,grepl("mean|std",names(testdata_raw))]
testdata_subject = read.table(file="./subject_test.txt",header=FALSE)
testlabels = read.table(file="./y_test.txt",header=FALSE)

# read the traindata stuff
traindata_raw = read.table(file="./X_train.txt",sep="",header=FALSE,col.names=v_features)
# extract the *mean* and *std* columns
traindata_stripped <- traindata_raw[,grepl("mean|std",names(traindata_raw))]
traindata_subject = read.table(file="./subject_train.txt",header=FALSE)
trainlabels = read.table(file="./y_train.txt",header=FALSE)

# 'concat' the test and train data sets into one data frame
testdata_merge1 <- cbind(testdata_stripped,testdata_subject)
colnames(testdata_merge1)[80] <- 'subject'
testdata_merge2 <- cbind(testdata_merge1,testlabels)
colnames(testdata_merge2)[81] <- 'label'
traindata_merge1 <- cbind(traindata_stripped,traindata_subject)
colnames(traindata_merge1)[80] <- 'subject'
traindata_merge2 <- cbind(traindata_merge1,trainlabels)
colnames(traindata_merge2)[81] <- 'label'

mergeddata <- rbind(testdata_merge2,traindata_merge2)
# replace the activity label ids with corresponding activity names
mergeddata$label <- activity_labels$V2[match(mergeddata$label,activity_labels$V1)]

meltedLabelData <- melt(mergeddata,id=c("label"))
labelMeans <- dcast(meltedLabelData, label ~ variable, mean)

# store tidy data in output file
write.table(labelMeans, file="./tidyData.csv", sep=",", col.names=colnames(labelMeans))