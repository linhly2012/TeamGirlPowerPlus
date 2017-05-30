library("plotly")
crime.dataset <- read.csv("States Level Data/Crime And Education Rate2014-StatesLevel.csv", stringsAsFactors = FALSE)
#View(crime.dataset)

BuildMap <- function(crime.dataset, crime) {
  # give state boundaries a white border
  l <- list(color = toRGB("white"), width = 2)
  
  # specify some map projection/options
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  # Make equation for map color / text
  var.equation <- paste0('~', crime)
  
  # Plot
  p <- plot_geo(data, locationmode = 'USA-states') %>%
    add_trace(
      z = eval(parse(text = var.equation)), text = ~state, locations = ~code,
      color = eval(parse(text = var.equation)), colors = color
    ) %>%
    colorbar(title = "Color Title") %>%
    layout(
      title = str_to_title(map.var),
      geo = g
    )
  return(p)
}
