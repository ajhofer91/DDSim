#----------------------------------------------------------------------------------------------------------------------------------#
#Wrapper for ss3sim and DD Growth case file creation#
#----------------------------------------------------------------------------------------------------------------------------------#
library(ss3sim)
library(r4ss)
d<-'C:/Users/Alex/Desktop/Github/DDSIM/'
d_base<-paste0(d,'Base_Scenario')
setwd(d)
#---------------------------------------------------------------------------------------------------------------------------------#

# Source DDSim functions:
source(paste0(d,'R/get-cohort-devs.R')) 
source(paste0(d,'R/write-growth-casefile.R')) 
source(paste0(d,'R/run-ddsim.R')) 


#----------------------------------------------------------------------------------------------------------------------------------#
run_ddsim( d,                        #wd
           paste0(d_base,"/Cases"),       #ss3sim input (cases)
           paste0(d_base,"/BDD_OM"),      #ss3sim input (om) 
           paste0(d_base,"/BDD_EM"),      #ss3sim input (em)
           "-spp",
           31,
           0,
           1)
#----------------------------------------------------------------------------------------------------------------------------------#
om<-paste0(d_base,"/D1-E0-F0-R0-G31-spp/1/om")
em<-paste0(d_base,"/D1-E0-F0-R0-G31-spp/1/em")

SSplotBiology(SS_output(om,covar=F),print=T,plotdir=paste0(d_base,"/plots/Om"))
SSplotBiology(SS_output(em,covar=F),print=T,plotdir=paste0(d_base,"/plots/Em"))

SSplotNumbers(SS_output(om,covar=F),print=T,plotdir=paste0(d_base,"/plots/Om"))
SSplotNumbers(SS_output(om,covar=F),print=T,plotdir=paste0(d_base,"/plots/Em"))
              
biglist<-SSgetoutput(dirvec=c(om, em), getcovar=T, forecast=T)              
biglist<-SSsummarize(biglist)              
SSplotComparisons(biglist,print=T,plotdir=paste0(d_base,"/plots"))              
