#Opens a Stata data file. Since Stata files automatically have headers, no need to specify that.

mydata<-read.dta("Y:/okofm/ElectoralRulesJuly2015/dataSTATA/DataExpTaxEmpPC.dta")

#Note that I call the dataset I open "mydata". Thus, I can refer to it by writing its name. For example, next line asks 
# R to give the names of the variables in the dataset.

#Some examples for doing basic computations

mydata$sum<-mydata$Fire+mydata$Police
mydata$mean<-(mydata$Fire+mydata$Police)/2

#In the next example, I attach the data such that I don't have to refer to the dataset every time.
attach(mydata)
mydata$sum<-Fire+Police
mydata$mean<-(Fire+Police)/2
detach(mydata)

#Another way of creating new variables
mydata<-transform(mydata,
sum=Fire+Police,
mean=(Fire+Police)/2
)

#RECODING VARIABLES

#Create 2 categories depending on spending on Fire
mydata$firecat<-ifelse(mydata$Fire>5478000,c("High Spending"),c("Low Spending"))

#another example, create 3 fire spending categories
attach(mydata)
mydata$firecat[Fire>5702000]<-"High Spending"
mydata$firecat[Fire>728600 & Fire<=5702000]<-"Intermediate Spending"
mydata$firecat[Fire<=728600]<-"Low Spending"
detach(mydata)

#RENAMING VARIABLES

install.packages("reshape")
library(reshape)
mydata<-rename(mydata,c(Fire="fire"))

#AN EXAMPLE USING LOGICAL OPERATORS

x<-c(1:10)
x[(x>8)|(x<5)]

#NUMERIC FUNCTIONS

abs(5.78)
sqrt(5.78)
ceiling(5.78)
floor(5.78)
trunc(5.78)
round(5.78,digits=1)
signif(5.78,digits=1)
cos(7.78)
log(5.58)
log10(5.58)
exp(5.58)

#CHARACTER FUNCTIONS

x<-"abcdef"
substr(x,2,4)

grep("A",c("b","A","c","A"),fixed=TRUE) #this function searches for patterns

sub("p","o","Hellp World",ignore.case=FALSE) #Find a pattern and replace it

strsplit("abc","") #splits the elements of character vector
strsplit("abc","b")

paste("Today is", date())
paste("x",1:3,sep="") #concatenate strings after using sep to separate them
paste("x",1:3,sep="M")

toupper(x)
tolower(x)

#STATISTICAL PROBABILITY FUNCTIONS

#Normal density function
x<-pretty(c(-3,3),30)
y<-dnorm(x)
plot(x,y,type='l',xlab="Normal Deviate",ylab="Density",yaxs="i")

pnorm(1.96) #cumulative normal probability

qnorm(.6) #normal quantile. value at the p percentile of normal distribution

x<-rnorm(50,m=50,sd=10) #50 normal deviates with mean m and standard deviation sd

dbinom(0:5,10,.5) #probability of 0 to 5 heads of fair coin out of 10 flips
pbinom(5,10,.5) #probability of 5 or less heads of fair coin out of 10 flips

#Similar statistical probability functions exist for poisson, uniform, etc.

#Other statistical functions
mean(x)
mean(x,trim=.05,na.rm=TRUE) #trimmed mean, removing any missing values and
# 5 percent of highest and lowest scores

sd(x)
median(x)
quantile(x,.3)
range(x)
sum(x)
min(x)
max(x)
scale(x,center=TRUE,scale=TRUE) #column center or standardize a matrix

#Other useful functions
seq(1,10,2) #generate a sequence
indices<-seq(1,10,2)

rep(1:3,2) #repeat x n times

cut(x,5) #divide continuous variable in factor with 5 levels

###CONTROL STRUCTURES

#we will write a function to get the transpose of a matrix
#it's a poor alternative to built-in t() function, but good practice

mytrans<-function(x) {
  if(!is.matrix(x)) {
    warning("argument is not a matrix: returning NA")
    return(NA_real_)
  }
  y<-matrix(1,nrow=ncol(x),ncol=nrow(x))
  for (i in 1:nrow(x)){
    for (j in 1:ncol(x)) {
      y[j,i]<-x[i,j]
    }
  }
  return(y)
}

z<-matrix(1:10,nrow=5,ncol=2)
tz<-mytrans(z)

###USER-WRITTEN FUNCTIONS

#function example -get measures of central tendency and spread for a numeric
#vector x. The user has a choice of measures and whether the results are printed.

mysummary<-function(x,npar=TRUE,print=TRUE){
  if (!npar){
    center <- mean(x); spread<-sd(x)
  } else {
    center <-median(x); spread <-mad(x)
  }
  if (print & !npar){
    cat("Mean=", center, "\n", "SD=", spread, "\n")
  } else if (print & npar){
    cat("Median=", center, "\n", "MAD=", spread, "\n")
  }
  result <- list(center=center,spread=spread)
  return(result)
}

#invoking the function
set.seed(1234)
x<-rpois(500,4)
y<-mysummary(x)

y<-mysummary(x,npar=FALSE,print=FALSE)
y<-mysummary(x,npar=FALSE)


###SORTING DATA
#sorting examples using the mtcars dataset
attach(mtcars)

#sort by mpg
newdata<-mtcars[order(mpg),]

#sort by mpg and cyl
newdata<-mtcars[order(mpg,cyl),]

#sort by mpg (ascending) and cyl (descending)
newdata<-mtcars[order(mpg,-cyl),]

detach(mtcars)

###AGGREGATING DATA
# aggregate data frame mtcars by cyl and vs, returning means for numeric variables
attach(mtcars)
aggdata<-aggregate(mtcars,by=list(cyl,vs),FUN=mean,na.rm=TRUE)
print(aggdata)
detach(mtcars)

###Reshaping data
#Transpose

mtcars
t(mtcars)



###CREATING A DATA FRAME FROM SCRATCH
z<- data.frame(cbind(c(1,1,2,2),c(1,2,1,2),c(5,3,6,2),c(6,5,1,4)))

#change the names of the columns
names(z)<-c("id","time","x1","x2")

#the reshape package

#example of melt function
library(reshape)
mdata<-melt(z,id=c("id","time"))

subjmeans<-cast(mdata,id~variable, mean)
timemeans<-cast(mdata,time~variable,mean)

###SUBSETTING DATA

#selecting (keeping) variables
myvars<-c("state_id","year","fire")
newdata<-mydata[myvars]

#select 1st and 5th thru 10th variables
newdata<-mydata[c(1,5:10)]

#exclude 3rd variable
newdata<-newdata[c(-3)]

#delete variables 
newdata$idchanged <- newdata$typecode <- NULL

####selecting observations
#first 5 observations
smalldata<-mydata[1:5,]

#based on variable values
newdata2<-mydata[which(mydata$year>=1980 & mydata$fire>=5000000),]

#selection using the subset function
newdata3<-subset(mydata, year>=1980 & (fire>=5000000 | fire<4000000),
                 select=state_id:fire)

newdata4<-subset(mydata, year>=1980 & (fire>=5000000 | fire<4000000),
                 select=c(state_id,fire,Police))

###Random samples
#take a random sample of size 50 from a dataset mydata
#sample without replacement
mysample<-mydata[sample(1:nrow(mydata),50,replace=FALSE),]
























