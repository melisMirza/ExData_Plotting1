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

#plot the graph and add the points
with(withdays, plot(wdays, Sub_metering_1, type="n", xlab = "", ylab = "Energy sub metering"))
with(withdays,points(wdays,Sub_metering_1, type="l"))
with(withdays,points(wdays,Sub_metering_2, type="l", col="red"))
with(withdays,points(wdays,Sub_metering_3, type="l", col="blue"))
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1  ","Sub_metering_2  ","Sub_metering_3  "))

#save as png & close device
dev.copy(png,file="plot3.png")
dev.off()