## HumanActivity Data
##

## Read features and activity names from files
features <- read.table('UCI HAR Dataset/features.txt')
ac_labels <- read.table('UCI HAR Dataset/activity_labels.txt')

## Merge train and test measurements in a single table
X <- rbind(read.table('UCI HAR Dataset/train/X_train.txt'), read.table('UCI HAR Dataset/test/X_test.txt'))

## Merge train and test activities, preserving order to match measurements X files
Y <- rbind(read.table('UCI HAR Dataset/train/Y_train.txt'), read.table('UCI HAR Dataset/test/Y_test.txt'))
## Replace activity codes with their meaningful names and select just
## the column with meaningful names
Y_m <- mutate(Y, Activity = ac_labels[V1,2])
Y_m <- subset(Y_m, select=c("Activity"))

## Merge train and test subjects, preserving order to match measurements X files
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

# Summarise mean of all measurements by Subject and Activity
sum <- summarise_each(group_by(X_s, Subject, Activity),funs(mean))

# Write to file
write.table(sum,file='UCI HAR Dataset/CourseProjectTidy.txt',row.names=FALSE)
