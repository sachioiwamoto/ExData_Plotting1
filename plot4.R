### Step 1. Reading and cleaning the data
# This step is common to all plots (1 to 4)
# Reading data from the course web site and unzip into the working directory
# and then load the extracted data into a data.frame
wd <- getwd()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "exdata-data-household_power_consumption.zip"
# NOTE: If on Mac, you may need to set method="curl" for download.file
download.file(fileUrl, file)
unzip(file, exdir = wd)
data <- read.table(paste(wd, "/household_power_consumption.txt", sep =""),
                       header = TRUE, sep = ";", na.strings = "?", quote="\"")
# Subsetting data from only the dates 2007-02-01 and 2007-02-02
data <- data[data$Date %in% c("1/2/2007", "2/2/2007"),]
# Merge Date and Time columens into one POSIXct class column called datetime
data$Date <- strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")
names(data)[1] <- c("datetime")
data <- subset(data, select = -c(Time))

### Step 2. Plotting data
# Plot 4. Multiple Base plots into a file named "plot4.png"
png("plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))
with(data, {
        # plot 4-(1) Global Active Power
        plot(data$datetime, data$Global_active_power, type = "l",  ann = FALSE)
        axis(side = 2, at = seq(0, 6, 2))
        title(ylab = "Global Active Power")
        # plot 4-(2) Voltage
        plot(data$datetime, data$Voltage, type = "l", ann = FALSE)
        axis(side = 2, at = seq(234, 246, 4))
        title(xlab = "datetime", ylab = "Voltage")
        # plot 4-(3) Energy sub metering
        plot(data$datetime, data$Sub_metering_1, type = "l", ann = FALSE)
        lines(data$datetime, data$Sub_metering_2, col = "red")
        lines(data$datetime, data$Sub_metering_3, col = "blue")
        legend("topright", col = c("black", "Red", "Blue"), lwd = 1, lty = c(1, 1, 1),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               bty = "n")
        axis(side = 2, at = seq(0, 30, 10))
        title(ylab = "Energy sub metering")
        # plot 4-(4) Global_reactive_power
        plot(data$datetime, data$Global_reactive_power, type = "l", ann = FALSE)
        axis(side = 2, at = seq(234, 246, 4))
        title(xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()