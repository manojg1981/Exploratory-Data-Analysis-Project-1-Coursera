
library(ggplot2)

zipfilename <- "exdata%2Fdata%2FNEI_data.zip"

if (! (file.exists("summarySCC_PM25.rds") | file.exists("Source_Classification_Code.rds") ) )
{
        unzip(zipfilename)
}


NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

aggByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggByYearAndFips$fips[aggByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggByYearAndFips$fips[aggByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
ggp <- ggplot(aggByYearAndFips, aes(factor(year), Emissions))
ggp <- ggp + facet_grid(. ~ fips)
ggp <- ggp + geom_bar(stat="identity")  +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from motor vehicle (ON-ROAD) in Baltimore , MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
print(ggp)
dev.off()