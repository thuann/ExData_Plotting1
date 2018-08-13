#download and extract zip data file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
unzip(temp)
unlink(temp)

#load raw data
rawData <- read.table("./data/household_power_consumption.txt",header = TRUE, sep = ";", 
                      col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power",
                                    "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                                    "Sub_metering_3"), na.strings="?",
                      colClasses = c("character", "character", "numeric", "numeric", 
                                     "numeric", "numeric", "numeric", "numeric", "numeric"),
                      stringsAsFactors = FALSE)

#subset
powerData <- subset(rawData, Date=="2007-02-01" | Date=="2007-02-02")

#date time conversion
powerData$Date <- as.Date(powerData$Date, format="%d/%m/%Y")
fullDate <- paste(powerData$Date, powerData$Time)
powerData$FullDate <- as.POSIXct(fullDate)


#plot
plot(powerData$Global_active_power~powerData$FullDate, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()




