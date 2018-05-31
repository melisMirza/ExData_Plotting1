library(dplyr)
library(lubridate)
#Read data
full_data <- read.table(".\\household_power_consumption.txt",header = TRUE, sep=";",na.strings = "?")
#filter data of 01/02/2007 and 02/02/2007
twoDays <- filter(full_data, Date=="1/2/2007" |Date=="2/2/2007")
#reformat date and rename
w <- paste(dmy(twoDays$Date),twoDays$Time)
days <- strptime(w, "%Y-%m-%d %H:%M:%S")
withdays <- cbind(twoDays,days)
names(withdays) <- c(names(twoDays), "wdays")

#Set parameters
par(mfrow=c(2,2))

#First graph (days vs. Global_active_power)
with(withdays, plot(wdays, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))

#Second graph(days vs. voltage)
with(withdays, plot(wdays, Voltage, type="l", xlab = "", ylab = "Voltage"))

#Third graph (days vs. sub meter 1,2,3)
with(withdays, plot(wdays, Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering"))
with(withdays,points(wdays,Sub_metering_1, type="l"))
with(withdays,points(wdays,Sub_metering_2, type="l", col="red"))
with(withdays,points(wdays,Sub_metering_3, type="l", col="blue"))
legend(95,95, lty=1, cex=0.5,col=c("black","red","blue"),box.lty=0, legend=c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "))


#Last Graph (days vs. global reactive power)
with(withdays, plot(wdays, Global_reactive_power, type="l", xlab = "datetime"))

#save as png & close device
dev.copy(png,file="plot4.png")
dev.off()