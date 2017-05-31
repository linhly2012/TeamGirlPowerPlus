library(markdown) 

navbarPage("Welcome",
  
   tabPanel("Map",
            mainPanel(
                h1("Correlation Between Crime and Education", align= "center"),
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
            titlePanel("Data of the Correlation Between Crime and Education"),
            tableOutput("table")
   )
)
