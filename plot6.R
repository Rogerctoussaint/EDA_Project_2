
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

car_data <- NEI[((NEI$fips == "06037") | (NEI$fips == "24510")) & (NEI$type == "ON-ROAD"),]
car_emiss <- aggregate(Emissions ~ year + fips, data = car_data, FUN = sum)
car_emiss$fips <- factor(car_emiss$fips)
levels(car_emiss$fips) <- c("Los Angeles", "Baltimore City")

png("plot6.png", width = 960, height = 480)
ggplot(car_emiss, aes(x=factor(year), y=Emissions, fill = year)) +
    facet_grid(. ~ fips) +
    geom_col() +
    xlab("Year") + 
    ylab(expression('PM'[2.5]*' (tons)')) +
    ggtitle("Los Angeles vs. Baltimore City - Motor Vehicle Emisions") +
    theme(plot.title = element_text(hjust = 0.5))
dev.off()
