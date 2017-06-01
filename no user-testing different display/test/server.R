library(shiny)
library(dplyr)
library(googleVis)
library(ggplot2)

setwd("/Users/linhly/Desktop/INFO/TeamGirlPowerPlusOne/")
df_2014 <- read.csv('./States Level Data/Crime And Education Rate2014-StatesLevel.csv')
df_2013 <- read.csv('./States Level Data/Crime And Education Rate2013-StatesLevel.csv')

function(input, output) {
  #render the whole map
  output$view <- renderGvis({
    
    if(input$year == 2014) {
      df <- df_2014
    } 
    else if(input$year == 2013) {
      df <- df_2013
    }
    #clean up the df - remove unneccessary columns
    df <- data.frame(df[2], df[4:15])
    #rename
    df <- plyr::rename(df, c("Violent.Crime.rate" = "Violent Crime Rate", 
                             "Murder.and.nonnegligent.manslaughter.rate" = "Murder & Nonnegligent Manslaughter Rate",
                             "Legacy.rape.rate..1" = "Legacy Rape Rate",
                             "Revised.rape.rate..2" = "Revised Rape Rate",
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
                                           width=700, 
                                           heigh = 400))
    
  })
  
  #render the table information
  output$table <- renderTable({
    #due to of the weird value being include in the df
    #df -> reformat to only appropriate information and 
    #value of interest
    #check.names = remove the dot between column names since 
    #there is white space in between words
    if(input$table_state == 'All'){
      data.frame(df, check.names=FALSE)      
    }
    else {
      tmp <- df %>% filter(State == input$table_state)
      data.frame(tmp, check.names = FALSE)
    }
  })
}
