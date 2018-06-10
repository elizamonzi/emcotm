#-----------------------------------------------------
#emcotm regression analysis
#-----------------------------------------------------
#set wd to emcotm/cogdata/aggregated_data
library(data.table)
library(psych)
library(stringr)
#-----------------------------------------------------
#reading in csvs to combine
mel1Data <- fread("mel1all.csv", select = c("subjectNo", "ascDescFin1", "Condition1"), colClasses = "character")
mel2Data <- fread("mel2all.csv", select = c("subjectNo", "ascDescFin2", "Condition2"), colClasses = "character")
mel3Data <- fread("mel3all.csv", select = c("subjectNo", "ascDescFin3", "Condition3"), colClasses = "character")
mel4Data <- fread("mel4all.csv", select = c("subjectNo", "ascDescFin4", "Condition4"), colClasses = "character")
mel5Data <- fread("mel5all.csv", select = c("subjectNo", "ascDescFin5", "Condition5"), colClasses = "character")
mel6Data <- fread("mel6all.csv", select = c("subjectNo", "ascDescFin6", "Condition6"), colClasses = "character")
mel7Data <- fread("mel7all.csv", select = c("subjectNo", "ascDescFin7", "Condition7"), colClasses = "character")
mel8Data <- fread("mel8all.csv", select = c("subjectNo", "ascDescFin8", "Condition8"), colClasses = "character")
wmc <- fread("WMC_emcot_n_66.csv", colClasses = "character")
davesmaster <- fread("Master-Data-EMCOT.csv", colClasses = "character")

masteremcot <- Reduce(function(x, y) merge(x, y, all=TRUE), 
                 list(mel1Data, mel2Data, mel3Data, mel4Data, mel5Data, mel6Data, mel7Data, mel8Data, 
                      wmc, davesmaster))

masteremcot <- masteremcot[order(as.numeric(subjectNo))]

fwrite(masteremcot,"MasterEMCOT.csv")
