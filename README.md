# Austin Animal Center
## Resources 
### Data
- [City of Austin Data Center](https://data.austintexas.gov/browse?City-of-Austin_Department-=Animal+Services)
>The city of Austin’s online repository of statistical data. From this data source we downloaded Animal Center Intake and Outcome data from Oct, 1st 2013 to present. All animals receive a unique Animal ID during intake.

- [Intake Data](https://github.com/CorinneBean/Project_A_Team/blob/e8b7306861dd99d65887e9fa9b7fe92c5a36d103/Resources/Austin_Animal_Center_Intakes.csv)
> Intakes represent the status of animals as they arrive at the Animal Center. All animals receive a unique Animal ID during intake. Annually over 90% of animals entering the center, are adopted, transferred to rescue or returned to their owners.

- [Outcomes Data](https://github.com/CorinneBean/Project_A_Team/blob/e8b7306861dd99d65887e9fa9b7fe92c5a36d103/Resources/Austin_Animal_Center_Outcomes.csv)
> The Outcomes data set reflects that Austin, TX. is the largest "No Kill" city in the country. All animals received with unique Animal IDs are safely adopted or transferred and this data represents that.

- [Google Slides](https://docs.google.com/presentation/d/1K8pBQ0ttgLPquqlpsvYnzDSHKgBfmPmnp6c2Xg19fgM/edit#slide=id.p) 
> Google slide presentation

- [Story Board](https://public.tableau.com/app/profile/nick.foley3714/viz/FinalProject_16622592472410/Story1?publish=yes) 
> Tableau Story Board 

### Software
- PostgresSQL
- SQLAlchemy
- Jupyter Notebook
- Pandas

## Project Overview 

#### Purpose
Austin, Texas is the largest "No Kill" city in the country, and home of the Austin Animal Center (AAC). The center reports that 90% of animals are either adopted, returned to their owner, or transferred to a rescue. Our interest in this topic is to determine what outcome would be expected for each breed, particularly for breeds considered “violent” or aggressive, and compare if younger or older pets are more likely to find a home. Another interest we had was looking at the geographical area of the City of Austin to determine if there is an area within the city that has a higher number of stray population.

#### Questions to Answer
1. What month has most intakes/outcomes
2. Distribution of dog and cats.
3. Where in Austin are most intakes coming from?
4. Average dog and cat intake in a week?
5. Average time in the shelter by age ?

#### Team Roles
| Roles         | Responsibility     | Name          |
| ------------- |:------------------:| -------------:|
| Square        | Github             | Corinne       |
| Circle        | Machine Learning   | Shruti        |
| Triangle      | Database           | Sharon        |
| X             | Project Management | Ashley & Nick |

## Database
The following is an ERD of the database and tables used for this project..

![ERD](https://user-images.githubusercontent.com/87085239/190934132-7dbfd05a-a18d-4294-8807-36a001b37403.png)

### Database Integration

For this project, we utilized PostgresSQL and fully integrated the database into our project.

- The database contains static data captured from the Austin Animal Center website, and census data. The three tables within the database which were used for the final dataset are:
    - Intake_df
    - Outcome_df
    - Zipcode_df

- The Database interfaces with the project using Jupyter Notebook, Pandas and SQLAlchemy. These tools aided in the export of the dataframes into the Postgres AAC database to create the tables. .

- Both inner and left joins were utilized with SQL to join the three tables together. Data was then manipulate on number, character and date columns.

- Three connection strings using SQLAlchemy export the data into the Postgres database and create the tables. Two connection strings import the final dataset into the Jupyter Notebook machine learning scripts.

#### Data Analysis - *(Refer slides for details)*
The data analysis process began with the consideration of two datasets from Austin Animal Center. 

## Machine Learning Model
The following is a provisional machine learning model which was used during the planning phase.

![ML Mockup](https://github.com/CorinneBean/Project_A_Team/blob/37e725957dba0e937832051c41ce61b0a53d2517/Images/ML%20Mockup.png)

#### Data Analysis (Refer slides for details)

The data analysis process began with the consideration of two datasets from Austin Animal Center. 
- [Austin_Animal_Center_Intakes.csv](https://github.com/CorinneBean/Project_A_Team/blob/e8b7306861dd99d65887e9fa9b7fe92c5a36d103/Resources/Austin_Animal_Center_Intakes.csv)
Intakes represent the status of animals as they arrive at the Animal Center. All animals receive a unique Animal ID during intake. Annually over 90% of animals entering the center, are adopted, transferred to rescue or returned to their owners.

- [Austin_Animal_Center_Outcomes.csv](https://github.com/CorinneBean/Project_A_Team/blob/e8b7306861dd99d65887e9fa9b7fe92c5a36d103/Resources/Austin_Animal_Center_Outcomes.csv)
The Outcomes data set reflects that Austin, TX. is the largest "No Kill" city in the country. All animals received with unique Animal IDs are safely adopted or transferred and this data represents that.

### Data Analysis & Machine Learning.

- Data analysis was performed using Machine Larning to determine the successful and unsuccessful outcome of each animal at the center. The datasets used in this analysis contained 12 columns and 144K rows each.

**Preliminary Data Preprocessing:**

- Each dataset was cleaned by removing bad or erroneous data.

- The columns that were entered as Strings were converted to numeric/date fields so that it’s helpful for Machine Learning models.

- The intake and outcome datasets were merged based on unique identifier (as described in the Database section) for further analysis.

**Preliminary Feature Engineering and Preliminary Feature Selection:**

  * For the intake & outcome datasets , The "Age upon Intake" column was a string containing (days, weeks, years etc.), the column was split and then "Age Upon Intake(days)" & "Age Upon Intake(years)" was calculated. Similar we used DateTime Series to get Intake Month, Intake year and Intake Weekday & Intake Hour are calculated.
  * Created a new column - Intake Frequency as in how many times a same animal with unique Animal ID is brought to AAC.
  * Cumulative frequency is #4 is calculated for each row based on the Intake Time and date and time in Ascending order.
  * Once loaded into Postgres SQL tables, the files were altered to create primary key off the (“animal_id_intake”,” order_of_intake”) and (“animal_id_outcome”,” order_of_outcome”) as well as altering the date fields. The zipcode table was altered to create a primary key of “index_id” that joins to the index_id_intake.
  * Based on the new primary keys made up of a combination of Compound key from intake_df (animal_id_intake & order_of_intake) and outcome_df (animal_id_outcome & order_of_outcome), the tables are joined along with zipcode to get a combined dataset containing both data together.
  * Using case statements columns were split up and restructured for analysis such as subtypes for breeds based on the predominate identified breed, if it contained Pit Bull and date calculations.
  * The acc_intake_outcome and acc_intake_available were then exported to "acc_intake_outcome.csv" & "acc_intake_available.csv" and also connected to the machine learning script using sqlalchemy.

**How data was split into training and testing sets.**

* Toget the train and test data,we consider the combined data from intake and outcome. (acc_intake_outcome.csv)
* Age, Breed, Color, Intake type, Intake Condition & Outcome Type are considered.
* We split our analysis for Dogs and Cats and their Success/Failure of getting Adopted/Return-to-Owner/Rto-Adopted.
* Hot encoding is performed for each of above categories to get the data ready for ML.
* The data is split into X and y. Where below are the features 
  - X = The hot encoded values of the following features
    ‘age_upon_intake(days)’ ’age_upon_outcome(days)’ ’days_in_shelter ’ ’intake_condition’ ‘color_intake’ ‘breed_intake’ ’intake_type’
  - Y = ‘outcome_type’ encoded for Success and Failure.

**Model choice, limitations and benefits.**

We used Logistic Regression and Random Forest Classification models to analyze the data.
Logistic Regression - is performed when we are expecting a Binary Outcome - Here we are running the ML model to determine if Dog / Cat will have success or Failure as outcome for given categories or features in consideration.

Random Forest Classification - This model produces good predictions, and is capable to handle large datasets efficiently. This model helps in producing higher level of accuracy. Below is the Confusion Matrix for Dogs and Cats.

**Explanation of changes in model choice (if changes occurred between the Segment 2 and Segment 3 deliverables**
For Segment 2 , for Dogs - recall values was very low and it was a perfect case of Class imbalance where Success(Adopted) & Failure(Other) situations in which the existing classes in a dataset aren't equally represented. 
<img width="148" alt="image" src="https://user-images.githubusercontent.com/98556229/192126961-35f190fd-230b-42ee-881e-41bd358cb8de.png">

<img width="248" alt="image" src="https://user-images.githubusercontent.com/98556229/192126966-426a83a8-4284-4fb3-a82b-75e1cdeefc16.png">

To Improve the above problem of class imbalance - 
* We re-categorized the outcome_type to get the Success(Adopted) & Failure(Other) situations.
* Splitting the color_intake into 2 separate color_1 and color_2 based on the delimiter.

**Update & improved results from ML** 
* With new data columns Confusion Matrix for Dog is -

<img width="648" alt="image" src="https://user-images.githubusercontent.com/98556229/192126993-8013cc3c-f956-4569-a978-ccffd622eae8.png">


* With new data columns Confusion Matrix for Cat is -

<img width="651" alt="image" src="https://user-images.githubusercontent.com/98556229/192127033-497bf1c8-73d4-4294-9b54-417c1dfdbc6a.png">




