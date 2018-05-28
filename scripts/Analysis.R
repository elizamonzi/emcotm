#-------------
#Draft
#-------------
library(data.table)
library(psych)
library(stringr)
library(ggplot2)
library(apaTables)
#-------------
emdata <- fread("EMCOTcode_EM.csv",header = TRUE, colClasses = "character")
emdata
emdata$almostclean <- unlist(str_extract_all(emdata$MelodyFile, pattern = "P.*"))
emdata$clean <- unlist(str_replace_all(emdata$almostclean,pattern = ".aif",""))
emdata$clean
emdata$subjectNo <- unlist(str_replace_all(emdata$clean,pattern = "P", ""))
emdata$subjectNo
emdata$subjectNo <- as.integer(emdata$subjectNo)
emdata[,subjectNo := as.character(subjectNo)]

grades <- fread("EMCOT grades - Sheet1.csv", colClasses = "character")
str(grades)

grades[,subjectNo := as.character(subjectNo)]

aggdata <- grades[emdata, on = "subjectNo"]

# Replace all Ps in AS and MT 

aggdata[ASI=="P"]$ASI <- 4
aggdata[,ASI := as.numeric(ASI)]

aggdata$MTI
aggdata[ASII=="P"]$ASII <- 4
aggdata[,ASII := as.numeric(ASII)]

aggdata[ASIII=="P"]$ASIII <- 4
aggdata[,ASIII := as.numeric(ASIII)]

aggdata[ASIV=="P"]$ASIV <- 4
aggdata[,ASIV := as.numeric(ASIV)]

aggdata[FMT=="P"]$FMT <- 4
aggdata[,FMT := as.numeric(FMT)]

aggdata[MTI=="P"]$MTI <- 4
aggdata[,MTI := as.numeric(MTI)]

aggdata[MTII=="P"]$MTII <- 4
aggdata[,MTII := as.numeric(MTII)]

aggdata[MTIII=="P"]$MTIII <- 4
aggdata[,MTIII := as.numeric(MTIII)]

aggdata[MTIV=="P"]$MTIV <- 4
aggdata[,MTIV := as.numeric(MTIV)]

aggdata[, .(ASI, ASII, ASIII, ASIV, MTI, MTII, MTIII, MTIV, FMT)]

#---------------------

# vector number issues

str(aggdata)

aggdata$`3-digit contour vector` <- ifelse(aggdata$`3-digit contour vector` == "10", "010", aggdata$`3-digit contour vector`)
aggdata$`3-digit contour vector` <- ifelse(aggdata$`3-digit contour vector` == "12", "012", aggdata$`3-digit contour vector`)
aggdata$`3-digit contour vector` <- ifelse(aggdata$`3-digit contour vector` == "21", "021", aggdata$`3-digit contour vector`)

#--------------------

# Condition A Melody 5 - asc vs. desc

aggdata[Condition == "A" & Melody == "Mel5", .(counts = .N), 
        by = c("Ascends(1)/Descends(2)", "3-digit contour vector")]
aggdata[Condition == "B" & Melody == "Mel5", .(counts = .N), 
        by = c("Ascends(1)/Descends(2)", "3-digit contour vector")][order(counts)]



str(aggdata)
