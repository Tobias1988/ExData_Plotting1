##Read the file, only the needed values and concatenate these datasets

x <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
a<-x[(x$Date=="1/2/2007"),]
b<-x[(x$Date=="2/2/2007"),]
c <- rbind(a, b)

##Do conversions to the fields from factor to Time/Date/Num

c$Date=as.Date(c$Date, "%d/%m/%Y")
c$Time=as.character(c$Time)
c$Global_active_power=as.numeric(levels(c$Global_active_power)[c$Global_active_power])

##Open the file destination and draw the plots

png(file="plot1.png")
hist(c$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
dev.off()