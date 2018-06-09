#======================================================================================================
# Extracting Features
#--------------------------------------------------
library(data.table)
library(ggplot2)
library(stringr)
# Point to Features
setwd("data/symbolic")
file.edit("Fantastic.R")
# NOW SELECT ALL THEN CLICK RUN

list.files()
cleanold <- "BerkowitzFeatures.csv"
if (file.exists(cleanold)) file.remove(cleanold)
berkowitzFeatures <- compute.features(melody.filenames = list.files(pattern=".csv"), 
                                     dir = ".",
                                     use.segmentation = FALSE, 
                                     write.out = TRUE)
fwrite(berkowitzFeatures,"BerkowitzFeatures.csv")
#======================================================================================================
# Explore and Extract 
names(berkowitzFeatures)
berkowitzFeatures <- fread("BerkowitzFeatures.csv")
berkowitzFeatures <- data.table(berkowitzFeatures)
ggplot(berkowitzFeatures, aes(glob.duration)) + geom_density()

# Set Seconds
timeSubset <- berkowitzFeatures[glob.duration >= 9 & glob.duration <= 12]
ggplot(timeSubset, aes(glob.duration)) + geom_density()
timeSubset
ggplot(timeSubset, aes(x = note.dens, y = tonalness)) + geom_point() +
    labs(title = "Selection of Experimental Melodies",
         x = "Note Density",
         y = "Tonalness") +
  geom_text(aes(label=str_replace_all(file.id,pattern = "Berkowitz",""), hjust = .5, vjust = -.75))

## Needed to pick the absolute numbers so they can be used in modeling

ggplot(timeSubset, aes(x = scale(note.dens), y = scale(tonalness))) + geom_point() +
  labs(title = "Selection of Experimental Melodies (z)",
       x = "Note Density",
       y = "Tonalness") +
  geom_text(aes(label=str_replace_all(file.id,pattern = "Berkowitz",""), hjust = .5, vjust = -.75))

# High Tonality, Low Density [ Easy Condition ]

## Berkowitz 34 , Ab Major 3/4
berkowitzFeatures[file.id == "Berkowitz34"]

# High Tonality, High Density [ Middle Conditions ]
# 112
berkowitzFeatures[file.id == "Berkowitz112"]
# 6/8 D Major

# Low Tonality, Low Density [ Middle Conditions ]
# 3/4 Bb Major
berkowitzFeatures[file.id == "Berkowitz9"]

# Low Tonality, High Density [ Hard Condition]
berkowitzFeatures[file.id == "Berkowitz95"]
# 6/8 G Major 

berkowitzFeatures[file.id == "Berkowitz9" | file.id == "Berkowitz34" | file.id == "Berkowitz112" | file.id == "Berkowitz95", .(file.id, tonalness, note.dens)]
## Used z scores of limited corpus to help pick, but will use regressors as actual numbers


# Next Round?
# 10 - 12
# Melodies to Pick 
# 50, 16, 79, 112


