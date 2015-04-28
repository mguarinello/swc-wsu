# Intro to R practice script 
x <-8
y <-x/2
x <-15
ls() # list objects in environment
# vector of weights, c() is a function and it means 'combine'
weights <- c(50, 60, 65, 82)
weights
animals <- c("mouse","rat","dog")
animals
#to find help on a function
?mean
# to get number of elements in a vector
length(weights)
length(animals)

#to find class of on object, class is character or number
class(weights)
class(animals)

#to find out about structure of object, e.g., class and length and items
str(weights)
str(animals)

#to add to a vector
weights <- c(weights,90)
weights
weights <-c(30, weights)
weights

#create new vector combining x, y, weights and then find the mean
z <- c(x,y,weights)
z_mean <- mean(z)
z_mean

#to get working directory, list files
getwd()
list.files()
setwd("~/Desktop") #to change working directory
setwd("~/Desktop/swc-wsu/data")

#working with Data; Using gapminder; life expectancy, gdp, etc. for countries
#load data; create object for data
gapminder <- read.csv("gapminder.csv")
head(gapminder)  #to read initial rows of data file, defaults to 7 rows
class(gapminder)
str(gapminder) #gives class, num of columns, rows, types of variables/factors and levels

#how to pull variables out of data; bracket sub-setting [ ] to subset, inside [ ] you put the index value or specify range
weights[1]
weights[1:3] # to select first 3 elements

#for data frames, need to specify rows and columns, give as  rows,columns
gapminder[1,1] #for 1st row, 1st column
gapminder[1,3] #for 1st row, 3rd column
gapminder[500,5:6] # for 500th row, 5th and 6th column
#to get a single column of data frame use $

gapminder$pop
#equivalent to
gapminder[,5] # gives 5th column, all values because you didn't specify rows
gapminder[,"pop"] # using column name to get all data for that column

# to get all data for Finland, using expression for rows with is data, columns as blank to get all columns
gapminder[gapminder$country == "Finland", ]

# to get countries and years with population <= 100,000, need to specify columns
gapminder[gapminder$pop <= 100000, c("country","year")]

#testing to see which are equivalent with the 1st one below
gapminder[50,4] #this finds the 50th row in the 4th column
gapminder[50,"lifeExp"] #yes; this finds the 50th row in the life Exp in the 4th row
gapminder[4,50] #no; this finds the 4th value in the 50th column, there is no 50th column so it is null
gapminder$lifeExp[50] #yes; this finds the column for lifeExp and finds the 50th value

#which countries in data have life expectancy > 80
gapminder[gapminder$lifeExp > 80, "country"]

#Working with Packages to extend functionality in R; Here we will work with dplyr for data manipulation and ggplot2 for plotting

#first have to install to your computer
install.packages("dplyr")
install.packages("ggplot2")

#then you have to load for your R session, can also click in packages pane
library("dplyr")
library(help=dplyr)  # to pull up documentation, list of fxns in dplyr

#DPLYR
#selecting columns and rows using dplyer
select(gapminder,country, year, pop)  #select columns you want to keep
filter(gapminder,country == "Finland")  #filter to keep rows you want

#using pipe, for stepwise subsetting, reads the left side of pipe as argument, so you don't have to put gapminder as first argument in () in second row
gapminder_small <- gapminder %>%  #create and object for your new filtered data
  filter(pop <= 100000) %>%
  select(country, year)

#practice- rows with gdpPercap is >= 35000. keep country, year, and gdpPercap
gapminder %>%
  filter(gdpPercap >= 35000) %>% 
  select(country, year, gdpPercap)

#to add to new columns to data, based on values of exisitng data, e.g. for calc., units, etc.
gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%  #mutate adds a new column
  head   # to see just the first 6 rows
#note this does not overwrite the gapminder object unless you re-assign gapminder object for this code

#split into groups
gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%   #adds column and calculates totalgdb
  group_by(continent) %>%                  # groups results by continent
  summarize(meangdp = mean(totalgdp))     # new column, give it name, set = to mean of total gdp

#do the same as above, but by years too
gapminder %>%
  mutate(totalgdp = gdpPercap *pop) %>%
  group_by (continent, year) %>%
  summarize (meangdp =mean(totalgdp))

#to get mean and min by continent and year
min_mean_gdp <- gapminder %>%
  mutate(totalgdp = gdpPercap * pop) %>%
  group_by (continent, year) %>%
  summarize(meangdp = mean(totalgdp),
            mingdp = min(totalgdp))

#practice- get the max life Exp for each continent
gapminder %>%
  group_by(continent) %>%
  summarize(maxLife = max(lifeExp))

#practice- max, min, mean life Exp for each year
gapminder %>%
  group_by(year) %>%
  summarize(maxLife = max(lifeExp),
            minLife = min(lifeExp),
            meanLife = mean(lifeExp))

#practice - pick country, find pop for each year before 1982. return data frame with country, year, pop
gapminder_Australia <-gapminder %>%
  filter(country == "Australia", year < 1982) %>%  
  select(country, year, pop) %>%

#to export a data frame, write.
write.csv(gapminder_Australia,"gapminder_Australia.csv")


