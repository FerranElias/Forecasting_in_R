#average method
meanf(ausbeer)  #the forecasts of all future values are equal to the mean of the historical data

#naive method
naive(ausbeer)  #all forecast are simply set to be the value of the last observation
rwf(ausbeer)  #same as above

#seasonal naive method
snaive(ausbeer)   #sets each forecast to be equal to the last observed value from the same season of the preceeding year

#drift method
rwf(ausbeer, drift=TRUE)  #a variation on the naive method is to allow the forecasts to increase or decrease over time, 
#where the amount of change over time (called the drift) is set to be the average change seen in the historical data. This is
#equivalent to drawing a line between the first and last observation, and extrapolating it into the future

beer2 <- window(ausbeer,start=1992,end=2006-0.1)
beerfit1 <- meanf(beer2,h=11)
beerfit2 <- naive(beer2,h=11)
beerfit3 <- snaive(beer2, h=11)

plot(beerfit1, plot.conf= FALSE, main="Forecast for quarterly beer production")
lines(beerfit2$mean,col=2)
lines(beerfit3$mean,col=3)
legend("topright",lty=1,col=c(4,2,3), legend=c("Mean method", "Naive method", "Seasonal naive method"))

dj2 <- window(dj,end=250)
plot(dj2,main="Dow Jones Index (daily ending 15 Jul 94", ylab="", xlab="Day", xlim=c(2,290))
lines(meanf(dj2,h=42)$mean,col=4)
lines(rwf(dj2,h=42)$mean,col=2)
lines(rwf(dj2,drift=TRUE,h=42)$mean, col=3)
legend("topleft",lty=1,col=c(4,2,3),legend=c("Mean method","Naive method","Drift method"))
