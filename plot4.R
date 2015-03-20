## read data
setwd('~/')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")grep('Coal+',SCC$EI.Sector,perl=TRUE,value=FALSE)

## Build the data set used for plotting
## find the SCC for coal sources
sourceCoal <- unique(SCC$EI.Sector[grep('Coal+',SCC$EI.Sector,perl=TRUE,value=FALSE)])
mySCC <- unique(SCC$SCC[which(SCC$EI.Sector==sourceCoal[2])])

## subset the data set by new SCC
## calculate the sum of each year
subNEI2 <- subset(NEI,SCC %in% mySCC)
Mytotal <- matrix(0,4,2)
for(i in 1:4){
  temp <- unique(subNEI2$year)[i]
  Mytotal[i,1] <- temp
  Mytotal[i,2] <- sum(subNEI2$Emissions[which(subNEI2$year == temp)])
}

## Use base plot
png(filename = "plot4.png",width = 480, height = 480)
opar <- par()
par(bg = 'cornsilk',cex=0.75)
plot(Mytotal[,1],Mytotal[,2],type='p',pch=20,xlab='Year',
     ylab='Total Emissions',xaxt='n',yaxt='n',)
axis(side=1,Mytotal[,1],labels=TRUE)
axis(side=2,seq(20000,70000,5000),labels=TRUE)
lines(Mytotal[,1],Mytotal[,2],lty=2,lwd=2,col='red')
title('Coal combustion-related Emissions',font.main = 3, adj=1)
dev.off()

