library(dplyr)
library(lubridate)

readData <- function(filePath = "household_power_consumption.txt") {
    colClasses <- c("character", "character", rep("numeric", 7))

    read.table(
        filePath, 
        header = TRUE,
        sep = ";",
        na.strings = "?", 
        colClasses = colClasses
    ) %>% tbl_df %>%
        mutate(time = dmy_hms(paste(Date, Time))) %>%
        select(-c(Date, Time)) %>%
        filter(year(time) == 2007 & month(time) == 2)
}


