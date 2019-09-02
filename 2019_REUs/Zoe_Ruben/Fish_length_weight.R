##### June 15, 2019. Dumagete - Philippines   #########
#         Eric Garcia's Script for                    #
#   Analizing relationship between fish lenght,       #
#   weight, egg mass, and egg size.                   #
###  ><((º> ############################## <º))><   ###

rm(list=ls())
getwd()
#set working directory to location of this script
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()

# load the library
library(ggplot2)

# Loading Zoe's data on Siganus fuscescens
nicole <- read.csv("PlotosusLineatus_DataCollection.csv", header = TRUE)
nicole <- nicole[,c(1:6)]

?read.csv

# What are the varible names?
colnames(nicole)


# plot sample frequency distribution  (histogram) of Standard lenght with bins of 1 cm
ggplot(data = nicole) + 
  aes(x = Standard.Length..cm.) + 
  geom_histogram(binwidth = 1)

# saved this file as Pli_sample_distribution

# However, how well represented is the entire size range of this species 
# if max lenght is 32 cm according to FishBase?

# Plot frequency distribution  (histogram) of Standard lenght, using 32 bins
# 32 bc I want bins to be 1 cm and the max lenght is 40
ggplot(data = nicole) + 
  aes(x = Standard.Length..cm.) + 
  geom_histogram(bins = 32)

# you can achieve the same plot by specifying the with of bins. In this case = 1 cm
ggplot(data = zoe) + 
  aes(x = Standard.Length..cm.) + 
  geom_histogram(binwidth = 1)

# saved this plot as Truesampledist

# Is there a correlation between weight and length?
# Make a scatterplot using weight and length in Zoe's actual data

# Simple scatterplot using plot
Pli_L_vs_W <- plot(nicole$Standard.Length..cm., nicole$Weight..g.)

# Fit a line in the scatterplot
Pli_L_vs_W <-  lm(Weight..g.~Standard.Length..cm., data=nicole)
plot(nicole$Standard.Length..cm., nicole$Weight..g.)
abline(Pli_L_vs_W)
