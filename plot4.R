library(lattice)
library(sqldf)

# Set the default size for the plotting
.pardefault <- par(no.readonly = T)


# Read the data with only relevant data
power <- read.csv.sql("<Correct Pathname to be added>household_power_consumption.txt", 
                      sep=";",
                      header=TRUE, 
                      sql = "select * from file where Date in ('1/2/2007', '2/2/2007' )")

# Subset the data for specific dates, and remove NAs if any
power2 <- data.frame(na.omit(power))

# Create the date time variable as suggested and assign relevant format
dt = paste(power2$Date, power2$Time)
dt2 = strptime(dt, "%d/%m/%Y %H:%M:%S")

# Create lattice 2 by 2 and print all the graphs once again
png(file = "<Correct pathname to be added>plot4.png")

par(mfcol = c(2,2))

# Plot 1
plot(dt2, as.numeric(as.character(power2$Global_active_power)), 
     type="l", xlab = "", ylab = "Global Active Power")

# Plot 2
#Creates plot of date/time v Sub metering 1 data
plot(dt2, power2$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")

#Adds line graph for date/time v Sub metering 2 data in red
lines(dt2, power2$Sub_metering_2, type = "l", col = "red" )

#Adds line graph for date/time v Sub metering 3 data in blue
lines(dt2, power2$Sub_metering_3, type = "l", col = "blue" )

#Adds legend to graph
legend("topright", lty= 1, col = c("Black", "red", "blue"), 
       legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# Plot 3
plot(dt2, as.numeric(as.character(power2$Voltage)), 
     type="l", xlab = "", ylab = "Voltage")

# Plot 4
plot(dt2, as.numeric(as.character(power2$Global_reactive_power)), 
     type="l", xlab = "", ylab = "Global Reactive Power")

dev.off()

