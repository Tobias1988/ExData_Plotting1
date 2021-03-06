##Read the file, only the needed values and concatenate these datasets

x <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
a<-x[(x$Date=="1/2/2007"),]
b<-x[(x$Date=="2/2/2007"),]
c <- rbind(a, b)

##Do conversions to the fields from factor to Time/Date/Num

c$Date=as.Date(c$Date, "%d/%m/%Y")
library(chron)
c$Time=chron(times=c$Time)
c$Global_active_power=as.numeric(levels(c$Global_active_power)[c$Global_active_power])
c$Sub_metering_1=as.numeric(levels(c$Sub_metering_1)[c$Sub_metering_1])
c$Sub_metering_2=as.numeric(levels(c$Sub_metering_2)[c$Sub_metering_2])
c$Sub_metering_3=as.numeric(levels(c$Sub_metering_3)[c$Sub_metering_3])
c$DateTime <- do.call(paste, c(c[c("Date", "Time")], sep=" "))
c$DateTime = strptime(c$DateTime, format="%Y-%m-%d %H:%M:%S")

##Open the file destination and draw the plots

png(file="plot3.png")
with(c, plot(DateTime, c$Sub_metering_1, type="n", xlab=" ", ylab="Energy sub metering"))
with(c, lines(DateTime, c$Sub_metering_1))
with(c, lines(DateTime, c$Sub_metering_2, col="red"))
with(c, lines(DateTime, c$Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1, 1), col=c("black", "red", "blue"))
dev.off()