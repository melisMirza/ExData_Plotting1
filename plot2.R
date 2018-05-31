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

#plot the graph
with(withdays, plot(wdays, Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)"))

#save as png & close device
dev.copy(png,file="plot2.png")
dev.off()