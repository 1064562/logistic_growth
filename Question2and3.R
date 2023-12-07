install.packages("ggplot2")
library(ggplot2)

# Question 2: find pop size when t = 4980 in exponential and logistic growth models

growth_data <- read.csv("experiment1.csv")

# inital pop size
N0 <- 6.903e+00

# growth rate
r <- 9.990e-03

# time elapsed
t <- 4980

# Use formula N(t) = N0 x e^rt:

expo_fun <- function(t) {
  
  N_t <- N0 * exp(r*t)
  
  return(N_t)
  
}

pop_4980_expo <- expo_fun(4980)
pop_4980_expo

# Logistic growth model (from plot_data_and_model.R): 

K <- 5.979e+10

logistic_fun <- function(t) {
  
  N <- (N0*K*exp(r*t))/(K-N0+N0*exp(r*t))
  
  return(N)
  
}

# create a variable, calling the function with t = 4980 and output N:

pop_4980_logistic <- logistic_fun(4980)
pop_4980_logistic

# Question 3: make a graph of exponential / logistic growth curves:

ggplot(aes(t, N), data = growth_data) +
  # include two different models, specify that they are different colours
  geom_function(aes(colour="red"), fun=logistic_fun) +
  
  geom_function(aes(colour="blue"), fun=expo_fun) +

  #transform y axis
  scale_y_continuous(trans='log10') +
  #add title + axis
  labs(
    title = "Comparison of Exponential and Logistic Growth Models",
    x = "Time",
    y = "Population Size (log scale)"
  ) +
  # add a legend, put it at the bottom of the graph
  scale_colour_manual(
    name = "Growth Models",
  ) +
  
  theme(legend.position = "bottom")
