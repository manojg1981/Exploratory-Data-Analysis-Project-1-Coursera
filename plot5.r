
library(ggplot2)

zipfilename <- "exdata%2Fdata%2FNEI_data.zip"

if (! (file.exists("summarySCC_PM25.rds") | file.exists("Source_Classification_Code.rds") ) )
{
        unzip(zipfilename)
}


NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

png("plot5.png", width=840, height=480)
ggp <- ggplot(aggByYear, aes(factor(year), Emissions))
ggp <- ggp + geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from motor vehicle (ON-ROAD) in Baltimore & Maryland (fips = "24510") from 1999 to 2008')
print(ggp)
dev.off()