### Read data
setwd('~/')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Set up the data set used for plotting
## find the SCC for Vehicles sources
attach(NEI)
temp = grep('Vehicles+',SCC$EI.Sector,perl=TRUE,value=FALSE)
Vehicles <- unique(SCC$EI.Sector[temp])
mySCC <- unique(SCC$SCC[which(SCC$EI.Sector %in% Vehicles)])

## subset NEI by the new SCC with Vehicles sources and fips=25410 or fips=06037
## myNEI is the final data set which is used by plotting 
myNEI <- subset(NEI,SCC %in% mySCC)
myNEI <- subset(myNEI,fips == "06037"|fips == "24510")
sumEmis <- rep(0,2099)
for(i in 1:2099){
  sumEmis[i] <- sum(myNEI$Emissions[which(myNEI$year==myNEI$year[i] & myNEI$fips==myNEI$fips[i])])
}
myNEI <- data.frame(myNEI,sumEmis)
for(i in 1:2099){
  if(myNEI$fips[i]==24510)
    myNEI$fips[i] <- 'Baltimore City'
  else
    myNEI$fips[i] <- 'Los Angeles County' 
}

### Use ggplot2
png(filename = "plot6.png",width = 480, height = 480)
plot6 <- ggplot(myNEI,aes(year,sumEmis,col=fips))+geom_point()+
  geom_line()+scale_x_continuous(name='Year',breaks=c(1999,2002,2005,2008))+
  scale_y_continuous(name='Total Emissions of Each Year (ton)')+
  ggtitle('PM2.5 Emissions for Baltimore City and Los Angeles County')
plot6
dev.off()
