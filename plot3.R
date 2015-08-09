# The following package are used in preparing the data.
library(dplyr)
library(lubridate)

# Reading the data.
dt <- read.table(file = "household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE)

# Subsetting and formating the data.
dt <- dt %>% filter(Date %in% c("1/2/2007","2/2/2007")) %>%
        mutate(Global_active_power = as.numeric(Global_active_power)) %>%
        mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
        mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
        mutate(Sub_metering_3 = as.numeric(Sub_metering_3)) %>%
        rowwise() %>% mutate(Datetime = paste(Date,Time, collapse = " ")) %>%
        rowwise() %>% mutate(Datetime = dmy_hms(Datetime)) %>%
        select(Datetime, Global_active_power, Sub_metering_1, Sub_metering_2, Sub_metering_3)

# Plotting the data to the PNG graphics device.
png("plot3.png", width=480, height=480)
par(bg=NA, mar = c(4,4,2,1))
plot(dt$Datetime, dt$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(dt$Datetime, dt$Sub_metering_2, type="l", col = "red")
lines(dt$Datetime, dt$Sub_metering_3, type="l", col = "blue")
legend("topright", lwd=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()