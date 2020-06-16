##Process
This code contains a script that access zip folder from the URL and then cleans
it as as per the standards.
Since i ran the script multiple times to check that everyinth is order i realized
i had to write some chunk of code that checks if the value exists and doesn't unzip
or reread the files.
I've changed the name of the zip folder to Coursera3 because it easier to remember
To begin understanding the data we'll follow the README from the zipped folder and tried to make
sense of the features and variables.
README mentions that features.txt has all the features, so i read features.txt
and stored it.
Training sets(X_train) was imported to see their relationship with other values
It became clear that train_y is just the column:activity, so we'll change that
by writing a quick function for that
Then i imported the subject table to Get subject information for this table
Changed the variables to something more understandable
Removed the duplicate file
Finally we can create a proper "train" data frame by column binding the above columns
and naming them as per the feature value
Now we'll extract the required column values from the data frame
The same process was repeated for the Test data
They were both finally merged
then sorted by id (to make them tidy)
simplified and summarised as per the question and finally stored in the variable
finaldata

##variables used:
        features : data frame of rows = 561 columns = 2
                Had the feature name for the data
        filename: character of length 1
                Had the name of the downloaded file
        final: dataframe[10299 x 81]
                Had the final merged data unsummarised
        finalresult: dataframe [180 x 81]
                Had the final result
        nam: character vector of [1:563]
                Had tha values of all the variable names of the table including id and activity.
        subjectid:dataframe [1x1] 
                had the id for train_x
        test: dataframe [2947 x 81]
                final matrix of test data
        test_x: dataframe [2947x561]
                imported table for data in test
        test_y: dataframe [2947 x 2]
                imported table for activity in test
        test_subject: dataframe [2947 x 1] 
                imported table for subject id in test 
        train: dataframe[7352 x 81]
                final table for train
        train_x:dataframe [7352 x 561] 
                imported table for data in train
        train_y:dataframe[7352 x 2]
                imported table for activity in train
        val: logical vector
        had the values of the final table's column name hich match the required vales by the question
