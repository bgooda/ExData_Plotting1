# The following package are used in preparing the data.
library(dplyr)
library(lubridate)

# Reading the data.
dt <- read.table(file = "household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors=FALSE)

# Subsetting and formating the data.
dt <- dt %>% filter(Date %in% c("1/2/2007","2/2/2007")) %>%
        mutate(Global_active_power = as.numeric(Global_active_power)) %>%
        rowwise() %>% mutate(Datetime = paste(Date,Time, collapse = " ")) %>%
        rowwise() %>% mutate(Datetime = dmy_hms(Datetime)) %>%
        select(Datetime, Global_active_power)

# Plotting the data to the PNG graphics device.
png("plot1.png", width=480, height=480)
par(bg=NA, mar = c(4,4,2,1))
hist(dt$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()