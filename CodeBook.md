Variables
1. datapath = File path for all downloaded files for project
2. filelist = This variable is having list of all files
3. x_train, y_train, x_test, y_test, subject_train and subject_test = the data from the downloaded files.
4. x_data, y_data, subject_data, traindata, testdata and alldata merged dataset for analysis in next steps.
5. mean_and_std_features, a numeric vector used to extract the desired data
6. activityLabels, features variable for files downloaded.
7. Finally, averages_data contains the relevant averages which will be later stored in a .txt file. ddply() from the plyr package is used to apply colMeans() and ease the development.

Script Run steps
The script run_analysis.Rperforms below steps

1. Setting base directory to where to store downloaded data.
2. Down load file and store in coursera3data folder. If folder does not exists then create it.
3. Unzip downloaded data file
4. Set the file path and get list of files.
5. Merge the training and test sets to create one data set using rbind()
6. Columns with the mean and standard deviation measures are taken from the whole dataset. 
After extracting these columns, they are given the correct names, taken from features.txt.
7. Labels taken from "activity_labels.txt"
8. Added descriptive names to merged data set.
9. Created new dataset using ddly to it's average data values. Dataset saved into "averages_data.txt" as tidy data.

