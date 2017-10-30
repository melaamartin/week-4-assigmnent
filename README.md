# week-4-assigmnent
Fetting and cleaning data week week 4 programming assignment

##NOTE: In first step, User must set path in their local directory to execute this code

Major steps in script and justification: 

1. Script will access url, download and open zip file, then read in only files of relevance for this assignment(pre-determined from assignment, README.txt in zip file, inspecting individual files:[3] features.txt, [14:16] subject_test.txt, X_test.txt, y_test.txt, [26:28] subject_train.txt, X_train.txt, y_train.txt

2. The script will then merge loaded files, extract only mean and sd measures (columns). I did not including gravityMean or meanFreq, assuming from assignment that we want just mean with corresponding st dev

3. Activity and variable names are changed to be more descriptive and user friendly. The variable names are largely left as written in features.txt, as these are descriptive and can be easily matched to the data source text files and descriptions. 
Since they could be more user friendly though, the script changes names to get rid of '()' and '-' characters. 

4. The final data frame constructed from this script consists of an aggregated dataset of mean measures for all variables by subject and activity. The final steps will write a table to specified path and read back in to R to view (Rstudio). 

Final note: the final dataset is in wide form, because it is easier to describe functions between variables (columns) than between rows (Wickham 2010). Given descriptions of data in downloaded fileset, in any future analysis the different measurement variables (including x,y,z dimensions) would likely be functionally combined, compared, or correlated. 

