# Make conjoint surveys using the conjointTools package

# Install packages
# install.packages("fastDummies")
# install.packages("remotes")
# remotes::install_github("jhelvy/conjointTools")

# Load libraries
library(conjointTools)
library(fastDummies)
library(logitr)

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

# --------------------
# Simulate choice data!
# --------------------

# Dummy code the powertrain attribute
survey <- dummy_cols(survey, "powertrain")
head(survey)

# Simulate random choices
data <- simulateChoices(
  survey, 
  altID = "altID",
  obsID = "obsID"
)
head(data) 

# Simulate choices according to an assumed utility model
data <- simulateChoices(
  survey, 
  altID = "altID",
  obsID = "obsID",
  pars = list(
    price = -0.1,
    fuelEconomy = 0.1, 
    accelTime = 0.1,
    powertrain_Electric = -4
  )
)
head(data)

# Estimate a model 
model <- logitr(
  data   = data,
  choice = "choice",
  obsID  = "obsID",
  pars   = c("price", "fuelEconomy", "accelTime", "powertrain_Electric")
)

summary(model)
