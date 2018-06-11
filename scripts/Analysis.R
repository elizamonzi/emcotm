#-----------------------------------------------------
#emcotm analysis: asc/desc by condition/melody
#-----------------------------------------------------
#set wd to emcotm/data
library(data.table)
library(psych)
library(stringr)
library(ggplot2)
library(apaTables)
library(plyr)
library(dplyr)
#-----------------------------------------------------
#this whole section can be SKIPPED now, it was only needed for me to settle rater disputes
#so skip to line 123

#read code csvs for interrater agreement so I can review and settle disputes

#----mel1----
mel1code <- fread("mel1code.csv", header = TRUE, colClasses = "character")
mel1code$match <- ifelse(mel1code$dbAscDesc == mel1code$dsAscDesc, mel1code$dbAscDesc, "CHECK")
View(mel1code)

#now I go relisten to the melodies with "CHECK" in the column "match"
#in column "check" I copy over column "dbAscDesc" and replace the "CHECK"s with final code decision

#then to check this one with kv's code
mel1code <- fread("mel1code.csv", header = TRUE, colClasses = "character")
mel1code$matchkv <- ifelse(mel1code$check == mel1code$kvAscDesc, mel1code$check, "RECHECK")
View(mel1code)

#now I go relisten to the melodies with "RECHECK" in the column "matchkv"
#in column "ascDescFin" I copy over column "check" and replace the "RECHECK"s with final code
mel1code <- fread("mel1code.csv", header = TRUE, colClasses = "character")

#----mel2----
mel2code <- fread("mel2code.csv", header = TRUE, colClasses = "character")
mel2code$match <- ifelse(mel2code$dbAscDesc == mel2code$dsAscDesc, mel2code$dbAscDesc, "CHECK")
View(mel2code)

#now I go relisten to the melodies with "CHECK" in the column "match"
#in column "ascDescFin" I copy over column "dbAscDesc" and replace the "CHECK"s with final code
mel2code <- fread("mel2code.csv", header = TRUE, colClasses = "character")

#----mel3----
mel3code <- fread("mel3code.csv", header = TRUE, colClasses = "character")
mel3code$match <- ifelse(mel3code$dbAscDesc == mel3code$cdAscDesc, mel3code$dbAscDesc, "CHECK")
View(mel3code)

#now I go relisten to the melodies with "CHECK" in the column "match"
#in column "check" I copy over column "dbAscDesc" and replace the "CHECK"s with final code

#then to check this one with kv's code
mel3code <- fread("mel3code.csv", header = TRUE, colClasses = "character")
mel3code$matchkv <- ifelse(mel3code$check == mel3code$kvAscDesc, mel3code$check, "RECHECK")
View(mel3code)

#now I go relisten to the melodies with "RECHECK" in the column "matchkv"
#in column "ascDescFin" I copy over column "check" and replace the "RECHECK"s with final code
mel3code <- fread("mel3code.csv", header = TRUE, colClasses = "character")

#----mel4----
mel4code <- fread("mel4code.csv", header = TRUE, colClasses = "character")
mel4code$match <- ifelse(mel4code$dbAscDesc == mel4code$cdAscDesc, mel4code$dbAscDesc, "CHECK")
View(mel4code)

#now I go relisten to the melodies with "CHECK" in the column "match"
#in column "ascDescFin" I copy over column "dbAscDesc" and replace the "CHECK"s with final code
mel4code <- fread("mel4code.csv", header = TRUE, colClasses = "character")

#----mel5----
mel5code <- fread("mel5code.csv", header = TRUE, colClasses = "character")
mel5code$match <- ifelse(mel5code$emAscDesc == mel5code$cdAscDesc, mel5code$emAscDesc, "CHECK")
View(mel5code)

#now I go relisten to the melodies with "CHECK" in the column "match"
#in column "check" I copy over column "emAscDesc" and replace the "CHECK"s with final code

#then to check this one with kv's code
mel5code <- fread("mel5code.csv", header = TRUE, colClasses = "character")
mel5code$matchkv <- ifelse(mel5code$check == mel5code$kvAscDesc, mel5code$check, "RECHECK")
View(mel5code)

#now I go relisten to the melodies with "RECHECK" in the column "matchkv"
#in column "ascDescFin" I copy over column "check" and replace the "RECHECK"s with final code
mel5code <- fread("mel5code.csv", header = TRUE, colClasses = "character")

#----mel6----
mel6code <- fread("mel6code.csv", header = TRUE, colClasses = "character")
mel6code$match <- ifelse(mel6code$emAscDesc == mel6code$cdAscDesc, mel6code$emAscDesc, "CHECK")
View(mel6code)

#now I go relisten to the melodies with "CHECK" in the column "match"
#in column "ascDescFin" I copy over column "emAscDesc" and replace the "CHECK"s with final code
mel6code <- fread("mel6code.csv", header = TRUE, colClasses = "character")

#----mel7----
mel7code <- fread("mel7code.csv", header = TRUE, colClasses = "character")
mel7code$match <- ifelse(mel7code$emAscDesc == mel7code$dsAscDesc, mel7code$emAscDesc, "CHECK")
View(mel7code)

