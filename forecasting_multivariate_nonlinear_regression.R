Cityp <- pmax(fuel$City-25,0)
fit2 <- lm(Carbon~City+Cityp,data=fuel)
x <- 15:50
z <- pmax(x-25,0)
fcast2 <- forecast(fit2, newdata=data.frame(City=x,Cityp=z))
plot(jitter(Carbon)~jitter(City), data=fuel)
lines(x,fcast2$mean,col="red")

#example of a cubic regression spline
fit3 <- lm(Carbon~City+I(City^2)+I(City^3)+I(Cityp^3), data=fuel)
fcast3 <- forecast(fit3,newdata=data.frame(City=x,Cityp=z))
plot(jitter(Carbon)~jitter(City), data=fuel)
lines(x, fcast3$mean, col="red")
