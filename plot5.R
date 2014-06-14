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
vehTypes <- SCC[grepl('veh',SCC$EI.Sector,ignore.case=TRUE),]
baltiVeh <- NEI[NEI$fips=='24510'&is.element(NEI$SCC,vehTypes$SCC),]
baltiVehYearTotals <- as.data.frame(rowsum (baltiVeh$Emissions, baltiVeh$year, reorder = TRUE))

## Make the plot
png ('plot5.png')
barplot (baltiVehYearTotals$V1, names.arg = row.names(baltiVehYearTotals), main = "Baltimore Annual Vehicle PM25 Pollution" )
dev.off()
