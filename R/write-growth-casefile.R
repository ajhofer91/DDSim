#' Write case files for simulation
#'
#' TODO: Insert more information here.
#'
#' @param N Numbers-at-age matrix (output from r4ss) 
#' @param alk Age-length-key (output from r4ss) 
#' @param lbin Length vector breakpoints (output from r4ss)
#' @param yrs Number of years simulation is run
#' @return Matrix of calculated cohort-specific growth deviations
write_growth_casefile <- function(A, dir, case_folder, affix, years, str){
  myreplist<-SS_output(paste0(dir,"/D1-E0-F0-R0-G",A-1,affix,"/1/om"),covar=FALSE)
  N<-myreplist$natage #complete numbers at age
  Nf<-N[1:(nrow(N)/2),]
  Nm<-N[(1+(nrow(N)/2)):nrow(N),]
  Nf<-as.matrix(Nf[seq(5,nrow(Nf),by=2),12:ncol(Nf)]) #correct numbers at age for each sex
  Nm<-as.matrix(Nm[seq(5,nrow(Nm),by=2),12:ncol(Nm)])
  #need age length keys seperated by sex
  akf<-t(apply(myreplist$ALK[,,1],2,rev))     #length class is small to large, age is young to old
  akm<-t(apply(myreplist$ALK[,,2],2,rev))     #row=age, col=length class
  S<-myreplist$lbinspop
  
  Fem<-apply(Cohort_Dev(Nf,akf,S,years),2,'/',myreplist$recruit[,2]-mean(myreplist$recruit[,2]))
  Mal<-apply(Cohort_Dev(Nm,akm,S,years),2,'/',myreplist$recruit[,2]-mean(myreplist$recruit[,2]))
  Fem<-str*Fem
  Mal<-str*Mal
  f<-rep(0,years)
  f[1:A]<-round(Fem[1,1:A],6)
  cat("function_type; change_tv","\n","param; Age_K_Fem_GP_1_a_1","\n",c(paste0("dev; ",list(c(f)))),file=paste0(case_folder,"/1X",A,affix,".txt"),fill=F)
  m<-rep(0,years)
  m[1:A]<-round(Mal[1,1:A],6)
  cat("function_type; change_tv","\n","param; Age_K_Mal_GP_1_a_1","\n",c(paste0("dev; ",list(c(m)))),file=paste0(case_folder,"/1Y",A,affix,".txt"),fill=F)
  
  b<-1
  while((b<years)){
    if(b<A){n<-rep(0,years)
            n[b+1:(A-b)]<-round(Fem[(b+1),1:(A-b)],6)
            cat("function_type; change_tv","\n",paste0("param; Age_K_Fem_GP_1_a_",b+1),"\n",c(paste0("dev; ",list(c(n)))),file=paste0(case_folder,"/",b+1,"X",A,affix,".txt"),fill=F)
    }else{
      cat("function_type; change_tv","\n",paste0("param; Age_K_Fem_GP_1_a_",b+1),"\n",c(paste0("dev; ",list(c(rep(0,31))))),file=paste0(case_folder,"/",b+1,"X",A,affix,".txt"),fill=F)
    }
    b<-b+1
  }  
  b<-1
  while((b<years)){
    if(b<A){n<-rep(0,years)
            n[b+1:(A-b)]<-round(Mal[(b+1),1:(A-b)],6)
            cat("function_type; change_tv","\n",paste0("param; Age_K_Mal_GP_1_a_",b+1),"\n",c(paste0("dev; ",list(c(n)))),file=paste0(case_folder,"/",b+1,"Y",A,affix,".txt"),fill=F)  
    }else{
      cat("function_type; change_tv","\n",paste0("param; Age_K_Mal_GP_1_a_",b+1),"\n",c(paste0("dev; ",list(c(rep(0,31))))),file=paste0(case_folder,"/",b+1,"Y",A,affix,".txt"),fill=F)   
    }
    b<-b+1
  }
  
}