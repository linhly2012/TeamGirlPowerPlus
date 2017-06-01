#shiny dashboard 
#https://rstudio.github.io/shinydashboard/get_started.html
#condition Panel 
#https://shiny.rstudio.com/reference/shiny/latest/conditionalPanel.html
#install.packages('shinydashboard')

library(shinydashboard)
library(shiny)
library(dplyr)
library(googleVis)
library(ggplot2)

# setwd("C:/Users/zacht/Documents/info-201/final-project/TeamGirlPowerPlusOne/box-display")
df_2014 <- read.csv('../States.Level.Data/Crime.And.Education.Rate.2014-StatesLevel.csv')
df_2013 <- read.csv('../States.Level.Data/Crime.And.Education.Rate.2013-StatesLevel.csv')
df.data <- df_2013

server <- function(input, output) {
  #render the whole map
  output$view <- renderGvis({
    
    if(input$year == 2014) {
      df.data <- df_2014
    } 
    else if(input$year == 2013) {
      df.data <- df_2013
    }
    #clean up the df.data - remove unneccessary columns
    df.data <- data.frame(df.data[2], df.data[4:15])
    #rename
    df.data <- plyr::rename(df.data, c("Violent.Crime.rate" = "Violent Crime Rate", 
                             "Murder.and.nonnegligent.manslaughter.rate" = "Murder & Nonnegligent Manslaughter Rate",
                             "Legacy.rape.rate..1" = "Legacy Rape Rate",
                             "Revised.rape.rate..2" = "Revised Rape Rate",
                             "Robbery.rate" = "Robbery Rate",
                             "Aggravated.assault.rate" = "Aggravated Assault Rate",
                             "Economically.disadvantaged" = "Economically Disadvantaged",
                             "Limited.English.proficiency" = "Limited English Proficiency",
                             "Students.with.disabilities" = "Students With Disabilities"))
    
    GeoStates <- gvisGeoChart(df.data, "State", "Total",
                              "Population",
                              options=list(region="US",
                                           displayMode="regions",
                                           resolution="provinces",
                                           colors="['#4286f4']",
                                           width= 600, 
                                           heigh = 400))
  })
  
  #render the table information
  output$table <- renderTable({
    #due to of the weird value being include in the df.data
    #df.data -> reformat to only appropriate information and 
    #value of interest
    #check.names = remove the dot between column names since 
    #there is white space in between words
    if(input$table_year == 2013) {
      tmp <- df_2013
    }
    else if(input$table_year == 2014) {
      tmp <- df_2014
    }
    else if(input$table_year == 'Both') {
      tmp <- rbind(x=df_2013,
                   y=df_2014)
    }
    if(input$table_state != 'All') {
      tmp <- filter(tmp, State == input$table_state)
    }
    #clean up the df.data - remove unneccessary columns
    tmp <- data.frame(tmp[2], tmp[4:15])
    #rename
    tmp <- select(tmp, State, Year, Violent.Crime.Rate, Murder...Nonnegligent.Manslaughter.Rate, Revised.Rape.Rate, 
                  Robbery.Rate, Aggravated.Assault.Rate, Total, Economically.Disadvantaged, 
                  Limited.English.Proficiency, Students.With.Disabilities) %>% 
            mutate(Violent.Crime.Graduation.Ratio = Violent.Crime.Rate / Total)
    colnames(tmp) <- c("State", "Year", "Violent Crime Rate", "Murder/Nonegligent manslaugter Rate", "Rape Rate", "Robbery Rate", 
                       "Aggravated Assault Rate", "Graduation Rate", "Economically Disadvantaged Rate", "Limited English Proficiency Rate",
                       "Student Disability Rate", "Violent Crime/Graduation Ratio")
    data.frame(tmp, check.names = FALSE)
  },
  digits = 1)
}

