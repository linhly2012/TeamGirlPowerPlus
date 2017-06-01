library(shinydashboard)
library(plotly)
#this return a list of html tags we can use for ui.R 
#names(tags)
dashboardPage(skin = "purple",
  dashboardHeader(title = "Welcome CBCAER"),
  #this method use to display the icon, and names of the tab menu  
  dashboardSidebar(
      sidebarMenu(
        menuItem("Maps", tabName = "maps", icon = icon("map")),
        menuItem("Table", tabName = "tables", icon = icon("table")),
        menuItem("About", tabName = "about", icon = icon("info"))
    )
  ),
  dashboardBody(
    #this tab item will display the maps and scatterplot of the dataframe 
    #with user choice of variable for x and y axis.
    tabItems(
      tabItem(tabName = "maps",
        h2("Data Visualization"),
        p("This is a map visualization of the crime rate for each state.
            Please hover over each data point for more information."),
        fluidRow(
          box(width = 5,
          selectInput(inputId = "year",
              label = "Year: ",
              choices = c("2013", "2014"),
              selected = "2013")
          ),
          p("This is a scatterplot that shows the trends/correlations between the rate of economically disadvantaged
            students in each state compared to a specific type of crime rate. This is aggregated by state level. 
            Please hover over each data point for more information."),
          box(width = 5,
          selectInput(inputId = "crime",
              label = "Y Variable: ",
              choices = c("Violent Crime Rate",
                          "Murder/Nonegligent manslaugter Rate", 
                          "Rape Rate", "Robbery Rate", 
                          "Aggravated Assault Rate"),
              selected = "Violent Crime Rate")
          )
        ),
        fluidRow(
          box(width = 5,
          title="Graduation Rate By Year (Percent)",
          solidHeader = TRUE, status = "primary",
          htmlOutput("view")
          ),
          box(width = 5,
          selectInput(inputId = "students.state.info",
              label = "X Variable: ",
              choices = c("Economically Disadvatanged",
                          "Limited English Proficiency",
                          "Student Disability"),
              selected = "Economically Disadvatange")
          ),
          box(width = 5,
          solidHeader = TRUE, status="primary", plotlyOutput("plot")
          )
        )
    ),
    #this tab item will create a new tab for user to view the table
    #info of different year(s) and state(s) level.
    tabItem(tabName = "tables",
      fluidRow(
        box(width = 5,
          selectInput(inputId = "table_state", 
          label = "State: ",
          choices = c("All", df.data$State %>% as.list()),
          selected = "All"
        ),
        selectInput(inputId = "table_year",
          label = "Year: ",
          choices = c("Both", "2013", "2014"),
          selected = "2013"
        )
      ),
      box( #display the table
        width=12,
        title="Correlation Between Crime & HS Graduation",
        solidHeader = TRUE,
        status = "primary",
        div(style = 'overflow-x: scroll', tableOutput("table"))
      )
     )
    ),
    #this tab item will create a separate tab for user to read about the info
    #of this project
    tabItem(tabName = "about",
      box(width = 8,
      h2("About This Project"),
      p(
        "For this project, we are trying to find the correlation between crimes and education 
        rates in each state. As it is almost part of the American culture, moving from states 
        to states, for different living purpose become something that happen to almost every 
        citizens. When moving, we always try to find out, 'if the location is a good place', or
        how's the schooling here for people who has kids."
      ),
      br(),
      p(
        "With the web application, user will get to see the most recent information about the 
        graduation (2013, 2014) year of graduation rate and crimes rate of each categories for
        each state. Through graph, user will able to see the relationship of each data points 
        for those states"
      ),
      tags$footer(
        p(
          "Credits: Zach Thomas, SoHyun Jang, Christie Gan, Linh Ly")
        )
      )
    )
  )
 )
)