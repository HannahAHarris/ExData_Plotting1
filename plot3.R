#load and check data
mydata = read.table("/Users/hharris/Desktop/R Course/household_power_consumption.txt", header = T, sep = ";")
head(mydata)
tail(mydata)
#convert "Date" variable to date form and subset data by date
typeof(mydata$Date)
mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")
cleandata <- mydata[(mydata$Date=="2007-02-01") | (mydata$Date=="2007-02-02"),]
head(cleandata)
tail(cleandata)

#ensure all variables are numeric
cleandata$Global_active_power <- as.numeric(as.character(cleandata$Global_active_power))
cleandata$Global_reactive_power <- as.numeric(as.character(cleandata$Global_reactive_power))
cleandata$Global_reactive_power <- as.numeric(as.character(cleandata$Global_reactive_power))
cleandata$Sub_metering_1 <- as.numeric(as.character(cleandata$Sub_metering_1))
cleandata$Sub_metering_2 <- as.numeric(as.character(cleandata$Sub_metering_2))
cleandata$Sub_metering_3 <- as.numeric(as.character(cleandata$Sub_metering_3))

#save time and date as timestamps
cleandata<- transform(cleandata, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

#create plot of y axis "energy submetering", ledgend top right with submetering 1 (black) submetering 2 (red) submetering 3 (blue), x axis timestamp (day of the week)

plot(cleandata$timestamp,cleandata$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(cleandata$timestamp,cleandata$Sub_metering_2,col="red")
lines(cleandata$timestamp,cleandata$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
par(mar=c(4,4,4,4))

#save plot as plot3 PNG with dimensions 480x480 pix
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
