library(markdown) 
library(ggplot2)
#documentation for split layout 
#https://shiny.rstudio.com/reference/shiny/latest/splitLayout.html

navbarPage("Welcome CBCAER",
  
   tabPanel("Map",
            sidebarPanel(
              selectInput(inputId = "year", 
                          label = "Year ", 
                          choices = c("2013", "2014"),
                          selected = "2013"
              )
            ),
            mainPanel(
                h2("Correlation Between Crime and Education Rate"),
                htmlOutput("view")
            )
   ), 

   tabPanel("Table",
            fluidRow(column(12, offset=2,
                            h1("Correlation between Crime & HS Graduation in 2014"))),
            sidebarPanel(
              selectInput(inputId = "table_state", 
                          label = "State : ", 
                          choices = c("All", df$State %>% as.list()),
                          selected = "All"
              )
            ),
            tableOutput("table")
   )
)

#plot a map with each county name inside the state
#map.text("county", "wash")
#graphing a single state 
#m <- map_data('state', region='Washington')#
#ggplot() + 
#    geom_polygon(data=m, aes(x=long, y=lat, group=group),colour="black", fill="white")
