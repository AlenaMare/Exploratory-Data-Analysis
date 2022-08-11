# Loading the file.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "e_data.zip")
unzip("e_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#2. Using the base plotting system to show total emissions from PM2.5 in the Baltimore City, Maryland from 1999 to 2008?.
vehicle.scc<- SCC[grepl("[Vv]eh", SCC$Short.Name), ]

emissions.veh.balt <- NEI %>%
  subset(fips == "24510" & NEI$SCC %in% vehicle.scc$SCC)

baltimore_veh_annual <- aggregate(Emissions~year, emissions.veh.balt, sum)

png("plot5.png",width=650, height=480)
with(baltimore_veh_annual,
     plot(x = year,
          y = Emissions,
          ylab = "Annual Emissions [Tons]",
          xlab = "Year",
          main = "Total Annual Emissions from motor vehicle sources in Baltimore City, Maryland by Year",
          pch = 16,
          cex = 2
     ))
dev.off()