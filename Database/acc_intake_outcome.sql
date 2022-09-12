--intake_df
--DROP TABLE IF EXISTS intake_df;
--modify intake_df from AAC_Intake_etl_step1.ipynb script
--drop added index column
ALTER TABLE intake_df DROP index;
--change datetime from text to datetime
ALTER TABLE intake_df
    ALTER COLUMN datetime_intake TYPE timestamp without time zone
    USING datetime_intake::timestamp without time zone;
--add primary keys
ALTER TABLE intake_df ADD PRIMARY KEY ("animal_id_intake", "order_of_intake");
--verify records
select * from intake_df;

--outcome_df
--DROP TABLE IF EXISTS outcome_df;
--modify outcome_df from AAC_Outcome_etl_step1.ipynb script
--drop added index column
ALTER TABLE outcome_df DROP index;
--change datetime from text to datetime
ALTER TABLE outcome_df
    ALTER COLUMN datetime_outcome TYPE timestamp without time zone
    USING datetime_outcome::timestamp without time zone;
--add primary keys
ALTER TABLE outcome_df ADD PRIMARY KEY ("animal_id_outcome", "order_of_outcome");
--verify records
select * from outcome_df;


--zipcodes_df
--DROP TABLE IF EXISTS zipcodes_df;
--modify zipcodes_df from Demographic_data.ipynb script
--drop added index column
ALTER TABLE zipcodes_df DROP index;
--change index_id from text to integar
ALTER TABLE zipcodes_df
    ALTER COLUMN index_id TYPE bigint
	USING index_id::bigint
--add primary keys
ALTER TABLE zipcodes_df ADD PRIMARY KEY ("index_id");
--verify records
select * from zipcodes_df;




--create combined table
DROP TABLE IF EXISTS acc_intake_outcome;

select intake_df.*,outcome_df.*,
case when breed_intake LIKE '%Mix%' then 'Mix' when  breed_intake LIKE '%mix%' then 'Mix' else 'Purebred' end as breed_intake_subtype,
case when breed_intake LIKE '%Mix%' then regexp_replace(breed_intake,'Mix','','g')
	when breed_intake LIKE '%/%' then regexp_replace(breed_intake,'^([^/]+).*$','\1')
	else breed_intake end as main_breed_intake,
case when breed_intake LIKE '%Pit Bull%' then 'Y' else 'N' end as breed_contains_pitbull,
case when sex_upon_intake LIKE '%Female%' then 'Female' else 'Male' end as sex_upon_intake_subtype,
datetime_outcome - datetime_intake as time_in_shelter,
case when split_part((datetime_outcome - datetime_intake)::text,' ',1) LIKE '%:%' then '0' else split_part((datetime_outcome - datetime_intake)::text,' ',1) end as days_in_shelter,
zipcode as zipcode_intake,
longitude as longitude_intake,
latitude as latitude_intake

INTO acc_intake_outcome

From intake_df 
INNER JOIN outcome_df
ON intake_df.animal_id_intake=outcome_df.animal_id_outcome and 
intake_df.order_of_intake=outcome_df.order_of_outcome
LEFT OUTER JOIN zipcodes_df
ON intake_df.index_id_intake=zipcodes_df.index_id

--change days_in_shelter to numeric
ALTER TABLE acc_intake_outcome ALTER COLUMN days_in_shelter TYPE NUMERIC(10,0)
            USING COALESCE(NULLIF(days_in_shelter, '')::NUMERIC, 0);
			
--verify records
select * from acc_intake_outcome
where NOT zipcode_intake IS NULL;			

--create table for intake not with outcome
DROP TABLE IF EXISTS acc_intake_available;

select index_id_intake,
	animal_id_intake,
	datetime_intake,
	monthyear_intake,
	found_location,
	intake_type,
	intake_condition,
	animal_type_intake,
	sex_upon_intake,
	age_upon_intake,
	breed_intake,
	color_intake,
	"age_upon_intake(days)",
	"age_upon_intake(years)",
	age_range_intake,
	intake_month,
	intake_year,
	intake_weekday,
	intake_hour,
	intake_frequency,
	order_of_intake,
	case when breed_intake LIKE '%Mix%' then 'Mix' when  breed_intake LIKE '%mix%' then 'Mix' else 'Purebred' end as breed_intake_subtype,
	case when breed_intake LIKE '%Mix%' then regexp_replace(breed_intake,'Mix','','g')
	when breed_intake LIKE '%/%' then regexp_replace(breed_intake,'^([^/]+).*$','\1')
	else breed_intake end as main_breed_intake,
	case when breed_intake LIKE '%Pit Bull%' then 'Y' else 'N' end as breed_contains_pitbull,
	case when sex_upon_intake LIKE '%Female%' then 'Female' else 'Male' end as sex_upon_intake_subtype,
	NOW() - datetime_intake as time_in_shelter,
	case when split_part((NOW() - datetime_intake)::text,' ',1) LIKE '%:%' then '0' else split_part((NOW() - datetime_intake)::text,' ',1) end as days_in_shelter,
	zipcode as zipcode_intake,
	longitude as longitude_intake,
	latitude as latitude_intake


INTO acc_intake_available

From intake_df 
Left Outer Join outcome_df
ON intake_df.animal_id_intake=outcome_df.animal_id_outcome and 
intake_df.order_of_intake=outcome_df.order_of_outcome
LEFT OUTER JOIN zipcodes_df
ON intake_df.index_id_intake=zipcodes_df.index_id
Where outcome_df.animal_id_outcome IS NULL;

--change days_in_shelter to numeric
ALTER TABLE acc_intake_available ALTER COLUMN days_in_shelter TYPE NUMERIC(10,0)
            USING COALESCE(NULLIF(days_in_shelter, '')::NUMERIC, 0);

select * from acc_intake_available
--where NOT zipcode_intake IS NULL;