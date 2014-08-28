#' Calculate cohort growth deviations based on length- and numbers-at-age
#'
#' TODO: Insert more information here.
#'
#' @param N Numbers-at-age matrix (output from r4ss) 
#' @param alk Age-length-key (output from r4ss) 
#' @param lbin Length vector breakpoints (output from r4ss)
#' @param yrs Number of years simulation is run
#' @return Matrix of calculated cohort-specific growth deviations
get_cohort_devs <- function(N, alk, lbin, yrs){
  M<-matrix(0,nrow=nrow(N),ncol=ncol(N),byrow=F)   #calculating total length for each age class each year
  a<-1 #row counter
  while(a<=nrow(N)){
    b<-1 #column counter
    while(b<=ncol(N)){
      M[a,b]<-sum(N[a,b]*alk[b,]*lbin)
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
  
  CN_Matrix<-matrix(0,nrow=1,ncol=ncol(N),byrow=F)  #ordering Numbers matrix by Cohort
  a<-1
  while(a<=nrow(M)){
    if(a<=61){CN_Matrix<-rbind(CN_Matrix,diag(N[a:nrow(N),1:ncol(N)]))
              a<-a+1
    }else{
      CN_Matrix<-rbind(CN_Matrix,c(diag(N[a:nrow(N),1:ncol(N)]),rep(0,a-61)))
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