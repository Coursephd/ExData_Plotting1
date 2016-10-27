# Set the default size for the plotting
.pardefault <- par(no.readonly = T)

# Read the data with only relevant data
library(sqldf)
power <- read.csv.sql("<Correct Pathname to be added>household_power_consumption.txt", 
                      sep=";",
                      header=TRUE, 
                      sql = "select * from file where Date in ('1/2/2007', '2/2/2007' )")

# Subset the data for specific dates, and remove NAs if any
power2 <- data.frame(na.omit(power))

# Create the date time variable as suggested and assign relevant format
dt = paste(power2$Date, power2$Time)
dt2 = strptime(dt, "%d/%m/%Y %H:%M:%S")

# Plot 2, labelling
png(file = "<Correct pathname to be added>plot2.png")

plot(dt2, as.numeric(as.character(power2$Global_active_power)), 
     type="l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()