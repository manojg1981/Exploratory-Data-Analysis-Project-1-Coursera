
zipfilename <- "exdata%2Fdata%2FNEI_data.zip"

if (! (file.exists("summarySCC_PM25.rds") | file.exists("Source_Classification_Code.rds") ) )
{
        unzip(zipfilename)
}


NEI <- readRDS("summarySCC_PM25.rds")


SCC <- readRDS("Source_Classification_Code.rds")


subsetNEI  <- NEI[NEI$fips=="24510", ]

aggByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

barplot(height=aggByYear$Emissions, names.arg=aggByYear$year, xlab="Years"
        , ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' for Baltimore City, for various years'))
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()