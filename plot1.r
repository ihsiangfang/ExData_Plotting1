electric<- read.table("household_power_consumption.txt", sep = ";", header = T, 
                      stringsAsFactors = F)
electric$datetime<- as.POSIXct(paste(electric$Date, electric$Time), 
                               format = "%d/%m/%Y %H:%M:%S")

electric[ ,1]<- as.Date(electric[ ,1], format = "%d/%m/%Y")
##electric$Time<- strptime(electric$Time, format = "%H:%M:%S")

#select data from 2007/2/1 and 2007/2/2
electricsub<- electric[which(electric$Date == "2007-02-01" | electric$Date == "2007-02-02"), ]

electricsub[,3:9]<- sapply(electricsub[,3:9], as.numeric)

hist(electricsub$Global_active_power, col ="red", main ="Global Active Power", xlab ="Global Active Power (kilowatts)")
dev.copy(png, file ="png1.png")
dev.off()

with(electricsub, plot(datetime, Global_active_power , type ="l", ylab = "Global Active Power (kilowatts)", xlab = ""))