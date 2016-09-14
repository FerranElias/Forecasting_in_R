getwd()
setwd("C:/Users/okoFM/Documents/R/Graphs/")

#Creating a graph
attach(mtcars)
plot(wt,mpg)
abline(lm(mpg~wt))
title("Regression of MPG on Weight")
pdf("mygraph.pdf")
png("mygraph.png")

#Histograms and density plots
hist(mtcars$mpg)
hist(mtcars$mpg, breaks=12, col="red")

#add a normal curve
x<-mtcars$mpg
h<-hist(x,breaks=10,col="red",xlab="Miles Per Gallon",
        main="Histogram with Normal Curve")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean = mean(x),sd=sd(x))
yfit<-yfit*diff(h$mids[1:2])*length(x)
lines(xfit,yfit,col="blue",lwd=2)

#kernel density plots
d<-density(mtcars$mpg) #returns the density data
plot(d)

#filled density plot
d<-density(mtcars$mpg)
plot(d,main="Kernel Density of Miles Per Gallon")
polygon(d,col="red",border="blue")

#Comparing groups via kernel density
#compare mpg distributions for cars with 4, 6, or 8 cylinders
install.packages('sm',repos='http://cran.r-project.org')
library(sm)
attach(mtcars)

#create value labels
cyl.f<-factor(cyl,levels=c(4,6,8),
              labels=c("4 cylinder","6 cylinder","8 cylinder"))

#plot densities
sm.density.compare(mpg,cyl,xlab="Miles Per Gallon")
title(main="MPG Distribution by Car Cylinders")

#add legend via mouse click
colfill<-c(2:(2+length(levels(cyl.f))))
legend(locator(1),levels(cyl.f),fill=colfill)

#Dot plots
#Simple Dotplot
dotchart(mtcars$mpg,labels = row.names(mtcars),cex = .7,
         main="Gas Milage for Car Models",
         xlab="Miles Per Gallon")

#Dotplot: grouped sorted and colored
#sort by mpg, group and color by cylinder
x<-mtcars[order(mtcars$mpg),] #sort by mpg
x$cyl<-factor(x$cyl) #it must be a factor
x$color[x$cyl==4]<-"red"
x$color[x$cyl==6]<-"blue"
x$color[x$cyl==8]<-"darkgreen"
dotchart(x$mpg,labels=row.names(x),cex=.7,groups=x$cyl,
         main="Gas Milage for Car Models\ngrouped by cylinder",
         xlab="Miles Per Gallon",gcolor="black", color=x$color)


#Simple Bar Plot
counts<-table(mtcars$gear)
barplot(counts,main="Car Distribution",xlab="Number of Gears")

#Simple Horizontal Bar Plot with Added Labels
counts<-table(mtcars$gear)
barplot(counts,main="Car Distribution",horiz="T",
        names.arg = c("3 Gears", "4 Gears", "5 Gears"))

#Stacked bar plot with colors and legend
counts<-table(mtcars$vs,mtcars$gear)
barplot(counts,main="Car Distribution by Gears and VS",
        xlab="Number of Gears",col=c("darkblue","red"),
        legend=rownames(counts))

#Grouped Bar Plot
counts<-table(mtcars$vs,mtcars$gear)
barplot(counts,main="Car Distribution by Gears and VS",
        xlab="Number of Gears",col=c("darkblue","red"),
        legend=rownames(counts),beside=T)

#Line charts
x<-c(1:5); y<-x #create some data
par(pch=22,col="red")
par(mfrow=c(2,4)) #all plots on one page
opts=c("p","l","o","b","c","s","S","h")
for(i in 1:length(opts)){
  heading=paste("type=",opts[i])
  plot(x,y,type='n',main=heading)
  lines(x,y,type=opts[i])
}

