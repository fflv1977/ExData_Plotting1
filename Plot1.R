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
plottable1 <- subset(sourcetable, sourcetable$Date %in% as.Date(c('2007-02-01', '2007-02-02')))
  
  
### 03 - PLOT
with(plottable1, hist(plottable1$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kwatts)", col = c("red")))

### 04 - EXPORT GRAPHIC
dev.copy(png, file = "Plot1.png", width = 480, height = 480)
dev.off()