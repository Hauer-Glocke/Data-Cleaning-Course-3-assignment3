#**Criteria:** GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.

#**Task:** Create a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.

#Overview of Steps

To give an understanding what I did, here is an ordered list of how I approached the task in my code:

1. Clear Working Environment
2. Loading necessary libraries
3. Loading the Dataset into a temporary folder
4. Merging of test and train data and add correct names (Step 1)
5. Subset on collumn names, only means and standard deviations (Step 2)
6. Add Activity Labels and Subject Names (Step 3)
        + Activity Labels
        + Subject Identifier
        + Merging data
7. Appropriate Label Names (Step 4)
8. Create Summary Dataset (Step5)
9. Cleaning up and Create txt-file

#Finaler Output

* df
        * Merged dataset with all means and standard deviations
        * 10,299 observations, variable names adjusted from feature.txt
* df_summary
        * Aggregated summary of the "df" dataset
        * All observations aggregated into means in 30 subjects and 6 activities (180 observations)
        
All other files are dropped on the way, because they are temporary.

#Overview Variables
* "subject"
* "activities"
* "time_body_acc_mean_x"           
* "time_body_acc_mean_y"
* "time_body_acc_mean_z"
* "time_body_acc_std_x"
* "time_body_acc_std_y"
* "time_body_acc_std_z"
* "time_gravity_acc_mean_x"
* "time_gravity_acc_mean_y"
* "time_gravity_acc_mean_z"
* "time_gravity_acc_std_x"
* "time_gravity_acc_std_y"
* "time_gravity_acc_std_z"
* "time_body_accjerk_mean_x"       
* "time_body_accjerk_mean_y"
* "time_body_accjerk_mean_z"
* "time_body_accjerk_std_x"        
* "time_body_accjerk_std_y"
* "time_body_accjerk_std_z"
* "time_body_gyro_mean_x"          
* "time_body_gyro_mean_y"
* "time_body_gyro_mean_z"
* "time_body_gyro_std_x"           
* "time_body_gyro_std_y"
* "time_body_gyro_std_z"
* "time_body_gyrojerk_mean_x"      
* "time_body_gyrojerk_mean_y"
* "time_body_gyrojerk_mean_z"
* "time_body_gyrojerk_std_x"       
* "time_body_gyrojerk_std_y"
* "time_body_gyrojerk_std_z"
* "time_body_accmag_mean"          
* "time_body_accmag_std"
* "time_gravity_accmag_mean"
* "time_gravity_accmag_std"        
* "time_body_accjerkmag_mean"
* "time_body_accjerkmag_std"
* "time_body_gyromag_mean"         
* "time_body_gyromag_std"
* "time_body_gyrojerkmag_mean"
* "time_body_gyrojerkmag_std"      
* "freq_body_acc_mean_x"
* "freq_body_acc_mean_y"
* "freq_body_acc_mean_z"           
* "freq_body_acc_std_x"
* "freq_body_acc_std_y"
* "freq_body_acc_std_z"            
* "freq_body_acc_mean_freq_x"
* "freq_body_acc_mean_freq_y"
* "freq_body_acc_mean_freq_z"      
* "freq_body_accjerk_mean_x"
* "freq_body_accjerk_mean_y"
* "freq_body_accjerk_mean_z"       
* "freq_body_accjerk_std_x"
* "freq_body_accjerk_std_y"
* "freq_body_accjerk_std_z"        
* "freq_body_accjerk_mean_freq_x"
* "freq_body_accjerk_mean_freq_y"
* "freq_body_accjerk_mean_freq_z"  
* "freq_body_gyro_mean_x"
* "freq_body_gyro_mean_y"
* "freq_body_gyro_mean_z"          
* "freq_body_gyro_std_x"
* "freq_body_gyro_std_y"
* "freq_body_gyro_std_z"           
* "freq_body_gyro_mean_freq_x"
* "freq_body_gyro_mean_freq_y"
* "freq_body_gyro_mean_freq_z"     
* "freq_body_accmag_mean"
* "freq_body_accmag_std"
* "freq_body_accmag_mean_freq"     
* "freq_body_accjerkmag_mean"
* "freq_body_accjerkmag_std"
* "freq_body_accjerkmag_mean_freq" 
* "freq_body_gyromag_mean"
* "freq_body_gyromag_std"
* "freq_body_gyromag_mean_freq"    
* "freq_body_gyrojerkmag_mean"
* "freq_body_gyrojerkmag_std"
* "freq_body_gyrojerkmag_mean_freq"
