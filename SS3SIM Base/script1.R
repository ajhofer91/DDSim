# SS3SIM template 
# Run ss3SIM with and without bias correction
# This file configured for Simple Example ('Basic DD').
# by Alex Hofer, 
# contact ajhofer91@gmail.com
#-------------------------------------------------------------#
#Load Package from Lib
library(ss3sim)
help(package = "ss3sim")
#-------------------------------------------------------------# 
# Without bias adjustment:
#set WD
setwd('F:/SS3SIM/2011/Basic DD')
#Specify directories for OM, EM and case files.
d <- "F:/SS3SIM/2011/Basic DD"
case_folder <- paste0(d,"/Cases")
om <- paste0(d, "/BDD_OM")
omx<-paste0(d,"Base model")
em <- paste0(d, "/BDD_EM")
#testing OM base
run_ss3model(scenarios = "D0-E0-F0-R0-spp",iterations = 1:1, type= 'om', ss3path=omx)
#testing OM and EM without DD growth
run_ss3sim(iterations = 1:1, scenarios = "D1-E0-F0-R0-spp",
           case_folder = case_folder, om_dir = om, em_dir = em, bias_adjust = TRUE,
           case_files = list(F = "F", D = c("index", "lcomp",
                                            "agecomp"), R = "R", E = "E"))

get_results_all(user_scenarios = c("D1-E0-F0-R0-spp"))
scalar_dat <- read.csv("final_results_scalar.csv")
ts_dat <- read.csv("final_results_ts.csv")







