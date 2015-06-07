electric<- read.table("household_power_consumption.txt", sep = ";", header = T, 
                      stringsAsFactors = F)
electric$datetime<- as.POSIXct(paste(electric$Date, electric$Time), 
                               format = "%d/%m/%Y %H:%M:%S")

electric[ ,1]<- as.Date(electric[ ,1], format = "%d/%m/%Y")
##electric$Time<- strptime(electric$Time, format = "%H:%M:%S")

#select data from 2007/2/1 and 2007/2/2
electricsub<- electric[which(electric$Date == "2007-02-01" | electric$Date == "2007-02-02"), ]
lang<- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
with(electricsub, plot(datetime, Global_active_power , type ="l", ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.copy(png, file="plot2.png")
dev.off()