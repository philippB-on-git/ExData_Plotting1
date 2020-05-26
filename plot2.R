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

# create plot2.png
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(x = dat$DateTime,
     y = dat$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()