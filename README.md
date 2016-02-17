# Clean Data Project
#### Project for Coursera course "Getting and Cleaning Data"
by Nick Stokes

This project aimed to collect and clean the "Human Activity Recognition Using 
Smartphones Dataset"  
The final output of the script is a clean dataset in which the features that 
contain the mean and standard deviation measurements are averaged for each 
subject and activity.

#Repository Files

###run_analysis.R
This script downloads, extracts and processes the dataset.  
Data from the training set and test set are combined, along with the variable 
labels. Data is then summarized and output as data_summary.txt  
  
This file is well commented to make it easy for anyone to follow the summary 
process.


###data_summary.txt
The output of run_analysis.R. This file is overwritten every time the 
run_analysis.R script is run.


###codebook.MD
This codebook contains infomation from the original dataset, along with 
additional information on the data summary. It outlines all the variables 
and processing that happens to create the data_summary.txt file.