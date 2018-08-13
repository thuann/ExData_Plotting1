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
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(powerData, {
  plot(Global_active_power~FullDate, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~FullDate, type="l", 
       ylab="Voltage", xlab="")
  plot(Sub_metering_1~FullDate, type="l", 
       ylab="Energy Sub metering", xlab="")
  lines(Sub_metering_2~FullDate,col='Red')
  lines(Sub_metering_3~FullDate,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~FullDate, type="l",xlab="")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()


