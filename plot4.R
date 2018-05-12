
file <- "EPA_EMISSIONS.zip"

if(!file.exists(file))
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = file)

if(!file.exists("summarySCC_PM25.rds"))
    unzip(file)

if(!exists("NEI"))
    NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
    SCC <- readRDS("Source_Classification_Code.rds")

coal_emiss <- subset(NEI, type = 'coal')
coal_emiss <- aggregate(Emissions ~ year, )