library(shiny)
library(dplyr)
library(googleVis)

#df <- read.csv('./States Level Data/Crime And Education Rate2014-StatesLevel.csv')
#clean up the df - remove unneccessary columns
#df <- data.frame(df[2], df[4:15])
#rename
#df <- plyr::rename(df, c("Violent.Crime.rate" = "Violent Crime Rate", 
                         # "Murder.and.nonnegligent.manslaughter.rate" = "Murder & Nonnegligent Manslaughter Rate",
                         # "Legacy.rape.rate..1" = "Legacy Rape Rate..1",
                         # "Revised.rape.rate..2" = "Revised Rape Rate..2",
                         # "Robbery.rate" = "Robbery Rate",
                         # "Aggravated.assault.rate" = "Aggravated Assault Rate",
                         # "Economically.disadvantaged" = "Economically Disadvantaged",
                         # "Limited.English.proficiency" = "Limited English Proficiency",
                         # "Students.with.disabilities" = "Students With Disabilities"))
#View(df)

function(input, output) {
  #render the whole map
  output$view <- renderGvis({
    GeoStates <- gvisGeoChart(df, "State", "Total",
                              "Population",
                              options=list(region="US",
                                           displayMode="regions",
                                           resolution="provinces",
                                           colors="['#4286f4']",
                                           width=800, 
                                           heigh = 500))
  })

  #render scatter
  output$plot <- renderPlot({
    state.names <- df$State %>% unique() %>% as.list()
    for(name in state.names) {
      if(input$state == name) {
        plot.data <- df %>% select(name)
        break
      }
    }
  })

  
  ggplot(plot.data, aes(x=x_variable, y=y_variable, color=factor(name))) + geom_point() +
    labs(x=x_name,y=name) 
  
  #render the table information
  output$table <- renderTable({
    #due to of the weird value being include in the df
    #df -> reformat to only appropriate information and 
    #value of interest
    #check.names = remove the dot between column names since 
    #there is white space in between words
    data.frame(df, check.names=FALSE)
  })
}
