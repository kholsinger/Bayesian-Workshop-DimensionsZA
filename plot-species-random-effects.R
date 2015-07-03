## Note: data and fit object from analysis must be in memory before
## this is run

library(ggplot2)

tbl <- data.frame(label=tmp$species,
                  sp.no=as.numeric(tmp$species))
tbl <- unique(tbl)

n.sampled <- dim(fit$BUGSoutput$sims.list$beta.0)[1]
beta.0 <- numeric(0)
species <- character(0)
for (i in 1:n.species) {
  beta.0 <- c(beta.0, fit$BUGSoutput$sims.list$beta.0)
  species <- c(species, rep(as.character(tbl$label[tbl$sp.no==i]), n.sampled))
}

dat <- data.frame(beta.0=beta.0, species=species)

p <- ggplot(dat, aes(x=species, y=beta.0)) + geom_boxplot() +
  theme(axis.text.x=element_blank())
print(p)
