
getwd()
setwd("C:/Users/toddhim/Desktop/Coursera")
library(datasets)

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
download.file(fileUrl, destfile = "power_consumption.zip") 
dateDownloaded <- date()
##[1] "Thu Aug 04 08:28:25 2016"


##unzipping dataset and reading data into R 
unzip("power_consumption.zip") 


#reading data into R.  Removing the first row as it contains row names
power_consumption <- read.table("household_power_consumption.txt", sep = ";", colClasses="character", skip = 1)

#confirming the right number of rows/columns (2,075,259 rows and 9 columns)
dim(power_consumption)
head(power_consumption)

#adding back in row 
names(power_consumption)[1] <- "Date"
names(power_consumption)[2] <- "Time"
names(power_consumption)[3] <- "Global_active_power"
names(power_consumption)[4] <- "Global_reactive_power"
names(power_consumption)[5] <- "Voltage"
names(power_consumption)[6] <- "Global_intensity"
names(power_consumption)[7] <- "Sub_metering_1"
names(power_consumption)[8] <- "Sub_metering_2"
names(power_consumption)[9] <- "Sub_metering_3"


##update Date field
power_consumption$Date <- as.Date(power_consumption$Date, "%d/%m/%Y")
##class(power_consumption$Date)

##update Time field
power_consumption$Time <- strptime(power_consumption$Time, "%H:%M:%S")
##class(power_consumption$Time)

##Date range: 2007-02-01 and 2007-02-02
Feb1_2 = subset(power_consumption, as.Date(Date) == '2007-02-01' | as.Date(Date) == '2007-02-02')


##data to numeric
Feb1_2$Global_active_power <- as.numeric(Feb1_2$Global_active_power)
Feb1_2$Global_reactive_power <- as.numeric(Feb1_2$Global_reactive_power)
Feb1_2$Voltage <- as.numeric(Feb1_2$Voltage)
Feb1_2$Global_intensity <- as.numeric(Feb1_2$Global_intensity)
Feb1_2$Sub_metering_1 <- as.numeric(Feb1_2$Sub_metering_1)
Feb1_2$Sub_metering_2 <- as.numeric(Feb1_2$Sub_metering_2)
Feb1_2$Sub_metering_3 <- as.numeric(Feb1_2$Sub_metering_3)
##summary(Feb1_2)
##head(Feb1_2, n=100)

##################################################

##PLOT1


hist(Feb1_2$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (Kilowatts)")

dev.copy(png, file = "plot1.png",width=480,height=480) #copy plot to PNG file
dev.off()

