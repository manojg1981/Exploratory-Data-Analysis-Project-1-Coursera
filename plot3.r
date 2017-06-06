
library(ggplot2)

zipfilename <- "exdata%2Fdata%2FNEI_data.zip"

if (! (file.exists("summarySCC_PM25.rds") | file.exists("Source_Classification_Code.rds") ) )
{
        unzip(zipfilename)
}


NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")


subsetNEI  <- NEI[NEI$fips=="24510", ]

aggByYear <- aggregate(Emissions ~ year + type, subsetNEI, sum)

png("plot3.png",width=480,height=480,units="px")



ggp <- ggplot(aggByYear, aes(year, Emissions, color = type))
ggp <- g + geom_line() +
        xlab("year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions in Baltimore City, Maryland (fips == "24510") from 1999 to 2008')

print(ggp)
dev.off()