# install.packages(c("tidyverse", "nycflights13", "here"))
library(tidyverse)
library(nycflights13)
library(here)

# The setting below is optional, it lets you see all the columns in a data frame
options(dplyr.width = Inf)



# DATA FRAMES --------------------------------------------------------------

beatles <- tibble(
    firstName   = c("John", "Paul", "Ringo", "George"),
    lastName    = c("Lennon", "McCartney", "Starr", "Harrison"),
    instrument  = c("guitar", "bass", "drums", "guitar"),
    yearOfBirth = c(1940, 1942, 1940, 1943),
    deceased    = c(TRUE, FALSE, FALSE, TRUE)
)

beatles

# Extract rows and columns using df[row, col]
beatles[1,] # First row
beatles[,1] # First column

# Extract whole columns using df$name
beatles$firstName
beatles$lastName

# Get the dimensions
nrow(beatles)  # number of rows
ncol(beatles)  # number of columns
dim(beatles)   # numbers of rows, columns 

# View dataset in new tab
view(beatles) # This is "read-only" so you can't corrupt the data :)

# View data types of each column
glimpse(beatles)



# DATA FROM PACKAGES ----------------------------------------------------------

# See which data frames are available in a package:
data(package = "ggplot2") # note: ggplot2 is part of the "tidyverse" package

# Find out more about a package data set
?msleep

# Look at the variables and their types
glimpse(msleep)

# View the **first** or **last** 6 rows with head() or tail()
head(msleep)
tail(msleep)

# View first 10 rows
head(msleep, 10)

# View dataset in new tab
view(msleep)

# Get variable names
names(msleep)
colnames(msleep)



# DATA FROM CSV FILE ----------------------------------------------------------

# Build path to data using here()
path_to_data <- here('data', 'data.csv')
path_to_data

# Read in data using read_csv()
data <- read_csv(path_to_data)

# How many rows and columns are in the data frame?
nrow(data)
ncol(data)
dim(data)

# What type of data is each column? 
# (Just look, don't need to type out the answer)
glimpse(data)

# Preview the different columns - what do you think this data is about? 
# What might one row represent?
# ANSWER: These are observations of bird impacts with aircraft. Each row 
#         is one impact observation

# How many unique airports are in the data frame? 
# HINT: Use unique()
unique(data$airport) # View all airports
length(unique(data$airport)) # Count how many there are

# What is the earliest and latest observation in the data frame?
# HINT: Use min() and max()
min(data$incident_date)
max(data$incident_date)

# What is the lowest and highest cost of any one repair in the data frame?
# HINT: Use min() and max() with na.rm = TRUE
min(data$cost_repairs_infl_adj, na.rm = TRUE)
max(data$cost_repairs_infl_adj, na.rm = TRUE)    



# filter() & select() ---------------------------------------------------------

# Read in the data.csv file in the data folder:
path_to_data <- here('data', 'data.csv')
data <- read_csv(path_to_data)

# Create a new data frame, dc, that contains only the rows from DC airports.
dc <- data %>% 
    filter(state == 'DC')

# Create a new data frame, dc_dawn, that contains only the rows from DC 
# airports that occurred at dawn.
dc_dawn <- data %>% 
    filter(state == 'DC') %>%
    filter(time_of_day == 'Dawn')

dc_dawn <- data %>% 
    filter(state == 'DC', time_of_day == 'Dawn')

dc_dawn <- data %>% 
    filter(state == 'DC' & time_of_day == 'Dawn')

# Create a new data frame, dc_dawn_birds, that contains only the rows from DC
# airports that occurred at dawn and only the variables (columns) about the 
# species of bird.
dc_dawn_birds <- data %>% 
    filter(state == 'DC', time_of_day == 'Dawn') %>% 
    select(contains('species'))

# How many unique species of birds have been involved in accidents at DC
# airports?
unique(dc_dawn_birds$species)
length(unique(dc_dawn_birds$species))



# mutate() & arrange() --------------------------------------------------------

# Read in the data.csv file in the data folder:
path_to_data <- here('data', 'data.csv')
data <- read_csv(path_to_data)

# Create the height_miles variable (the height variable converted to miles)
# HINT: There are 5,280 feet in a mile
data <- data %>% 
    mutate(height_miles = height / 5280)

# Create the cost_mil variable 
# TRUE if the repair cost >= $1 million, otherwise FALSE
data <- data %>% 
    mutate(cost_mil = ifelse(cost_repairs_infl_adj > 10^6, TRUE, FALSE))

data <- data %>% 
    mutate(cost_mil = cost_repairs_infl_adj > 10^6) # This also works

# Remove rows that have NA for cost_repairs_infl_adj and re-arrange the 
# resulting data frame based on the highest height and most expensive cost
# HINT: The function is.na() returns TRUE if a value is NA
data <- data %>% 
    filter(!is.na(cost_repairs_infl_adj)) %>% 
    arrange(desc(height), desc(cost_repairs_infl_adj)) 
