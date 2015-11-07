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

png("plot4.png", width = 480, height = 480)

data = readData()

par(mfcol = c(2,2))

# draw plot in upper left corner
with(
    data,
    plot(
        Global_active_power ~ time, 
        type = "l", 
        ylab = "Global Active Power", 
        xlab = "")
)


# draw plot in lower left corner
with(
    data,
    plot(time, Sub_metering_1, 
         type = "n",
         ylab = "Energy sub metering",
         xlab = "")
)
with(data, lines(time, Sub_metering_1, col = "black"))
with(data, lines(time, Sub_metering_2, col = "red"))
with(data, lines(time, Sub_metering_3, col = "blue"))
legend(
    "topright", 
    c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
    lty = c(1,1,1), 
    col = c("black","red", "blue")
)

with(
    data,
    plot(
        Voltage ~ time, 
        type = "l", 
        xlab = "datetime")
)

with(
    data,
    plot(
        Global_reactive_power ~ time, 
        type = "l", 
        xlab = "datetime")
)

dev.off()
