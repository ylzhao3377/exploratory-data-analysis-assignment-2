###Read data
setwd('~/')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## build the data set which can be used by plotting
attach(NEI)
temp = grep('Vehicles+',SCC$EI.Sector,perl=TRUE,value=FALSE)

## find the SCC for vehicles sources
Vehicles <- unique(SCC$EI.Sector[temp])
mySCC <- unique(SCC$SCC[which(SCC$EI.Sector %in% Vehicles)])

## subset the data set by the new SCC and fips=24510
## Mytotal is the final matrix used by plotting
myNEI <- subset(NEI,SCC %in% mySCC &fips == "24510")
Mytotal <- matrix(0,4,2)
for(i in 1:4){
  temp <- unique(year)[i]
  Mytotal[i,1] <- temp
  Mytotal[i,2] <- sum(myNEI$Emissions[which(myNEI$year == temp)])
}

## Use Base to plot
png(filename = "plot5.png",width = 480, height = 480)
par(bg = 'cornsilk',cex=0.75)
plot(Mytotal[,1],Mytotal[,2],type='p',pch=20,xlab='Year',
     ylab='Total Emissions (ton)',xaxt='n',yaxt='n')
axis(side=1,Mytotal[,1],labels=TRUE)
axis(side=2,seq(50,350,50),labels=TRUE)
lines(Mytotal[,1],Mytotal[,2],lty=2,lwd=2,col='red')
title('Motor Vehicle Sources Emissions',font.main = 3, adj=1)
dev.off()

