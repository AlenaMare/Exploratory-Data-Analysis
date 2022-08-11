# Loading the file.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "e_data.zip")
unzip("e_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#2. Using the base plotting system to show total emissions from PM2.5 in the Baltimore City, Maryland from 1999 to 2008?.
install.packages("ggplot2")
library(ggplot2)

baltimore <- subset(NEI, fips == "24510")
baltimore_type_annual <- aggregate(Emissions~year + type, baltimore, sum)

png("plot3.png",width=580, height=480)
plot <- qplot(year, Emissions, data = baltimore_type_annual, facets = .~type, color = type)
plot + geom_line() +
  xlab("Year") +
  ylab("Baltimore City Annual Emissions [Tons]") +
  ggtitle("Total Baltimore Emissions [2.5] by Type from 1999 to 2008")
dev.off()