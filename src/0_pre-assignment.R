# Create a vector
vector <- c(65, 6, 13, 31, 20, 71, 27, 51)

sum(vector) # Calculate the sum of elements in the vector
length(vector) # Calculate the number of elements in the vector
sum(vector)/length(vector) # Method 1 for calculating the mean of the elements in the vector
mean(vector) # Method 2 for calculating the mean of the elements in the vector
sd(vector) # Calculate the standard deviation of the elements in the vector


# Draw a treatment vector from random draws from a binomial (Bernoulli) distribution
set.seed(2018)
z = rbinom(n = 1000, size = 1, prob = .5)
length(z)
mean(z)
hist(z)


# Draw an outcome variable from a standard normal distribution with an ATE of 0.2
y = rnorm(n = 1000) + z * .2
length(y)
mean (y)
min(y) # Minimum
max(y) # Махіти
hist(y)

# Calculate the mean of Y for the treatment group (Z = 1)
mean(y[z == 1]) # [Z == 1] subsets Y to observations where Z = 1
mean (y[z == 0]) # [Z == 0] subsets Y to observations where Z = 0

# Calculate the difference in means
mean(y[z == 1]) - mean(y[z == 0])