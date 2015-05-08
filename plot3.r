if (file.exists("household_power_consumption.txt")){
  
  # Import data
  lines <- grep("1/2/2007", readLines("household_power_consumption.txt"))
  skips <- sum(lines[1],-1)
  power <- read.table("household_power_consumption.txt", sep=";", skip=skips, nrows=2880)
  names(power) <- c("date","time","globalActivePower","globalReactivePower","voltage","globalIntensity","subMetering1","subMetering2","subMetering3")
  power$dateTime <- paste(power$date, power$time, sep=" ")
  power$dateTime <- strptime(power$dateTime, "%d/%m/%Y %H:%M:%S")
  power <- power[,c(10, 3:9)]
  
} else {
  
  #Download data
  zipURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(zipURL, destfile = "Electric_power_consumption.zip", mode="wb")
  unzip("Electric_power_consumption.zip")
  
  # Import data
  lines <- grep("1/2/2007", readLines("household_power_consumption.txt"))
  skips <- sum(lines[1],-1)
  power <- read.table("household_power_consumption.txt", sep=";", skip=skips, nrows=2880)
  names(power) <- c("date","time","globalActivePower","globalReactivePower","voltage","globalIntensity","subMetering1","subMetering2","subMetering3")
  power$dateTime <- paste(power$date, power$time, sep=" ")
  power$dateTime <- strptime(power$dateTime, "%d/%m/%Y %H:%M:%S")
  power <- power[,c(10, 3:9)]
  
}

# Plot Line Graph
png("plot3.png", width=480, height=480)
with(power, plot(dateTime, subMetering1, type="l", col="black", xlab="", ylab="Energy sub metering", main=""))
with(power, points(dateTime, subMetering2, type="l", col="red"))
with(power, points(dateTime, subMetering3, type="l", col="blue"))
legend("topright", lty=1, col=c("black","red","blue"), legend = c("sub_metering_1","sub_metering_2","sub_metering_3"))
dev.off()
