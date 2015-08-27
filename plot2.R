library(dplyr)
#NEI <- readRDS("summarySCC_PM25.rds")
#NEI <- transform(NEI,year=factor(year),type=factor(type))
NEI_Baltimore <- subset(NEI,fips=="24510")
#png(file="plot2.png",width=480,height=600)

NEI_Baltimore <- group_by(select(NEI_Baltimore,Emissions,year),year)
sumBalt <- summarise_each(NEI_Baltimore,funs(sum))
barplot(sumBalt$Emissions,names.arg=sumBalt$year,ylab="Emissions",
        main="Total PM2.5 Emissions in different years in Baltimore")

# par(mfrow=c(2,1),mar=c(4,5,4,1))
# boxplot(Emissions~year,NEI_Baltimore,xlab="",ylab="Emissions",
#         main="Emissions in Baltimore WITH outliers",cex=.8)
# 
# boxplot(Emissions~year,NEI_Baltimore,xlab="",ylab="Emissions",
#         main="Emissions in Baltimore WITHOUT outliers",cex=.8,outline = FALSE)
# 
# dev.off()


