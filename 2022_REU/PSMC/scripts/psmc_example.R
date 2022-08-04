#load ggplot2
library(ggplot2)

#load the source code for functions
source('~/Dropbox/Mac/Desktop/psmc_out/plot_psmc.R')

#read in some PSMC outputs - make sure to use the correct generation time  
Adu<-psmc.result(file="~/Dropbox/Mac/Desktop/psmc_outfiles/Adu20kall.psmc",g=2.5)
Ako<-psmc.result(file="~/Dropbox/Mac/Desktop/psmc_outfiles/AkodenovoSSL20kall.psmc",g=2.5)
Hqu<-psmc.result(file="~/Dropbox/Mac/Desktop/psmc_outfiles/HqudenovoSSL20kall.psmc",g=1.3)
Sin<-psmc.result(file="~/Dropbox/Mac/Desktop/psmc_outfiles/SindenovoSSL20kall.psmc",g=2.89)

#for plotting multiple species
#add species to each PSMC result
Adu$species="Adu"
Ako$species="Ako"
Hqu$species="Hqu"
Sin$species="Sin"
#add grouping variables - your predictors
Adu$group="Estuarine"
Ako$group="Estuarine"
Hqu$group="Semi-pelagic"
Sin$group="Reef"
#combine results
PSMC_combined=rbind(Adu,Ako,Hqu,Sin)
#plot with x-axis on normal scale
psmc.plot(PSMC_combined)
#plot with x-axis on log scale
psmc.plot.log(PSMC_combined)

#getting data and hypothesis testing 
#read in species data / predictor variables. you can start from the Species Characteristics sheet, modify that in Excel, and save as a .csv
species.dataset=read.csv("~/Dropbox/Mac/Desktop/psmc_out/species_ranges.csv",header=T)
#make columns for population size variables
species.dataset$Ne10000=rep(NA,25)
species.dataset$Ne25000=rep(NA,25)
species.dataset$Ne100000=rep(NA,25)
species.dataset$Ne500000=rep(NA,25)
species.dataset$theta0=rep(NA,25)
#extract data from PSMC and add it to the species data 
species.dataset$Ne10000[(which(species.dataset$species=="Herklotsichthys_quadrimaculatus"))]=psmc.Netime(Hqu,10000)
species.dataset$Ne25000[(which(species.dataset$species=="Herklotsichthys_quadrimaculatus"))]=psmc.Netime(Hqu,25000)
species.dataset$Ne100000[(which(species.dataset$species=="Herklotsichthys_quadrimaculatus"))]=psmc.Netime(Hqu,100000)
species.dataset$Ne500000[(which(species.dataset$species=="Herklotsichthys_quadrimaculatus"))]=psmc.Netime(Hqu,500000)
species.dataset$theta0[(which(species.dataset$species=="Herklotsichthys_quadrimaculatus"))]=psmc.theta0(file="~/Dropbox/Mac/Desktop/psmc_outfiles/HqudenovoSSL20kall.psmc",g=1.3)
species.dataset$Ne10000[(which(species.dataset$species=="Stethojulis_interrupta"))]=psmc.Netime(Sin,10000)
#etc....

#hypothesis testing: use the general template lm(<responsevariable>~<predictorvariable>,data=species.dataset)