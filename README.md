# Austin Animal Center
## Project Overview 

### Purpose
The Austin Animal Center is located in Austin, Texas, the "No Kill" city in the country. The center reports that 90% of animals are either adopted, returned to their owner, or transferred to a rescue. Our interest in this topic is to determine what outcome would be expected for each breed, particularly for breeds considered “violent” or aggressive, and compare if younger or older pets are more likely to find a home. Another interest we had was looking at the geographical area of the City of Austin to determine if there is an area within the city that has a higher number of stray population.

### Questions to Answer
1.  Using a confusion matrix determine how many were adopted , returned to their owner or transferred to a rescue in a confusion matrix.
2.  What area of Austin is most likely to have strays?
3.  What type of animal (dog/cat/other) is most likely to be adopted?
4.  What type of animal (dog/cat/other) is most likely to be returned to the owner?
5.  Are transfers mostly purebred animals to breed-specific rescues (not sure this data exists, but perhaps can draw the conclusion)?
6.  Is there a specific age group more likely to be returned to owner/adopted?
7.  Average time in shelter?
8.  Average time in shelter by animal type?
9.  Average time in shelter by age?
10. Average dog and cat intake in a week.
11. Average dog and cat successful outcome in a week.
12. What day of week is the shelter most likely to adopt?
13. What month has the most intakes/outcomes?
14. How are the intakes happening?
15. Does color play a role in successful outcome?
16. Does breed play a role in successful outcome?
17. Distribution of dogs to cats.
18. Do dogs get adopted faster than cats?
19. Where in Austin are most intakes coming from?
20. Demographics of area where most intakes are coming.

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
- Austin_Animal_Center_Intakes.csv 
Intakes represent the status of animals as they arrive at the Animal Center. All animals receive a unique Animal ID during intake. Annually over 90% of animals entering the center, are adopted, transferred to rescue or returned to their owners.

- Austin_Animal_Center_Outcomes.csv
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

## Resources 
### Data
[City of Austin Data Center](https://data.austintexas.gov/browse?City-of-Austin_Department-=Animal+Services) -  The city of Austin’s online repository of statistical data. From this data source we downloaded Animal Center Intake and Outcome data from Oct, 1st 2013 to present. All animals receive a unique Animal ID during intake.

[Intake Data](https://data.austintexas.gov/Health-and-Community-Services/Austin-Animal-Center-Intakes/wter-evkm/data) - Intake represents the status of animals as they enter the Animal Center

[Outcome Data](https://data.austintexas.gov/Health-and-Community-Services/Austin-Animal-Center-Outcomes/9t4d-g238/data) - Outcome represents the status of animals as they leave the Animal Center

### Software



## Results 
