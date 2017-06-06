
library(ggplot2)

zipfilename <- "exdata%2Fdata%2FNEI_data.zip"

if (! (file.exists("summarySCC_PM25.rds") | file.exists("Source_Classification_Code.rds") ) )
{
        unzip(zipfilename)
}


NEI <- readRDS("summarySCC_PM25.rds")

SCC <- readRDS("Source_Classification_Code.rds")

NEISCC <- merge(NEI, SCC, by="SCC")

coaldata  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coaldata, ]

aggByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)



png("plot4.png", width=640, height=480)
ggp <- ggplot(aggByYear, aes(factor(year), Emissions))
ggp <- ggp + geom_bar(stat="identity") +
        xlab("Year") +
        ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions from coal Year 1999 to 2008')
print(ggp)
dev.off()