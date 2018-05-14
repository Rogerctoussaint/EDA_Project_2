file <- "EPA_EMISSIONS.zip"

if(!file.exists(file))
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = file)

if(!file.exists("summarySCC_PM25.rds"))
    unzip(file)

if(!exists("NEI"))
    NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
    SCC <- readRDS("Source_Classification_Code.rds")


png("plot1.png", width = 480, height = 480)
total_emissions <- aggregate(Emissions/1000 ~ year, data = NEI, FUN = sum)
barplot(height = total_emissions$Emissions, names.arg = total_emissions$year, xlab = "Year", ylab = expression('PM'[2.5]*' (kilotons)'), 
        main = expression('Total PM'[2.5]*' Emissions, All Sources'))
dev.off()