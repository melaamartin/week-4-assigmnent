####Read in data and upload required packages####

setwd(file_path)##set your file path
library(plyr)

##this will automatically source, download and unzip file into wd
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "samsung_data.zip")
unzip("samsung_data.zip", exdir = "samsung_data")

files <- list.files("samsung_data", full.names=TRUE, recursive=TRUE)##full.names command appends file path to file name

##files needed(pre-determined from assignment, README.txt in zip file, inspecting individual files):
#[3] features.txt, [14:16] subject_test.txt, X_test.txt, y_test.txt, [26:28] subject_train.txt, X_train.txt, y_train.txt

vars <- read.table(files[3], header=FALSE)
subtest <- read.table(files[14], header=FALSE)
xtest<-read.table(files[15], header=FALSE)
ytest<-read.table(files[16], header=FALSE)
subtrain <- read.table(files[26], header=FALSE)
xtrain<-read.table(files[27], header=FALSE)
ytrain<-read.table(files[28], header=FALSE)

#1. Merge datasets, assuming one-to-one row matching as ordered from download
# first #merge dataset categories together, preserve order (test, train), add variable names
suball <- rbind(subtest,subtrain);colnames(suball) <- c("subject")
yall <- rbind(ytest,ytrain); colnames(yall) <- c("activity")
xall <- rbind(xtest,xtrain); colnames(xall) <- vars[,2] ##apply colnames from 'vars' db (features.txt)
tidy1 <- cbind(suball,yall,xall)

#2. Extract only columns with mean or sd in them
##am not including gravityMean or meanFreq, am assuming from assignment that we want just mean with corresponding st dev
tidy1.sml <- tidy1[grep("sub|activity|std|mean()", names(tidy1), value=TRUE)]##cannot use fixed with alternate conditions
tidy1.sml <- tidy1.sml[, -grep("Freq", names(tidy1.sml))]##drop 'meanFreq()', 68 variables

##next change variable and activity names

#3. #change numeric activity label codes to activity names ('activity_labels.txt' doc), all in lower case and truncating walking_upstairs/walking_downstairs
tidy1.sml$activity <- as.factor(tidy1.sml$activity)
tidy1.sml$activity <- revalue(tidy1.sml$activity, c("1"="walking", "2"="walkingup", "3"="walkingdown", "4"="sitting", "5"="standing", "6"="laying"))

##variable names from features.txt are descriptive and match data source text files and descriptions
##but they could be more user friendly. New names get rid of '()' and '-' but retain original descriptors (see codebook)
##'Mean' and 'Sd' are capitalized to improve legibility through differntiation of distinct terms
## trying to shorten would sacrifice descriptiveness (e.g. 'fBodyBodyGyroJerkMagMean' could be something like f.bbGyroJrkMag.mean, but would still be unwieldy and add ambiguity, better to keep variable names closer to source)
names(tidy1.sml) <- gsub("-mean()-", "Mean", names(tidy1.sml), fixed=TRUE)
names(tidy1.sml) <- gsub("-std()-", "Sd", names(tidy1.sml), fixed=TRUE)
names(tidy1.sml) <- gsub("-std()", "Sd", names(tidy1.sml), fixed=TRUE)
names(tidy1.sml) <- gsub("-mean()", "Mean", names(tidy1.sml), fixed=TRUE)

##5. Create new dataset of mean of all measures by subject and activity
#Leaving dataset in wide form, because it is easier to describe functions between variables (columns) than between rows (Wickham 2010)
#given the purpose of this dataset, in future analysis different variables (including x,y,z dimensions) would likely be functionally combined, compared, or correlated

tidy2 <- aggregate(tidy1.sml[,3:68], list(subject=tidy1.sml$subject, activity=tidy1.sml$activity), mean)

write.table(tidy2,file="outputDB_C3wk4.txt", row.names=FALSE)

##view output dataset to check
data <- read.table("./outputDB_C3wk4.txt", header = TRUE) 
View(data)

##Thanks to https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
