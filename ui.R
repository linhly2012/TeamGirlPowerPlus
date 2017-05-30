# working directory commented out for shiny app publication
#setwd("~/INFO201/a8-building-apps-christiegan/")

# Create a shinyUI with a fluidPage layout
shinyUI(fluidPage(
  
  titlePanel("Areas of Crime and Its Correlation to the Student Demographic"),
  
  sidebarLayout(
    
    sidebarPanel( 
      # allows user to select a type of crime in the US
      selectInput("crime", label = "Crime Type", choices = tail(crime.dataset, length(list.of.nutrition)-8)),
    
      # allows user to select a type of student
      selectInput("student type", label = "Student Demographic", choices = tail(list.of.nutrition, 
                                                                                c("American Native or Alaskan Native", "Asian or Pacific Islander", "Hispanic", "Black", "White", "Economically Disadvantaged", "Limited English Proficiency", "Students with disabilities"))),
      # allows user to select a color from a list of choices
      radioButtons("color", label = h3("Color"), choices = list('Red' = 'red', 'Blue' = 'blue', 'Green' = 'green'))            
    ),
    
    mainPanel(
      # plotting out the map
      plotlyOutput('map')
    )
  
  )
  
))
