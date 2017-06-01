library('dplyr')

#df_2013 <- read.csv('./States Level Data/Crime And Education Rate2013-StatesLevel.csv')
df_2014 <- read.csv('./States Level Data/Crime And Education Rate2014-StatesLevel.csv')

#Summary for data in 2014 
#State has the lowest graduation rate
lowestGraduationRate <- df_2014 %>% filter(Total == min(Total))
#state 
lowestGradRateLocation <- lowestGraduationRate %>% select(State) %>% as.matrix()
#look into crime rate in the state
state_population <- lowestGraduationRate$Population
#violent crime info rate
violent_crime <- lowestGraduationRate$Violent.Crime.rate
#murder -similar crime rate
murder_nonnegligent_manslaughter <- lowestGraduationRate$Murder.and.nonnegligent.manslaughter.rate
#legacy rape rate 1
legacy_rape_1 <- lowestGraduationRate$Legacy.rape.rate..1
# revised rape rate 2
revised_rape_2 <- lowestGraduationRate$Revised.rape.rate..2 
#robery 
robbery <- lowestGraduationRate$Robbery.rate
#Aggravated assault 
aggravated_assault <- lowestGraduationRate$Aggravated.assault.rate


#State has the highest graduation rate 
highestGraduationRate <- df_2014 %>% filter(Total == max(Total))
#location
highestGradRateLocation <- highestGraduationRate %>% select(State) %>% as.matrix()
#look into crime rate in the state
high_state_population <-highestGraduationRate$Population
#violent crime info rate
high_violent_crime <- highestGraduationRate$Violent.Crime.rate
#murder -similar crime rate
high_murder_nonnegligent_manslaughter <- highestGraduationRate$Murder.and.nonnegligent.manslaughter.rate
#legacy rape rate 1
high_legacy_rape_1 <- highestGraduationRate$Legacy.rape.rate..1
# revised rape rate 2
highrevised_rape_2 <- highestGraduationRate$Revised.rape.rate..2 
#robery 
high_robbery <- highestGraduationRate$Robbery.rate
#Aggravated assault 
high_aggravated_assault <- highestGraduationRate$Aggravated.assault.rate