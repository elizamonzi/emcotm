#======================================================================================================
# E Prime Data Alligator 
#======================================================================================================
library(data.table)
library(rprime)
list.files()
#======================================================================================================
#--------------------------------------------------
# Rotation Trial 
#--------------------------------------------------

score.rotation.span <- function(fns=list.files(pattern=".txt")){
  
  # Set up the For Loop to score all of the .csv files in the directory
  for(i in seq(along=fns)){
    
    rotationTrial <- read_eprime(fns[i])
    print(paste("Now Working On File",fns[i]))
    
    rotationFL <- FrameList(rotationTrial)
    rotationSubjectFilter <- filter_in(rotationFL, "Running","Header")
    
    rotationFLfiltered <- filter_in(rotationFL, "Running","Rotation")
    
    # Subject Number 
    
    subjectBlock <- rotationSubjectFilter[1]
    subjectNo <- as.numeric(subjectBlock[[1]]$Subject)
    
    # Data 
    rotationScoreBlock <- rotationFLfiltered[5]
    
    ## NOTE THIS IS WHERE YOU WOULD ADD OTHER BLOCKS IF EXPANDED VERSION
    rotAbsolute <- as.numeric(rotationScoreBlock[[1]]$RotspanAbsoluteScore)
    rotBlock1 <- as.numeric(rotationScoreBlock[[1]]$RotspanPartialScoreBlock1)
    rotPartial <- as.numeric(rotationScoreBlock[[1]]$RotspanPartialScore)
    
    
    rot.data <- cbind(subjectNo,
                      rotAbsolute,rotBlock1,rotPartial)
    
    write.table(rot.data,paste0(substr(fns[i],1,nchar(fns[i])-4),"rot_data.csv"),sep=",",col.names=TRUE,row.names=FALSE)
    
    
  }
  
}

create.rotation.dataset <- function(){
  filenames <- list.files(pattern = "rot_data.csv")
  bigdata <- do.call("rbind", lapply(filenames, read.csv, header = TRUE))
  write.csv(bigdata,"../../cogdata/aggregated_data/RotationSpanData.csv")
}
#======================================================================================================
# Create Sym Span 

score.sym.span <- function(fns=list.files(pattern=".txt")){
  
  for(i in seq(along=fns)){
    
    symmetryTrial <- read_eprime(fns[i])
    print(paste("Now Working On File",fns[i]))
    
    symmetryFL_sym <- FrameList(symmetryTrial)
    symmetryFLfiltered <- filter_in(symmetryFL_sym, "Running","Symmetry")
    
    # Subject 
    SymmetrySubjectFilter <- filter_in(symmetryFL_sym, "Running","Header")
    subjectNo <- SymmetrySubjectFilter[[1]]$Subject
    
    # Data 
    symmetryScoreBlock <- symmetryFLfiltered[5]
    
    symErrorTotal <- as.numeric(symmetryScoreBlock[[1]]$SymmErrorTotal)
    symAccErrorTotal <- as.numeric(symmetryScoreBlock[[1]]$AccErrorTotal)
    symSpeedErorTotal <- as.numeric(symmetryScoreBlock[[1]]$SpeedErrorTotal)
    symSspanPartialScore <- as.numeric(symmetryScoreBlock[[1]]$SspanPartialScore)
     
    sym.data <- cbind(subjectNo,
                      symErrorTotal,symAccErrorTotal, symSpeedErorTotal, symSspanPartialScore)
    
    write.table(sym.data,paste0(substr(fns[i],1,nchar(fns[i])-4),"sym_data.csv"),sep=",",col.names=TRUE,row.names=FALSE)
  }
  
}


create.sym.dataset <- function(){
  filenames <- list.files(pattern = "sym_data.csv")
  bigdata <- do.call("rbind", lapply(filenames, read.csv, header = TRUE))
  write.csv(bigdata,"../../cogdata/aggregated_data/SymmetrySpanData.csv")
}

#======================================================================================================
# Number Series Data 
score.number.series <- function(fns=list.files(pattern=".txt")){
  
  for(i in seq(along=fns)){
    numberTrial <- read_eprime(fns[i])
    print(paste("Now Working On File",fns[i]))
    numberTrialFL <- FrameList(numberTrial)
    
    
    
    # Subject 
    NumberSubjectFilter <- filter_in(numberTrialFL, "Running","Header")
    subjectBlock <- NumberSubjectFilter[1]
    subjectNo <- as.numeric(subjectBlock[[1]]$Subject)
    
    
    # Data
    # Get Total Score, Total Attempted 
    numberScoreBlock <- filter_in(numberTrialFL,"Running","BlockList")
    
    nsTotalScore <- as.numeric(numberScoreBlock[[3]]$TotalScore)
    nsAttempted <- as.numeric(numberScoreBlock[[3]]$Attempted)
    nsTotalTime <- as.numeric(numberScoreBlock[[3]]$TotalTime)
    
    num.data <- cbind(subjectNo,
                      nsTotalScore,nsAttempted,nsTotalTime)
    
    write.table(num.data,paste0(substr(fns[i],1,nchar(fns[i])-4),"num_data.csv"),sep=",",col.names=TRUE,row.names=FALSE)
    
  }
}

create.num.dataset <- function(){
  filenames <- list.files(pattern = "num_data.csv")
  bigdata <- do.call("rbind", lapply(filenames, read.csv, header = TRUE))
  write.csv(bigdata,"../../cogdata/aggregated_data/NumerSeriesData.csv")
}


#======================================================================================================
# Score Ravens Data 

score.ravens <- function(fns=list.files(pattern=".txt")){
  
  for(i in seq(along=fns)){
    
    ravensTrial <- read_eprime(fns[i])
    print(paste("Now Working On File",fns[i]))
    ravensFL <- FrameList(ravensTrial)
    
    # Subject 
    ravensSubjectFilter <- filter_in(ravensFL, "Running","Header")
    subjectBlock <- ravensSubjectFilter[1]
    subjectNo <- as.numeric(subjectBlock[[1]]$Subject)
    
    # Data
    ravensScoreBlock <- ravensFL[[length(ravensFL)]]
    
    ravensScoreA <- as.numeric(ravensScoreBlock$Score_A)
    ravensScoreB <- as.numeric(ravensScoreBlock$Score_B)
    ravensScoreC <- as.numeric(ravensScoreBlock$Score_C)
    
    ravens.data <- cbind(subjectNo,ravensScoreA, ravensScoreB, ravensScoreC)
    
    write.table(ravens.data,paste0(substr(fns[i],1,nchar(fns[i])-4),"ravens_data.csv"),sep=",",col.names=TRUE,row.names=FALSE)
    
    
    
  }
  
}

create.ravens.dataset <- function(){
  filenames <- list.files(pattern = "ravens_data.csv")
  bigdata <- do.call("rbind", lapply(filenames, read.csv, header = TRUE))
  write.csv(bigdata,"../../cogdata/aggregated_data/RavensData.csv")
}

#======================================================================================================
# David John Baker, April 19th, 2018
#======================================================================================================