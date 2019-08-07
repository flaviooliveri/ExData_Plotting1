# data preparation
df <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
df$Date <- as.Date(df$Date, "%d/%m/%Y")
df <- subset(df, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
date_time <- as.POSIXct(paste(df$Date, df$Time))
df <- cbind(date_time, df)
df <- df[complete.cases(df),]

#plot
plot(Sub_metering_1 ~ date_time, data= df, type="l", ylab="Global Active Power (kilowatts)", xlab="")
lines(Sub_metering_2 ~ date_time, data = df, col='Red')
lines(Sub_metering_3 ~ date_time, data = df, col='Blue')
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#file save
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()