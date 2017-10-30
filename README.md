# week-4-assigmnent
Fetting and cleaning data week week 4 programming assignment

##NOTE: In first step, User must set path in their local directory to execute this code

Code will access url, download and open zip file, then read in only files of relevance for this assignment.The script will then merge loaded files, extract only mean and sd measures (columns). Activity and variable names are changed to be more descriptive and user friendly.The variable names are largely left as written in features.txt, as these are descriptive and can be easily matched to the data source text files and descriptions. Since they could be more user friendly though, the script changes names to get rid of '()' and '-' characters. The final data frame constructed from this script consists of an aggregated dataset of mean measures for all variables by subject and activity. The final steps will write a table to specified path and read back in to R to view (Rstudio). 

