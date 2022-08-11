# Loading the file.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "e_data.zip")
unzip("e_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#1. Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
total_annual_emissions <- aggregate(Emissions~year, NEI, sum)

png("plot1.png")
with(total_annual_emissions, 
     plot(x = year, 
          y = Emissions, 
          ylab = "Annual Emissions [Tons]", 
          xlab = "Year",
          main = "Total Annual Emissions in the US by Year",
          col = "blue",
          pch = 19,
          cex = 3
     ))
dev.off()