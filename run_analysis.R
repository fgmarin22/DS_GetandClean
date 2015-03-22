## HumanActivity Data
##

## Read features and activity names from files
features <- read.table('UCI HAR Dataset/features.txt')
ac_labels <- read.table('UCI HAR Dataset/activity_labels.txt')

## Merge train and test measurements in a single table
X <- rbind(read.table('UCI HAR Dataset/train/X_train.txt'), read.table('UCI HAR Dataset/test/X_test.txt'))

## Merge train and test Activities, preserving order to match measurements X files
Y <- rbind(read.table('UCI HAR Dataset/train/Y_train.txt'), read.table('UCI HAR Dataset/test/Y_test.txt'))
## Replace activity codes with their meaningful names and select just
## the column with meaningful names
Y_m <- mutate(Y, Activity = ac_labels[V1,2])
Y_m <- subset(Y_m, select=c("Activity"))

## Merge train and test Subjects, preserving order to match measurements X files
S <- rbind(read.table('UCI HAR Dataset/train/subject_train.txt'), read.table('UCI HAR Dataset/test/subject_test.txt'))
colnames(S) <- c('Subject')

## Select feature names of type mean - 'mean()' - or standard deviation - 'std()' - from the features table
colm <- sort(c(grep('mean()', features[,2], fixed = TRUE), grep('std()', features[,2], fixed = TRUE)))
## Select from X the columns that correspond to measurements of mean or standard deviation
X_s <- select(X, colm)

# Obtain descriptive variable names from feature names, supress parenthesis,
# and add them to the table as column titles
f <- lapply(features[,2], function(x) {gsub("()","",x, fixed=TRUE)})[colm]
colnames(X_s) <- f

# Bind together Subject, Activity and measurements in a single data frame
X_s <- cbind(S, Y_m, X_s)
# Check if any measurement is NA
sum(is.na(X_s))

# Option 1 - Wide format using dplyr library: Summarise mean of all measurements by Subject and Activity
# This option goes slower
# Uncomment the following two lines if you choose option 1
library(dplyr)
sum <- summarise_each(group_by(X_s, Subject, Activity),funs(mean))

# Option 2- Long format using reshape2 library: Summarise mean of all measurements by Subject and Activity
# This option goes slower
# Uncomment the following four lines if you choose option 2
#library(reshape2)
#X_Melt <- melt(X_s,id=c("Subject","Activity"))
#sum <- dcast(X_Melt, Subject + Activity + variable ~., mean)
#colnames(sum)[3:4] <- c("Measurement", "Value")

# Write to file
write.table(sum,file='UCI HAR Dataset/CourseProjectTidy.txt',row.names=FALSE)
