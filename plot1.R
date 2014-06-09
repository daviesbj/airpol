## Download data
download.file ('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip', method = 'curl', destfile = 'NEI_data.zip')
unzip ('NEI_data.zip')

NEI <- readRDS ("summarySCC_PM25.rds")

## Turn factorable things into factors
NEI <- transform (NEI,
                  fips=factor(fips),
                  SCC=factor(SCC),
                  Pollutant=as.factor(Pollutant),
                  type=as.factor(type),
                  year=as.factor(year))

SCC <- readRDS("Source_Classification_Code.rds")

## Statistical summary part
yearTotals <- as.data.frame(rowsum (NEI$Emissions, NEI$year, reorder = TRUE))

## Make the plot!
png('plot1.png')
barplot (yearTotals$V1, names.arg = row.names(yearTotals), main = "Annual PM25 Pollution Totals" )
dev.off()

