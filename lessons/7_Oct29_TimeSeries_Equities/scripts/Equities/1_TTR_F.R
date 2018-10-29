#' Author: Ted Kwartler
#' Date: 6-22-2018
#' Purpose: RSI Example
#' 

# Opts
options(scipen=999)

# Libs
library(TTR)
library(quantmod)
library(PerformanceAnalytics)
library(dygraphs)
library(htmltools)

# Get AMZN
getSymbols("AMZN")
AMZN <- AMZN['2018-01-01/2018-06-22']

# Calc RSI
AMZNrsi <-RSI(AMZN$AMZN.Close,
    maType="SMA", #Usually EMA; not covered
    n =14)

tail(AMZNrsi,10)

# Visualize 
browsable(
  tagList(
    dygraph(AMZN$AMZN.Close, group = "Price", height = 200, width = "100%"),
    dygraph(AMZNrsi, group = "Price", height = 200, width = "100%") %>%
      dyLimit(30, label = 'OverSold') %>%
      dyLimit(70, label = 'OverBought') %>%
      dyRangeSelector()
  )
)

# One more
getSymbols("HAS")

# Calc RSI
HASrsi <-RSI(HAS$HAS.Close,
             maType="SMA", #Usually EMA; not covered
             n =14)

# Visualize 
browsable(
  tagList(
    dygraph(HAS$HAS.Close, group = "Price", height = 200, width = "100%"),
    dygraph(HASrsi, group = "Price", height = 200, width = "100%") %>%
      dyLimit(30, label = 'OverSold') %>%
      dyLimit(70, label = 'OverBought') %>%
      dyRangeSelector()
  )
)

# End