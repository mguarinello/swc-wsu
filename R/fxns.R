# learning how to write our own functions

#example function for calculating Celsius; once run it will appear as a function in Env panel
f2c <-                        # give your function a name 
function(fahr) {              # fahr will be your input; this is also called the argument. when you use the function this is the degrees in farenheit
  return( (fahr - 32)*5/9)    # body of function, the R you want to run, executes code
}                             #

# executes function on vector of F degree values
f2c( c(32, 50, 25, 69, 80, 0))

# this will also work, don't need the return statement; whatever the last value is generated by the R script in the body will be what is returned
f2c_alt <-
  function(fahr) {
    (fahr - 32)*5/9
  }
# will give the same answers as above
f2c_alt( c(32, 50, 25, 69, 80, 0))

# if you only will have one line in your function you can write it like this
f2c_alt2 <-
  function(fahr)
    (fahr-32)*5/9

# will give the same answers as above
f2c_alt2( c(32, 50, 25, 69, 80, 0))

#to write one for conversion to celsius and kelvin
f2c_andK <-
  function(fahr){
    cel <- (fahr -32)*5/9
    kel <- (cel + 273.15)
    c(cel,kel)
  }

f2c_andK( c(32,50))

##practice- write the opposite to go from Celsius to Far
c2f <-
  function(cel){
    (cel*9/5)+32
  }

c2f( c(0, 100))

########### new fucntions, for gapminder data work ######

#new plot to do life exp vs. gdpPercap for selected year
plot_year <-
  function(year, data=gapminder) {  #if i don't specify another data variable, it will use gapminder, this object only has meaning within the function
    library(dplyr)
    library(ggplot2)
    the_year <- year  #renames input year as theyear, e.g. 2007
    data %>%
      filter(year==the_year) %>%   #filters year data on the input year, e.g., 2007
      ggplot(aes(x=gdpPercap, y=lifeExp,
             color=continent)) +
      geom_point()+
      scale_x_log10()
  }

#practice-- function to make plot of life Exp vs gdpPercap across years for a selected country
plot_country <-
  function(country, data=gapminder) {  
    s_country <- country
    data %>%
      filter(country==s_country) %>%
      ggplot(aes(x=gdpPercap, y=lifeExp, color=year))+
      geom_point()+
      scale_x_log10()
  }

#plot_country("New Zealand")   #if you need a string, enter the string as an argument and then the function will make it into the variable and you can treat it as such