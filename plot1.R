setwd('~/')
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

plot1 <- function(){
  ## Build the data set used for plotting
  ## calculate the sum for each year
  attach(NEI)
  Mytotal <- matrix(0,4,2,dimnames=list(NULL,c('year','CityEmis')))
  for(i in 1:4){
  temp <- unique(year)[i]
  Mytotal[i,1] <- temp
  Mytotal[i,2] <- sum(Emissions[which(year == temp)])
  }
  
  ## plot
  opar <- par()
  par(bg = 'cornsilk',cex=0.75)
  plot(Mytotal[,1],Mytotal[,2],type='p',pch=20,xlab='Year',
     ylab='Total Emissions',xaxt='n',yaxt='n',)
  axis(side=1,Mytotal[,1],labels=TRUE)
  axis(side=2,seq(3e+06,8e+06,1e+06),labels=TRUE)
  lines(Mytotal[,1],Mytotal[,2],lty=2,lwd=2,col='red')
  title('PM2.5 Total Emissoins',font.main = 3, adj=1)
}

## export the plot
png(filename = "plot1.png",width = 480, height = 480)
plot1()
dev.off()



