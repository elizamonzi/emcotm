#======================================================================================================
# Big Kahuna Alligator EMCOT
#--------------------------------------------------
library(data.table)
#wd should be ../emcotm"
source("scripts/MelodicAlligatorEMCOT.R")
source("scripts/GMSI_AlligatorEMCOT.R")
source("scripts/eprimeAlligatorEMCOT.R")
#--------------------------------------------------
# Create Rotation Span Data
#--------------------------------------------------
setwd("cogdata/3. RotSpan_1block/")
# Create New Rotation Individual Files 
score.rotation.span()
# Update New Dataset 
create.rotation.dataset()
# Do we get warnings?!?!?

# Remove Junk Files
junk <- dir(pattern="rot_data") 
file.remove(junk)
setwd("../..")
#--------------------------------------------------
# Create Sym Span Data
#--------------------------------------------------
setwd("cogdata/2. SymSpan_1block/")
# Create New Rotation Individual Files 
score.sym.span()
# Update New Dataset 
create.sym.dataset()
# Do we get warnings?!?!?

# Remove Junk Files
junk <- dir(pattern="sym_data") 
file.remove(junk)
setwd("../..")
#--------------------------------------------------
# Create GMSI Data
#--------------------------------------------------
setwd("cogdata/GMSI 1/")
score.gmsi.extra()
create.gmsi.dataset()

junk <- dir(pattern="data") 
file.remove(junk)
setwd("../..")
#--------------------------------------------------
# Create Master Analysis Spreadheet
#--------------------------------------------------
# Create Master Spreadsheet for Analysis 
setwd("cogdata/aggregated_data/")

rotationData <- fread("RotationSpanData.csv", colClasses = "character")
symmetryData <- fread("SymmetrySpanData.csv", colClasses = "character")
goldExtraData <- fread("Gold_MSI_combined_data_with_Indvidual_Responses.csv", colClasses = "character")

#this is me trying to come up with a way to read all the data into the master
#mel1Data <- fread("mel1all.csv", select = c("") colClasses = "character")
#mel2Data <- fread("mel2all.csv", colClasses = "character")
#mel3Data <- fread("mel3all.csv", colClasses = "character")
#mel4Data <- fread("mel4all.csv", colClasses = "character")
#mel5Data <- fread("mel5all.csv", colClasses = "character")
#mel6Data <- fread("mel6all.csv", colClasses = "character")
#mel7Data <- fread("mel7all.csv", colClasses = "character")
#mel8Data <- fread("mel8all.csv", colClasses = "character")

rotationData[, V1 := NULL]
symmetryData[, V1 := NULL]
goldExtraData[, V1 := NULL]


master <- Reduce(function(x, y) merge(x, y, all=TRUE), 
                 list(rotationData, symmetryData, goldExtraData))



master <- master[order(as.numeric(subjectNo))]

fwrite(master,"Master-Data-EMCOT.csv")
setwd("../..")
#======================================================================================================

