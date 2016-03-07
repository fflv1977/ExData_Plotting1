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
plottable2 <- subset(sourcetable, sourcetable$Date %in% as.Date(c('2007-02-01', '2007-02-02')))


# create new colum "Day" (date+time)
plottable2$Time <- strptime(plottable2$Time, format = "%H:%M:%S")
plottable2$Time <- sub(".* ", "", plottable2$Time)
plottable2$Day <- as.POSIXlt(paste(plottable2$Date, plottable2$Time), format = "%Y-%m-%d %H:%M:%S")


### 03 - PLOT
plot(plottable2$Day,plottable2$Global_active_power, type = "l", main = "", xlab = "", ylab = "Global Active Power (kwatts)")

### 04 - EXPORT GRAPHIC
dev.copy(png, file = "Plot2.png", width = 480, height = 480)
dev.off()
