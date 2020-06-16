##This code contains a script that access zip folder from the URL and then tidy
## it as as per the standards.
filename <- "Coursera3.zip"

## Checking if archieve already exists.
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, destfile = filename)
}  

## Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

##I've changed the name of the zip folder to Coursera3 because it easier to remember

        ##README mentions that features.txt has all the features
        features <- read.table("UCI HAR Dataset/features.txt")
        ##Getting the data
        train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
        train_y <- read.table("UCI HAR Dataset/train/Y_train.txt")
        ## it is clear train_y is just the column:activity, so we'll change that
        ## writing a quick function for that
        change<- function(train_y){
                ## mapping activity names to a vector (could have done by importing the text file
                ## but since there are only six items this is also fine)
                mat <-c("walking","walkingup","walkingdown","sitting","standing","laying")
                vect <- c()
                for(i in 1:nrow(train_y)){
                        vect[i] <-mat[[train_y[[1]][[i]]]]
                } 
                train_y <- cbind(train_y,vect)
                train_y
        }
        train_y <- change(train_y)


        ## Get subject information for this table
        train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
        
        ##Changing variables to something more understandable
        subjectid <- train_subject
        ##removing duplicates
        rm(train_subject)

        ## let's create one good train data frame
        ##bind it all together
        train <- cbind(subjectid$V1,train_y$vect,train_x) 
        ##extract name from features
        nam <- features$V2
        nam<-c("id","activity",nam)
        colnames(train) <- nam
        ## only required values
                ##finding names that have mean or std values
                val <- grepl("id|activity|*mean*|*std*",nam)
                ##getting the right values
                train <- train[ ,val]
        
        ## let's get value for test subjects
        test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
        test_Y <- read.table("UCI HAR Dataset/test/Y_test.txt")
        ##need to change test_y variables
        test_Y <- change(test_Y)
        test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
        ## creating one test table
        test <- cbind(test_subject$V1,test_Y$vect,test_x)
        colnames(test) <- nam
        ## only required values
                test <- test[ ,val]
        ## merging them both
        final <- rbind(test,train)
        ##sorting by id
        final <- final[order(final$id), ]
        finalresult <- final %>%
                group_by(id, activity) %>%
                summarise_all(list(mean = mean))
        
        write.table(finalresult,"final.txt")

        