#now I go relisten to the melodies with "CHECK" in the column "match"
#in column "check" I copy over column "emAscDesc" and replace the "CHECK"s with final code

#then to check this one with kv's code
mel7code <- fread("mel7code.csv", header = TRUE, colClasses = "character")
mel7code$matchkv <- ifelse(mel7code$check == mel7code$kvAscDesc, mel7code$check, "RECHECK")
View(mel7code)

#now I go relisten to the melodies with "RECHECK" in the column "matchkv"
#in column "ascDescFin" I copy over column "check" and replace the "RECHECK"s with final code
mel7code <- fread("mel7code.csv", header = TRUE, colClasses = "character")

#----mel8----
mel8code <- fread("mel8code.csv", header = TRUE, colClasses = "character")
mel8code$match <- ifelse(mel8code$emAscDesc == mel8code$dsAscDesc, mel8code$emAscDesc, "CHECK")
View(mel8code)

#now I go relisten to the melodies with "CHECK" in the column "match"
#in column "ascDescFin" I copy over column "emAscDesc" and replace the "CHECK"s with final code
mel8code <- fread("mel8code.csv", header = TRUE, colClasses = "character")

#--------------------
#START HERE

mel1code <- fread("mel1code.csv", header = TRUE, colClasses = "character")
mel2code <- fread("mel2code.csv", header = TRUE, colClasses = "character")
mel3code <- fread("mel3code.csv", header = TRUE, colClasses = "character")
mel4code <- fread("mel4code.csv", header = TRUE, colClasses = "character")
mel5code <- fread("mel5code.csv", header = TRUE, colClasses = "character")
mel6code <- fread("mel6code.csv", header = TRUE, colClasses = "character")
mel7code <- fread("mel7code.csv", header = TRUE, colClasses = "character")
mel8code <- fread("mel8code.csv", header = TRUE, colClasses = "character")

#add grades/conditions csv to code

conditiongrades <- fread("EMCOT grades - Sheet1.csv", colClasses = "character")

mel1all <- mel1code[conditiongrades, on="subjectNo"]
mel2all <- mel2code[conditiongrades, on="subjectNo"]
mel3all <- mel3code[conditiongrades, on="subjectNo"]
mel4all <- mel4code[conditiongrades, on="subjectNo"]
mel5all <- mel5code[conditiongrades, on="subjectNo"]
mel6all <- mel6code[conditiongrades, on="subjectNo"]
mel7all <- mel7code[conditiongrades, on="subjectNo"]
mel8all <- mel8code[conditiongrades, on="subjectNo"]

#trying to do a thing, this may not be necessary but shouldn't mess up anything
write.csv(mel1all, "../cogdata/aggregated_data/mel1all.csv")
write.csv(mel2all, "../cogdata/aggregated_data/mel2all.csv")
write.csv(mel3all, "../cogdata/aggregated_data/mel3all.csv")
write.csv(mel4all, "../cogdata/aggregated_data/mel4all.csv")
write.csv(mel5all, "../cogdata/aggregated_data/mel5all.csv")
write.csv(mel6all, "../cogdata/aggregated_data/mel6all.csv")
write.csv(mel7all, "../cogdata/aggregated_data/mel7all.csv")
write.csv(mel8all, "../cogdata/aggregated_data/mel8all.csv")

#-----------------------------------------------------
#count ascending vs. descending by condition

mel1counts <- with(mel1all, table(mel1all$Condition, mel1all$ascDescFin))
mel2counts <- with(mel2all, table(mel2all$Condition, mel2all$ascDescFin))
mel3counts <- with(mel3all, table(mel3all$Condition, mel3all$ascDescFin))
mel4counts <- with(mel4all, table(mel4all$Condition, mel4all$ascDescFin))
mel5counts <- with(mel5all, table(mel5all$Condition, mel5all$ascDescFin))
mel6counts <- with(mel6all, table(mel6all$Condition, mel6all$ascDescFin))
mel7counts <- with(mel7all, table(mel7all$Condition, mel7all$ascDescFin))
mel8counts <- with(mel8all, table(mel8all$Condition, mel8all$ascDescFin))

#-----------------------------------------------------
#view counts by melody 
    #to manually add all asc/desc observed by asc/desc dominant presentation
    #asc dom pres = mel 1-4 cond A & mel 5-8 cond B
    #desc dom pres = mel 1-4 cond B & mel 5-8 cond A

mel1counts
mel2counts
mel3counts
mel4counts
mel5counts
mel6counts
mel7counts
mel8counts

#I listed counts onto a pen&paper spreadsheet so that I could sum all ascending observations
  #and descending observations for both the ascending dominant presentations and the descending

#sums
sum(12,5,5,13,10,9,13,14) #ascending observation in descending dominant presentation
sum(20,26,28,21,23,24,19,18) #descending observation in descending dominant presentation
sum(18,17,21,21,19,9,25,24) #ascending observation in ascending dominant presentation
sum(14,14,10,11,14,24,8,9) #descending observation in ascending dominant presentation

