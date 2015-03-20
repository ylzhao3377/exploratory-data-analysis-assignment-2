### Read data
setwd('~/')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Build the data set which can be used for plotting
### Mytotal is the final matrix used for plotting, the fips=24510
attach(NEI)
Mytotal <- matrix(0,4,2,dimnames=list(NULL,c('year','CityEmis')))
for(i in 1:4){
  temp <- unique(year)[i]
  Mytotal[i,1] <- temp
  Mytotal[i,2] <- sum(Emissions[which(year == temp & fips == "24510")])
}

### Use Base to plot
png(filename = "plot2.png",width = 480, height = 480)
opar <- par()
par(bg = 'cornsilk',cex=0.75)
plot(Mytotal[,1],Mytotal[,2],type='p',pch=20,xlab='Year',
     ylab='Baltimore City Emissions',xaxt='n',yaxt='n',)
axis(side=1,Mytotal[,1],labels=TRUE)
axis(side=2,seq(500,5000,500),labels=TRUE)
lines(Mytotal[,1],Mytotal[,2],lty=2,lwd=2,col='red')
title('Baltimore City PM2.5 Emissoins',font.main = 3, adj=1)
par <- opar
dev.off()

