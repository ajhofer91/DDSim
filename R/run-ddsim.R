#' Wrapper for entire simulation
#'
#' TODO: Insert more information here.
#'
#' @param N Numbers-at-age matrix (output from r4ss) 
#' @param alk Age-length-key (output from r4ss) 
#' @param lbin Length vector breakpoints (output from r4ss)
#' @param yrs Number of years simulation is run
#' @return Matrix of calculated cohort-specific growth deviations
run_ddsim <- function(dir, #wd
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