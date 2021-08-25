# R BASICS ----

# R as a calculator
4+3
2-1+12-2*5
2-1+(12-2)*5 # Use parentheses to control the order of operations!
2^4 # Exponents

3*10
42/8

# R has lots of built in functions
sqrt(4)
abs(-10)
sqrt(1 + abs(-8)) # You can combine functions inside each other
round(3.14159)
round(3.14159, 3)

# Keyboard Shortcut - Run current line/selection	
# Windows: Ctrl + Enter
# Mac:     Cmd + Return

# Assign values to objects using "<-"
x <- 42
x
x = 42 # This also works, but "<-" is preferred
x
y <- 42
x + y

# Keyboard shortcut to produce "<-"
# Mac: "option" + "-"
# Windows: "alt" + "-"

# Always surround "<-" with spaces
x<-2   # Does this mean x <- 2 or x < -2?

# R ignores excess white space
x + y
x +             y

# R is case sensitive
number <- 2
Number <- 3
numbeR <- 4
number
Number
numbeR

# Use meaningful variable names
# Example: You are recording the speed of a car in mph
x <- 42             # Poor name
speed <- 42         # Good name
car_speed_mph <- 42 # Even better name

# Use "snake" or "camel" casing for variable names
# snake_case_uses_underscores
# camelCaseUsesCaps
days_in_week <- 7
monthsInYear <- 12

# Logic: returns TRUE or FALSE (in all caps)
x == 3 # Tests whether a value equals 3
x != 3 # Tests whether a value is not equal to 3
x <= 3 # Tests whether a value is less than or equal to 3

# This works with other data types too
"penguin" == "penguin"

# View all current objects in the environment
objects()

# Remove an object from the environment
rm(x)
objects()

# Remove all objects from the environment
rm(list = objects())

# --------------------------------------------------------------------------
# DATA TYPES ----

#   character: Strings (things in quotes)
#   integer  : Numbers with no decimal
#   numeric  : Numbers with decimals
#   factor   : Categorical variable
#   logical  : TRUE or FALSE

# Characters:
foo <- "a string"
foo
typeof(foo)

# Numeric vs. Integer
typeof(42.7)
typeof(42)
typeof(as.integer(42))
typeof(42L) # Adding an L makes numbers an integer

# Factors - can be number or characters
factor('one')
factor(1)

# Logical
this <- TRUE
that <- FALSE
typeof(this)
typeof(that)

# Convert data types using as.______(x)
as.numeric("123")
as.character(123)
as.integer(3.14)

# Check type using is.______(x)
is.numeric("123")
is.character(123)
is.integer(3.14)
is.integer(3)

# --------------------------------------------------------------------------
# VECTORS ----

# Series of elements **of the same type**

# Use the "c()" command to combine a list of values
# "c" stands for "concatenate"
x <- c(1, 1, 2, 3, 5, 8, 13)     # numeric vector
y <- c("a", "b", "c")            # character vector
z <- c(TRUE, FALSE, TRUE, TRUE)  # logical vector

# Use indexing to get a value from the vector:
length(x)
x
x[2]
x[2:3]
x[c(1, 4)]

# Sort and order:
x <- c(13, 1, 8, 2, 5, 3, 1)
x
sort(x) # Returns a sorted vector
order(x) # Returns the indices of the sorted vector
x[order(x)] # Produces same thing as "sort(x)"

# Some summary functions
min(x)
max(x)
mean(x)
range(x)
summary(x)

# Create sequences of numbers using "seq()"
seq(1, 10)
seq(1, 10, by = 2)
seq(10, 1, by = -1)
seq(1, 10, length = 3)

# Repeat values using "rep()":
rep(1, times = 4)
rep(seq(1, 5), times = 2)
rep(seq(1, 5), each = 2)

# Vector Operations:
x <- c(2, 3)
y <- c(4, 5)
x + y
x * y
x / y

# --------------------------------------------------------------------------
# DATA FRAMES ---- 

# Like an Excel spreadsheet; columns of vectors

# ***We will use these a lot!!!***

# R comes with a set of built-in data frames - we'll use "mtcars":

# Preview the first 6 rows using "head" and last 6 rows using "tail":
head(mtcars)
tail(mtcars)

# View the class of each column using "str" (for "structure"):
str(mtcars)

# Get the dimensions of the dataset:
dim(mtcars)
nrow(mtcars)  # number of rows
ncol(mtcars)  # number of columns

# Get the names of rows and columns
names(mtcars)
colnames(mtcars) # same as names
rownames(mtcars)

# A data.frame can store different types of data:
head(iris)   # Data on flower irises
str(iris)

# Extract individual columns using either indexes or "$" + the variable name:
mtcars[,1] # Get the first column (mpg)
mtcars$mpg # Also gets the first column, but using the variable name

# --------------------------------------------------------------------------
# Functions, loops, if statements ----

# Create a simply summation function:
simpleSum <- function(x, y) {
  value <- x + y
  return(value)
}
simpleSum(5, 4)

# For loop:
for (i in seq(1, 10)) {
  print('yay')
}

# While loop:
value <- 42
while (value > 37) {
  value <- value - 1
  print(value)
}

# If statements:
value <- 42
if (value > 10) {
  print('yay')
}
if (value < 10) {
  print('foo')
}

# If + else:
value <- 42
if (test < 10) {
  print('no')
} else if (test == 10) {
  print('foo')
} else {
  print('yay')
}

# Function with if statement:
simpleSum <- function(x, y) {
  if ((class(x) != 'numeric') | (class(y) != 'numeric')) {
    stop('x and y must be numbers!')
  }
  value <- x + y
  return(value)
}
simpleSum('foo', 2)
simpleSum(5, 2)
