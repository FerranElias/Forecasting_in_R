fuel2 <- fuel[fuel$Litres<2,]
summary(fuel2[,"Carbon"])
sd(fuel2[,"Carbon"])

beer2 <- window(ausbeer, start=1992, end=2006-.1)
lag.plot(beer2, lags=9, do.lines=FALSE)

Acf(beer2)

set.seed(30)
x <- ts(rnorm(50))
plot(x, main="White noise")
Acf(x)
