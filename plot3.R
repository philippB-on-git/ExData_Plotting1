library(readr)

# set language
Sys.setlocale(category = "LC_ALL", locale = "english")

# estimate needed memory
print(paste("Estimated memory required:", round(2075259*9*8/2^20, 2), "MB"))

# check if data is already extracted, if not extract
if (!file.exists("household_power_consumption.txt")) {
    unzip("exdata_data_household_power_consumption.zip")
}

# read data, convert date
dat <- read_delim("household_power_consumption.txt", delim = ";", na = "?")
dat$Date <- as.Date(dat$Date, tryFormats="%d/%m/%Y")

# prepare data
dat <- dat[dat$Date >= as.Date("2007-02-01") & 
               dat$Date <= as.Date("2007-02-02"), ]

dat$DateTime <- as.POSIXct(paste(dat$Date, dat$Time), 
                           format = "%Y-%m-%d %H:%M")

# create plot3.png
png(filename = "plot3.png", width = 480, height = 480, units = "px")
plot(x = dat$DateTime,
     y = dat$Sub_metering_1,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")

lines(x = dat$DateTime,
      y = dat$Sub_metering_1,
      col = "black")

lines(x = dat$DateTime,
      y = dat$Sub_metering_2,
      col = "red")

lines(x = dat$DateTime,
      y = dat$Sub_metering_3,
      col = "blue")

legend(x="topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = rep(1,3))

dev.off()