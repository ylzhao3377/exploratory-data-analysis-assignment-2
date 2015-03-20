library(ggplot2)
setwd('~/')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## build the data set for plotting
## subset the data set by fips=24510
subNEI <- subset(NEI,fips == "24510")
## calculate the sum for each type and each year
## subNEI is the final used data set
sumEmis <- rep(0,2096)
for(i in 1:2096){
  sumEmis[i] <- sum(subNEI$Emissions[which(subNEI$year==subNEI$year[i] & subNEI$type==subNEI$type[i])])  
}
subNEI <- data.frame(subNEI,sumEmis)

## Use ggplot and export the plot
png(filename = "plot3.png",width = 480, height = 480)
plot3 <- ggplot(subNEI,aes(year,sumEmis,col=type))+geom_point()+
  geom_line()+scale_x_continuous(name='Year',breaks=c(1999,2002,2005,2008))+
  scale_y_continuous(name='Total Emissions of Each Year (ton)')+
  ggtitle('PM2.5 Emissions for Baltimore City')
plot3
dev.off()
