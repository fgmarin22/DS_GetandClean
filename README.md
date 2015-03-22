# DS_GetandClean

==================================================================
Human Activity Recognition Using Smartphones Dataset
==================================================================
Francisco Garcia-Marin
==================================================================

This analysis is based on data from experiments that were carried out with a group of
30 people (Subjects), who performed six activities (WALKING, WALKING_UPSTAIRS,
WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

The subjects were wearing a smartphone on the waist. Using its embedded accelerometer
and gyroscope, 3-axial linear acceleration and 3-axial angular velocity was captured.

The process of getting and arranging these data can be performed with the R script 
run_analysis.R, if the needed files are present at the script's directory.

Process description:

*1- Read the files that contain:

	features: Names of the data items thar were taken, in the same order as theu are in
	the data file. (features.txt)
	
	activity_labels: This file contain meaningful names for the six activities, with
	their corresponding numeric codes ranging 1-6, (activity_labels.txt)
	
*2- Read the X measurements data files corresponding to the two phases - training and test -
 and join then together by appending test at the bottom of train. (X_train.txt and
 X_test.txt)
 
*3 - Read the Y activities data files corresponding to the two phases - training and test -
 and join then together by appending test at the bottom of train. These data correspond
 row by row to the X file, so order must be preserved. Y file has numeric activity 
 codes, so be build a corresponding Y_m table with meaningful names for the activities. 
 "Activity" header text is added.
 (Y_train.txt and Y_test.txt)
 
*4- Read the Subjects data files corresponding to the two phases - training and test -
 and join then together by appending test at the bottom of train. These data correspond
 row by row to the X file, so order must be preserved. Subject file has numeric subject 
 codes. "Subject" header text is added.(subject_train.txt and subject_test.txt)
 
 *5- Mean and Standard Deviation column names and their positions are selected from the
  features table read in step 1.
  The names chosen contain with mean() or std(). After considering the existing
  measurement names, I think that these are the ones that correspond to means and 
  standard deviations.
  Using these positions, the columns of the same numbers are chosen fron the X
  mesurements table, giving X_s.
  
  *6- Parenthesis are suppressed from the data names, giving the meaningful column names 
  that are added to the X_s table. These names can be interpreted to their meaning
  and may be looked up in the CodeBook to find a detailed explanation.
  
  *7- Subject, Activity and Measurements tables are joined together columnwise. (S, Y_m
  and X_s). The three tables have the same amount of rows, corresponding to each
  observation. The resulting table is named X_s.
  A check is done to find our if there are any missing data.
  
  *8- Measurement data are summarised using dplyr summarise_each function. For every
  distinct combination of Subject and Activity, the mean is calculted for every
  individual measurement. The resulting table is a wide format model, with as many
  columns as data items plus two ( subject and activity)
  
  *9- (optional)  This optional code uses the reshape2 library to summarise the data
  in the long format (four columns - Subject, Activity, Measurement and Value)
  
  *10- Finally, result is written to the output file CourseProjectTidy.txt
  

