library(dplyr)

#Read data
full_data <- read.table(".\\household_power_consumption.txt",header = TRUE, sep=";",na.strings = "?")
#filter data of 01/02/2007 and 02/02/2007
twoDays <- filter(full_data, Date=="1/2/2007" |Date=="2/2/2007")

#plot the histogram
hist(twoDays$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#save as png & close device
dev.copy(png,file="plot1.png")
dev.off()