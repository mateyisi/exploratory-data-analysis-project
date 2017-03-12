setwd("C:/Users/erik_/Documents/Exploratory Data Analysis")

############# read and format Data #############

hhld = read.table("household_power_consumption.txt", header = TRUE, sep = ";")

hhld$Date = as.Date(hhld$Date, format = "%d/%m/%Y")

mydata = subset(hhld, Date == as.Date("2007-02-01", "%Y-%m-%d") | Date == as.Date("2007-02-02", "%Y-%m-%d"))

mydata$Sub_metering_1 = as.numeric(as.character(mydata$Sub_metering_1))
mydata$Sub_metering_2 = as.numeric(as.character(mydata$Sub_metering_2))
mydata$Sub_metering_3 = as.numeric(as.character(mydata$Sub_metering_3))
mydata$Voltage = as.numeric(as.character(mydata$Voltage))
mydata$Global_reactive_power = as.numeric(as.character(mydata$Global_reactive_power))
mydata$Global_active_power = as.numeric(as.character(mydata$Global_active_power))

mydata$DateTime = strptime(paste(as.character(mydata$Date), as.character(mydata$Time)), format = "%Y-%m-%d %H:%M:%S")

############ make graph ##############
png(filename = "Plot4.png", width = 480, height = 480)
par(mfrow= c(2,2))

plot(mydata$DateTime, mydata$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

plot(mydata$DateTime, mydata$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

plot(mydata$DateTime, mydata$Sub_metering_1,type = "l", ylab = "Energy sub metering", xlab = "")
lines(mydata$DateTime, mydata$Sub_metering_2, type = "l", col = "red")
lines(mydata$DateTime, mydata$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty="n")

plot(mydata$DateTime, mydata$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()