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

#Plot2 

require(graphics)
par(mfrow = c(1, 1), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
ts.plot(c(a=as.numeric(WantedData[WantedData$Date=="Thurs",]$Global_active_power),xlabels=c(F),b=as.numeric(WantedData[WantedData$Date=="Fri",]$Global_active_power)), gpars=list(ylab="Global_active_power (Kilowatts)",lty=c(1:3), labels = FALSE))
axis(2, labels = T)
axis(1, at=c(0,1440,2800), labels=c("Thurs","Fri","Sat"))

dev.copy(png, file = "plot2.png") 

dev.off()





