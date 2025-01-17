###Descarga e instalacion de librerias## 
#install.packages(c("devtools","mia","plyr","dplyr", "reshape2","httr","urltools","tidyverse"))
## Instalación de Biomanager para descargar librerias externas al CRAN

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

## Versión actual funcional para r versión 4.4.1

BiocManager::install(version = "3.19")

## Descarga de MGnifyR con Biomanager
BiocManager::install("MGnifyR")

# Librerias necesarias para utilizar MGnifyR 
library(devtools)
library(tidyverse)
library(mia)
library(plyr)
library(dplyr)
library(reshape2)
library(httr)
library(urltools)
library(remotes)
library(MGnifyR)
library(phyloseq)
library(assertive)

##########################################
#Codigo recolectado del repositorio de GitHub de MGnify 

# Set up the MGnify client instance
mgclnt <- MgnifyClient(usecache = TRUE, cache_dir = '/tmp/MGnify_cache')


# Retrieve the list of analyses associated with a study
accession_list <- searchAnalysis(mgclnt, "studies", "MGYS00005592", usecache = TRUE)

# Download all associated study/sample and analysis metadata
meta_dataframe <- getMetadata(mgclnt, accession_list, usecache = TRUE)
saveRDS(meta_dataframe,"metadata_MGYS00005592.rds")

# Convert analyses outputs to a single `MultiAssayExperiment` object
process_metadata <- function(mgclnt){
mae <- getResult(mgclnt, meta_dataframe$analysis_accession, usecache = TRUE)
mae
}
process_metadata()

library(mia)

mae_phyloseq <- makePhyloseqFromTreeSummarizedExperiment(mae[[1]]) 
mae2_phyloseq <- makePhyloseqFromTreeSummarizedExperiment(mae[[2]])
mae3_phyloseq<-makePhyloseqFromTreeSummarizedExperiment(mae[[1]])
mae4_phyloseq<-makePhyloseqFromTreeSummarizedExperiment(mae[[2]])
mae5_phyloseq <- makePhyloseqFromTreeSummarizedExperiment(mae[[2]]) 
mae6_phyloseq <- makePhyloseqFromTreeSummarizedExperiment(mae[[3]]) 
mae7_phyloseq <- makePhyloseqFromTreeSummarizedExperiment(mae[[4]]) 
mae8_phyloseq <- makePhyloseqFromTreeSummarizedExperiment(mae[[5]]) 

View(sample_data(mae_phyloseq))
  