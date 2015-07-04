## Note: fit object from spike-and-slab must still be in memory
##

summarize.covar <- function(label, beta, gamma, max.width) {
  gamma.mu <- mean(gamma)
  beta.post <- beta[gamma>0]
  beta.mu <- mean(beta.post)
  beta.int <- quantile(beta.post, c(0.025, 0.975))
  line <- sprintf("%*s: %4.2 f     %6.3f (%6.3f, %6.3f)",
                  max.width, label, gamma.mu, beta.mu, beta.int[1], beta.int[2])
  cat(line)
  if ((beta.int[2] < 0.0) || (beta.int[1] > 0.0)) {
    cat("*", sep="")
  }
  cat("\n")
}

max.width <- nchar("beta.ratio")

list <- fit$BUGSoutput$sims.list
summarize.covar("beta.cdd", list$beta.cdd, list$gamma[,1], max.width)
summarize.covar("beta.elev", list$beta.elev, list$gamma[,2], max.width)
summarize.covar("beta.inso", list$beta.inso, list$gamma[,3], max.width)
summarize.covar("beta.map", list$beta.map, list$gamma[,4], max.width)
summarize.covar("beta.mat", list$beta.mat, list$gamma[,5], max.width)
summarize.covar("beta.ratio", list$beta.ratio, list$gamma[,6], max.width)
