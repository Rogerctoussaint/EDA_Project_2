
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

balt_car <- NEI[(NEI$fips == "24510") & (NEI$type == "ON-ROAD"),]
balt_car_emiss <- aggregate(Emissions ~ year, data = balt_car, FUN = sum)

png("plot5.png", width = 480, height = 480)
ggplot(balt_car_emiss, aes(x=factor(year), y=Emissions, label=round(Emissions,2), fill=year)) +
    geom_col() +
    xlab("Year") +
    ylab(expression('PM'[2.5]*' (tons)')) +
    ggtitle("Baltimore City - Motor Vehicle Emisions") +
    theme(plot.title = element_text(hjust = 0.5))
dev.off()