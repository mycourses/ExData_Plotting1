
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


## Initialise the four plot layout
par(mfcol=c(2, 2))

## Plot the time series line (from Plot 2) - Top left corner
plot(hpc$Timestamp, hpc$Global_active_power, type="l", ann=FALSE)
title(ylab="Global Active Power (kilowatts)")

## Plot the time series lines (from Plot 3) - Bottom left corner
plot(hpc$Timestamp, hpc$Sub_metering_1, type="l", col="black", ann=FALSE)
lines(hpc$Timestamp, hpc$Sub_metering_2, type="l", col="red")
lines(hpc$Timestamp, hpc$Sub_metering_3, type="l", col="blue")
title(ylab="Energy sub metering")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, lwd=2, cex=0.4)

## Plot the time series Voltage - Top right corner
plot(hpc$Timestamp, hpc$Voltage, type="l", ann=FALSE)
title(xlab="datetime", ylab="Voltage")

## Plot the time series Global Reactive Power - Bottom right corner
plot(hpc$Timestamp, hpc$Global_reactive_power, type="l", ann=FALSE)
title(xlab="datetime", ylab="Global_reactive_power")


