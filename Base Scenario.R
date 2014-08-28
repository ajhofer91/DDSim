#----------------------------------------------------------------------------------------------------------------------------------#
#Wrapper for ss3sim and DD Growth case file creation#
#----------------------------------------------------------------------------------------------------------------------------------#
library(ss3sim)
library(r4ss)
setwd('C:/Users/Alex/Desktop/Base Scenario')
#_---------------------------------------------------------------------------------------------------------------------------------#

# Source DDSim functions:
source('C:/Users/Alex/Desktop/Github/DDSim/R/get-cohort-devs.R') # Alex's Box
source('C:/Users/Alex/Desktop/Github/DDSim/R/write-growth-casefile.R') # Alex's Box


source('C:/Dropbox/Github/DDSim/R/get-cohort-devs.R') # Athol's Box
source('C:/Dropbox/Github/DDSim/R/write-growth-casefile.R.R') # Athol's Box



#----------------------------------------------------------------------------------------------------------------------------------#
#wrapper for entire simulation
Simulation<-function(dir, #wd
                     case_folder, #ss3sim input
                     om, #ss3sim input Om directory
                     em, #ss3sim input Em directory
                     affix,
                     years,
                     start,
                     str){ #Number of years the simulation runs for. [101]
  a<-start
  while(a<=years){
    run_ss3sim(iterations = 1:1, scenarios = paste0("D1-E0-F0-R0-G",a, affix),
               case_folder = case_folder, om_dir = om, em_dir = em, bias_adjust = F,
               case_files = list(F = "F", D = c("index", "lcomp",
                                                "agecomp"), G=c(paste0(seq(1:25),'X'),paste0(seq(1:25),'Y')), R = "R",E = "E"))
    
    growth_file(a+1,dir,case_folder,affix,years,str)
    a<-a+1
  }
  
}
#----------------------------------------------------------------------------------------------------------------------------------#
Simulation("C:/Users/Alex/Desktop/Base Scenario",            #wd
           "C:/Users/Alex/Desktop/Base Scenario/Cases",       #ss3sim input (cases)
           "C:/Users/Alex/Desktop/Base Scenario/BDD_OM",      #ss3sim input (om) 
           "C:/Users/Alex/Desktop/Base Scenario/BDD_EM",      #ss3sim input (em)
           "-spp",
           31,
           0,
           1)
#----------------------------------------------------------------------------------------------------------------------------------#
#Specify working folder (directory where subdirectories are species folders);
folder="C:/Users/Alex/Desktop/Base Scenario"

#Enter species name;
species="D1-E0-F0-R0-G31-spp"
year=1
#Specify model names as folder names of each set of model files, set the base case as model one;
model.names=c("om","em")

################### SECTION FOR MODEL COMPARISONS ######################

if(compare.plots==TRUE){
  
  #Get all report files into one 'biglist' and make each report list a global variable for plotting features;
  biglist=SSgetoutput(dirvec=model.dirs[which(compare==TRUE)],forecast=TRUE,verbose=TRUE,underscore=TRUE,listlists=TRUE,getcovar=FALSE)
  
  #Summarise the contents of 'biglist' using the SSsummarize function
  bigsummary=SSsummarize(biglist)
  
  #See estimated quantities summary (rounded):
  cbind(round(bigsummary$quants[1:2],2),bigsummary$quants[3:4])
  
  #Compare plots of interest using SSplotcomparisons;
  SSplotComparisons(bigsummary,btarg=biomass.target,endyrvec=last.year,minbthresh=biomass.threshold,subplots=1:14,spacepoints=5,staggerpoints=0,plot=TRUE,print=FALSE,legendlabels=model.names[which(compare==TRUE)])
}

#Enable this line below to direct Comparison Plots to some specified directory;
#SSplotComparisons(bigsummary,btarg=biomass.target,endyrvec=last.year,minbthresh=biomass.threshold,subplots=1:14,spacepoints=5,staggerpoints=1,plot=TRUE,print=TRUE,legendlabels=model.names[which(compare==TRUE)],plotdir="")

om<-"C:/Users/Alex/Desktop/Base Scenario/D1-E0-F0-R0-G31-spp/1/om"
em<-"C:/Users/Alex/Desktop/Base Scenario/D1-E0-F0-R0-G31-spp/1/em"
SSplotBiology(SS_output(om,covar=F),print=T,plotdir="C:/Users/Alex/Desktop/Base Scenario/plots/Om")
SSplotBiology(SS_output(em,covar=F),print=T,plotdir="C:/Users/Alex/Desktop/Base Scenario/plots/Em")
