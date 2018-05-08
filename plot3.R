require(ggplot2)

file <- "EPA_EMISSIONS.zip"

if(!file.exists(file))
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = file)

if(!file.exists("summarySCC_PM25.rds"))
    unzip(file)

if(!exists("NEI"))
    NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
    SCC <- readRDS("Source_Classification_Code.rds")

baltimore <- subset(NEI, fips == "24510")
balt_emissions <- aggregate(Emissions ~ year + type, data = baltimore, FUN = sum)

g <- ggplot(balt_emissions, aes(year, Emissions, col = type))
g <- g + geom_line() + 
         xlab("Year") + 
         ylab(expression('PM'[2.5]*' (tons)')) + 
         ggtitle(expression('Baltimore City, MD PM'[2.5]*' Emissions by Type'))

png("plot3.png", width = 480, height = 480)
print(g)
dev.off()