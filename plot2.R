## Coursera EDA, Course Project 2
## Data reading parts are common to all plot*.R files
## BEFORE USING: setwd('/directory/containing/dataset')
## Expecting the files summarySCC_PM25.rds and Source_Classification_Code.rds

# Read main dataset
NEI <- readRDS ("summarySCC_PM25.rds")

# Turn factorable things into factors
NEI <- transform (NEI,
                  fips=factor(fips),
                  SCC=factor(SCC),
                  Pollutant=as.factor(Pollutant),
                  type=as.factor(type),
                  year=as.factor(year))

# Read Source Classification Codes
SCC <- readRDS("Source_Classification_Code.rds")

## END of common part

## Statistical summary of data
baltiNEI <- NEI[NEI$fips=='24510',]
baltiYearTotals <- as.data.frame(rowsum (baltiNEI$Emissions, baltiNEI$year, reorder = TRUE))

## Make the plot
png('plot2.png')
barplot (baltiYearTotals$V1, names.arg = row.names(baltiYearTotals), main = "Baltimore Annual PM25 Pollution Totals" )
dev.off()

