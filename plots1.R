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


#plot1
par(mfrow = c(1, 1), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
hist(as.numeric(WantedData$Global_active_power),xlab="Global active power(Kilowatts)",main="Global Active Power")


dev.copy(png, file = "plot1.png") 
dev.off()





