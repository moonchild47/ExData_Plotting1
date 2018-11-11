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


png(file = "plot2.png", height = 480, width = 480, units = "px", bg = "transparent") 

# plot 2
plot(d$DateTime, d$Global_active_power, type = 'l', 
     main = 'Global active power over 2 days', xlab = 'Day', 
     ylab = 'Global active power (kilowatts)')

dev.off()