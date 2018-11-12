#' Author: Ted Kwartler
#' Data: 11-11-18
#' Purpose: Demonstrate getting XML API information

# Libraries
library(xml2)
library(stringr)
library(rvest)

# Youtube URL
youtubeCaption <- 'https://www.youtube.com/api/timedtext?asr_langs=de%2Cko%2Cit%2Cfr%2Cen%2Cru%2Cpt%2Cnl%2Ces%2Cja&caps=asr&sparams=asr_langs%2Ccaps%2Cv%2Cexpire&hl=en&v=NYL-wPVzL64&expire=1542014659&key=yttt1&signature=D92B806F573EEC9D91950064B1A43CABEBC4C0FC.69500835E1D5B7803E80C2EDDF87C56095F92B5F&lang=en&name=en&fmt=srv3'

# Go get the data
dat <- read_xml(youtubeCaption)

# Extract text, remove carriage returns, remove special characters
text<-xml_text(dat)
text<-str_replace_all(text, "[\r\n]" , "")
text<-iconv(text, "latin1", "ASCII", sub="")

# Save as a text file
writeLines(text,'~/someNews.txt')

# Or to organize all of the information
xmlData <- as_list(dat)

# Extract the text
text   <- do.call(rbind, xmlData$timedtext$body)
text   <- unlist(text)

# Extract and organize the timing info
timing <- lapply(xmlData$timedtext$body, attributes)
timing <- lapply(timing, unlist)
timing <- do.call(rbind, timing)
timing <- apply(timing, 2,as.numeric)

# Organize into DF
df <- data.frame(timing, text)

write.csv(df, '~/timedText.csv', row.names = F)

# End


