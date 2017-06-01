library(shinydashboard)
library(plotly)
#this return a list of html tags we can use for ui.R 
#names(tags)
dashboardPage(skin = "purple",
              dashboardHeader(title = "CR&ER"),
              #this method use to display the icon, and names of the tab menu  
              dashboardSidebar(
                sidebarMenu(
                  menuItem("Summary", tabName = "Summary", icon = icon("star")),
                  menuItem("Data Visualization", tabName = "maps", icon = icon("map")),
                  menuItem("Table", tabName = "tables", icon = icon("table")),
                  menuItem("About", tabName = "about", icon = icon("info"))
                )
              ),
              dashboardBody(
                
                #This tab will show a summary of the most siginifcant data points
                tabItems(
                  tabItem(tabName = "Summary",
                          box(width=12,
                            tags$b(tags$p(style = "font-size: 25px;", 
                            "Welcome to CR&ER! Where we focus on finding the association between 
                            Crime Rates & Education Rates across United States."
                            ), align="center")
                          ),
                          fluidRow(
                            box(width = 5,
                                selectInput(inputId = "summary_year",
                                            label = "Year: ",
                                            choices = c("2013", "2014"),
                                            selected = "2013")
                            ),
                            box(width = 12,
                                title = "Summary of Data",
                                solidHeader = TRUE,
                                status = "primary",
                                div(style = 'overflow-x: scroll', tableOutput("Summary"))
                            )
                          )
                      ),
                  tabItem(tabName = "maps",
                          tags$b(h2("Data Visualization", align="center")),
                          box(width=10,
                              p(
                                "On this page, you will able to see the total of students graduated
                                from high school in each states (measure in percent). Along with a 
                                graph for comparison - each crimes versus information related to 
                                high school graduates. "
                              ), align="center"
                          ),
                          fluidRow(
                            box(width = 5,
                                selectInput(inputId = "year",
                                            label = "Year: ",
                                            choices = c("2013", "2014"),
                                            selected = "2013")
                            ),
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
                                title="Graduation Rate By Year (Measure: percent of Students)",
                                solidHeader = TRUE, status = "primary",
                                htmlOutput("view")
                            ),
                            box(width = 5,
                                selectInput(inputId = "students.state.info",
                                            label = "X Variable: (Unit: percentage of students)",
                                            choices = c("Economically Disadvatanged",
                                                        "Limited English Proficiency",
                                                        "Student Disability"),
                                            selected = "Economically Disadvatange")
                            ),
                            box(width = 5,
                                title="Correlation Between Crime and Education",
                                solidHeader = TRUE, status="primary", plotlyOutput("plot"),
                                helpText("Note: The unit is crime rate for type of crime, 
                                         because through the source, they used specific type 
                                         of algorithm to find the value. ")
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
                                "For this project, we are looking for a correlation between crimes and education 
                                rates in each state. Nearly everyone will move to a new state or at least travel
                                in their lifetime which make this information relevant to nearly every American 
                                citizen in addition to foreign visitors. How safe a state is as well as the quality
                                of education one can find there are essential factors in determing where one may move."
                              ),
                              br(),
                              p(
                                "With this web application, a user will be able to see the most recent information about 
                                education and and violent crime rate for every state and make the appropriate comparisons
                                with the helpful and intuitive interactive features. One can see a brief overview of the
                                best and worst areas on the summary page, On the map page one can see how certain education
                                factors relate to violent crime as well as a geographical representation that gives information
                                about each state. If a user wants to view all of the inoframtion available they can checkout
                                the Table tab that can be organized by state and year."
                              ),
                              tags$footer(
                                tags$p(style = "font-size: 20px;",
                                  "Credits: Zachary Thomas, SoHyun Jang, Christie Gan, Linh Ly")
                                ), align="center"
                              )
                          )
                )
              )
            )