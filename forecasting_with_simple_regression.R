plot(jitter(Carbon)~jitter(City), xlab="City (mpg)", ylab="Carbon footprint (tons per year)",data=fuel)
fit <- lm(Carbon~City,data=fuel)
abline(fit)
summary(fit)

#evaluating the residuals
res <- residuals(fit)
plot(jitter(res)~jitter(City),ylab="Residuals",xlab="City",data=fuel)
abline(0,0)

#forecasting
fitted(fit)[1]
fcast <- forecast(fit,newdata=data.frame(City=30))
plot(fcast,xlab="City (mpg)", ylab="Carbon footprint (tons per year)")

#confidence intervals
confint(fit,level=0.95)

#non-linear functional forms
par(mfrow=c(1,2))
fit2 <- lm(log(Carbon)~log(City), data=fuel)
plot(jitter(Carbon)~jitter(City), xlab="City (mpg)", ylab="Carbon footprint (tonnes per year)", data=fuel)
lines(1:50, exp(fit2$coef[1]+fit2$coef[2]*log(1:50)))
plot(log(jitter(Carbon))~log(jitter(City)),xlab="log City mpg", ylab="log Carbon footprint", data=fuel)
abline(fit2)

res <- residuals(fit2)
plot(jitter(res, amount=.005)~jitter(log(City)),ylab="Residuals", xlab="log(City)", data=fuel)

#the plot shows that the residuals from estimating the log-log model are randomly scatted, while those of the linear
#model were not. the log-log functional form fits the data better