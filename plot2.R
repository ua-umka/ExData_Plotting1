install.packages("downloader") # to download and unzip files
install.packages("lubridate")
library("downloader")
library("lubridate") 

# Downloads and unzips files
if (!file.exists("power_consumption")) {
      url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      download(url, dest="power_consumption.zip", mode="wb")
      unzip ("power_consumption.zip", exdir = "power_consumption")
}

# Sets unzipped folder as a working directory
setwd("power_consumption")

# Reads required file
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
d <- dmy(data$Date)
n <- grepl('^2007-02-0[12]', d)
SubData <- subset(data, n)

# DateTime
SubData$DateTime <- strptime(paste(SubData$Date, SubData$Time), format="%d/%m/%Y %H:%M:%S")

# Graph 2
png("plot2.png", width = 480, height = 480)
plot(SubData$DateTime, SubData$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()