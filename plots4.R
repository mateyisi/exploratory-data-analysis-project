library(gdata)
library(lubridate)
require(graphics)
path<-"~/Documents/Projects/Exploratory\ data\ analysis\ with\ R/exploratory-data-analysis-project"# give path to the directry where sumsung data is stored 

setwd(path)

#Check the size of the file 
fileinf<-file.info("exdata_data_household_power_consumption/household_power_consumption.txt",extra_cols = F)
humanReadable(fileinf$size, standard="SI", units="mb")

#load the data
Electdata <- read.csv("exdata_data_household_power_consumption/household_power_consumption.txt", sep = ";")

# select the data corresponding to the specified period
Electdata$Date<-parse_date_time(Electdata$Date,c('dmY','dmy'))
WantedData <- Electdata[Electdata$Date=="2007-02-01 UTC" | Electdata$Date=="2007-02-02 UTC",]



#Plot 4

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

#p4_11

ts.plot(dataThurFri$Global_reactive_power, gpars=list(ylab="Global_reactive_power",xlab="datetime",lty=c(1:3), labels = FALSE))
axis(2, labels = T)
axis(1, at=c(0,1440,2800), labels=c("Thurs","Fri","Sat"))

#P4_12
ts.plot(dataThurFri$Voltage, gpars=list(ylab="Voltage",xlab="datetime",lty=c(1:3), labels = FALSE))
axis(2, labels = T)
axis(1, at=c(0,1440,2800), labels=c("Thurs","Fri","Sat"))

#P4_21

ts.plot(a, gpars=list(ylab="Energy submettering",lty=c(1:3), labels = FALSE))
axis(2, labels = T)
lines(b, type="l", lwd=2, col="red")
lines(c, type="l", lwd=2, col="violet")
axis(1, at=c(0,1440,2800), labels=c("Thurs","Fri","Sat"))
legend(1700, 40, legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),col=c("black","red", "violet"), lty=1:2,  cex=.4,pt.cex = 1)#

#P4_22
ts.plot(dataThurFri$Global_active_power, gpars=list(ylab="Global_reactive_power",xlab="datetime",lty=c(1:3), labels = FALSE))
axis(2, labels = T)
axis(1, at=c(0,1440,2800), labels=c("Thurs","Fri","Sat"))

dev.copy(png, file = "plot4.png",width = 480, height = 480) 
dev.off()




