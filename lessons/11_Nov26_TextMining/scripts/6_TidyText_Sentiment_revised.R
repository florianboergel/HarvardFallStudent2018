#' Title: Intro: TidyText Sentiment
#' Purpose: Construct a treemap showing multiple information levels
#' Author: Ted Kwartler
#' email: ehk116@gmail.com
#' License: GPL>=3
#' Date: 2018-11-24
#'

# Set the working directory
setwd("C:/Users/Edward/Desktop/HarvardFallAdmin2018/lessons/11_Nov26_TextMining/data")

# Libs
library(tidytext)
library(dplyr)
library(qdap)
library(tm)
library(radarchart)

# Options & Functions
options(stringsAsFactors = FALSE)
Sys.setlocale('LC_ALL','C')

tryTolower <- function(x){
  y = NA
  try_error = tryCatch(tolower(x), error = function(e) e)
  if (!inherits(try_error, 'error'))
    y = tolower(x)
  return(y)
}

cleanCorpus<-function(corpus){
  corpus <- tm_map(corpus, removePunctuation)
  corpus <- tm_map(corpus, stripWhitespace)
  corpus <- tm_map(corpus, removeNumbers)
  corpus <- tm_map(corpus, content_transformer(tryTolower))
  corpus <- tm_map(corpus, removeWords, customStopwords)
  return(corpus)
}


# Data
text <- readLines('Weeknd.txt')
text

# Create custom stop words
customStopwords <- c(stopwords('english'))

# Clean Corpus
txtCorpus <- VCorpus(VectorSource(text))
txtCorpus <- cleanCorpus(txtCorpus)

# DTM
txtDTM    <- DocumentTermMatrix(txtCorpus)
txtDTM
dim(txtDTM)

# Tidy
tidyCorp <- tidy(txtDTM)
tidyCorp
dim(tidyCorp)

# Get bing lexicon
# "afinn", "bing", "nrc", "loughran"
bing <- get_sentiments(lexicon = c("bing"))
head(bing)

# Perform Inner Join
bingSent <- inner_join(tidyCorp,bing, by=c('term'='word'))
bingSent

# Quick Analysis
table(bingSent$sentiment)

# Compare with qdap::Polarity
polarity(text)

# Get afinn lexicon
afinn <- get_sentiments(lexicon = c("afinn"))
head(afinn)

# Perform Inner Join
afinnSent <- inner_join(tidyCorp,afinn, by=c('term'='word'))
afinnSent

# Quick Analysis as a timeline 
summary(afinnSent$score)
plot(afinnSent$score, 
     type="n", 
     main="Quick Timeline of Identified Words") 
lines(afinnSent$score)

# Get nrc lexicon
nrc <- get_sentiments(lexicon = c("nrc"))
head(nrc)

# Perform Inner Join
nrcSent <- inner_join(tidyCorp,nrc, by=c('term'='word'))
nrcSent

# Quick Analysis
table(nrcSent$sentiment)
emos <- data.frame(table(nrcSent$sentiment))
emos <- emos[-c(6,7),] #drop the higher level positive/negative to get explicit emotion
chartJSRadar(scores=emos)

# End

