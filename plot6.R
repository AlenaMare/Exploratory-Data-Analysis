# Loading the file.
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "e_data.zip")
unzip("e_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#2. Using the base plotting system to show total emissions from PM2.5 in the Baltimore City, Maryland from 1999 to 2008?.
install.packages("ggplot2")
library(ggplot2)

vehicle.scc<- SCC[grepl("[Vv]eh", SCC$Short.Name), ]

emissions.vehicle <- NEI %>%
  filter(fips %in% c("24510", "06037") & NEI$SCC %in% vehicle.scc$SCC) %>%
  group_by(year, fips) %>%
  summarize(total_emissions = sum(Emissions))

emissions.vehicle$county_name <- factor(emissions.vehicle$fips, levels=c("06037", "24510"), labels=c("Los Angeles County", "Baltimore City")) 

png("plot6.png",width=650, height=480)
plot6 <- qplot(year, total_emissions, data = emissions.vehicle, color = county_name)
plot6 + geom_point(size = 3) + geom_line() +
  xlab("Year") +
  ylab("Total Emissions [Tons]") +
  ggtitle("Baltimore and LA Emissions [2.5] from motor vehicle sources from 1999 to 2008")
dev.off()