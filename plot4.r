electric<- read.table("household_power_consumption.txt", sep = ";", header = T, 
                      stringsAsFactors = F)
electric$datetime<- as.POSIXct(paste(electric$Date, electric$Time), 
                               format = "%d/%m/%Y %H:%M:%S")

electric[ ,1]<- as.Date(electric[ ,1], format = "%d/%m/%Y")
##electric$Time<- strptime(electric$Time, format = "%H:%M:%S")

#select data from 2007/2/1 and 2007/2/2
electricsub<- electric[which(electric$Date == "2007-02-01" | electric$Date == "2007-02-02"), ]

electricsub[,3:9]<- sapply(electricsub[,3:9], as.numeric)

Sys.setlocale("LC_TIME", "C")

par(mfrow=c(2,2))
with(electricsub, {
    plot(datetime, Global_active_power, type ="l", ylab = "Global Active Power (kilowatts)", xlab = "")
    plot(datetime, Voltage, type = "l")
    plot(datetime, Sub_metering_1, type= "l", ylab= "Energy sub metering", xlab= "")
    lines(datetime, Sub_metering_2, ylab= "Energy sub metering", xlab= "", col ="red")
    lines(datetime, Sub_metering_3, ylab= "Energy sub metering", xlab= "", col ="blue")
    legend("topright", lty =1 , col = c("black", "red", "blue"), bty= "n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(datetime, Global_reactive_power, type ="l")
    })

dev.copy(png, file="plot4.png")
dev.off()