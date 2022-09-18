library(tidyverse)
library(jsonlite)
library("readxl")
library("lubridate")
library("tidyr")
library("dplyr")
library("stringr")
library("ggplot2")




# Read acc_intake_outcome.csv
# avail_df<- read.csv('C:/Users/Sharon/Desktop/Project/Project_A_Team/Resources/acc_intake_available.csv', sep=',', header = TRUE, fill = TRUE)
# 
# # Read acc_intake_outcome.csv
# main_df<- read.csv('C:/Users/Sharon/Desktop/Project/Project_A_Team/Resources/acc_intake_outcome.csv', sep=',', header = TRUE, fill = TRUE)

# Read acc_all_data.csv
all_df<- read.csv('C:/Users/Sharon/Desktop/Project/Project_A_Team/Resources/aac_all_data.csv', sep=',', header = TRUE, fill = TRUE)


all_df<-all_df %>% 
  mutate(outcome_year=as.factor(outcome_year),
         intake_type=as.factor(intake_type),
         intake_condition=as.factor(intake_condition),
         animal_type_intake=as.factor(animal_type_intake),
         color_intake=as.factor(color_intake),
         intake_month=as.factor(intake_month),
         age_range_intake=as.factor(age_range_intake),
         intake_year=as.factor(intake_year),
         intake_weekday=as.factor(intake_weekday),
         outcome_type=as.factor(outcome_type),
         breed_intake_subtype=as.factor(breed_intake_subtype),
         main_breed_intake=as.factor(main_breed_intake),
         breed_contains_pitbull=as.factor(breed_contains_pitbull),
         sex_upon_intake_subtype=as.factor(sex_upon_intake_subtype),
         sex_upon_intake=as.factor(sex_upon_intake),
         outcome=as.factor(outcome)
)

#Make NA's 0
all_df[is.na(all_df)]<-0

#Filter negative days in shelter
# main_df<-filter(main_df, days_in_shelter >=0 & age_upon_outcome.days.>0)
# 
# avail_df<-filter(avail_df, days_in_shelter>0)

all_df<-filter(all_df, days_in_shelter >=0)

# main_dog_df<-filter(main_df, animal_type_intake=='Dog')
# main_cat_df<-filter(main_df, animal_type_intake=='Cat')
# 
# avail_dog_df<-filter(avail_df, animal_type_intake=='Dog') 
# avail_cat_df<-filter(avail_df, animal_type_intake=='Cat')

all_dog_df<-filter(all_df, animal_type_intake=='Dog') 
all_cat_df<-filter(all_df, animal_type_intake=='Cat')

all_df_graph<-filter(all_df, outcome != 'Available' &
                     (animal_type_intake == 'Cat' |
                     animal_type_intake == 'Dog'))

dog_df_graph<-filter(all_df, outcome != 'Available' &
                       (animal_type_intake == 'Dog'))

cat_df_graph<-filter(all_df, outcome != 'Available' &
                       (animal_type_intake == 'Cat'))
                       



available_dog<-filter(all_dog_df, State=='Available')
##################################Dogs
traindog<-filter(all_dog_df,((intake_year=='2013'| intake_year=='2014'|intake_year=='2015'|intake_year=='2016'|intake_year=='2017'|intake_year=='2018'|intake_year=='2019'|intake_year=='2020')
& outcome== 'Successful'))

#& (outcome_type=='Return to Owner'| outcome_type=='	
#Adoption'| outcome_type=='Rto-Adopt')))
                 

testdog<-filter(dog_df,(outcome_year=='2021' | outcome_year=='2022'))

##########Graphing
lm.graph<-ggplot(cat_df_graph, 
  aes(x=age_upon_intake.years., 
  y=days_in_shelter, 
  label = outcome))+ 
  geom_point(mapping=aes(color=outcome))+
  geom_smooth(method='lm', col="black")+
  theme_bw()+
  scale_color_discrete("Outcome")+
  labs(Title = "Cat: Days in Shelter",
       x= "Age Upon Intake",
       y= "Days in Shelter"
       )
lm.graph

plot(days_in_shelter ~ age_upon_intake.days., data=dog_df_graph)

boxplot(days_in_shelter~intake_type, data=all_dog_df, main="Title", xlab="Age in Years",
        ylab="Days In Shelter")

#box plot
ggplot(data=cat_df_graph)+geom_bar(mapping = aes(x=intake_year, fill = outcome))


p<-ggplot(all_df, aes(x=animal_type_intake,
                             y=count(index_id_intake),
                             fill=animal_type_intake))+
  geom_bar(stat="identity")+theme_minimal()
p


traindog.lm<-lm(days_in_shelter ~ intake_type+intake_condition+color_intake+intake_month+ intake_year+intake_weekday+intake_hour+ intake_frequency+outcome_type+breed_intake_subtype+ breed_intake+breed_contains_pitbull+sex_upon_intake, age_upon_intake.days.,data = traindog)



traindog.lm
summary(traindog.lm)
plot(traindog.lm)

####Cats

cat_df<-filter(main_df, animal_type_intake=='Cat') 

traincat<-filter(cat_df,((outcome_year=='2013'| outcome_year=='2014'|outcome_year=='2015'|outcome_year=='2016'|outcome_year=='2017'|outcome_year=='2018'|outcome_year=='2019'|outcome_year=='2020') & (outcome_type=='Return to Owner'| outcome_type=='	
Adoption'| outcome_type=='Rto-Adopt')))

traincat.lm<-lm(days_in_shelter ~ intake_type +
                  intake_condition + intake_month + 
                  age_upon_intake.days. + age_range_intake +  
                  intake_year + intake_weekday + + sex_upon_intake +
                  outcome_type + color_intake +
                  breed_intake_subtype + main_breed_intake,
                data = traincat)

traincat.lm
summary(traincat.lm)

