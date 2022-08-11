# Loading the file.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "e_data.zip")
unzip("e_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#2. Using the base plotting system to show total emissions from PM2.5 in the Baltimore City, Maryland from 1999 to 2008?.
SCC.sub <- SCC[grepl("Coal", SCC$Short.Name), ]
NEI.sub <- subset(NEI,
                  NEI$SCC %in% SCC.sub$SCC)

emissions_coal <- aggregate(Emissions~year, NEI.sub, sum)

png("plot4.png",width=580, height=480)
with(emissions_coal, 
     plot(x = year, 
          y = Emissions, 
          ylab = "Annual Emissions [Tons]", 
          xlab = "Year",
          main = "Total Annual Emissions in the US by Year",
          pch = 16,
          col = "green",
          cex = 2
     )) 
dev.off()