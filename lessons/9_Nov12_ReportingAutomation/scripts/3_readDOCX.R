#' Author: Ted Kwartler
#' Data: 11-11-18
#' Purpose: Working with new file types
#' 

# libraries
library(docxtractr)
library(xml2)

filePath <- 'C:/Users/Edward/Desktop/HarvardFallAdmin2018/lessons/9_Nov12_ReportingAutomation/data/exampleWord.docx'

# Easiest way to get the table data
info <- read_docx(filePath)
tableData <- docx_extract_all_tbls(info)
tableData <- as.data.frame(tableData)
tableData

# Easiest way to extract the simple text
library(textreadr)
info <- read_docx(filePath)
# End