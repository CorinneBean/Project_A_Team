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
> Google slide for Segment 2.

### Software
- PostgresSQL
- SQLAlchemy
- Jupyter Notebook
- Pandas

## Project Overview 

#### Purpose
Austin, Texas is the largest "No Kill" city in the country, and home of the Austin Animal Center (ACC). The center reports that 90% of animals are either adopted, returned to their owner, or transferred to a rescue. Our interest in this topic is to determine what outcome would be expected for each breed, particularly for breeds considered “violent” or aggressive, and compare if younger or older pets are more likely to find a home. Another interest we had was looking at the geographical area of the City of Austin to determine if there is an area within the city that has a higher number of stray population.

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

#### Communication Protocols
The main source of communication for this group was conducted via Zoom and Slack. An individual Slack channel was created specific to this group: final-project. A Google drive folder was also created that allowed the sharing of documents related to the preparation of this project. Team members meet via Zoom each Tuesday & Thursday from 7-9 pm CST.

## Database
The following is an ERD of the database and tables used for this project..

![ERD](https://github.com/CorinneBean/Project_A_Team/blob/37e725957dba0e937832051c41ce61b0a53d2517/Images/ERD.png)

### Database Integration

For this project, we utilized PostgresSQL and fully integrated the database into our project.

- The database contains static data captured from the Austin Animal Center website, and census data. The three tables within the database which were used for the final dataset are:
    - Intake_df
    - Outcome_df
    - Zipcode_df

- The Database interfaces with the project using Jupyter Notebook, Pandas and SQLAlchemy. These tools aided in the export of the dataframes into the Postgres AAC database to create the tables. .

- Both inner and left joins were utilized with SQL to join the three tables together. Data was then manipulate on number, character and date columns.

- Using a SQLAlchemy connection string to connect to the Postgres AAC database, the final tables were imported back into the Jupyter Notebook machine learning scripts.

## Machine Learning Model
The following is a provisional machine learning model which was used during the planning phase.

![ML Mockup](https://github.com/CorinneBean/Project_A_Team/blob/37e725957dba0e937832051c41ce61b0a53d2517/Images/ML%20Mockup.png)

#### Data Analysis - *(Refer slides for details)*

The data analysis process began with the consideration of two datasets from Austin Animal Center. 

1. [Austin_Animal_Center_Intakes.csv](https://github.com/CorinneBean/Project_A_Team/blob/e8b7306861dd99d65887e9fa9b7fe92c5a36d103/Resources/Austin_Animal_Center_Intakes.csv)

2. [Austin_Animal_Center_Outcomes.csv](https://github.com/CorinneBean/Project_A_Team/blob/e8b7306861dd99d65887e9fa9b7fe92c5a36d103/Resources/Austin_Animal_Center_Outcomes.csv)

### Data Analysis & Machine Learning

Data analysis was performed using Machine Larning to determine the successful and unsuccessful outcome of each animal at the center. The datasets used in this analysis contained 12 columns and 144K rows each.

1. #### Preliminary Data Preprocessing:

    - Each dataset was cleaned by removing bad or erroneous data.

    - The columns that were entered as Strings were converted to numeric/date fields so that it’s helpful for Machine Learning models.

    - The intake and outcome datasets were merged based on unique identifier (as described in the Database section) for further analysis.

2. #### Preliminary Feature Engineering and Preliminary Feature Selection:

    * For the intake & outcome datasets, The *Age upon Intake* column was a string containing (days, weeks, years etc.), the column was split and then *Age Upon Intake(days)* & *Age Upon Intake(years)* was calculated. We used DateTime Series to get Intake Month, Intake year and Intake Weekday & Intake Hour are calculated.

    * A new column was created, Intake Frequency, which was used to evaluate how many times the same unique Animal ID is brought to AAC.
  
     * Cumulative frequency is calculated for each row based on the Intake Time and date, and time in Ascending order.
  
    * Once the data was loaded into Postgres SQL tables, the data was manipulated to create a primary key off the *animal_id_intake* and *order_of_intake* tables, and *animal_id_outcome* and *order_of_outcome* tables. The zipcode table was altered to create a primary key of *index_id* that joins to the index_id_intake.
  
    * The new primary keys was made up of a combination of Compound key from *intake_df (animal_id_intake & order_of_intake)* and *outcome_df (animal_id_outcome & order_of_outcome)*, the tables are joined along with zipcode to get a combined dataset containing both data together.
  
    * Using case statements columns were split up and restructured for analysis such as subtypes for breeds based on the predominate identified breed (i.e. Pit Bull, Akita, Chihuahua)and date calculations.
  
     * The *acc_intake_outcome* and *acc_intake_available* were then exported to [acc_intake_outcome.csv](https://github.com/CorinneBean/Project_A_Team/blob/d28600b902462c3f7fe4116c166b6e18cdef496c/Resources/Data/acc_intake_outcome.csv) & [acc_intake_available.csv](https://github.com/CorinneBean/Project_A_Team/blob/d28600b902462c3f7fe4116c166b6e18cdef496c/Resources/Data/acc_intake_available.csv), and connected to the machine learning script using SQLAlchemy.

3. #### Description of how data was split into training and testing sets.

    * To get the training and test data, the combined data from intake and outcome was used. [acc_intake_outcome.csv](https://github.com/CorinneBean/Project_A_Team/blob/d28600b902462c3f7fe4116c166b6e18cdef496c/Resources/Data/acc_intake_outcome.csv)

    * Age, Breed, Color, Intake type, Intake Condition & Outcome Type the columns used during this process.

    * Dogs and Cats were split to allow deeper evaluation into each species and what their success/failure of getting either adopted, returned-to-owner, or RTO-Adopted.

    * Hot encoding is performed for each of above categories to get the data ready for ML.

    * The data is split into X and y. 
        - X = The hot encoded values of the following features:
            - age_upon_intake(days)
            - age_upon_outcome(days)
            - days_in_shelter
            - intake_condition
            - color_intake
            - breed_intake
            - intake_type
         - Y = *outcome_type* encoded for Success and Failure.

**Explanation of model choice, including limitations and benefits.**

We used Logistic Regression and Random Forest Classification models to analyze the data.

**Logistic Regression**
> Logistic Regression is performed when we are expecting a Binary Outcome. In this project, the ML model was run to determine if Dogs or Cats are more likely to have a successful or unsuccessful outcome.

**Random Forest Classification**
> This model produces good predictions, and is capable of handling large datasets efficiently. This model helps in producing higher level of accuracy. Below is the Confusion Matrix for Dogs and Cats.

## Results 

### Machine Learning

### Dogs

**Confusion matrix**

![image](https://user-images.githubusercontent.com/98556229/190839409-44201de9-4fe0-4269-92df-ffa8c17261e9.png)

**Plotting of confusion matrix**

![image](https://user-images.githubusercontent.com/98556229/190839464-fcfe1f1d-68db-41e7-9a23-273fe6116fb4.png)

**List of features sorted with feature importance**

![image](https://user-images.githubusercontent.com/98556229/190839439-d6dd3ed6-3db0-48c5-bdd3-8fea854d721d.png)


### Cats

**Confusion matrix**

![image](https://user-images.githubusercontent.com/98556229/190839479-d5727396-0f7d-4261-8412-08a0847def5b.png)

**Plotting of confusion matrix**

![image](https://user-images.githubusercontent.com/98556229/190839511-c732086f-2463-48e6-bad8-6a4bc87b5b46.png)

**List of features sorted with feature importance**

![image](https://user-images.githubusercontent.com/98556229/190839521-d01e865f-fb9e-404e-a60c-3639f35847f3.png)