#Next, we demonstrate each of the type= options when plot( ) sets up the graph and does plot the points.
x <- c(1:5); y <- x # create some data
par(pch=22, col="blue") # plotting symbol and color 
par(mfrow=c(2,4)) # all plots on one page 
opts = c("p","l","o","b","c","s","S","h") 
for(i in 1:length(opts)){ 
  heading = paste("type=",opts[i]) 
  plot(x, y, main=heading) 
  lines(x, y, type=opts[i]) 
}

#Create Line Chart
#Convert factor to numeric for convenience
Orange$Tree<-as.numeric(Orange$Tree)
ntrees<-max(Orange$Tree)

#get the range for the x and y axis
xrange<-range(Orange$age)
yrange<-range(Orange$circumference)

#set up the plot 
plot(xrange,yrange,type="n",xlab="Age (days)",
     ylab="Circumference (mm)")
colors<-rainbow(ntrees)
linetype<-c(1:ntrees)
plotchar<-seq(18,18+ntrees,1)

##add lines
for (i in 1:ntrees){
  tree<-subset(Orange,Tree==i)
  lines(tree$age,tree$circumference,type="b",lwd=1.5,
        lty=linetype[i],col=colors[i],pch=plotchar[i])
}


# add a title and subtitle 
title("Tree Growth", "example of line plot")

# add a legend 
legend(xrange[1], yrange[2], 1:ntrees, cex=0.8, col=colors,
       pch=plotchar, lty=linetype, title="Tree")

#Simple pie chart
slices<-c(10,12,4,16,8)
lbls<-c("US","UK","Australia","Germany","France")
pie(slices,labels = lbls,main="Pie Chart of Countries")

# Pie Chart with Percentages
slices <- c(10, 12, 4, 16, 8) 
lbls <- c("US", "UK", "Australia", "Germany", "France")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels 
lbls <- paste(lbls,"%",sep="") # ad % to labels 
pie(slices,labels = lbls, col=rainbow(length(lbls)),
    main="Pie Chart of Countries")

# 3D Exploded Pie Chart
install.packages('plotrix',repos = 'http://cran.r-project.org')
library(plotrix)
slices <- c(10, 12, 4, 16, 8) 
lbls <- c("US", "UK", "Australia", "Germany", "France")
pie3D(slices,labels=lbls,explode=0.1,
      main="Pie Chart of Countries ")

# Pie Chart from data frame with Appended Sample Sizes
mytable <- table(iris$Species)
lbls <- paste(names(mytable), "\n", mytable, sep="")
pie(mytable, labels = lbls, 
    main="Pie Chart of Species\n (with sample sizes)")

#boxplots of mpg by car cylinders
boxplot(mpg~cyl,data=mtcars,main="Car Milage Data",
        xlab="Number of Cylinders",ylab="Miles Per Gallon")

# Notched Boxplot of Tooth Growth Against 2 Crossed Factors
# boxes colored for ease of interpretation 
boxplot(len~supp*dose, data=ToothGrowth, notch=TRUE, 
        col=(c("gold","darkgreen")),
        main="Tooth Growth", xlab="Suppliment and Dose")

# Violin Plots
install.packages('vioplot',repos = 'http://cran.r-project.org')
library(vioplot)
x1 <- mtcars$mpg[mtcars$cyl==4]
x2 <- mtcars$mpg[mtcars$cyl==6]
x3 <- mtcars$mpg[mtcars$cyl==8]
vioplot(x1, x2, x3, names=c("4 cyl", "6 cyl", "8 cyl"), 
        col="gold")
title("Violin Plots of Miles Per Gallon")

# Example of a Bagplot
install.packages('aplpack',repos = 'http://cran.r-project.org')
library(aplpack)
attach(mtcars)
bagplot(wt,mpg, xlab="Car Weight", ylab="Miles Per Gallon",
        main="Bagplot Example")

#Scatterplot
attach(mtcars)
plot(wt,mpg,main="Scatterplot Example",xlab="Car Weight",
     ylab="Miles Per Gallon",pch=19)

