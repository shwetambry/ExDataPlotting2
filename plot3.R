library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
NEI <- transform(NEI,year=factor(year),type=factor(type))
NEI_Baltimore <- subset(NEI,fips=="24510")
NEI_Baltimore <- group_by(select(NEI_Baltimore,Emissions,year,type),year,type)
sumBalt <- summarise_each(NEI_Baltimore,funs(sum))
#png(file="plot3.png",width=600, height=480)
# qplot(factor(year),data=sumBalt, geom="bar",fill=type,weight=Emissions,
#       position="dodge",
#       main="Total PM2.5 Emissions in Baltimore from different
#       sources over the years.",xlab=" ", ylab="Emissions")
g<-ggplot(sumBalt,aes(factor(year),Emissions,fill=type))
p<-g+geom_bar(stat="identity",position="dodge") 
p+ labs(x="")+labs(title="Total PM2.5 Emissions in Baltimore from different sources over the years.")
#dev.copy(png,file="plot3.png")
#dev.off()

###########
#tips from peers
#g<-ggplot(NEI_Baltimore,aes(year,Emissions,color=type))
#g+geom_line(stat="summary",fun.y="sum")

###########


