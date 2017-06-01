#load 'readr' 'plotly' 'shiny' 'dplyr'
library(readr)
library(plotly)
library(shiny)
library(dplyr)

#set working directory
#setwd("/Users/shjang1025/Desktop/info/TeamGirlPowerPlusOne/testing ui and server/")

#setwd("/Users/linhly/Desktop/INFO/TeamGirlPowerPlusOne/testing ui and server")

# Define the data that is shown based on your inputs defined in the UI
# and turn it into an output plot
shinyServer(function(input, output) {

  output$plot <- renderPlotly({
    
    color <- input$color
    
    if(input$year == '2013') {
      #x <- CAER2013$State
      Crime.Rate <- CAER2013[,input$crime]
      Education.Rate <- CAER2013[,input$`student type`]
      data <- data.frame(Crime.Rate, Education.Rate)
      
      #data$x <- factor(data$x, levels = data[["x"]])
      
      plot_ly(data, x = ~Crime.Rate, y = ~Education.Rate, marker = list(size = 8,color = color,
              line = list(color = color, width = 2)), text = ~paste('Crime Rate', Crime.Rate,'Education Rate', Education.Rate, sep = "<br />") ) %>%
              layout(title = 'Correlation of Crime rate and Education rate',
                    yaxis = list(zeroline = FALSE),
                    xaxis = list(zeroline = FALSE))
     
      
      #plot_ly(data, x = ~x, y = ~y1, type = 'bar', name = 'Crime rate', marker = list(color = color, line = list(color = color))) %>%
        #add_trace(y = ~y2, name = 'Education rate', marker = list(color = 'rgb(70,130,180)')) %>%
      #  layout(title = paste0("US Crime and Education rate in", input$year), xaxis = list(title = "", tickangle = -45),yaxis = list(title = ""),
      #         margin = list(b = 100),
      #         barmode = 'group')
      
      
    } else {
      #x <- CAER2014$State
      Crime.Rate <- CAER2014[,input$crime]
      Education.Rate <- CAER2014[,input$`student type`]
      data <- data.frame(Crime.Rate, Education.Rate)
      #data$x <- factor(data$x, levels = data[["x"]])
      
      plot_ly(data, x = ~Crime.Rate, y = ~Education.Rate,marker = list(size = 8,color = color,
                                                                       line = list(color = color, width = 2))) %>%
        layout(title = 'Correlation of Crime rate and Education rate',
               yaxis = list(zeroline = FALSE),
               xaxis = list(zeroline = FALSE))
      
      #plot_ly(data, x = ~x, y = ~y1, type = 'bar', name = 'Crime rate', marker = list(color = color, line = list(color = color))) %>%
        #add_trace(y = ~y2, name = 'Education rate', marker = list(color = 'rgb(70,130,180)')) %>%
      #  layout(title = paste0("US Crime and Education rate in", input$year), xaxis = list(title = "", tickangle = -45),yaxis = list(title = ""),
      #         margin = list(b = 100),
      #         barmode = 'group')
    }

  })
})


