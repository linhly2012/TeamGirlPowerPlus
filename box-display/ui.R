library(shinydashboard)

dashboardPage(skin = "purple",
  dashboardHeader(title = "Welcome CBCAER"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Maps", tabName = "maps", icon = icon("map")),
      menuItem("Table", tabName = "tables", icon = icon("table"))
    )
  ),
  dashboardBody(
      tabItems(
        tabItem(tabName = "maps",
          h2("Graduation Rate By Year (Percent)"),
          # # Boxes need to be put in a row (or column)
          fluidRow(
            box(width = 5,
                selectInput(inputId = "year",
                label = "Year: ",
                choices = c("2013", "2014"),
                selected = "2013")
            ),
            box(width = 12,
                solidHeader = TRUE, status = "primary",
                htmlOutput("view")
            )
          )
        ),
        tabItem(tabName = "tables",
          fluidRow(
            box(width = 5,
                selectInput(inputId = "table_state", 
                            label = "State: ",
                            choices = c("All", df.data$State %>% as.list()),
                            selected = "All"
                ),

                # Only show this panel a state is select
                conditionalPanel(
                  condition = "input.table_state != 'All'",
                  selectInput(inputId = "table_year",
                              label = "Year: ",
                              choices = c("Both", "2013", "2014"),
                              selected = "2013"
                  )
                )
              ),
            
            box(
              width=12,
              title="Correlation between Crime & HS Graduation in 2014",
              solidHeader = TRUE,
              status = "primary",
              div(style = 'overflow-x: scroll', tableOutput("table"))
            )
          )
        )              
     )
  )
)