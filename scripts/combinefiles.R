#-----------------------------------------------------
#emcotm combine files
#-----------------------------------------------------
#set wd to emcotm/cogdata/aggregated_data
library(data.table)
library(psych)
library(stringr)
#-----------------------------------------------------
#reading in csvs to combine
dancomplete <- fread("complete_data3.csv", colClasses = "character")
elizacomplete <- fread("bigdatafile.csv", colClasses = "character")

datamerge <- merge(dancomplete, elizacomplete, "Subject")

datamerge <- datamerge[order(as.numeric(Subject))]

fwrite(datamerge,"datamerge.csv")
