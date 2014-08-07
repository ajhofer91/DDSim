#----------------------------------------------------------------------------------------------------------------------------------#
#Wrapper for ss3sim and DD Growth case file creation#
#----------------------------------------------------------------------------------------------------------------------------------#
library(ss3sim)
library(r4ss)
setwd('F:/SS3SIM/2011/Basic DD')
#_---------------------------------------------------------------------------------------------------------------------------------#
#Function to calculate cohort growth deviations
Cohort_Dev<-function(Nf,akf,S){
  M<-matrix(0,nrow=nrow(Nf),ncol=ncol(Nf),byrow=F)   #calculating total length for each age class each year
  a<-1 #row counter
  while(a<=nrow(Nf)){
    b<-1 #column counter
    while(b<=ncol(Nf)){
      M[a,b]<-sum(Nf[a,b]*akf[b,]*S)
      b<-b+1
    }
    a<-a+1
  }
  
  CG_Matrix<-matrix(0,nrow=1,ncol=ncol(M),byrow=F)   #ordering Length matrix by Cohort
  a<-1
  while(a<=nrow(M)){
    if(a<=61){CG_Matrix<-rbind(CG_Matrix,diag(M[a:nrow(M),1:ncol(M)]))
              a<-a+1
             }else{
               CG_Matrix<-rbind(CG_Matrix,c(diag(M[a:nrow(M),1:ncol(M)]),rep(0,a-61)))
               a<-a+1               
             }
  }
  
  CN_Matrix<-matrix(0,nrow=1,ncol=ncol(Nf),byrow=F)  #ordering Numbers matrix by Cohort
  a<-1
  while(a<=nrow(M)){
    if(a<=61){CN_Matrix<-rbind(CN_Matrix,diag(Nf[a:nrow(Nf),1:ncol(Nf)]))
              a<-a+1
    }else{
      CN_Matrix<-rbind(CN_Matrix,c(diag(Nf[a:nrow(Nf),1:ncol(Nf)]),rep(0,a-61)))
      a<-a+1               
    }
  }
  
  a<-1
  CGD<-matrix(0,nrow=nrow(CG_Matrix), ncol=ncol(CG_Matrix)-1)  #CHANGE IN GROWTH
  while(a<=nrow(CG_Matrix)){
    b<-1
    while(b<ncol(CG_Matrix)){
      CGD[a,b]<-CG_Matrix[a,b+1]-CG_Matrix[a,b]
      b<-b+1
    }
    a<-a+1 
  }
  
  a<-1
  CND<-matrix(0,nrow=nrow(CN_Matrix), ncol=ncol(CN_Matrix)-1)   #CHANGE IN NUMBERS
  while(a<=nrow(CN_Matrix)){
    b<-1
    while(b<ncol(CN_Matrix)){
      CND[a,b]<-CN_Matrix[a,b+1]-CN_Matrix[a,b]
      b<-b+1
    }
    a<-a+1 
  }
  
  CGD<-CGD[2:102,]
  CND<-CND[2:102,]
  
  G_Devs<-matrix(rep(0,nrow(CGD)),nrow=nrow(CGD),ncol=1)   #Growth Deviations
  a<-1
  while(a<=nrow(CGD)){
    G_Devs[a,1]<-mean(CGD[a,1:40])
    a<-a+1
    }
  
  N_Devs<-matrix(rep(0,nrow(CND)),nrow=nrow(CND),ncol=1)  #Number Deviations
  a<-1
  while(a<=nrow(CND)){
    N_Devs[a,1]<-mean(CND[a,1:40])
    a<-a+1
  }
  
  X<-apply(CGD,2,'-',G_Devs)
  
  Y<-apply(CND,2,'-',N_Devs)
  
  K_devs<-(X/Y)
  K_devs
}

#checked function 
X<-Cohort_Dev(Nf,akf,S)
#----------------------------------------------------------------------------------------------------------------------------------#
#function to write case files for simulation
growth_file<-function(A,dir,affix){
  myreplist<-SS_output(paste0(dir,"/D1-E0-F1-R0-G",A-1,affix,"/1/om"),covar=FALSE)
  N<-myreplist$natage #complete numbers at age
  Nf<-N[1:(nrow(N)/2),]
  Nm<-N[(1+(nrow(N)/2)):nrow(N),]
  Nf<-as.matrix(Nf[seq(5,nrow(Nf),by=2),12:ncol(Nf)]) #correct numbers at age for each sex
  Nm<-as.matrix(Nm[seq(5,nrow(Nm),by=2),12:ncol(Nm)])
  #need age length keys seperated by sex
  akf<-t(apply(myreplist$ALK[,,1],2,rev))     #length class is small to large, age is young to old
  akm<-t(apply(myreplist$ALK[,,2],2,rev))     #row=age, col=length class
  S<-myreplist$lbinspop
  
  Fem<-apply(Cohort_Dev(Nf,akf,S),2,'/',myreplist$recruit[,2]-mean(myreplist$recruit[,2]))
  Mal<-apply(Cohort_Dev(Nm,akm,S),2,'/',myreplist$recruit[,2]-mean(myreplist$recruit[,2]))
  
  
  sink(file=paste0(case_folder,"/G",A,affix,".txt"))
  cat("function_type; change_tv\n",paste0("change_tv_list; list(Age_K_Fem_GP_1_a_1=",list(Fem[1,1:A]),",\n" )) 
  b<-1
  while((b<A)){
    cat(paste0("Age_K_Fem_GP_1_a_",b+1,"=",list(c(rep(0,b),Fem[(b+1),1:(A-b)])),",\n"))    
    b<-b+1
  }
  if(A==1){
    cat(paste0("Age_K_Mal_GP_1_a_1=",list(Fem[1,1]),")"))
  }else{
    cat(paste0("Age_K_Mal_GP_1_a_1=",list(Fem[1,1:A]),",\n" )) 
  }
  b<-1
  while((b<A)){
    cat(paste0("Age_K_Mal_GP_1_a_",b+1,"=",list(c(rep(0,b),Fem[(b+1),1:(A-b)]))))    
    b<-b+1
    if(b<A){cat(",\n")}else{cat(")")}
  }
  sink()
}

#----------------------------------------------------------------------------------------------------------------------------------#
#wrapper for entire simulation
Simulation<-function(dir, #wd
                     case_folder, #ss3sim input
                     om_dir, #ss3sim input
                     em_dir, #ss3sim input
                     affix,
                     years){ #Number of years the simulation runs for. [101]
  a<-1
  while(a<=years){
    run_ss3sim(iterations = 1:1, scenarios = paste0("D1-E0-F1-R0-G",a-1, affix),
               case_folder = case_folder, om_dir = om, em_dir = em, bias_adjust = F,
               case_files = list(F = "F", D = c("index", "lcomp",
                                                "agecomp"), G = "G", R = "R",E = "E"))
    
    growth_file(a,dir,affix)
    a<-a+1
  }
  
}
#----------------------------------------------------------------------------------------------------------------------------------#
Simulation("F:/SS3SIM/Cod_example/",
           "F:/SS3SIM/Cod_example/Cases",
           "F:/SS3SIM/Cod_example/cod-om",
           "F:/SS3SIM/Cod_example/cod-em",
           "-cod",
           100)  