#add fit lines
abline(lm(mpg~wt),col="red") #regression line
lines(lowess(wt,mpg),col="blue") #lowess line

# Enhanced Scatterplot of MPG vs. Weight 
# by Number of Car Cylinders 
install.packages('car',repos = 'http://cran.r-project.org')
library(car) 
scatterplot(mpg ~ wt | cyl, data=mtcars, 
            xlab="Weight of Car", ylab="Miles Per Gallon", 
            main="Enhanced Scatter Plot", 
            labels=row.names(mtcars))

scatterplot(mpg ~ wt , data=mtcars, 
            xlab="Weight of Car", ylab="Miles Per Gallon", 
            main="Enhanced Scatter Plot", 
            labels=row.names(mtcars))

# Basic Scatterplot Matrix
pairs(~mpg+disp+drat+wt,data=mtcars, 
      main="Simple Scatterplot Matrix")

# Scatterplot Matrices from the lattice Package 
install.packages('lattice',repos = 'http://cran.r-project.org')
library(lattice)
splom(mtcars[c(1,3,5,6)], groups=cyl, data=mtcars,
      panel=panel.superpose, 
      key=list(title="Three Cylinder Options",
               columns=3,
               points=list(pch=super.sym$pch[1:3],
                           col=super.sym$col[1:3]),
               text=list(c("4 Cylinder","6 Cylinder","8 Cylinder"))))

# Scatterplot Matrices from the car Package
library(car)
scatterplot.matrix(~mpg+disp+drat+wt|cyl, data=mtcars,
                   main="Three Cylinder Options")

# Scatterplot Matrices from the glus Package 
install.packages('gclus',repos = 'http://cran.r-project.org')
library(gclus)
dta <- mtcars[c(1,3,5,6)] # get data 
dta.r <- abs(cor(dta)) # get correlations
dta.col <- dmat.color(dta.r) # get colors
# reorder variables so those with highest correlation
# are closest to the diagonal
dta.o <- order.single(dta.r) 
cpairs(dta, dta.o, panel.colors=dta.col, gap=.5,
       main="Variables Ordered and Colored by Correlation" )

# High Density Scatterplot with Binning
install.packages('hexbin',repos = 'http://cran.r-project.org')
library(hexbin)
x <- rnorm(1000)
y <- rnorm(1000)
bin<-hexbin(x, y, xbins = 50) 
plot(bin, main="Hexagonal Binning")

# High Density Scatterplot with Color Transparency 
pdf("scatterplot.pdf") 
x <- rnorm(1000)
y <- rnorm(1000) 
plot(x,y, main="PDF Scatterplot Example", col=rgb(0,100,0,50,maxColorValue=255), pch=16)
dev.off()

# 3D Scatterplot
install.packages('scatterplot3d',repos = 'http://cran.r-project.org')
library(scatterplot3d)
attach(mtcars)
scatterplot3d(wt,disp,mpg, main="3D Scatterplot")

# 3D Scatterplot with Coloring and Vertical Drop Lines
library(scatterplot3d) 
attach(mtcars) 
scatterplot3d(wt,disp,mpg, pch=16, highlight.3d=TRUE,
              type="h", main="3D Scatterplot")

# 3D Scatterplot with Coloring and Vertical Lines
# and Regression Plane 
library(scatterplot3d) 
attach(mtcars) 
s3d <-scatterplot3d(wt,disp,mpg, pch=16, highlight.3d=TRUE,
                    type="h", main="3D Scatterplot")
fit <- lm(mpg ~ wt+disp) 
s3d$plane3d(fit)

# Spinning 3d Scatterplot
install.packages('rgl',repos = 'http://cran.r-project.org')
library(rgl)
plot3d(wt, disp, mpg, col="red", size=3)

# Another Spinning 3d Scatterplot
install.packages('Rcmdr',repos = 'http://cran.r-project.org')
library(Rcmdr)
attach(mtcars)
scatter3d(wt, disp, mpg)










