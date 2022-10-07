# A sample vector
v <- c(1, 4, 4, 3, 2, 2, 3)

v[c(2, 3, 4)]
v[2:4]
v[c(2, 5, 7, 1)]


# Create a sample data frame
data <- read.table(header=T, text='
                   subject sex size
                         1   M    7
                         2   F    6
                         3   F    9
                         4   M   11')
# Get the element at row 1 , column 3
data[1,3]
data[1, "size"]

# Get rows 1 and 2, and all columns
data[1:2,]
data[c(1,2),]

# get rows 1 and 2, and only columns 2
data[1:2, 2]
data[c(1,2), 2]

# Get rows 1 and 2, and only the columns named "sex" and "size"
data[1:2, c("sex", "size")]
data[c(1, 2), c(2, 3)]


# bool indexing
v > 2
v[v>2]
v[c(F,T,T,T,F,F,T)]

# A boolean vector
data$subject < 3
data[data$subject < 3]
data[c(TRUE, TRUE, FALSE, FALSE),]

# It is also possible to get the numeric indices of the TRUEs
which(data$subject < 3)
data[which(data$subject < 3), ]


# Negative indexing
v
v[-1]
v[-1:-3]
v[-length(v)]  # drop the last element



# Make a random value
# random uniform value
runif(1)

# Get a vector of 4 numbers
runif(4)

# Get a vector of 3 numbers from 0 to 100
runif(3, min=0, max=100)

# Get 3 integer from 0 to 100
# Use max=101 because it will never actually equal 101
floor(runif(300, min=0, max=101))

# This will do the same thing
sample(1:100, 3, replace=TRUE)

# To generate integers WITHOUT replacement & sort:
sort(sample(1:100, 100, replace=FALSE))

# Get normalized distribution
rnorm(5)
# Check mean of value
mean(rnorm(1000))

# Use a different mean and standard deviation
rnorm(4, mean=50, sd=10)

# To check that the distribution looks right, make a histogram of the numbers
x <- rnorm(400, mean=50, sd=10)
hist(x)


# Create a random sequence
set.seed(123)
runif(3)

set.seed(123)
runif(3)
# This set-seed code, must be written every time on create random-value


# Save the seed
oldseed <- .Random.seed
runif(3)

# Restore the seed
.Random.seed <- oldseed
runif(3)
# if you don't used set-seed, it will never exist '.Random.seed' object

# Create a function that restore Random-seed
rand_store <- function(){
  if (exists(".Random.seed", .GlobalEnv))
    oldseed <- .GlobalEnv$.Random.seed
  else
    oldseed <- NULL
  print(runif(3))
  
  if (!is.null(oldseed))
    .GlobalEnv$.Random.seed <- oldseed
  else
    rm(".Random.seed", envir=.GlobalEnv)
}


# handling the decimal
# -2.5 ~ 2.5 slice by 0.5
x <- seq(-2.5, 2.5, by=.5)    

# Round to nearest
round(x)

# Round up
ceiling(x)

# Round down
floor(x)

# drop the decimal
trunc(x)

# Round to one decimal
round(x, digits=1)


# Create the string
# paste()
a <- "apple"
b <- "banana"

# Put a a and b together, with a space in between:
paste(a, b)

# With no space, use sep="", or use paste0():
paste(a, b, sep="")
paste0(a, b)

# With a comma and space:
paste(a, b, sep=", ")


# With a vector
d <- c("fig", "grapefruit", "honeydew")

# If the input is a vector, use collapse to put the elements together:
paste(d, collapse=", ")

# If the input is a scalar and a vector, it puts the scalar with each
# element of the vector, and returns a vector:
paste(a, d)

# Use sep and collapse
paste(a, d, sep="-", collapse=", ")
# sep 은 scalar 요소 뒤에 적용 , collapse는 vector 요소 뒤에 적용


# sprintf()
# %s, %d 등 포맷에 맞는 형식으로 출력
a <- "string"
sprintf("This is where a %s goes.", a)
sprintf("%.5f", pi)


# export the string to formula
"y ~ x1 + x2"
as.formula("y ~ x1 + x2")

measurevar <- "y"
groupvars <- c("x1", "x2", "x3")

as.formula(paste(measurevar, paste(groupvars, collapse=" + "), sep=" ~ "))
