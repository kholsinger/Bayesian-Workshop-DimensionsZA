debug <- FALSE

standardize <- function(x) {
  if (is.numeric(x)) {
    y <- (x - mean(x, na.rm=TRUE))/sd(x, na.rm=TRUE)
  } else {
    y <- x
  }
  y
}

drop.levels <- function(dat) {
  dat[] <- lapply(dat, function(x) x[,drop=TRUE])
  return(dat)
}

## read in appropriate data set
##
traits <- read.csv("Protea_CFR_DATA.csv",
                   na.strings=".",
                   header=TRUE)

## add climate data
##
climate <- read.csv("Protea_Pellie_Climate.csv",
                    na.strings=".",
                    header=TRUE)

combined <- merge(traits,
                  climate,
                  by.x="Site_location",
                  by.y="Site_location")
if (debug) {
  print(levels(combined$Site_location))
  cat("nrow(traits):   ", nrow(traits), "\n")
  cat("nrow(climate):  ", nrow(climate), "\n")
  cat("nrow(combined): ", nrow(combined), "\n")
}
rm(traits, climate)

## prepare the data for JAGS
##
## 1. pull the relevant data into columns
##
site <- combined$Site_location
species <- combined$Valente_name

lma <- combined$LMA
area <- combined$Canopy_area
lwr <- combined$LWratio
fwc <- combined$FWC
map <- combined$MAP
mat <- combined$MAT
ratio <- combined$ratio
cdd <- combined$CDD
inso <- combined$Insolation
elev <- combined$Elevation

## 2. put them back in a data frame and include only complete
## cases
tmp <- data.frame(species=species,
                  site=site,
                  lma=lma,
                  area=area,
                  lwr=lwr,
                  fwc=fwc,
                  map=map,
                  mat=mat,
                  ratio=ratio,
                  cdd=cdd,
                  inso=inso,
                  elev=elev)

if (debug) {
  check <- sample(nrow(tmp), 15, replace=FALSE)
  print(as.numeric(tmp$species[check]))
  print(tmp[check,])
  flush.console()
}

ok <- complete.cases(tmp)
tmp <- tmp[ok,]
tmp <- drop.levels(tmp)


## 3. pull the vectors back out and standardize for JAGS
##
species <- as.numeric(tmp$species)
site <- tmp$site
lma <- standardize(tmp$lma)
area <- standardize(tmp$area)
lwr <- standardize(tmp$lwr)
fwc <- standardize(tmp$fwc)
map <- standardize(tmp$map)
mat <- standardize(tmp$mat)
ratio <- standardize(tmp$ratio)
cdd <- standardize(tmp$cdd)
inso <- standardize(tmp$inso)
elev <- standardize(tmp$elev)

n.samp <- nrow(tmp)
n.species <- max(species)
