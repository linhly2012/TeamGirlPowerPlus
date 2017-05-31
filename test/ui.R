library(markdown) 

navbarPage("Welcome",
  
   tabPanel("Map",
            mainPanel(
                fluidRow(column(12, offset=3,h1("Graduation Rate in the US, 2014"))),
                #h1("Graduation Rate in the US, 2014", align= "center"),
                htmlOutput("view")
              )
            ), 
   
   tabPanel("Plot",
            sidebarPanel(
              selectInput(inputId = "state", 
                          label = "States: ", 
                          choices = df$State %>% as.vector()
              )
            ),
            #display the scatter plot pannel
            mainPanel(
              plotOutput("plot")
            )
   ),
   
   tabPanel("Table",
            titlePanel("Correlation Between Crime and Education in 2014"),
            sidebarPanel(
              selectInput(inputId = "table_state", 
                          label = "States: ", 
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
# m <- map_data('state', region='Washington')
# p <- ggplot() + 
#    geom_polygon( data=m, aes(x=long, y=lat, group=group),colour="black", fill="white") + 
#    geom_text() + ggtitle("Washington") 

