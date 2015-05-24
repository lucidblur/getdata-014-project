# getdata-014-project
The run_analysis.R script should run in a working directory that contains the "UCI HAR Dataset" directory.
If the data isn't present, uncomment line 75 before running to download and extract the data.

Running the script will complete the requirements of the assignment\:
1. Merging the datasets is handled with the **loadData** function.
2. Extracting only means and standard deviations is handled by the **narrowData** function.
3. Descriptive activity names are applied with the **applyActivity** function.
4. Descriptive variable names are attached inside of the **loadData** function.
5. Creating the output dataset of the means of the variables grouped by subject and activity and writing it to a file named results.txt is done in the **createTidy** function.
