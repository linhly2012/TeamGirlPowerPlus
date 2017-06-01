library(plotly)
getwd()
setwd('/Users/linhly/Desktop/INFO/TeamGirlPowerPlusOne/box-display/')
df_2014 <- read.csv('../States.Level.Data/Crime.And.Education.Rate.2014-StatesLevel.csv')

View(df_2014)
plot <- plot_ly(df_2014,
                x = ~df_2014$Violent.Crime.Rate,
                y = ~df_2014$Economically.Disadvantaged,
                type = 'scatter',
                mode = 'markers',
                marker = list(size = 10, color = '#e6ecff',
                              line = list(color = '#3366ff', width = 2)),
                text = ~paste0("violent crime rate:", df_2014$Violent.Crime.Rate, 
                               "<br />", "Economically Disadvatanged",
                               df_2014$Economically.Disadvantaged,
                               "<br />")) %>%
  layout(title = paste0("<b>",'Crime Rate Studies',"</b>"),
         xaxis = list(title = 'Economically Disadvatanged'),
         yaxis = list(title = 'Violent Crime Rate', zeroline = TRUE)
  )

plot
