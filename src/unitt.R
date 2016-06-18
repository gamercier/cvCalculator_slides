#' unit test for cvcalc.R
#' 
setwd("~/MOOC/CourseEra/DevelopingDataP/prj/cvCalc")
source("./cvcalc.R")
unit.test.sterms <- function(f,coef,obs,answ){
  out <- f(coef,obs)
  if(abs(answ-out) < 0.01){
    return("Sucess!")
  } else {
    return("Fail!")
  }
}

unit.test.ten.surv <- function(f,coef,obs,bsurv,means,answ){
  out <- f(coef,obs,bsurv,means)
  if(abs(answ-out) < 0.1){
    return("Sucess!")
  } else {
    return("Fail!")
  }
}

obs.test <- c("age"=55,"tchol"=213,"hdl"=50,"tsbp"=0,"nsbp"=120,"smk"=0,"diab"=0)
coefs <- data.frame("female.white"=c.wwoman,"female.black"=c.aawoman,"male.white"=c.wman,
                    "male.black"=c.aaman)
answers.sum <- c("female.white"=-29.67,"female.black"=86.16,"male.white"=60.69,
                 "male.black"=18.97)
answers.ten <- c("female.white"=2.1,"female.black"=3.0,"male.white"=5.3,
                 "male.black"=6.1)
cases <- c("female.white","female.black","male.white","male.black")

for(case in cases){
  cat(paste("Doing ",case,"\n"))
  cfs <- coefs[[case]]
  names(cfs) <- row.names(coefs)
  cat("Testing sum of terms. \n")
  cat( paste(unit.test.sterms(s.terms,cfs,obs.test,answers.sum[case]),"\n") )
  
  cat("Testing 10 year survival. \n")
  cat( paste(unit.test.ten.surv(ten.year.risk,cfs,obs.test,
                                base.survival[case],mean.s.terms[case],
                                answers.ten[case]),"\n") )
  
}
