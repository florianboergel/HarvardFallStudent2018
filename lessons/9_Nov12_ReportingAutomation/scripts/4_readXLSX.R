#' Author: Ted Kwartler
#' Data: 11-11-18
#' Purpose: Working with new file types

# Libraries
library(readxl)

# File Path
filePath <- 'C:/Users/Edward/Desktop/HarvardFallAdmin2018/lessons/9_Nov12_ReportingAutomation/data/exampleExcel.xlsx'

numSheets <- excel_sheets(filePath)
numSheets

sheetOne   <- read_excel(filePath, 1)
sheetTwo   <- read_excel(filePath, 2)
sheetThree <- read_excel(filePath, 3)


# End