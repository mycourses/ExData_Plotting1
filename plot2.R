
## Load only the two relevant days into a data set
hpc <- read.table("household_power_consumption.txt", sep=";",
                  na.strings="?", header=FALSE, stringsAsFactors=FALSE,
                  skip=66637, nrow=2880)

## Change the column headers to their original names
colnames(hpc) <- c("Date", "Time", "Global_active_power",
                   "Global_reactive_power", "Voltage", "Global_intensity",
                   "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## Aggregate Date and Time into Timestamp in POSIXlt format
dt <- hpc$Date
tm <- hpc$Time
ts <- paste(dt, tm)
hpc$Timestamp <- strptime(ts, "%d/%m/%Y %H:%M:%S")

## Plot the time series line (Plot 2)
png('plot2.png', width = 480, height = 480)
plot(hpc$Timestamp, hpc$Global_active_power, type="l", ann=FALSE)
title(ylab="Global Active Power (kilowatts)")
dev.off()
