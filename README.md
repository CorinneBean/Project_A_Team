# Austin Animal Center
## Project Overview 

### Purpose
The Austin Animal Center is located in Austin, Texas, the "No Kill" city in the country. The center reports that 90% of animals are either adopted, returned to their owner, or transferred to a rescue. Our interest in this topic is to determine what outcome would be expected for each breed, particularly for breeds considered “violent” or aggressive, and compare if younger or older pets are more likely to find a home. Another interest we had was looking at the geographical area of the City of Austin to determine if there is an area within the city that has a higher number of stray population.

### Questions to Answer
1. What month has most intakes/outcomes
2. Distribution of dog and cats.
3. Where in Austin are most intakes coming from?
4. Average dog and cat intake in a week?
5. Average time in the shelter by age ?

### Roles
| Roles         | Responsibility     | Name          |
| ------------- |:------------------:| -------------:|
| Square        | Github             | Corinne       |
| Circle        | Machine Learning   | Shruti        |
| Triangle      | Database           | Sharon        |
| X             | Project Management | Ashley & Nick |

### Communication Protocols
The main source of communication for this group was conducted via Zoom and Slack. An individual Slack channel was created specific to this group. A Google drive folder was also created that allowed the sharing of documents related to the preparation of this project.

### Workflow
#### Machine Learning Model
The following is a provisional machine learning model which was used during the planning phase.

![ML Mockup](https://github.com/CorinneBean/Project_A_Team/blob/37e725957dba0e937832051c41ce61b0a53d2517/Images/ML%20Mockup.png)

#### Data Analysis (Refer slides for details)

The data analysis process began with the consideration of two datasets from Austin Animal Center. 
- [Austin_Animal_Center_Intakes.csv](https://github.com/CorinneBean/Project_A_Team/blob/e8b7306861dd99d65887e9fa9b7fe92c5a36d103/Resources/Austin_Animal_Center_Intakes.csv)
Intakes represent the status of animals as they arrive at the Animal Center. All animals receive a unique Animal ID during intake. Annually over 90% of animals entering the center, are adopted, transferred to rescue or returned to their owners.

- [Austin_Animal_Center_Outcomes.csv](https://github.com/CorinneBean/Project_A_Team/blob/e8b7306861dd99d65887e9fa9b7fe92c5a36d103/Resources/Austin_Animal_Center_Outcomes.csv)
The Outcomes data set reflects that Austin, TX. is the largest "No Kill" city in the country. All animals received with unique Animal IDs are safely adopted or transferred and this data represents that.



#### Database
The following is a provisional database which was used during the planning phase.

![ERD](https://github.com/CorinneBean/Project_A_Team/blob/37e725957dba0e937832051c41ce61b0a53d2517/Images/ERD.png)

#### Database Integration

For this project, we utilized PostgresSQL and fully integrated the database into our project.

* Database stores static data for use during the project
  - Database stores multiple data tables used for compiling the final dataset.
* Database interfaces with the project in some format (e.g., scraping updates the database)
  - Database interfaces with the project using Jupyter Notebook Pandas and sqlalchemy to export the dfs into the Postgres AAC database and create the   tables. After the tables have been joined and data fields manipulated, sqlalchemy is used to connect to the database and import the final sql table back to Jupyter Notebooks to use for the machine learning.
  
* Includes at least two tables (or collections, if using MongoDB)
  - The AAC database includes three tables used for the final dataset.
* Includes at least one join using the database language (not including any joins in Pandas)
  - SQL is used to join the three tables together and perform data manipulation on number, character and date columns.
* Includes at least one connection string (using SQLAlchemy or PyMongo)
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



## Resources 
### Data
[City of Austin Data Center](https://data.austintexas.gov/browse?City-of-Austin_Department-=Animal+Services) -  The city of Austin’s online repository of statistical data. From this data source we downloaded Animal Center Intake and Outcome data from Oct, 1st 2013 to present. All animals receive a unique Animal ID during intake.

[Intake Data](https://data.austintexas.gov/Health-and-Community-Services/Austin-Animal-Center-Intakes/wter-evkm/data) - Intake represents the status of animals as they enter the Animal Center

[Outcome Data](https://data.austintexas.gov/Health-and-Community-Services/Austin-Animal-Center-Outcomes/9t4d-g238/data) - Outcome represents the status of animals as they leave the Animal Center

[Google Slides](https://docs.google.com/presentation/d/1K8pBQ0ttgLPquqlpsvYnzDSHKgBfmPmnp6c2Xg19fgM/edit#slide=id.p) - Google slide for Segment 2.

### Software



## Results 
