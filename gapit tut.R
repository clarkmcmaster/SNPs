#Import data from Zhiwu Zhang Lab
myY <- read.table("http://zzlab.net/GAPIT/data/mdp_traits.txt", head = TRUE)
myGD=read.table(file="http://zzlab.net/GAPIT/data/mdp_numeric.txt",head=T)
myGM=read.table(file="http://zzlab.net/GAPIT/data/mdp_SNP_information.txt",head=T)
#GWAS with five methods
myGAPIT_MLM <- GAPIT(
  Y=myY[,c(1,3)], #fist column is individual ID, the third columns is days to pollination
  GD=myGD,
  GM=myGM,
  PCA.total=3,
  model=c("GLM", "MLM", "CMLM", "FarmCPU", "Blink"),
  Multiple_analysis=TRUE)