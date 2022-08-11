# Loading the file.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "e_data.zip")
unzip("e_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#2. Using the base plotting system to show total emissions from PM2.5 in the Baltimore City, Maryland from 1999 to 2008?.
baltimore <- subset(NEI, fips == "24510")
baltimore_annual <- aggregate(Emissions~year, baltimore, sum)

png("plot2.png")
with(baltimore_annual,
     plot(x = year,
          y = Emissions,
          ylab = "Baltimore City Annual Emissions [Tons]", 
          xlab = "Year",
          main = "Total Annual Emissions in Baltimore City, Maryland by Year",
          pch = 16,
          col = "red",
          cex = 3
     ))
dev.off()