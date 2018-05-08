
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
balt_emissions <- aggregate(Emissions ~ year, data = baltimore, FUN = sum)

png("plot2.png", width = 480, height = 480)
barplot(height = balt_emissions$Emissions, names.arg = balt_emissions$year, xlab = "Year", ylab = expression('PM'[2.5]*' (tons)'), 
        main = expression('Baltimore City, MD PM'[2.5]*' Emissions, All Sources'))
dev.off()