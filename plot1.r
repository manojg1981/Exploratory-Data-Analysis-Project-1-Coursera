
zipfilename <- "exdata%2Fdata%2FNEI_data.zip"

if (! (file.exists("summarySCC_PM25.rds") | file.exists("Source_Classification_Code.rds") ) )
{
        unzip(zipfilename)
}


NEI <- readRDS("summarySCC_PM25.rds")


SCC <- readRDS("Source_Classification_Code.rds")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

aggByYear <- aggregate(Emissions ~ year, NEI, sum)

barplot(height=aggByYear$Emissions, names.arg=aggByYear$year, xlab="Years"
        , ylab=expression('total PM2.5 emission'),main=expression('Total PM2.5 emissions for various years in US'))
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()