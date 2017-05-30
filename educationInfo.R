library('dplyr')
library('readxl')

#set working directory
#setwd("/Users/linhly/Desktop/INFO/TeamGirlPowerPlusOne")

#value is go by percent of students 
#the data has been clean in a readable format through Google Drive excel 
#all the value in the data infomration go by "PERCENT OF STUDENT" for each 
#variable
#reading the graduation rate of HS students in each state

#for the year of 2014 - data will be using is 2013 - 2014
grad_rates_13_14 <- read.csv('./data/education-grad-rate-revised-data-2013-2014.csv')

#for the year of 2013 - data will be using is 2012 - 2013
grad_rates_12_13 <- read.csv('./data/education-grad-rates-revised-2012-2013.csv')

#reading in crimerates data 
crime_rates <- read.csv('./data/CrimeStateByState_Clean.csv')

#new location to store the file in states level by year
dir.create('States Level Data')

#use function to filter down the crime rates df to interest year. 
#looking into to two df, due to two differen years 2013 and 2014
FilterDfYear <- function (year) {
  df_state_crime_year <- crime_rates %>% filter(Year == year)
  #df <- merge(x=df_state_crime_year, y=grad_rates_df, by='State')
  if(year == 2013) {
    df <- merge(x=df_state_crime_year, y=grad_rates_12_13, by='State')
  }
  else {
    df <- merge(x=df_state_crime_year, y=grad_rates_13_14, by='State')    
  }
  
  path <- paste0('./States Level Data/Crime And Education Rate', year, '-StatesLevel.csv')
  #to csv file for each year 
  write.csv(df, file=path)
  return(df)
}

#there will be a column name TOTAL -> it is the value of 
#PERCENT OF STUDENTS gradute from that state during that
#school year.

#note for JoinedCrimeAndEd2013 df, there will be only 50 obs.
#because in 2012-2013 school year, Idoho about graduation rate 
#data is not available.
JoinedCrimeAndEd2013 <- FilterDfYear(2013)
JoinedCrimeAndEd2014 <- FilterDfYear(2014)

