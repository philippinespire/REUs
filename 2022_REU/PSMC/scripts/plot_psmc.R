# Function to plot PSMC using .psmc output
# Modified from https://github.com/elhumble/SHO_analysis_2020/blob/master/scripts/plot_psmc.R

## load PSMC data into R
##be sure to provide mutation rate + genration time. other variables can be left at defaults

psmc.result<-function(file,i.iteration=25,mu=1e-8,s=100,g=1)
{
  X<-scan(file=file,what="",sep="\n",quiet=TRUE)
  
  # extract data for each iteration (30)
  
  START<-grep("^RD",X) # line numbers
  END<-grep("^//",X) # line numbers
  
  X<-X[START[i.iteration+1]:END[i.iteration+1]]
  
  TR<-grep("^TR",X,value=TRUE) # \theta_0 \rho_0
  RS<-grep("^RS",X,value=TRUE) # k t_k \lambda_k \pi_k \sum_{l\not=k}A_{kl} A_{kk}
  
  write(TR,"temp.psmc.result")
  theta0<-as.numeric(read.table("temp.psmc.result")[1,2])
  N0<-theta0/(4*mu)/s # scale 

  write(RS,"temp.psmc.result")
  a<-read.table("temp.psmc.result")
  Generation<-as.numeric(2*N0*a[,3])
  Ne<-as.numeric(N0*a[,4])
  
  a$Generation<-as.numeric(2*N0*a[,3])
  a$Ne<-as.numeric(N0*a[,4])
  
  file.remove("temp.psmc.result")
  
  n.points<-length(Ne)
  
  YearsAgo<-c(as.numeric(rbind(Generation[-n.points],Generation[-1])),
              Generation[n.points])*g
  Ne<-c(as.numeric(rbind(Ne[-n.points],Ne[-n.points])),
        Ne[n.points])
  
  data.frame(YearsAgo,Ne,mu,g)
  #plot(Ne~YearsAgo)
}

###plot a PSMC result - log scale x axis
###must do library(ggplot2) first

psmc.plot.log<-function(result)
{
	ggplot(data=result,aes(x=YearsAgo+1,y=Ne,group=species,color=group)) +
	scale_x_log10(breaks = scales::pretty_breaks(),limits=c(2000,2000000)) +
	geom_line() +
  theme(axis.text.x = element_text(angle = -20))
}

###plot a PSMC result - normal scale x axis
###must do library(ggplot2) first

psmc.plot<-function(result)
{
	ggplot(data=result,aes(x=YearsAgo+1,y=Ne,group=species,color=group)) +
	xlim(2000,2000000) +
	geom_line()
}


###extract theta0
psmc.theta0<-function(file,i.iteration=25,mu=1e-8,s=100,g=1)
{
  X<-scan(file=file,what="",sep="\n",quiet=TRUE)
  
  # extract data for each iteration (30)
  
  START<-grep("^RD",X) # line numbers
  END<-grep("^//",X) # line numbers
  
  X<-X[START[i.iteration+1]:END[i.iteration+1]]
  
  TR<-grep("^TR",X,value=TRUE) # \theta_0 \rho_0
  RS<-grep("^RS",X,value=TRUE) # k t_k \lambda_k \pi_k \sum_{l\not=k}A_{kl} A_{kk}
  
  write(TR,"temp.psmc.result")
  as.numeric(read.table("temp.psmc.result")[1,2])
 }

###extract Ne for a given time
psmc.Netime<-function(result,time)
{
	Tdiff=min(abs(result$YearsAgo-time))
	interval=which(abs(result$YearsAgo-time)==Tdiff)
	ifelse(result$YearsAgo[interval[2]]-time<0,result$Ne[interval[2]],result$Ne[interval[2]-1])
}
