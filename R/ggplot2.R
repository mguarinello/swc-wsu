# WORKING WITH GGPLOT2 -- for data visualizations, from Jen, edited and modified based on what I remember since I overwrote mine accidently.

# load ggplot2 library
library(ggplot2)

setwd("~/Desktop/swc-wsu/")

# load gapminder data
gapminder <- read.csv("~/Desktop/swc-wsu/data/gapminder.csv")

# scatterplot of lifeExp vs gdpPercap
# aes = aesthetics; in this case, sets x and y axes, b/c these are in main () for ggplot, applies to whole plot
# geom = geometric objects, in this case
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + 
  geom_point()

p <- ggplot(gapminder, aes(x=gdpPercap, y=lifeExp))  # define graphical object p
p + geom_point()   # add the layer for geometric points

#add a scale feature to make the geometry on a log scale
p3 <- p + geom_point() + scale_x_log10()
p3
# color points by continent
p3 + aes(color=continent)

#review
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + scale_x_log10() + geom_point()

# Challenge:  make scatterplot of lifeExp vs gdpPercap with only China data
ggplot((gapminder %>% filter(country == "China")), aes(x=gdpPercap, y=lifeExp)) + 
  geom_point(size = 5, alpha = 0.5, color = "red")
# or better
p_china <- gapminder %>%
  filter(country=="China") %>%
  ggplot(aes(x=gdpPercap, y=lifeExp)) +
  geom_point(size = 5, alpha = 0.5, color = "red")  #alpha is for opacity

# Challenge: try size, shape, color aesthetics, 
# both with categorical variables (e.g., continent) and numeric variables (e.g., pop)
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, 
                      color=continent, size=pop, shape=continent)) + 
  scale_x_log10() + geom_point()

# add multiple layers (each call to geom_* creates new layer)
ggplot((gapminder %>% filter(country == "China")), aes(x=gdpPercap, y=lifeExp)) + 
  geom_point(size = 5, alpha = 0.7, aes(color=year)) + geom_line(color = "violet")

# Challenge: make plot of lifeExp vs gdpPercap for China and India
# with lines in black but points colored by country.
ggplot((gapminder %>% filter(country == "China" | country == "India")), aes(x=gdpPercap, y=lifeExp)) + 
  geom_point(aes(color = country), size = 5) + geom_line(aes(group=country), color="black") 
# or
ggplot((gapminder %>% filter(country %in% c("China", "India"))), aes(x=gdpPercap, y=lifeExp)) + 
  geom_point(aes(color = country), size = 5) + geom_line(aes(group=country), color="black")

# make a histogram
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(x=lifeExp)) + geom_histogram(binwidth=2.5, fill="orchid", color="black")

# make a boxplot
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(y=lifeExp, x=continent)) + geom_boxplot(fill="aquamarine", width=0.8)

# make a point plot
gapminder %>%
  filter(year==2007) %>%
  ggplot(aes(y=lifeExp, x=continent)) + geom_boxplot() +
  geom_point(position=position_jitter(width=0.1, height=0), aes(color=continent)) 

# FACETING, splitting the data:  facet_grid(), facet_wrap()
# facet_grid() splits either vertically or horizontally depending on where you put the ~
# facet_wrap() simply wraps individual facets
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + geom_point() + scale_x_log10() + facet_grid(continent ~ .)
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + geom_point() + scale_x_log10() + facet_grid(~ continent)
ggplot(gapminder, aes(x=gdpPercap, y=lifeExp)) + geom_point() + scale_x_log10() + facet_grid(continent ~ year)

ggplot(gapminder, aes(x=gdpPercap, y=lifeExp, color=continent)) + geom_point() + scale_x_log10() + facet_wrap(~year)

# Challenge: select 5 countries, plot lifeExp vs gdpPercap across time (with geom_line), facet by country
plot <- gapminder %>%
  filter(country == "India" | country == "New Zealand" | country == "China" | country == "Iceland" | country == "Iran") %>%
  ggplot(aes(y=lifeExp, x=gdpPercap)) + geom_line(aes(color=country)) + facet_wrap(~ country)

# SAVE AS (png, pdf, etc)
ggsave("figures/plot.png", plot, height=7, width=10)
