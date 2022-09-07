--ACC intake and outcome data

--Create intake table
DROP TABLE IF EXISTS intake_csv;

CREATE TABLE intake_csv (
	PRIMARY KEY (animal_id_intake, order_of_intake),
	Index_ID_intake INT NOT NULL,
	Animal_ID_intake VARCHAR NOT NULL,
	DateTime_intake timestamp without time zone,
	MonthYear_intake VARCHAR,
	Found_Location VARCHAR,
	Intake_Type VARCHAR,
	Intake_Condition VARCHAR,
	Animal_Type_intake VARCHAR,
	Sex_upon_Intake VARCHAR,
	Age_upon_Intake VARCHAR,
	Breed_intake VARCHAR,
	Color_intake VARCHAR,
	"Age_Upon_Intake(days)" numeric,
	"Age_Upon_Intake(years)" numeric,
	Age_Range_intake VARCHAR,
	Intake_Month INT,
	Intake_Year INT,
	Intake_Weekday VARCHAR,
	Intake_Hour INT,
	Intake_Frequency INT,
	Order_of_Intake INT
);

--verify records
select * from intake_csv;


--Create outcome table
DROP TABLE IF EXISTS outcome_csv;

 CREATE TABLE outcome_csv (
	PRIMARY KEY (animal_id_outcome, order_of_outcome)
	Index_ID_outcome INT NOT NULL,
	Animal_ID_outcome VARCHAR NOT NULL,
	DateTime_outcome timestamp without time zone,
	MonthYear_outcome VARCHAR,
	Date_of_Birth_outcome Date,
	Outcome_Type VARCHAR,
	Outcome_SubType VARCHAR,
	Animal_Type_outcome VARCHAR,
	Sex_upon_Outcome VARCHAR,
	Age_upon_Outcome VARCHAR,
	Breed_outcome VARCHAR,
	Color_outcome VARCHAR,
	"Age_Upon_Outcome(days)" numeric,
	Outcome_Month INT,
	Outcome_Year INT,
	Outcome_Weekday VARCHAR,
	Outcome_Hour INT,
	"Age_Upon_Outcome(years)" numeric,
	Age_Range_outcome VARCHAR,
	Outcome_Frequency INT,
	Order_of_Outcome INT
	);	
	
--verify records
select * from outcome_csv;


--create combined table
DROP TABLE IF EXISTS acc_intake_outcome;

select intake_csv.*,outcome_csv.*

INTO acc_intake_outcome

From intake_csv 
INNER JOIN outcome_csv
ON intake_csv.animal_id_intake=outcome_csv.animal_id_outcome and 
intake_csv.order_of_intake=outcome_csv.order_of_outcome

--verify records
select * from acc_intake_outcome;

	
--create table for intake not with outcome
DROP TABLE IF EXISTS acc_intake_available;

select Index_ID_intake,
	Animal_ID_intake,
	DateTime_intake,
	MonthYear_intake,
	Found_Location,
	Intake_Type,
	Intake_Condition,
	Animal_Type_intake,
	Sex_upon_Intake,
	Age_upon_Intake,
	Breed_intake,
	Color_intake,
	"Age_Upon_Intake(days)",
	"Age_Upon_Intake(years)",
	Age_Range_intake,
	Intake_Month,
	Intake_Year,
	Intake_Weekday,
	Intake_Hour,
	Intake_Frequency,
	Order_of_Intake
INTO acc_intake_available

From intake_csv 
Left Outer Join outcome_csv
ON intake_csv.animal_id_intake=outcome_csv.animal_id_outcome and 
intake_csv.order_of_intake=outcome_csv.order_of_outcome
Where outcome_csv.animal_id_outcome IS NULL;

select * from acc_intake_available