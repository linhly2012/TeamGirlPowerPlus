#install.packages('googleVis')
library(googleVis)
library(dplyr)
#gvisGeoChart
#https://www.rdocumentation.org/packages/googleVis/versions/0.6.0/topics/gvisGeoChart
#different type of map with gvisGeoChart
#https://cran.r-project.org/web/packages/googleVis/vignettes/googleVis_examples.html

#Implementing gvis to shiny
#https://cran.r-project.org/web/packages/googleVis/vignettes/googleVis.pdf

df <- read.csv('./States Level Data/Crime And Education Rate2014-StatesLevel.csv')
#clean up the df - remove unneccessary columns
df <- data.frame(df[2], df[4:15])
#rename
df <- plyr::rename(df, c("Violent.Crime.rate" = "Violent Crime Rate", 
                         "Murder.and.nonnegligent.manslaughter.rate" = "Murder & Nonnegligent Manslaughter Rate",
                         "Legacy.rape.rate..1" = "Legacy Rape Rate..1",
                         "Revised.rape.rate..2" = "Revised Rape Rate..2",
                         "Robbery.rate" = "Robbery Rate",
                         "Aggravated.assault.rate" = "Aggravated Assault Rate",
                         "Economically.disadvantaged" = "Economically Disadvantaged",
                         "Limited.English.proficiency" = "Limited English Proficiency",
                         "Students.with.disabilities" = "Students With Disabilities"))


GeoStates <- gvisGeoChart(df, "State", "Total",
                          "Population",
                          options=list(region="US",
                                       displayMode="regions",
                                       resolution="provinces",
                                       colors="['#4286f4']",
                                       width=800, 
                                       heigh = 500))
plot(GeoStates)

