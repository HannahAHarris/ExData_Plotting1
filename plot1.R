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
##cleandata<- transform(cleandata, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

#ensure all variables are numeric
cleandata$Global_active_power <- as.numeric(as.character(cleandata$Global_active_power))
cleandata$Global_reactive_power <- as.numeric(as.character(cleandata$Global_reactive_power))
cleandata$Global_reactive_power <- as.numeric(as.character(cleandata$Global_reactive_power))
cleandata$Sub_metering_1 <- as.numeric(as.character(cleandata$Sub_metering_1))
cleandata$Sub_metering_2 <- as.numeric(as.character(cleandata$Sub_metering_2))
cleandata$Sub_metering_3 <- as.numeric(as.character(cleandata$Sub_metering_3))

#create a histogram with title "Global Active Power", x axis kilowatts 0246, y access frequency 0 200...1200, 11 bars, red colour

hist(cleandata$Global_active_power, main = ("Global Active Power"), col = "red", xlab = "Global Active Power (kilowatts)", ylim=c(0, 1200), xlim=c(0,6))

#save histogram as PDF with 480x480 pix
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
#check working directory where PNG file is saved
getwd()
