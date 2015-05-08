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

# Plot Histogram
png("plot1.png", width=480, height=480)
with(power, hist(globalActivePower, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power"))
dev.off()
