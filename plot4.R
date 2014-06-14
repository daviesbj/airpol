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
coalTypes <- SCC [grepl ('coal', SCC$Short.Name, ignore.case = TRUE) & grepl ('comb', SCC$Short.Name, ignore.case =TRUE), ]
coalCombNEI <- NEI [is.element (NEI$SCC, coalTypes$SCC), ]
coalCombYearTotals <- as.data.frame (rowsum (coalCombNEI$Emissions, coalCombNEI$year, reorder = TRUE))

## Make the plot
png('plot4.png')
barplot (coalCombYearTotals$V1, names.arg = row.names (coalCombYearTotals), main = "Nationwide Annual Coal Combustion PM25 Totals" )
dev.off()
