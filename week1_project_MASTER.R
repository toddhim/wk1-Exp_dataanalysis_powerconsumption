
getwd()
setwd("C:/Users/toddhim/Desktop/Coursera")


fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
download.file(fileUrl, destfile = "power_consumption.zip") 
dateDownloaded <- date()
##[1] "Thu Aug 04 08:28:25 2016"

list.files(getwd())

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
##names(power_consumption)
##head(power_consumption)


##update Date field
power_consumption$Date <- as.Date(power_consumption$Date, "%d/%m/%Y")
##class(power_consumption$Date)

##update Time field
power_consumption$Time <- strptime(power_consumption$Time, "%H:%M:%S")
##class(power_consumption$Time)


##Date range: 2007-02-01 and 2007-02-02
Feb1_2 = subset(power_consumption, as.Date(Date) == '2007-02-01' | as.Date(Date) == '2007-02-02')

##head(Feb1_2)
##dim(Feb1_2)
##summary(Feb1_2)



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



library(datasets)

##Plot 1
hist(Feb1_2$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")
dev.copy(png, file = "plot1.png",width=480,height=480) #copy plot to PNG file
dev.off()

##########################################

##Plot 2



plot(Feb1_2$Global_active_power,type="l",lwd=2,
     xaxt="n",ylim=c(0,6),col="black",
     xlab = "", ylab="Global Active Power (Kilowatts)")
days = c("Thu","Fri","Sat")
axis(1,at=c(0,1441,2880), labels=days)  
dev.copy(png, file = "plot2.png",width=480,height=480) #copy plot to PNG file

dev.off() 
   




################################################

##Plot 3


plot(Feb1_2$Sub_metering_1,type="l",lwd=2, xaxt="n",ylim=c(0,30),col="black", xlab = "", ylab="Engineering sub metering")
lines(Feb1_2$Sub_metering_2, col='red')
lines(Feb1_2$Sub_metering_3, col='blue')
days = c("Thu","Fri","Sat")
axis(1,at=c(0,1441,2880), labels=days) 
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 
dev.copy(png, file = "plot3.png",width=480,height=480) #copy plot to PNG file

dev.off() 





##################################################

##PLOT4


par(mfcol=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))  
with(Feb1_2, {  
  
  plot(Feb1_2$Global_active_power,type="l",lwd=2,
      xaxt="n",ylim=c(0,6),col="black",
      xlab = "", ylab="Global Active Power")
  days = c("Thu","Fri","Sat")
  axis(1,at=c(0,1441,2880), labels=days)  

  plot(Feb1_2$Sub_metering_1,type="l",lwd=2, 
       xaxt="n",ylim=c(0,30),col="black", xlab = "", 
       ylab="Engineering sub metering")
    lines(Feb1_2$Sub_metering_2, col='red')
    lines(Feb1_2$Sub_metering_3, col='blue')
  days = c("Thu","Fri","Sat")
  axis(1,at=c(0,1441,2880), labels=days) 
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")) 

  plot(Feb1_2$Voltage,type="l",lwd=2, 
       xaxt="n",ylim=c(234,246),col="black", 
       xlab = "datetime", ylab="Voltage (volt)")
  days = c("Thu","Fri","Sat")
  axis(1,at=c(0,1441,2880), labels=days) 

  plot(Feb1_2$Global_reactive_power,type="l",lwd=2,
      xaxt="n",ylim=c(0.0, 0.5),col="black",
      xlab = "datetime", ylab = "Global_reactive_power")
  days = c("Thu","Fri","Sat")
  axis(1,at=c(0,1441,2880), labels=days) 
})

dev.copy(png, file = "plot4.png",width=480,height=480) #copy plot to PNG file
dev.off() 

##############

