rm(list = ls())

setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(tidyverse)
library(janitor)
library(lubridate)

#install.packages("ggpubr")
#install.packages("qqplotr")
library(ggpubr)
library(qqplotr)

source("workshop_functions.R")

#### Read In Data ####

cars <- tibble(mtcars)

cars %>% ggplot(aes(x=mpg, y=wt)) +
  geom_point() +
  geom_smooth(method=lm, level=0.95) +
  stat_cor(label.y = 2.5) + 
  stat_regline_equation(label.y=2) 

cars %>% ggplot(aes(sample=mpg)) +
  stat_qq_band() +
  stat_qq_line() +
  stat_qq_point()

cars %>% ggplot(aes(sample=wt)) +
  stat_qq_band() +
  stat_qq_line() +
  stat_qq_point()


#Read in diamond data

dmd <-tibble(diamonds)


## run a linear regression: price ~ carat

## plot the results

## check the Q-Q plots for price and carat

## run an anova: price ~ color

















caratprice<-lm(price~carat,data=dmd)
summary(caratprice)

#depthprice<-lm(price~depth,data=dmd)
#summary(depthprice)

#colorprice<-lm(price~color,data=dmd)
#summary(colorprice)

#unique(dmd$color)

dmd %>%  ggplot(aes(x = carat, y = price)) +
  geom_point() + 
  geom_smooth(method='lm',level = 0.95) +
  stat_cor(label.y = 30000) + 
  stat_regline_equation(label.y = 25000)


