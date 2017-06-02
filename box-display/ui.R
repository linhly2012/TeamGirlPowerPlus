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
                          p(
                            "We were curious about how the crime rate affects student's education, and how education rates
                            affect crime rate. The two issues can stem from either one, and they both can influence each other.
                            As it turns out, once we aggregated and made visualizations, there's insn't a very clear 
                            correlation between the two. So, we conclude that there are a lot more other factors that determine 
                            the crime rate and graduation rate. However, it is interesting to see the comparisons of rates
                            between the states, and between each type of student."
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
                          ),
                          helpText(
                            tags$i("Source: Bureau of Justice Statistics")
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
                              ), 
                              align="center"
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
                                title="Correlation Between Crime and Education",
                                solidHeader = TRUE, status="primary", plotlyOutput("plot"),
                                helpText(
                                  tags$i("Source: Public high school 4-year adjusted cohort graduation rate (ACGR)")
                                ),
                                br(),
                                helpText("Note: The unit is crime rate for type of crime, 
                                         because through the source, they used specific type 
                                         of algorithm to find the value. "),
                                helpText("Each point represent the percentage of high school students 
                                         who graduate with Economically Disadvantage (x-axis) in each
                                          state vs. different type of crime rates.(y-axis)")
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
                              tags$p(
                                "For this project, we are looking for a correlation between crimes and education 
                                rates in each state. Nearly everyone will move to a new state or at least travel
                                in their lifetime which make this information relevant to nearly every American 
                                citizen in addition to foreign visitors. How safe a state is and the quality
                                of education one can find in a state are essential factors in determing where one may move."
                              ),
                              br(),
                              tags$p(
                                "With this web application, a user will be able to see the most recent information about 
                                education and and violent crime rate for every state and make the appropriate comparisons
                                with the helpful and intuitive interactive features. One can see a brief overview of the
                                best and worst areas on the summary page. On the map page one can see how certain education
                                factors relate to violent crime as well as a geographical representation that gives information
                                about each state. If a user wants to view all of the information available, they can check out
                                the Table tab that can be organized by state and year."
                              ),
                              tags$footer(
                                tags$p(style = "font-size: 20px;",
                                       "Credits: Zachary Thomas, SoHyun Jang, Christie Gan, Linh Ly")
                              ), align="center"
                              ),
                          br(), 
                          box(width=8, 
                              tags$b("Sources: "),
                              br(), 
                              br(), 
                              tags$div("1. ",
                                       tags$a(href = "https://nces.ed.gov/ccd/tables/ACGR_RE_and_characteristics_2013-14.asp", 
                                              "NCES-Common Core of Data(CCD)")
                              ),
                              tags$div("2. ",
                                       tags$a(href = "https://www.ucrdatatool.gov/Search/Crime/State/StatebyState.cfm?NoVariables=Y&CFID=149133250&CFTOKEN=9e4178ccfd9cae35-093A50F6-F370-F176-8A9DCD54AFB37926", 
                                              "UCR - Uniform Crime Reporting Statistics")
                              ),
                              tags$div("3. ",
                                       tags$a(href = "https://www.bjs.gov/developer/ncvs/developers.cfm", 
                                              "BJS- Bureau of Justice Statistics")
                              )
                          )
                        )
              )
            )
)




              