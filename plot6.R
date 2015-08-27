library(dplyr)
library(ggplot2)
#NEI <- readRDS("summarySCC_PM25.rds")
#NEI <- transform(NEI,year=factor(year),type=factor(type))
#Motor_Balt <- subset(NEI,fips=="24510"&type=="ON-ROAD")
#Motor_LA <- subset(NEI,fips=="06037"&type=="ON-ROAD")
# Motor_Balt_LA <- rbind(Motor_Balt,Motor_LA)

MBLA<- filter(NEI,type=="ON-ROAD" & (fips=="24510"|fips=="06037"))
MBLA$fips <- gsub("24510","Baltimore City",MBLA$fips)
MBLA$fips <- gsub("06037","Los Angeles County",MBLA$fips)

Motor_Balt_LA <- group_by(select(MBLA,Emissions,year,fips),year,fips)
sumMotor <- summarise_each(Motor_Balt_LA,funs(sum))
png(file="plot6.png",width=600, height=480)
# qplot(factor(year),data=sumBalt, geom="bar",fill=type,weight=Emissions,
#       position="dodge",
#       main="Total PM2.5 Emissions in Baltimore from different
#       sources over the years.",xlab=" ", ylab="Emissions")
g<-ggplot(sumMotor,aes(year,Emissions))
p<-g+geom_point(aes(color=fips),size=4) 
p+ labs(x="",y="Emissions")+labs(title="Comparison of PM2.5 Emissions from motor vehicle \n sources in Baltimore and LA over the years.")
#dev.copy(png,file="plot6.png")
dev.off()


