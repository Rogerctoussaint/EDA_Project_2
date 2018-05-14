
require(ggplot2)
require(dplyr)

file <- "EPA_EMISSIONS.zip"

if(!file.exists(file))
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = file)

if(!file.exists("summarySCC_PM25.rds"))
    unzip(file)

if(!exists("NEI"))
    NEI <- readRDS("summarySCC_PM25.rds")
if(!exists("SCC"))
    SCC <- readRDS("Source_Classification_Code.rds")


coal_emiss_rows <- grep("Fuel Comb.*Coal", SCC$EI.Sector)
coal_emiss <- SCC[coal_emiss_rows,]
coal_data <- merge(NEI, coal_emiss, by = "SCC")

png("plot4.png", width = 480, height = 480)
g <- ggplot(coal_data, aes(x = factor(year), y = Emissions/1000, label = round(Emissions/1000, 2), fill = year))
g + geom_col() +
    xlab("Year") + 
    ylab(expression('PM'[2.5]*' (kilotons)')) +
    ggtitle("Countrywide Emissions from Coal Combustion-Related Sources") + 
    theme(plot.title = element_text(hjust = 0.5))
dev.off()

