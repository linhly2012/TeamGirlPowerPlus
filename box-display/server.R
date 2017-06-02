#install.packages('shinydashboard')

library(shinydashboard)
library(shiny)
library(dplyr)
library(googleVis)
library(ggplot2)
library(magrittr)
library(plotly)
library(knitr)
# setwd("C:/Users/zacht/Documents/info-201/final-project/TeamGirlPowerPlusOne/box-display")
#df_2014 <- read.csv('../States.Level.Data/Crime.And.Education.Rate.2014-StatesLevel.csv')
#df_2013 <- read.csv('../States.Level.Data/Crime.And.Education.Rate.2013-StatesLevel.csv')
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
                                           width= 380, 
                                           heigh = 500))
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
  })
  
  #this method render a scatterplot that is support by plotly. The scatterplot 
  #will be use to display the correlation between the information of crimes rate
  #and education rates(including, "Economically Disadvantaged Rate", "Limited English 
  #Proficiency Rate", "Student Disability Rate") of each state.
  output$plot <- renderPlotly({
    if(input$year == 2014) {
      df.data <- df_2014
    } 
    else if(input$year == 2013) {
      df.data <- df_2013
    }
    #clean up the df.data - remove unneccessary columns
    df.data <- data.frame(df.data[2], df.data[4:15])
    
    #identify y-label and variable go on y axis and color for each crime
    if(input$crime == "Violent Crime Rate") {
      y_var = df.data$Violent.Crime.Rate
      color_display = '#ff422d'
    }
    else if(input$crime == "Murder/Nonegligent manslaugter Rate") {
      y_var = df.data$Murder...Nonnegligent.Manslaughter.Rate
      color_display = '#b71f4a'
    }
    else if(input$crime == "Rape Rate") {
      y_var = df.data$Revised.Rape.Rate
      color_display = '#7e5591'
    }
    else if(input$crime == "Robbery Rate") {
      y_var = df.data$Revised.Rape.Rate  
      color_display = '#5b6166'
    }
    else if(input$crime == "Aggravated Assault Rate") {
      y_var = df.data$Aggravated.Assault.Rate
      color_display = '#b20a01'
    }
    y_label = input$crime
    
    plot <- plot_ly(df.data,
                    x = ~df.data$Economically.Disadvantaged,
                    y = ~y_var,
                    type = 'scatter',
                    mode = 'markers',
                    marker = list(size = 10, color = ~color_display,
                                  line = list(color = '#bae8ff', width = 1)),
                    text = ~paste0("Location: ", df.data$State, "<br />",
                                   "Population: ", df.data$Population, "<br />",
                                   y_label, ": ", y_var, 
                                   "<br />", "Economically Disadvatanged", ": ", 
                                   df.data$Economically.Disadvantaged,
                                   "<br />")) %>%
      layout(xaxis = list(title = paste0("Economically Disadvatanged",
                                         "<br />", "(Percentage of Students)")),
             margin = list(b = 50),
             yaxis = list(title = y_label, zeroline = TRUE)
      )
  })

  #render summary page
  output$Summary <- renderTable({
    if(input$summary_year == 2014) {
      tmp <- df_2014
    } else if(input$summary_year == 2013) {
      tmp <- df_2013
    }
    tmp <- tmp %>% select(2, 4:7, 9:15)
    high.grad <- tmp %>% filter(Total == max(Total))
    low.crime <- tmp %>% filter(Violent.Crime.Rate == min(Violent.Crime.Rate))
    high.crime <- tmp %>% filter(Violent.Crime.Rate == max(Violent.Crime.Rate))
    low.grad <- tmp %>% filter(Total == min(Total))
    high.crime.state <- tmp %>% filter(State != "District of Columbia") %>% filter(Violent.Crime.Rate == max(Violent.Crime.Rate))
    low.grad.state <- tmp %>% filter(State != "District of Columbia") %>% filter(Total == min(Total))
    tmp <- rbind(high.grad, low.grad, low.grad.state, low.crime, high.crime, high.crime.state)
    tmp <- cbind(Status = c("Highest Graduation Rate", "Lowest Graduation Rate", "lowest Graduation Rate (State)",
                            "Lowest Crime Rate", "Highest Crime Rate", "Highest Crime Rate (State)"), tmp)
    colnames(tmp) <- c("Status", "State", "Year", "Population", "Violent Crime Rate", "Murder/Nonnegligent Manslaughter Rate",
                       "Rape Rate", "Robbery Rate", "Aggravated Assault Rate", "Graduation Rate",
                       "Economically Disadvantaged Rate", "Limited English Proficiency Rate", "Student Disability Rate")
    data.frame(tmp, check.names = FALSE)
  })
}

