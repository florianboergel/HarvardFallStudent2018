#' Author: Ted Kwartler
#' Data: 11-11-18
#' Purpose: Demonstrate getting json API information

# Libraries
library(jsonlite)

# Original page
# https://projects.fivethirtyeight.com/trump-approval-ratings/

# Developer Tab has two API endpoints
historicalURL <- 'https://projects.fivethirtyeight.com/trump-approval-ratings/historical-approval.json'

trumpURL      <- 'https://projects.fivethirtyeight.com/trump-approval-ratings/approval.json'


# Get Historical
approvalRatings <- fromJSON(historicalURL)
head(approvalRatings)

# Get Trump
trumpApproval   <- fromJSON(trumpURL)
head(trumpApproval)

# End