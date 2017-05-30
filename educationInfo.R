library('dplyr')
library('readxl')

#set working directory
setwd("/Users/linhly/Desktop/INFO/TeamGirlPowerPlusOne")

#value is go by percen of students 
#the data has been clean in a readable format through Google Drive excel 
#all the value in the data infomration go by "PERCENT OF STUDENT" for each 
#variable
data_graduation_rates <- read.csv('./data/education-grad-rate-revised-data.csv')

crime_rates <- read.csv('./data/CrimeStateByState_Clean.csv')

test_join_data_CA_ed <- data_graduation_rates %>% filter(State == 'California')
test_join_data_CA_crime <- crime_rates %>% filter(State == 'California' , (Year == 2013 | Year == 2014))

join_data <- merge(x=test_join_data_CA_ed , y=test_join_data_CA_crime, by='State')
