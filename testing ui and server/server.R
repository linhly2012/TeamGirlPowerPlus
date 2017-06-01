#load 'readr' 'plotly' 'shiny' 'dplyr'
library(readr)
library(plotly)
library(shiny)
library(dplyr)


#set working directory
#setwd("/Users/shjang1025/Desktop/info/TeamGirlPowerPlusOne/testing ui and server/")

# Define the data that is shown based on your inputs defined in the UI
# and turn it into an output plot
shinyServer(function(input, output) {

  output$plot <- renderPlotly({
    
    color <- input$color
    
    #Make scatter plot to know correlation between 2013 Crime rate and Education rate
    if(input$year == '2013') {

      Crime.Rate <- CAER2013[,input$crime]
      Education.Rate <- CAER2013[,input$`student type`]
      data <- data.frame(Crime.Rate, Education.Rate)
      
      plot_ly(data, x = ~Crime.Rate, y = ~Education.Rate, marker = list(size = 8,color = color,
              line = list(color = color, width = 2)), text = ~paste('Crime Rate', Crime.Rate,'Education Rate', Education.Rate, sep = "<br />") ) %>%
              layout(title = 'Correlation of Crime rate and Education rate',
                    yaxis = list(zeroline = FALSE),
                    xaxis = list(zeroline = FALSE))
      #Make scatter plot to know correlation between 2014 Crime rate and Education rate   
    } else {
      
      Crime.Rate <- CAER2014[,input$crime]
      Education.Rate <- CAER2014[,input$`student type`]
      data <- data.frame(Crime.Rate, Education.Rate)
      
      plot_ly(data, x = ~Crime.Rate, y = ~Education.Rate,marker = list(size = 8,color = color,
                                                                       line = list(color = color, width = 2))) %>%
        layout(title = 'Correlation of Crime rate and Education rate',
               yaxis = list(zeroline = FALSE),
               xaxis = list(zeroline = FALSE))
    }

  })
})


