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

jags.data <- c("lma",
               "mat",
               "n.samp",
               "tau",
               "phi")
jags.par <- c("beta.0",
              "beta.mat",
              "sigma.resid")

fit.simple <- jags(data=jags.data,
                  inits=NULL,
                  parameters=jags.par,
                  model.file="simple-linear-regression.jags",
                  n.chains=n.chains,
                  n.burnin=n.burnin,
                  n.iter=n.iter,
                  n.thin=n.thin,
                  DIC=TRUE,
                  working.directory=".")
fit.robust <- jags(data=jags.data,
                   inits=NULL,
                   parameters=jags.par,
                   model.file="robust-linear-regression.jags",
                   n.chains=n.chains,
                   n.burnin=n.burnin,
                   n.iter=n.iter,
                   n.thin=n.thin,
                   DIC=TRUE,
                   working.directory=".")
results <- data.frame(model=c("Simple","Robust"),
                      data=c("Original","Original"),
                      beta.0=c(fit.simple$BUGSoutput$mean$beta.0,
                               fit.robust$BUGSoutput$mean$beta.0),
                      beta.mat=c(fit.simple$BUGSoutput$mean$beta.mat,
                                 fit.robust$BUGSoutput$mean$beta.mat))

lma[lma > 4.74] <- 20.0
fit.simple <- jags(data=jags.data,
                   inits=NULL,
                   parameters=jags.par,
                   model.file="simple-linear-regression.jags",
                   n.chains=n.chains,
                   n.burnin=n.burnin,
                   n.iter=n.iter,
                   n.thin=n.thin,
                   DIC=TRUE,
                   working.directory=".")
fit.robust <- jags(data=jags.data,
                   inits=NULL,
                   parameters=jags.par,
                   model.file="robust-linear-regression.jags",
                   n.chains=n.chains,
                   n.burnin=n.burnin,
                   n.iter=n.iter,
                   n.thin=n.thin,
                   DIC=TRUE,
                   working.directory=".")
tmp <- data.frame(model=c("Simple","Robust"),
                  data=c("Modified","Modified"),
                  beta.0=c(fit.simple$BUGSoutput$mean$beta.0,
                           fit.robust$BUGSoutput$mean$beta.0),
                  beta.mat=c(fit.simple$BUGSoutput$mean$beta.mat,
                             fit.robust$BUGSoutput$mean$beta.mat))
results <- rbind(results, tmp)


