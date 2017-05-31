#load 'readr' 'plotly' 'shiny' 'dplyr'
library(readr)
library(plotly)
library(shiny)
library(dplyr)

#set working directory
#setwd("/Users/shjang1025/Desktop/info/a8-building-apps-shjang1025")


# Define the data that is shown based on your inputs defined in the UI
# and turn it into an output plot
shinyServer(function(input, output) {
  
  output$plot <- renderPlotly({
    
    
  })
})


