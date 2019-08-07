# data preparation
df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
df$Date <- as.Date(df$Date, "%d/%m/%Y")
df <- subset(df, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
date_time <- as.POSIXct(paste(df$Date, df$Time))
df <- cbind(date_time, df)
df <- df[complete.cases(df),]

#plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(df, {
    plot(Global_active_power ~ date_time, type="l", ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage ~ date_time, type="l",  ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1 ~ date_time, type="l", ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2 ~ date_time,col='Red')
    lines(Sub_metering_3 ~ date_time,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power ~ date_time, type="l", ylab="Global Rective Power (kilowatts)", xlab="")
})

#file save
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()