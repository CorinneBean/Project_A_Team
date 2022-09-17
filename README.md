# Austin Animal Center
## Project Overview 

## Resources 
### Data
[City of Austin Data Center](https://data.austintexas.gov/browse?City-of-Austin_Department-=Animal+Services) -  The city of Austin’s online repository of statistical data. From this data source we downloaded Animal Center Intake and Outcome data from Oct, 1st 2013 to present. All animals receive a unique Animal ID during intake.

[Intake Data](https://data.austintexas.gov/Health-and-Community-Services/Austin-Animal-Center-Intakes/wter-evkm/data) - Intake represents the status of animals as they enter the Animal Center

[Outcome Data](https://data.austintexas.gov/Health-and-Community-Services/Austin-Animal-Center-Outcomes/9t4d-g238/data) - Outcome represents the status of animals as they leave the Animal Center

### Software

### Purpose
Austin, Texas is the largest "No Kill" city in the country, and home of the Austin Animal Center (ACC). The center reports that 90% of animals are either adopted, returned to their owner, or transferred to a rescue. Our interest in this topic is to determine what outcome would be expected for each breed, particularly for breeds considered “violent” or aggressive, and compare if younger or older pets are more likely to find a home. Another interest we had was looking at the geographical area of the City of Austin to determine if there is an area within the city that has a higher number of stray population.

### Questions to Answer
1.  Using a confusion matrix determine how many were adopted , returned to their owner or transferred to a rescue in a confusion matrix.
2.  What area of Austin is most likely to have strays?
3.  What type of animal (dog/cat/other) is most likely to be adopted?
4.  What type of animal (dog/cat/other) is most likely to be returned to the owner?
5.  Are transfers mostly purebred animals to breed-specific rescues (not sure this data exists, but perhaps can draw the conclusion)?
6.  Is there a specific age group more likely to be returned to owner/adopted?

### Roles
| Roles         | Responsibility     | Name          |
| ------------- |:------------------:| -------------:|
| Square        | Github             | Corinne       |
| Circle        | Machine Learning   | Shruti        |
| Triangle      | Database           | Sharon        |
| X             | Project Management | Ashley & Nick |

### Communication Protocols
The main source of communication for this group was conducted via Zoom and Slack. An individual Slack channel was created specific to this group: final-project. A Google drive folder was also created that allowed the sharing of documents related to the preparation of this project. Team members meet via Zoom each Tuesday & Thursday from 7-9 pm CST.

### Workflow
#### Machine Learning Model
The following is a provisional machine learning model which was used during the planning phase.

![ML Mockup](https://github.com/CorinneBean/Project_A_Team/blob/37e725957dba0e937832051c41ce61b0a53d2517/Images/ML%20Mockup.png)

##### ML Data Analysis (Refer slides for details)
[Intake Data](https://data.austintexas.gov/Health-and-Community-Services/Austin-Animal-Center-Intakes/wter-evkm/data) - Intake represents the status of animals as they enter the Animal Center

[Outcome Data](https://data.austintexas.gov/Health-and-Community-Services/Austin-Animal-Center-Outcomes/9t4d-g238/data) - Outcome represents the status of animals as they leave the Animal Center

#### Database
The following is a provisional database which was used during the planning phase.

![ERD](https://github.com/CorinneBean/Project_A_Team/blob/37e725957dba0e937832051c41ce61b0a53d2517/Images/ERD.png)

##### Database Integration
For this project, we utilized PostgresSQL and fully integrated the database into our project.

- The database contains static data captured from the Austin Animal Center website, and census data. The three tables within the database which were used for the final dataset are:
    - Intake_df
    - Outcome_df
    - Zipcode_df

- The Database interfaces with the project using Jupyter Notebook, Pandas and SQLAlchemy. These tools aided in the export of the dataframes into the Postgres AAC database. Once all the data was exported tables were created within the database. 

- Both inner and left joins were utilized with SQL to join the three tables together. Data was then manipulate on number, character and date columns.

- Three connection strings using SQLAlchemy export the data into the Postgres database and create the tables. Two connection strings import the final dataset into the Jupyter Notebook machine learning scripts.

#### Data Analysis & Machine Learning.

– Data analysis is performed on the intake and outcomes data containing large dataset of 12 columns and 144k rows each.
– To analyze the Successful/Unsuccessful outcome of Adoption or relocation of pets based on data.

✓ Description of preliminary data preprocessing

  * Clean up of entries from each dataset and to get rid of bad or erroneous data.
  * The columns that were entered as Strings were converted to numeric/date fields so that it’s helpful for Machine Learning models.
  * Next in the database we merged the intake and outcome datasets based on unique identifier (as described in the Database section) for further analysis.

✓ Description of preliminary feature engineering and preliminary feature selection, including their decision-making process.
  * For the intake & outcome datasets , The "Age upon Intake" column was a string containing (days, weeks, years etc.), the column was split and then "Age Upon Intake(days)" & "Age Upon Intake(years)" was calculated. Similar we used DateTime Series to get Intake Month, Intake year and Intake Weekday & Intake Hour are calculated.
  * Created a new column - Intake Frequency as in how many times a same animal with unique Animal ID is brought to AAC.
  * Cumulative frequency is #4 is calculated for each row based on the Intake Time and date and time in Ascending order.
  * Once loaded into Postgres SQL tables, the files were altered to create primary key off the (“animal_id_intake”,” order_of_intake”) and (“animal_id_outcome”,” order_of_outcome”) as well as altering the date fields. The zipcode table was altered to create a primary key of “index_id” that joins to the index_id_intake.
  * Based on the new primary keys made up of a combination of Compound key from intake_df (animal_id_intake & order_of_intake) and outcome_df (animal_id_outcome & order_of_outcome), the tables are joined along with zipcode to get a combined dataset containing both data together.
  * Using case statements columns were split up and restructured for analysis such as subtypes for breeds based on the predominate identified breed, if it contained Pit Bull and date calculations.
  * The acc_intake_outcome and acc_intake_available were then exported to "acc_intake_outcome.csv" & "acc_intake_available.csv" and also connected to the machine learning script using sqlalchemy.

✓ Description of how data was split into training and testing sets.

* Toget the train and test data,we consider the combined data from intake and outcome. (acc_intake_outcome.csv)
* Age, Breed, Color, Intake type, Intake Condition & Outcome Type are considered.
* We split our analysis for Dogs and Cats and their Success/Failure of getting Adopted/Return-to-Owner/Rto-Adopted.
* Hot encoding is performed for each of above categories to get the data ready for ML.
* The data is split into X and y. Where below are the features 
  - X = The hot encoded values of the following features
    ‘age_upon_intake(days)’ ’age_upon_outcome(days)’ ’days_in_shelter ’ ’intake_condition’ ‘color_intake’ ‘breed_intake’ ’intake_type’
  - Y = ‘outcome_type’ encoded for Success and Failure.

✓ Explanation of model choice, including limitations and benefits.

We used Logistic Regression and Random Forest Classification models to analyze the data.
Logistic Regression - is performed when we are expecting a Binary Outcome - Here we are running the ML model to determine if Dog / Cat will have success or Failure as outcome for given categories or features in consideration.

Random Forest Classification - This model produces good predictions, and is capable to handle large datasets efficiently. This model helps in producing higher level of accuracy. Below is the Confusion Matrix for Dogs and Cats.

## ML results For Dogs

#### Confusion matrix  - 
![image](https://user-images.githubusercontent.com/98556229/190839409-44201de9-4fe0-4269-92df-ffa8c17261e9.png)

#### Plotting of confusion matrix 
![image](https://user-images.githubusercontent.com/98556229/190839464-fcfe1f1d-68db-41e7-9a23-273fe6116fb4.png)


#### List of features sorted with feature importance 
![image](https://user-images.githubusercontent.com/98556229/190839439-d6dd3ed6-3db0-48c5-bdd3-8fea854d721d.png)


## ML results For Cats

#### Confusion Matrix 
![image](https://user-images.githubusercontent.com/98556229/190839479-d5727396-0f7d-4261-8412-08a0847def5b.png)

#### Plotting of confusion matrix 
![image](https://user-images.githubusercontent.com/98556229/190839511-c732086f-2463-48e6-bad8-6a4bc87b5b46.png)


#### List of features sorted with feature importance 
![image](https://user-images.githubusercontent.com/98556229/190839521-d01e865f-fb9e-404e-a60c-3639f35847f3.png)