# The following package are used in preparing the data.
library(dplyr)
library(lubridate)

# Reading the data.
dt <- read.table(file = "household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE)

# Subsetting and formating the data.
dt <- dt %>% filter(Date %in% c("1/2/2007","2/2/2007")) %>%
        mutate(Global_active_power = as.numeric(Global_active_power)) %>%
        mutate(Global_reactive_power = as.numeric(Global_reactive_power)) %>%
        mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
        mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
        mutate(Sub_metering_3 = as.numeric(Sub_metering_3)) %>%
        mutate(Voltage = as.numeric(Voltage)) %>%
        rowwise() %>% mutate(Datetime = paste(Date,Time, collapse = " ")) %>%
        rowwise() %>% mutate(Datetime = dmy_hms(Datetime)) %>%
        select(Datetime, Global_active_power, Global_reactive_power, Voltage, Sub_metering_1, Sub_metering_2, Sub_metering_3)

# Plotting the data to the PNG graphics device.
png("plot4.png", width=480, height=480)
par(mfrow = c(2,2), bg=NA, mar = c(4,4,2,1))
plot(dt$Datetime, dt$Global_active_power, xlab = "", ylab="Global Active Power (kilowatts)", type="l")
plot(dt$Datetime, dt$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(dt$Datetime, dt$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(dt$Datetime, dt$Sub_metering_2, type="l", col = "red")
lines(dt$Datetime, dt$Sub_metering_3, type="l", col = "blue")
legend("topright",lwd=2,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty ="n")
plot(dt$Datetime, dt$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
