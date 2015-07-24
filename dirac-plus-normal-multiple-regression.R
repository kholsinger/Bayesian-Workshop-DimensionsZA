require(R2jags)

rm(list=ls())
source("setup-data.R")

n.chains <- 5
n.burnin <- 5000
n.iter <- 10000
n.thin <- 5

## prior parameter for precision of regression coefficients
tau <- 0.1
## prior parameter for precisions
##
phi <- 1

jags.data <- c("lma",
               "mat",
               "map",
               "ratio",
               "cdd",
               "inso",
               "elev",
               "species",
               "n.samp",
               "n.species",
               "tau",
               "phi")
jags.par <- c("beta.0",
              "beta.mat",
              "beta.map",
              "beta.ratio",
              "beta.cdd",
              "beta.inso",
              "beta.elev",
              "beta.zero",
              "gamma",
              "pi",
              "sigma.resid",
              "sigma.species")

fit <- jags(data=jags.data,
            inits=NULL,
            parameters=jags.par,
            model.file="dirac-plus-normal-multiple-regression.jags",
            n.chains=n.chains,
            n.burnin=n.burnin,
            n.iter=n.iter,
            n.thin=n.thin,
            DIC=TRUE,
            working.directory=".")
