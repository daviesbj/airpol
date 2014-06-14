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
baltiLosAngVeh <- NEI[(NEI$fips=='24510'|NEI$fips=='06037')&is.element(NEI$SCC,vehTypes$SCC),]
library('reshape2')
baltiLaMelt <- melt (baltiLosAngVeh, id.vars = c("type", "year", "fips", "SCC", "Pollutant"), value.name = "Emissions")
fipsYear <- dcast (baltiLaMelt, fips+year ~ variable, fun.aggregate = sum)

## Make the plot
library('ggplot2')
g<-ggplot(fipsYear,aes(year,Emissions))
g +
  geom_bar(stat='identity') +
  facet_grid( . ~ fips ) +
  scale_y_log10(breaks = c(10,100,1000)) + ylab('Emissions -- Log Scale') +
  ggtitle("LA & Baltimore Vehicle Emissions")
ggsave (filename = 'plot6.png' )
