
# Cleaning the data set

library(dplyr)

# import data
crime.data <- read.csv("CrimeStateByState.csv")

# Make column names significant
colnames(crime.data) <- as.character(unlist(crime.data[9, ]))

# Creating a vector of all of the state names including DC and United States-Total
state.names <- union(state.name, c("District of Columbia", "United States-Total"))
state.names <- sort(state.names)

# Removing most of the extra columns
crime.data <- filter(crime.data, Population != "")

# Creating a state column
crime.data$State <- ""

# Adding state names to each row
for(i in 0:51) {
  for(j in ((i * 16)+ 2):(i * 16 + 16)) {
    crime.data[[j, "State"]] <- state.names[(i + 1)]
  }
}

# Deleting extra rows
crime.data <- filter(crime.data, State != "")

#Writing .csv back to the data folder
write.csv(crime.data, "data/CrimeStateByState_Clean.csv")