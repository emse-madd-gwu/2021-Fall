# install.packages(c("tidyverse", "here"))
library(tidyverse)
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
# ANSWER: These are observations of flights departing NYC airports  
#         in 2013

# How many unique airlines are in the data frame? 
# HINT: Use unique()
unique(data$carrier) # View all airports
length(unique(data$carrier)) # Count how many there are

# What is the earliest and latest observation in the data frame?
# HINT: Use min() and max()
min(data$time_hour)
max(data$time_hour)

# What is the shortest and longest air time for any one flight in the data frame?
# HINT: Use min() and max() with na.rm = TRUE
min(data$air_time, na.rm = TRUE)
max(data$air_time, na.rm = TRUE)    



# filter() & select() ---------------------------------------------------------

# Read in the data.csv file in the data folder:
path_to_data <- here('data', 'data.csv')
data <- read_csv(path_to_data)

# Create a new data frame, flights_fall, that contains only flights that 
# departed in the fall semester
flights_fall <- data %>% 
    filter(month >= 8)

# Create a new data frame, flights_dc, that contains only flights that
# flew to DC airports (Reagan or Dulles)
flights_dc <- data %>% 
    filter(dest %in% c('DCA', 'IAD'))

flights_dc <- data %>% 
    filter(dest == 'DCA' | dest == 'IAD') # Same result

# Create a new data frame, flights_dc_carrier, that contains only flights that
# flew to DC airports (Reagan or Dulles) and only the columns about the 
# month and carrier
flights_dc_carrier <- data %>% 
    filter(dest %in% c('DCA', 'IAD')) %>% 
    select(month, carrier)

# How many unique airlines were flying to DC airports in July?
flights_dc_carrier %>% 
    filter(month == 7) %>% 
    distinct(carrier)

df_july <- flights_dc_carrier %>% 
    filter(month == 7) 
length(unique(df_july$carrier))


# mutate() & arrange() --------------------------------------------------------

# Read in the data.csv file in the data folder:
path_to_data <- here('data', 'data.csv')
data <- read_csv(path_to_data)

# Create the "speed" variable in mph from the time (in minutes) 
# and distance (in miles) variables. 
# Which flight flew the fastest?
data <- data %>% 
    mutate(speed = distance / (air_time / 60))
data %>% 
    arrange(desc(speed))

# Create the dep_delay_hour variable 
# TRUE if the departure delay is greater or equal to one hour
data <- data %>% 
    mutate(dep_delay_hour = ifelse(dep_delay > 60, TRUE, FALSE))

data <- data %>% 
    mutate(dep_delay_hour = dep_delay > 60) # This also works

# Remove rows that have NA for air_time and re-arrange the 
# resulting data frame based on the longest air time and longest flight distance
# HINT: The function is.na() returns TRUE if a value is NA
data %>% 
    filter(!is.na(air_time)) %>% 
    arrange(desc(air_time), desc(distance)) 
