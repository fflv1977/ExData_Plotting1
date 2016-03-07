## Assignment: Course Project 1

### 01 - DATA LOADING
# Load to Working Directory.
sourcetable <- read.table("./exdata-data-household_power_consumption/household_power_consumption.txt"
                          , header = TRUE
                          , sep = ";"
                          , colClasses = c("character", "character", "numeric",  "numeric", "numeric", "numeric", "numeric", "numeric", "numeric" )
                          , na.strings = c("?")
)

### 02 DATA CLEANING
# change class for  Date column
sourcetable$Date <- with (sourcetable, as.Date(Date, "%d/%m/%Y"))

# subset (2007-02-01 & 2007-02-02)
plottable4 <- subset(sourcetable, sourcetable$Date %in% as.Date(c('2007-02-01', '2007-02-02')))


# create new colum "Day" (date+time)
plottable4$Time <- strptime(plottable4$Time, format = "%H:%M:%S")
plottable4$Time <- sub(".* ", "", plottable4$Time)
plottable4$Day <- as.POSIXlt(paste(plottable4$Date, plottable4$Time), format = "%Y-%m-%d %H:%M:%S")


  
### 03 - PLOT
par(mfrow = c(2,2))
  
#### graphic 01
with(plottable4, plot(Day, Global_active_power,type = "l", main = "", xlab = "", ylab = "Global Active Power"))
  
#### graphic 02
with(plottable4, plot(Day, Voltage, main = "",type = "l", xlab = "datetime", ylab = "Voltage"))

#### graphic 03
with(plottable4, plot(Day, Sub_metering_1, main = "", xlab = "", ylab = "Energy sub metering",type = "l"))
lines(plottable4$Day, plottable4$Sub_metering_2, type = "l", col = "red")
lines(plottable4$Day, plottable4$Sub_metering_3, type = "l", col = "blue")

legend("topright", col = c("black", "blue", "red"), pch = "--", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#### graphic 04
with(plottable4, plot(Day, Global_reactive_power,type = "l",  main = "", xlab = "datetime", ylab = "Global_reactive_power"))


### 04 - EXPORT GRAPHIC
dev.copy(png, file = "Plot4.png", width = 480, height = 480)
dev.off()

