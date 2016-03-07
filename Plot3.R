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
plottable3 <- subset(sourcetable, sourcetable$Date %in% as.Date(c('2007-02-01', '2007-02-02')))


# create new colum "Day" (date+time)
plottable3$Time <- strptime(plottable2$Time, format = "%H:%M:%S")
plottable3$Time <- sub(".* ", "", plottable2$Time)
plottable3$Day <- as.POSIXlt(paste(plottable2$Date, plottable2$Time), format = "%Y-%m-%d %H:%M:%S")


  
### 03 - PLOT
  
  with(plottable3, plot(Day, plottable3$Sub_metering_1, main = "", xlab = "", ylab = "Energy sub metering",type = "l"))
  lines(plottable3$Day, plottable3$Sub_metering_2, type = "l", col = "red")
  lines(plottable3$Day, plottable3$Sub_metering_3, type = "l", col = "blue")
  
  legend("topright", col = c("black", "blue", "red"), pch = "--", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
### 04 - EXPORT GRAPHIC
  dev.copy(png, file = "Plot3.png", width = 480, height = 480)
  dev.off()
  