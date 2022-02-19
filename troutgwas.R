myGD <- read.csv("AxiomGT1_edited.calls.csv",head=T)
myGM <- read.csv("mygm.csv",head=T)
myY <- read.csv("trout phenotypes.csv",head=T)
myGAPIT <- GAPIT(
  Y = myY,
  GD = myGD,
  GM = myGM,
  PCA.total = 3
)
