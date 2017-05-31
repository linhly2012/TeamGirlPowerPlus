library(shiny)
library(dplyr)
# working directory commented out for shiny app publication
#setwd("/Users/shjang1025/Desktop/info/TeamGirlPowerPlusOne/testing ui and server/")

#load data
CAER2013 <- read.csv("Crime And Education Rate2013-StatesLevel.csv")
CAER2014 <- read.csv("Crime And Education Rate2014-StatesLevel.csv")

#change the column names in each dataset.
names(CAER2013)[6:11] <- c("Violent Crime", "Murder and non-negligent manslaughter", "Legacy rape", "Revised rape", "Robbery", "Aggravated assault")
names(CAER2013)[13:15] <- c("Economically disadvantaged", "Limited English Proficiency", "Disabled students")
names(CAER2014)[6:11] <- c("Violent Crime", "Murder and non-negligent manslaughter", "Legacy rape", "Revised rape", "Robbery", "Aggravated assault")
names(CAER2014)[13:15] <- c("Economically disadvantaged", "Limited English Proficiency", "Disabled students")

# Create a shinyUI with a fluidPage layout
shinyUI(fluidPage(
  
  titlePanel("Areas of Crime and Its Correlation to the Student Demographic"),
  
  sidebarLayout(
    
    sidebarPanel( 
      # allows user to select a type of crime in the US
      selectInput(inputId = "crime", 
                  label = "Crime Type", 
                  choices = colnames(CAER[,6:11])),
      
      # allows user to select a year
      selectInput(inputId = "year",
                  label = "Year:",
                  choices = list('2013','2014')),
      
      # allows user to select a type of student
      selectInput(inputId = "student type", 
                  label = "Education:", 
                  choices = colnames(CAER[,13:15])),
      
      # allows user to select a color from a list of choices
      radioButtons("color", 
                   label = "Color:", 
                   choices = c("Orange" = "orange", 
                               "Green" = "green", 
                               "Pink" = "pink", 
                               "Black" = "black")),
    br(),
                  
     submitButton("Find"),
                  
     br()
      ),
      
      mainPanel(
        
        # plotting out the graph
        plotlyOutput('plot')
      )
    )
    
  ))
  