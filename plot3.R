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
library ("reshape2")
baltiMelt <- melt (baltiNEI, id.vars = c("type", "year", "fips", "SCC", "Pollutant"), value.name = "Emissions")
baltiYearType <- dcast (baltiMelt, type+year ~ variable, fun.aggregate = sum)

## Make the plot
library('ggplot2')
g<-ggplot(baltiYearType,aes(year,Emissions))
g+geom_bar(stat='identity') + facet_grid( . ~ type )
ggsave (filename = 'plot3.png' )

