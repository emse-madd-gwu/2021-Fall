# Load libraries
library(tidyverse)
library(conjointTools)
library(readr)
library(here)

# Define the attributes and levels
levels <- list(
  price = c(1, 1.2, 1.5, 2, 2.5, 3),
  percent_cacao = c(0.1, 0.6, 0.7, 0.8), 
  crispy_rice = c(0, 1),
  brand = c("Hershey", "Lindt", "Ghirardelli")
)

# Make a full-factorial design of experiment, then recode the levels
doe <- makeDoe(levels)
doe <- recodeDesign(doe, levels)

# Make a survey
survey <- makeSurvey(
    doe       = doe, # Design of experiment
    nResp     = 542, # Total number of respondents (upper bound)
    nAltsPerQ = 3,   # Number of alternatives per question
    nQPerResp = 8    # Number of questions per respondent  
)

# Simulate choices based on a utility model
data <- simulateChoices(
    survey = survey,
    altID  = "altID",
    obsID  = "obsID",
    pars = list(
        price = -0.5,
        percent_cacao = 0.05,
        crispy_rice = -0.2,
        brand = c(-0.5, -0.1)
    )
)

# Rearrange column names
data <- data[c(
    'respID', 'obsID', 'qID', 'altID', 'choice', 'price', 'percent_cacao',
    'crispy_rice', 'brand')]

# Save data
write_csv(data, here('data', 'data.csv'))
