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
#grepl("mean|std",names(testdata_raw))
test_stripped <- testdata_raw[,grepl("mean|std",names(testdata_raw))]
testdata_subject = read.table(file="./subject_test.txt",header=FALSE)
testlabels = read.table(file="./y_test.txt",header=FALSE)

# read the traindata stuff
traindata_raw = read.table(file="./X_train.txt",sep="",header=FALSE,col.names=v_features)
# extract the *mean* and *std* columns
#grepl("mean|std",names(traindata_raw))
train_stripped <- traindata_raw[,grepl("mean|std",names(traindata_raw))]
traindata_subject = read.table(file="./subject_train.txt",header=FALSE)
trainlabels = read.table(file="./y_train.txt",header=FALSE)

# 'concat' the test and train data sets into one data frame
test_merge <- cbind(test_stripped,testdata_subject)
colnames(test_merge)[80] <- 'subject'
testdata_merged <- cbind(test_merge,testlabels)
colnames(testdata_merged)[81] <- 'label'
train_merge <- cbind(train_stripped,traindata_subject)
colnames(train_merge)[80] <- 'subject'
traindata_merged <- cbind(train_merge,trainlabels)
colnames(traindata_merged)[81] <- 'label'

data <- rbind(testdata_merged,traindata_merged)
# replace the activity label ids with corresponding activity names
data$label <- activity_labels$V2[match(data$label,activity_labels$V1)]

meltedLabelData <- melt(data,id=c("label"))
labelMeans <- dcast(meltedLabelData, label ~ variable, mean)

write.table(labelMeans, file="./tidyData.txt", sep=",", col.names=colnames(labelMeans))