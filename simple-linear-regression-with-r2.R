require(R2jags)

rm(list=ls())
source("setup-data.R")

n.chains <- 5
n.burnin <- 5000
n.iter <- 10000
n.thin <- 5

## prior precision on regression coefficients
##
tau <- 0.1
## prior parameter for residual precision
##
phi <- 1

lma.var <- var(lma)

jags.data <- c("lma",
               "mat",
               "lma.var",
               "n.samp",
               "tau",
               "phi")
jags.par <- c("beta.0",
              "beta.mat",
              "sigma2.resid",
              "r2")

fit <- jags(data=jags.data,
            inits=NULL,
            parameters=jags.par,
            model.file="simple-linear-regression-with-r2.jags",
            n.chains=n.chains,
            n.burnin=n.burnin,
            n.iter=n.iter,
            n.thin=n.thin,
            DIC=TRUE,
            working.directory=".")
