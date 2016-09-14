""" a good forecasting method will yield residuals with the following properties:
-the residuals are uncorrelated. if there are correlations between residuals, then there is information left in the residuals
which should be used in computing forecasts
-the residuals have zero mean. if the residuals have a mean other than zero, then the forecasts are biased

in addition to these essential properties, it is useful (but not necessary) for the residuals to also have the 
following two properties:
-the residuals have constant variance
-the residuals are normally distributed
"""

dj2 <- window(dj, end=250)
plot(dj2, main="Dow Jones Index (daily ending 15 Jul 94)", 
     ylab="", xlab="Day")
res <- residuals(naive(dj2))
plot(res,main="Residuals from naive method",ylab="", xlab="Day")
Acf(res,main="ACF of residuals")
hist(res,nclass="FD",main="Histogram of residuals") #the histogram suggests that the residuals may not follow a normal
#distribution. the left tail is a little too long. the rest looks pretty good

#in addition to looking at the ACF plot, we can do a more formal test for autocorrelation by considering a whole set of
#r_k as a group, rather than treat each one separately. when we look at the ACF plot to see if each spike is within the
#required limits, we are implicitly carrying out multiple hypothesis tests, each one with a small probability of giving a false 
#positive. when enough tests are done, it is likely that at least one will give a false positive. in order to overcome
#this problem, we test whether the first h autocorrelations are significantly different from what would be expected from 
#a white noise. the following lines compute two of these tests:
Box.test(res,lag=10,fitdf=0)
Box.test(res,lag=10,fitdf=0,type="Lj")

