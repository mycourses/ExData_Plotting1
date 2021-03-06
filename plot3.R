
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

## Plot the time series lines (Plot 3)
png('plot3.png', width = 480, height = 480)
plot(hpc$Timestamp, hpc$Sub_metering_1, type="l", col="black", ann=FALSE)
lines(hpc$Timestamp, hpc$Sub_metering_2, type="l", col="red")
lines(hpc$Timestamp, hpc$Sub_metering_3, type="l", col="blue")
title(ylab="Energy sub metering")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, lwd=2, cex=0.8)
dev.off()



