#analyze gapminde using my own functions

#load data
gapminder <- read.csv("data/gapminder.csv")

#load packages
library(dplyr)
library(ggplot2)

#load my functions
source("R/fxns.R")

#to all data for 1952 using function
plot_year(1952)
#to plot for Asia, here we specify the data by giving it as an argument; if we don't give the data argument, the function uses gapminder as a default
gm_asia <- gapminder %>%
  filter(continent=="Asia")
plot_year(1952, gm_asia)

plot_country("New Zealand")