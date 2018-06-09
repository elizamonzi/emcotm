#======================================================================================================
# Melodic Dictation Wrangler 
#--------------------------------------------------
# Libraries
library(ggplot2)
library(data.table)
library(stringr)
#--------------------------------------------------
# Things to get List
# * Transcribe Time for melody 112
# * Transcribe Time for melody 9
# * Transcribe Time for melody 95
# * Transcribe Time for melody 34
# * Aural Survey 
# * Subject Number 
#--------------------------------------------------

# This is same as bais.c just fyi
score.melodic.aural <- function(fns=list.files(pattern=".csv")){
  
    # Set up the For Loop to score all of the .csv files in the directory
      for(i in seq(along=fns)){
    
    tmp.dat <- read.csv(fns[i], stringsAsFactors = FALSE)
    tmp.dat <- data.table(tmp.dat)
    print(paste("Now Working On File",fns[i]))

# Transcribe Times 
    
transcribeTimes <- tmp.dat[stimulus == "sound/E1MB112.mp3" | 
                         stimulus == "sound/E1MB9.mp3" | 
                         stimulus == "sound/E1MB95.mp3" | 
                         stimulus == "sound/E1MB34.mp3", .(rt, time_elapsed, subject, stimulus, button_pressed) ]

# NOTE TRANSCRIBE TIMES ARE NOT OUTPUT IN THIS VERSION OF THE SCRIPT

# Aural Questions and BAIS C

auralQuestions <- tmp.dat[trial_index == 88 | trial_index == 89]

page1 <- auralQuestions[1,10]
page2 <- auralQuestions[2,10]

page1split <- str_split(string = page1,pattern = ",")
page1items <- as.data.table(page1split)
page1subjectResponse <- str_extract_all(page1items$V1, pattern = "\\:(.*)")
page1subjectResponse.dt <- data.table(page1subjectResponse)
nocolon <- str_remove_all(string = page1subjectResponse.dt$page1subjectResponse, pattern = ":")
itemlevel <- str_remove_all(nocolon, pattern = "\"")

auralWeeksTaken <-  itemlevel[1]
auralWeeksTaught <- itemlevel[2]
highSchoolAP <- itemlevel[3]
highschoolAPscore <- itemlevel[4]
absolutePitch <- itemlevel[5]
solfegeSystem <- itemlevel[6]
weeksSinceLastAural <- itemlevel[7]
dictationStrat <- itemlevel[8]
wantToDoMore <- itemlevel[9]
emailIfMore <- itemlevel[10]

subjectNo <- transcribeTimes$subject[1]

#--------------------------------------------------
# Bais 
baisData <- page2

baisDigitsColon <- unlist(str_extract_all(baisData,":[0-9]"))
baisDigits <- str_replace_all(baisDigitsColon,":","")
baisVector <- as.numeric(baisDigits)
javascriptSucks <- baisVector + 1
baisScore <- round(mean(javascriptSucks),3)
BAIS <- "BAIS-C"

auralAnswers <- cbind(subjectNo,
                      auralWeeksTaken,
                      auralWeeksTaught, 
                      highSchoolAP, 
                      highschoolAPscore, 
                      absolutePitch, 
                      solfegeSystem, 
                      weeksSinceLastAural,
                      dictationStrat,
                      wantToDoMore,
                      emailIfMore, 
                      baisScore,
                      BAIS)

write.table(auralAnswers,paste0(substr(fns[i],1,nchar(fns[i])-4),"auralAnswers_data.csv"),sep=",",col.names=TRUE,row.names=FALSE)


    }
}

create.aural.dataset <- function(){
  filenames <- list.files(pattern = "auralAnswers")
  bigdata <- do.call("rbind", lapply(filenames, read.csv, header = TRUE))
  write.csv(bigdata,"../../cogdata/aggregated_data/AuralAnswers-Data.csv")
}

