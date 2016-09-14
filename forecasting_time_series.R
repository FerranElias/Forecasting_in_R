fit.ex3 <- tslm(consumption ~ income , data=usconsumption)
plot(usconsumption, ylab="% change in consumption and income", plot.type="single", col=1:2, xlab="Year")
legend("topright",legend=c("Consumption", "Income"),lty=1,col=c(1,2), cex=0.9)
plot(consumption~income, data=usconsumption,ylab="% change in consumption", xlab="% change in income")
abline(fit.ex3)
summary(fit.ex3)

#scenario based forecasting. how much would consumption change given 1% increase and decrease in income
fcast <- forecast(fit.ex3, newdata=data.frame(income=c(-1,1)))
plot(fcast, ylab="% change in consumption", xlab="% change in income")

#linear trend example
fit.ex4 <- tslm(austa ~ trend)
f <- forecast(fit.ex4, h=5, level=c(80,95))
plot(f,ylab="International tourist arrivals to Australia (millions)", xlab="t")
lines(fitted(fit.ex4),col="blue")
summary(fit.ex4)

#residual autocorrelation: with time series it is highly likely that the value of a variable observed in the current
#time period will be influenced by its value in the previous period. The forecasts from a model with autocorrelated errors
#are still unbiased, but they will usually have larger prediction intervals than they need to
par(mfrow=c(2,2))
res3 <- ts(resid(fit.ex3), s=1970.25, f=4)
plot.ts(res3,ylab="res (Consumption)")
abline(0,0)
Acf(res3)
res4 <- resid(fit.ex4)
plot(res4,ylab="res (Tourism)")
abline(0,0)
Acf(res4)
