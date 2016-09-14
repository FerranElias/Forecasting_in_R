#get means for variables in data frame mydata excluding missing values
y<-matrix(1:20,nrow=5,ncol=4)
ydata<-data.frame(y)
sapply(ydata,mean,na.rm=T)
summary(ydata)

#tukey min, lower-hinge, median, upper-hinge, max
fivenum(y)

library(Hmisc)
describe(ydata)

install.packages('pastecs',repos='http://cran.r-project.org')
library(pastecs)
stat.desc(ydata)

install.packages('psych',repos='http://cran.r-project.org')
library(psych)
describe.by(ydata,1)
describeBy(ydata,1)

install.packages('doBy',repos='http://cran.r-project.org')
library(doBy)
summaryBy(mpg + wt ~ cyl + vs, data = mtcars, 
          FUN = function(x) { c(m = mean(x), s = sd(x)) } )
# produces mpg.m wt.m mpg.s wt.s for each 
# combination of the levels of cyl and vs

#Generating frequency tables
attach(ydata)
mytable<-table(X1,X2) #X1 will be rows and X2 will be columns
mytable #print table

margin.table(mytable,1) # x1 frequencies (summed over x2)
margin.table(mytable,2) # x2 frequencies (summed over x1)

prop.table(mytable) #cell percentages
prop.table(mytable,1) #row percentages
prop.table(mytable,2) #column percentages

#3-Way Frequency Table
mytable<-table(X1,X2,X3)
ftable(mytable)

# 2-Way Cross Tabulation
install.packages('gmodels',repos='http://cran.r-project.org')
library(gmodels)
CrossTable(ydata$X2, ydata$X1)















