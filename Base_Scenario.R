#----------------------------------------------------------------------------------------------------------------------------------#
#Wrapper for ss3sim and DD Growth case file creation#
#----------------------------------------------------------------------------------------------------------------------------------#
library(ss3sim)
library(r4ss)
d<-'C:/Users/Alex/Desktop/Base Scenario'
setwd(d)
#---------------------------------------------------------------------------------------------------------------------------------#

# Source DDSim functions:
source('C:/Users/Alex/Desktop/Github/DDSim/R/get-cohort-devs.R') # Alex's Box
source('C:/Users/Alex/Desktop/Github/DDSim/R/write-growth-casefile.R') 
source('C:/Users/Alex/Desktop/Github/DDSim/R/run-ddsim.R') 

source('C:/Dropbox/Github/DDSim/R/get-cohort-devs.R') # Athol's Box
source('C:/Dropbox/Github/DDSim/R/write-growth-casefile.R') 
source('C:/Dropbox/Github/DDSim/R/run-ddsim.R') 

#----------------------------------------------------------------------------------------------------------------------------------#
run_ddsim( d,                        #wd
           paste0(d,"/Cases"),       #ss3sim input (cases)
           paste0(d,"/BDD_OM"),      #ss3sim input (om) 
           paste0(d,"/BDD_EM"),      #ss3sim input (em)
           "-spp",
           31,
           0,
           1)
#----------------------------------------------------------------------------------------------------------------------------------#
om<-paste0(d,"/D1-E0-F0-R0-G31-spp/1/om")
em<-paste0(d,"/D1-E0-F0-R0-G31-spp/1/em")

SSplotBiology(SS_output(om,covar=F),print=T,plotdir=paste0(d,"/plots/Om")
SSplotBiology(SS_output(em,covar=F),print=T,plotdir=paste0(d,"/plots/Em")

SSplotNumbers(SS_output(om,covar=F),print=T,plotdir=paste0(d,"/plots/Om")
SSplotNumbers(SS_output(om,covar=F),print=T,plotdir=paste0(d,"/plots/Em")
              
biglist<-SSgetoutput(dirvec=c(om, em), getcovar=T, forecast=T)              
biglist<-SSsummarize(biglist)              
SSplotComparisons(biglist,print=T,plotdir=paste0(d,"/plots"))              
