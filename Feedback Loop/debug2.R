#Debugging Growth case folders
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
em <- paste0(d, "/BDD_EM")
#testing case file for growth base
run_ss3sim(scenarios = "D1-E0-F1-R0-G1-spp",iterations = 1:1, case_folder = case_folder, om_dir = om, em_dir = em, bias_adjust = TRUE,
           case_files = list(F = "F", D = c("index", "lcomp",
                                            "agecomp"), R = "R", E = "E",G='G'))









