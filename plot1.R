library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
NEI$type <- gsub("NONPOINT","NON-POINT",NEI$type)
NEI <- transform(NEI,year=factor(year),type=factor(type))
#png(file="plot1.png",width=600,height=480)
NEI_US <- group_by(select(NEI,Emissions,year),year)
sumUS <- summarise_each(NEI_US,funs(sum))

###
#tips from peers
# sumUS <- aggregate(NEI$Emissions,list(NEI$year),FUN="sum")
#plot(sumUS,type="l")


###


#df <- tapply(sumUS$Emissions,list(sumUS$type,sumUS$year),sum)
#barplot(df,beside=TRUE,col=c("Red","Blue","Green","Yellow"),xlab="",ylab="Emissions",
#        legend("topright",c("Nonpoint","Non-Road","On-Road","Point"),
#               fill=c("Red","Blue","Green","Yellow")),
#        main="Total PM2.5 Emissions in US from different 
#sources over the years")
#legend=legend("topright",rownames(df),fill=c("Red","Blue","Green","Yellow"))

barplot(sumUS$Emissions,ylab="Emissions",names.arg=sumUS$year,
        main="Total PM2.5 Emissions from all sources in US over the years.")
#dev.off()
# par(mfrow=c(2,1),mar=c(4,5,4,1))
# boxplot(Emissions~year,NEI,xlab="",ylab="Emissions",
#         main="Emissions over the years containing outliers",cex=0.8)
# 
# boxplot(Emissions~year,NEI,xlab="",ylab="Emissions",outline=FALSE,
#         main="Emissions over the years containing NO outliers", cex= 0.8)
#dev.off()
