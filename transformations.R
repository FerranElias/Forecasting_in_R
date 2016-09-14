#if the data show variation that increases or decreases with the level of the series, then a transformation can be useful
#for example, a logarithmic transformation is often useful because they are interpretable: changes in a log value are 
#relative (or percentage) changes on the original scale. so if log base 10 is used, then an increase of 1 on the log scale
#corresponds to a multiplication of 10 on the original scale

plot(elec, ylab="Transformed electricity demand",xlab="Year", main="Transformed monthly electricity demand")

plot(log(elec), ylab="Transformed electricity demand",xlab="Year", main="Transformed monthly electricity demand")
title(main="Log",line=-1)

#a useful family of transformations that includes logarithms and power transformations is the family of "Box-Cox transformations",
#a good value of lambda is one which makes the size of the seasonal variation about the same across the whole series, as that
#makes the forecasting model simpler

#the BoxCox.lambda() function will choose a value of lambda for you
lambda <- BoxCox.lambda(elec)
plot(BoxCox(elec,lambda))

#calendar adjustments
monthdays <- rep(c(31,28,31,30,31,30,31,31,30,31,30,31),14)
monthdays[26 + (4*12)*(0:2)] <- 29
par(mfrow=c(2,1))
plot(milk,main="Monthly milk production per cow",ylab="Pounds",xlab="Years")
plot(milk/monthdays,main="Average milk production per cow per day",ylab="Pounds",xlab="Years")  #the seasonal pattern is much simpler
#in the average daily production plot compared to the average monthly production. by looking at average daily production
#we remove the variation due to the different month lengths
