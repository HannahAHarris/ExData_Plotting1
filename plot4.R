#load and check data
mydata = read.table("/Users/hharris/Desktop/R Course/household_power_consumption.txt", header = T, sep = ";")
head(mydata)
tail(mydata)
#convert "Date" variable to date form and subset data by date
mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
cleandata <- mydata[(mydata$Date=="2007-02-01") | (mydata$Date=="2007-02-02"),]
head(cleandata)
tail(cleandata)

#ensure all variables are numeric
cleandata$Global_active_power <- as.numeric(as.character(cleandata$Global_active_power))
cleandata$Global_reactive_power <- as.numeric(as.character(cleandata$Global_reactive_power))
cleandata$Sub_metering_1 <- as.numeric(as.character(cleandata$Sub_metering_1))
cleandata$Sub_metering_2 <- as.numeric(as.character(cleandata$Sub_metering_2))
cleandata$Sub_metering_3 <- as.numeric(as.character(cleandata$Sub_metering_3))
cleandata$Voltage <- as.numeric(as.character(cleandata$Voltage))

#save time and date as timestamps
cleandata<- transform(cleandata, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

#create plot parameters
par(mfrow=c(2,2), mar =c(4,6,4,4))

#create plot of global active power by timestamp (day of week)
plot(cleandata$timestamp,cleandata$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#create plot of voltage by timestamp (dayofweek)
head(cleandata$Voltage)
plot(cleandata$timestamp,cleandata$Voltage, type="l", xlab="datetime", ylab="Voltage")

#create plot of y axis "energy submetering", ledgend top right with submetering 1 (black) submetering 2 (red) submetering 3 (blue), x axis timestamp (day of the week)
plot(cleandata$timestamp,cleandata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(cleandata$timestamp,cleandata$Sub_metering_2,col="red")
lines(cleandata$timestamp,cleandata$Sub_metering_3,col="blue")
#shrink ledgend using "cex" and remove ledgend box using "bty="n""
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "), lty=c(1,1), cex=.5, bty="n")

#create plot of global_Reactive_power by timestamp (dayofweek)
plot(cleandata$timestamp,cleandata$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#print plot to PNG with 480x480 pix
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
