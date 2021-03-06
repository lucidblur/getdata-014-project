# How this script works
+ The UCI HAR Dataset is downloaded and extracted using **getData** (optional, uncomment line 75 to do this)

1. The train and test datasets are loaded, labeled, and merged together in the **loadData** function.
  1. Variable labels are loaded into a _labels_ variable from the features.txt file.
  2. Activity labels are loaded into the _activities_ variable from the activity\_labels.txt file, the variable is saved so it can be accessed outside of **loadData**.
  3. Both the test and train data are loaded using the **prepData** function.
    1. Data, Activities, and Subjects are loaded from the X\_train/test.txt, y\_train/test.txt, and subject\_train/test.txt files, respectively.
    2. Labels are applied to the Data fields using the _labels_ variable.
    3. All three dataframes are combined using cbind.
  4. The test and train dataframes are merged using rbind.
2. The data is narrowed to include only the subject, activity, and mean and standard deviation fields by subsetting to a general expression in **narrowData**.
3. Descriptive activity names are applied in **applyActivity** by factoring _data$activity_ with labels from the _activities_ variable created in 1.ii. (data$subject is also factored).
4. Descriptive variable names were applied to the data in step 1.iii.b.
5. Data is narrowed to the average of each variable grouped by activity and subject in **createTidy** by applying group\_by and summarise\_each to the data. The results are written to result.txt.
