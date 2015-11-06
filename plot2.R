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
        filter(year(time) == 2007 & month(time) == 2) %>%
        filter(day(time) %in% c(1, 2))
}

png("plot2.png", width = 480, height = 480)

with(
    readData(),
    plot(
        Global_active_power ~ time, 
        type = "l", 
        ylab = "Global Active Power (kilowatts)", 
        xlab = "")
)

dev.off()
