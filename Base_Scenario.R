#----------------------------------------------------------------------------------------------------------------------------------#
# Wrapper for ss3sim and DD Growth case file creation #
#----------------------------------------------------------------------------------------------------------------------------------#

# Load required libraries, set simulation directory (sim_dir):
library(ss3sim)
library(r4ss)
sim_dir <- '.'
sim_dir_base <- paste0(sim_dir,'Base_Scenario')

# Set R folder and source functions:
r_lib   <- './R'
r_files <- list.files(r_lib,pattern="\\.[Rr]$")
for(name in r_files) source(file.path(r_lib, name), echo=FALSE)

#----------------------------------------------------------------------------------------------------------------------------------#
# Run DDSim:
run_ddsim( d,                                   #wd
           paste0(sim_dir_base,"/Cases"),       #ss3sim input (cases)
           paste0(sim_dir_base,"/BDD_OM"),      #ss3sim input (om) 
           paste0(sim_dir_base,"/BDD_EM"),      #ss3sim input (em)
           "D1-E0-F0-R0",
           "-spp",
           31,
           0,
           1)

#----------------------------------------------------------------------------------------------------------------------------------#
om<-paste0(sim_dir_base,"/D1-E0-F0-R0-G31-spp/1/om")
em<-paste0(sim_dir_base,"/D1-E0-F0-R0-G31-spp/1/em")

SSplotBiology(SS_output(om,covar=F),print=T,plotdir=paste0(sim_dir_base,"/plots/Om"))
SSplotBiology(SS_output(em,covar=F),print=T,plotdir=paste0(sim_dir_base,"/plots/Em"))

SSplotNumbers(SS_output(om,covar=F),print=T,plotdir=paste0(sim_dir_base,"/plots/Om"))
SSplotNumbers(SS_output(om,covar=F),print=T,plotdir=paste0(sim_dir_base,"/plots/Em"))
              
biglist<-SSgetoutput(dirvec=c(om, em), getcovar=T, forecast=T)              
biglist<-SSsummarize(biglist)              
SSplotComparisons(biglist,print=T,plotdir=paste0(sim_dir_base,"/plots"))              