#-------------------------------------------------
#graphing attempts

#barplot of raw count data
Counts <- structure(list(X = c(81, 179), Y = c(154, 104)), 
                    .Names = c("Descending Dominant Presentation", "Ascending Dominant Presentation"), 
                    class = "data.frame", row.names = c(NA, -2L))
Counts
colors <- c("blue", "red")

barplot(as.matrix(Counts), main="Frequency of Ascending and Descending Cadences", ylab="Frequency", 
        cex.lab = 1, cex.main = 1.4, beside=TRUE, col=colors)

legend("topright", c("Ascending Cadence", "Descending Cadence"), cex=1, bty="n", fill=colors)

#barplot of percentages
Perc <- structure(list(X = c(31, 69), Y = c(60, 40)), 
                    .Names = c("Descending Dominant Presentation", "Ascending Dominant Presentation"), 
                    class = "data.frame", row.names = c(NA, -2L))
Perc
colors <- c("dark grey", "light grey")

b = barplot(as.matrix(Perc), main="Percentage of Ascending and Descending Cadences", ylab="Percentage", 
        cex.lab = 1, cex.main = 1.4, beside=TRUE, col=colors)

legend("topright", c("Ascending Cadence", "Descending Cadence"), cex=1, bty="n", fill=colors)

#attempting and failing to see a table
descDomPres =("
         -         Ascending  Descending
         Expected  25         75
         Actual    31         69
         ")

ascDomPres =("
         -         Ascending  Descending
         Expected  75         25
         Actual    60         40
         ")

####below is all stuff from before, wasn't working because there were duplicate subject numbers in subjectNo column
#-------------
# emdata <- fread("EMCOTcode_EM.csv",header = TRUE, colClasses = "character")
# emdata
# emdata$almostclean <- unlist(str_extract_all(emdata$melodyFile, pattern = "P.*"))
# emdata$clean <- unlist(str_replace_all(emdata$almostclean,pattern = ".aif",""))
# emdata$clean
# emdata$subjectNo <- unlist(str_replace_all(emdata$clean,pattern = "P", ""))
# emdata$subjectNo
# emdata$subjectNo <- as.integer(emdata$subjectNo)
# emdata[,subjectNo := as.character(subjectNo)]
# 
# grades <- fread("EMCOT grades - Sheet1.csv", colClasses = "character")
# str(grades)
# 
# grades[,subjectNo := as.character(subjectNo)]
# 
# aggdata <- grades[emdata, on = "subjectNo"]
# aggdata
# View(aggdata)
# # Replace all Ps in AS and MT 
# 
# aggdata[ASI=="P"]$ASI <- 4
# aggdata[,ASI := as.numeric(ASI)]
# 
# aggdata$MTI
# aggdata[ASII=="P"]$ASII <- 4
# aggdata[,ASII := as.numeric(ASII)]
# 
# aggdata[ASIII=="P"]$ASIII <- 4
# aggdata[,ASIII := as.numeric(ASIII)]
# 
# aggdata[ASIV=="P"]$ASIV <- 4
# aggdata[,ASIV := as.numeric(ASIV)]
# 
# aggdata[FMT=="P"]$FMT <- 4
# aggdata[,FMT := as.numeric(FMT)]
# 
# aggdata[MTI=="P"]$MTI <- 4
# aggdata[,MTI := as.numeric(MTI)]
# 
# aggdata[MTII=="P"]$MTII <- 4
# aggdata[,MTII := as.numeric(MTII)]
# 
# aggdata[MTIII=="P"]$MTIII <- 4
# aggdata[,MTIII := as.numeric(MTIII)]
# 
# aggdata[MTIV=="P"]$MTIV <- 4
# aggdata[,MTIV := as.numeric(MTIV)]
# 
# aggdata[, .(ASI, ASII, ASIII, ASIV, MTI, MTII, MTIII, MTIV, FMT)]
# 
# #---------------------
# 
# # vector number issues
# 
# str(aggdata)
# 
# aggdata$`3-digit contour vector` <- ifelse(aggdata$`3-digit contour vector` == "10", "010", aggdata$`3-digit contour vector`)
# aggdata$`3-digit contour vector` <- ifelse(aggdata$`3-digit contour vector` == "12", "012", aggdata$`3-digit contour vector`)
# aggdata$`3-digit contour vector` <- ifelse(aggdata$`3-digit contour vector` == "21", "021", aggdata$`3-digit contour vector`)
# 
# #--------------------
# 
# # Condition A Melody 5 - asc vs. desc
# 
# aggdata[Condition == "A" & Melody == "Mel5", .(counts = .N), 
#         by = c("Ascends(1)/Descends(2)", "3-digit contour vector")]
# aggdata[Condition == "B" & Melody == "Mel5", .(counts = .N), 
#         by = c("Ascends(1)/Descends(2)", "3-digit contour vector")][order(counts)]
# 
# 
# 
# str(aggdata)
