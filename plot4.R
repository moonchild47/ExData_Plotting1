# download data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- paste0(getwd(),"/","data.zip")
#download zip file
download.file(url,destfile,method = "curl")
#unzip file
unzip("data.zip")


#setwd("~/Documents/R_Code/Coursera/Exploratory Data Analysis/Week 1")
d <- read.delim('household_power_consumption.txt', sep = ';')

# convert to date
d$Date <- as.Date(d$Date, "%d/%m/%Y")

# only use data from the dates 2007-02-01 and 2007-02-02
d <- d[d$Date <= "2007-02-02" & d$Date >= "2007-02-01",]
# drop factors which are not needed
d[] <- lapply(d, function(x) if (is.factor(x)) factor(x) else x)

# combine date and time
d$DateTime <- as.POSIXct(paste(d$Date, d$Time), format = "%Y-%m-%d %H:%M:%S")

# convert variables of interest to numeric values
d$Global_active_power <- as.numeric(levels(d$Global_active_power))[d$Global_active_power]
d$Global_reactive_power <- as.numeric(levels(d$Global_reactive_power))[d$Global_reactive_power]
d$Sub_metering_1 <- as.numeric(levels(d$Sub_metering_1))[d$Sub_metering_1]
d$Sub_metering_2 <- as.numeric(levels(d$Sub_metering_2))[d$Sub_metering_2]
d$Voltage <- as.numeric(levels(d$Voltage))[d$Voltage]


png(file = "plot4.png", height = 480, width = 480, units = "px", bg = "transparent") 

par(mfrow = c(2,2))

plot(d$DateTime, d$Global_active_power, type = 'l', xlab = 'Day', 
     ylab = 'Global active power')

plot(d$DateTime, d$Voltage, type = 'l', xlab = 'Day', ylab = 'Voltage')

plot(d$DateTime, d$Sub_metering_1, type = 'l',
     xlab = 'Day',
     ylab = 'Energy sub metering')
lines(d$DateTime, d$Sub_metering_2, type = 'l', col = 'red')
lines(d$DateTime, d$Sub_metering_3, type = 'l', col = 'blue')
legend("topright", legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
       col = c("black","red", "blue"), lty = 1, cex = 0.5)

# plot 4
plot(d$DateTime, d$Global_reactive_power, type = 'l',
     xlab = 'Day',
     ylab = 'Globale reactive power')


dev.off()