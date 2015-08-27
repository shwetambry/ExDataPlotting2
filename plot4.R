library(dplyr)
#NEI <- readRDS("summarySCC_PM25.rds")
classCode <- readRDS("Source_Classification_Code.rds")
NEI <- transform(NEI,year=factor(year),type=factor(type))
index <- grep("Coal",classCode$EI.Sector)
SCCcoal <- classCode$SCC[index]
ind <- grep(paste(SCCcoal,collapse="|"),NEI$SCC)
coalData <- NEI[ind,]
coalData_Emissions <- select(coalData,Emissions,year)
coalData_Emissions <-group_by(coalData_Emissions,year)
sumUS <- summarise_each(coalData_Emissions,funs(sum)) 
#png(file="plot4.png")
barplot(sumUS$Emissions, names.arg=sumUS$year,ylab="Emissions",
        main="Emissions from coal combustion sources over the years")
#dev.off()

