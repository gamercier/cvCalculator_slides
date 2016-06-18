#' 10 year cardiovascular risk factor calculator.
#' 
#' Coefficients
#' age, age2, tchol, age.tchol, hdl,
#' age.hdl, tsbp, age.tsbp, nsbp, age.nsbp,
#' smk, age.smk  diab
c.wwoman <-
  c("age"=-29.799, "age2"=4.884, "tchol"=13.540, "age.tchol"=-3.114, "hdl"=-13.578,
    "age.hdl"=3.149, "tsbp"=2.019, "age.tsbp"=0, "nsbp"=1.957, "age.nsbp"=0,
    "smk"=7.574, "age.smk"=-1.665, "diab"=0.661)

c.aawoman <-
  c("age"=17.114, "age2"=0, "tchol"=0.940, "age.tchol"=0, "hdl"=-18.920,
    "age.hdl"=4.475, "tsbp"=29.291, "age.tsbp"=-6.432, "nsbp"=27.820, "age.nsbp"=-6.087,
    "smk"=0.691, "age.smk"=0, "diab"=0.874)

c.wman <-
  c("age"=12.344, "age2"=0, "tchol"=11.853, "age.tchol"=-2.664, "hdl"=-7.990,
    "age.hdl"=1.769, "tsbp"=1.797, "age.tsbp"=0, "nsbp"=1.764, "age.nsbp"=0,
    "smk"=7.837, "age.smk"=-1.795, "diab"=0.658)

c.aaman <-
  c("age"=2.469, "age2"=0, "tchol"=0.302, "age.tchol"=0, "hdl"=-0.307,
    "age.hdl"=0, "tsbp"=1.916, "age.tsbp"=0, "nsbp"=1.809, "age.nsbp"=0,
    "smk"=0.549, "age.smk"=0, "diab"=0.645)

base.survival <- c("female.white"=0.9665,"female.black"=0.9533,
                   "male.white"=0.9144,"male.black"=0.8954)
mean.s.terms <- c("female.white"=-29.18,"female.black"=86.61,
                  "male.white"=61.18,"male.black"=19.54)

#'  Takes coefficients and observations to compute the sum of terms
s.terms <- function(coefs,obs){
  age <- obs["age"]; tchol<-obs["tchol"]; hdl <- obs["hdl"]
  tsbp <- obs["tsbp"]; nsbp <- obs["nsbp"]; smk <- obs["smk"]; diab <- obs["diab"]
  log.age <- log(age)
  log.age2 <- log.age*log.age
  log.tchol <- log(tchol)
  log.hdl <- log(hdl)
  if(tsbp > 0){
    log.tsbp <- log(tsbp)
  } else {
    log.tsbp <- 0
  }
  if(nsbp > 0){
    log.nsbp <- log(nsbp)
  } else {
    log.nsbp <- 0
  }
  s <- coefs["age"]*log.age + coefs["age2"]*log.age2 + coefs["tchol"]*log.tchol +
    coefs["age.tchol"]*log.age*log.tchol + coefs["hdl"]*log.hdl +
    coefs["age.hdl"]*log.age*log.hdl + coefs["tsbp"]*log.tsbp +
    coefs["age.tsbp"]*log.age*log.tsbp + coefs["nsbp"]*log.nsbp +
    coefs["age.nsbp"]*log.age*log.nsbp + coefs["smk"]*smk +
    coefs["age.smk"]*log.age*smk + coefs["diab"]*diab
  return(s)
}

#' Takes the coefficients, observations, baseline survival, and average of sum of terms
#' to compute the 10 year cardiovascular risk factor as a percent.
ten.year.risk <-function(coefs,obs,bsurv,means){
  s.terms <- s.terms(coefs,obs)
  d <- s.terms - means
  ed <- exp(d)
  return(100.0*(1. - bsurv^(ed)))
}

#' Adapting for shiny app
params <- data.frame("female.white"=c.wwoman,"female.black"=c.aawoman,
                     "male.white"=c.wman,"male.black"=c.aaman)
row.names(params) <- names(c.wwoman)

get.parms <- function(sex,race){
  if(sex == "Female" && race == "Other"){
    ps <- params[["female.white"]]
    names(ps) <- row.names(params)
    return(list(parms=ps,bsurv=base.survival["female.white"],
                means=mean.s.terms["female.white"]))
  }
  else {
    if(sex == "Female" && race == "African American"){
      ps <- params[["female.black"]]
      names(ps) <- row.names(params)
      return(list(parms=ps,bsurv=base.survival["female.black"],
                  means=mean.s.terms["female.black"]))
    }
    else {
      if(sex == "Male" && race == "African American"){
        ps <- params[["male.black"]]
        names(ps) <- row.names(params)
        return(list(parms=ps,bsurv=base.survival["male.black"],
                    means=mean.s.terms["male.black"]))
      }
      else {
        ps <- params[["male.white"]] # default parameters
        names(ps) <- row.names(params)
        bsurv <- base.survival["male.white"]
        msterms <- mean.s.terms["male.white"]
        return(list(parms=ps,bsurv=base.survival["male.white"],
                    means=mean.s.terms["male.white"]))
      }
    }
  }
}

#' packager for observation
pack.obs <- function(age,tchol,hdl,tsbp,nsbp,smk,diab){
  return(c(age=age,tchol=tchol,hdl=hdl,tsbp=tsbp,nsbp=nsbp,smk=smk,diab=diab))
}

#' calculator to use with shiny app
cvcalc <- function(sex,race,obs){
  info <- get.parms(sex,race)
  return(ten.year.risk(info$parms,obs,info$bsurv,info$means))
}
