# Make conjoint surveys using the conjointTools package

# Install packages
# install.packages("fastDummies")
# install.packages("remotes")
# remotes::install_github("jhelvy/conjointTools")

# Load libraries
library(conjointTools)
library(fastDummies)
library(here)

# Define the attributes and levels
levels <- list(
  price       = c(15, 20, 25), # Price ($1,000)
  fuelEconomy = c(20, 25, 30),   # Fuel economy (mpg)
  accelTime   = c(6, 7, 8),      # 0-60 mph acceleration time (s)
  powertrain  = c("Gasoline", "Electric")
)

# Make a full-factorial design of experiment
doe <- makeDoe(levels)
head(doe) # preview

# Recode the design of experiment
doe <- recodeDesign(doe, levels)
head(doe) # preview

# Make a basic survey
survey <- makeSurvey(
    doe       = doe,  # Design of experiment
    nResp     = 1000, # Total number of respondents (upper bound)
    nAltsPerQ = 3,    # Number of alternatives per question
    nQPerResp = 8     # Number of questions per respondent
)
head(survey) # preview

# Make a labeld survey with "powertrain" as the label
survey_labeled <- makeSurvey(
    doe       = doe,
    nResp     = 1000,
    nAltsPerQ = 3,
    nQPerResp = 8,
    group     = "powertrain"
)
head(survey_labeled) # preview

# Make a survey with outside good
survey_og <- makeSurvey(
    doe       = doe,
    nResp     = 1000,
    nAltsPerQ = 3,
    nQPerResp = 8,
    outsideGood = TRUE
)
head(survey_og) # preview

# Save design
write_csv(survey, here('choice_questions.csv'))
