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
c$DateTime <- do.call(paste, c(c[c("Date", "Time")], sep=" "))
c$DateTime = strptime(c$DateTime, format="%Y-%m-%d %H:%M:%S")

##Open the file destination and draw the plots

png(file="plot2.png")
with(c, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))
dev.off()

