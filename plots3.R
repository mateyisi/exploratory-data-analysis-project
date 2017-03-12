library(gdata)
library(lubridate)

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

# convert the date into week days and rplace qustion marks by NA in Global_active_power
WantedData$Date <-wday(WantedData$Date, label=TRUE)
WantedData$Global_active_power <- gsub("?", NA,as.character(WantedData$Global_active_power), fixed = TRUE)
with(WantedData, ts.plot(Date,as.numeric(Global_active_power) ,xaxt = "n",type = "l"))

# Plot3

# replace question mark "?" by NA in Sub_metering_1 2 and 3.

WantedData$Sub_metering_1 <- gsub("?", NA,as.character(WantedData$Sub_metering_1), fixed = TRUE)
WantedData$Sub_metering_2 <- gsub("?", NA,as.character(WantedData$Sub_metering_2), fixed = TRUE)
WantedData$Sub_metering_3 <- gsub("?", NA,as.character(WantedData$Sub_metering_3), fixed = TRUE)

dataThurFri <- WantedData[WantedData$Date=="Thurs"|| WantedData$Date=="Fri",]
ts.plot(dataThurFri,gpars= list(dataThurFri$Sub_metering_1,dataThurFri$Sub_metering_2),type="l")

# convert sub_metering data to numeric
a<-as.numeric(dataThurFri$Sub_metering_1)
b<-as.numeric(dataThurFri$Sub_metering_2)
c<-as.numeric(dataThurFri$Sub_metering_3)

#plot 3

par(mfrow = c(1, 1), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
ts.plot(a, gpars=list(ylab="Energy submettering",xlab="datetime",lty=c(1:3), labels = FALSE))
axis(2, labels = T)
lines(b, type="l", lwd=2, col="red")
lines(c, type="l", lwd=2, col="violet")
axis(1, at=c(0,1440,2800), labels=c("Thurs","Fri","Sat"))
legend(1700, 40, legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),col=c("black","red", "violet"), lty=1:2, cex=.9)

dev.copy(png, file = "plot3.png") 
dev.off()






