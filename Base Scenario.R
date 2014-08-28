#----------------------------------------------------------------------------------------------------------------------------------#
#Wrapper for ss3sim and DD Growth case file creation#
#----------------------------------------------------------------------------------------------------------------------------------#
library(ss3sim)
library(r4ss)
setwd('C:/Users/Alex/Desktop/Base Scenario')
#_---------------------------------------------------------------------------------------------------------------------------------#
#Function to calculate cohort growth deviations
Cohort_Dev<-function(Nf,akf,S,yrs){
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
  
  CGD<-CGD[2:(yrs+2),]
  CND<-CND[2:(yrs+2),]
  
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
#----------------------------------------------------------------------------------------------------------------------------------#
#function to write case files for simulation
growth_file<-function(A,dir,case_folder,affix,years,str){
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
