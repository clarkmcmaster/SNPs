#INSTALLING AND LOADING GAPIT: run both
source("http://zzlab.net/GAPIT/GAPIT.library.R")
source("http://zzlab.net/GAPIT/gapit_functions.txt")
library(GAPIT3)
library(tidyverse)

#taxa names should be in first column
#phenotypes should all be in remaining columns
#multiple phenotypes can be used in the model at once
#missing data should be either "NaN" or "NA"


#IF NUMERIC: Homozygotes '0' or '2', hetero '1' in 'GD' file. first row is SNPs,
#first column is taxa name. 'GM' file contains name and loc of each SNP.
#First column is SNP ID, second is xsome, third is base pair position.

#ARGUMENTS;
#   Y = df of phenotypic data
#   GD = df of genetic data in numerical format
#   GM = genetic map df to provide genomic coordinates
#   CV = covariates
#   G = genomic data in hmp.txt format
#   
#   User can pass G or GD. If G is passed, no need to pass GM since mapping is included in hmp


#############################################################################################################

# The following simple GWAS script will automatically calculate kinship matrix using VanRaden method, 
# perform GWAS and genomic prediction with the optimal compression level using the default
# clustering algorithm (average) and group kinship type (Mean). 'PCA.total' argument specifies
# number of principal components to include in the GWAS model.

#Step 1: read data from wd
myY <- read.table("FILE-NAME.txt",head=T)
myG <- read.table("FILE-NAME.hmp.txt",head=F)

#Step 2: run GAPIT
myGAPIT <- GAPIT(
  Y = myY,
  G = myG,
  PCA.total = 3
)

#############################################################################################################

# User can specify additional clustering algorithms using the 'kinship.cluster' parameter (default: 'average').
# Default kinship.group = 'mean'. This can improve statistical power (Enriched CMLM). A specific range of group
# numbers can be specified, controlled by 'group.from', 'group.to', and 'group.by' parameters.

#Step 2: run GAPIT
myGAPIT <- GAPIT(
  y = myY,
  g = myG,
  PCA.total = 3,
  kinship.cluster = c('average','complete','ward'),
  kinship.group = c('Mean','Max'),
  model = 'CMLM'
)


#############################################################################################################

# Numeric genotype format. Must pass arguments through "GD" and "GM" parameters for genomic data and genotype
# map respectively. This will be in a series of txt files rather than hmp.txt

#Step 1: read data
myY <- read.table('FILE-NAME.txt',head=T)
myGD <- read.table('FILE-NAME_numeric.txt',head=T)
myGM <- read.table('FILE-NAME_information.txt',head=T)

#Step 2: run GAPIT
myGAPIT <- GAPIT(
  Y = myY,
  GD = myGD,
  GM = myGM,
  PCA.total = 3
)

#############################################################################################################

# GAPIT can conduct Bayesian information criterion-based model selection to find the optimal number of PCs for
# inclusion in the GWAS model. Pass "Model.selection = TRUE" to function to activate this. Results of the BIC 
# model selection procedure are summarized in the 'BIC.Model.Selection.Results.csv' output file.

#############################################################################################################

#Step 2: run GAPIT
myGAPIT <- GAPIT(
  Y = myY,
  GD = myGD,
  GM = myGM,
  PCA.total = 3,
  Inter.Plot = TRUE
)

#############################################################################################################

# This script above is quite a good one to start with I think, it will produce interactive Manhattan and QQ
# plots for each phenotype in 'Y'.

#############################################################################################################








