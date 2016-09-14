# Type family examples - creating new mappings 
plot(1:10,1:10,type="n")
windowsFonts(
  A=windowsFont("Arial Black"),
  B=windowsFont("Bookman Old Style"),
  C=windowsFont("Comic Sans MS"),
  D=windowsFont("Symbol")
)
text(3,3,"Hello World Default")
text(4,4,family="A","Hello World from Arial Black")
text(5,5,family="B","Hello World from Bookman Old Style")
text(6,6,family="C","Hello World from Comic Sans MS")
text(7,7,family="D", "Hello World from Symbol")

# A Silly Axis Example

# specify the data 
x <- c(1:10); y <- x; z <- 10/x

# create extra margin room on the right for an axis 
par(mar=c(5, 4, 4, 8) + 0.1)

# plot x vs. y 
plot(x, y,type="b", pch=21, col="red", 
     yaxt="n", lty=3, xlab="", ylab="")

# add x vs. 1/x 
lines(x, z, type="b", pch=22, col="blue", lty=2)

# draw an axis on the left 
axis(2, at=x,labels=x, col.axis="red", las=2)

# draw an axis on the right, with smaller text and ticks 
axis(4, at=z,labels=round(z,digits=2),
     col.axis="blue", las=2, cex.axis=0.7, tck=-.01)

# add a title for the right axis 
mtext("y=1/x", side=4, line=3, cex.lab=1,las=2, col="blue")

# add a main title and bottom and left axis labels 
title("An Example of Creative Axes", xlab="X values",
      ylab="Y=X")

#Combining Plots
# 4 figures arranged in 2 rows and 2 columns
attach(mtcars)
par(mfrow=c(2,2))
plot(wt,mpg, main="Scatterplot of wt vs. mpg")
plot(wt,disp, main="Scatterplot of wt vs disp")
hist(wt, main="Histogram of wt")
boxplot(wt, main="Boxplot of wt")

attach(mtcars)
par(mfrow=c(3,1)) 
hist(wt)
hist(mpg)
hist(disp)

# One figure in row 1 and two figures in row 2
attach(mtcars)
layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
hist(wt)
hist(mpg)
hist(disp)

# One figure in row 1 and two figures in row 2
# row 1 is 1/3 the height of row 2
# column 2 is 1/4 the width of the column 1 
attach(mtcars)
layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE), 
       widths=c(3,1), heights=c(1,2))
hist(wt)
hist(mpg)
hist(disp)

# Add boxplots to a scatterplot
par(fig=c(0,0.8,0,0.8), new=TRUE)
plot(mtcars$wt, mtcars$mpg, xlab="Car Weight",
     ylab="Miles Per Gallon")
par(fig=c(0,0.8,0.55,1), new=TRUE)
boxplot(mtcars$wt, horizontal=TRUE, axes=FALSE)
par(fig=c(0.65,1,0,0.8),new=TRUE)
boxplot(mtcars$mpg, axes=FALSE)
mtext("Enhanced Scatterplot", side=3, outer=TRUE, line=-3)

# Lattice Examples 
library(lattice) 
attach(mtcars)

# create factors with value labels 
gear.f<-factor(gear,levels=c(3,4,5),
               labels=c("3gears","4gears","5gears")) 
cyl.f <-factor(cyl,levels=c(4,6,8),
               labels=c("4cyl","6cyl","8cyl")) 

# kernel density plot 
densityplot(~mpg, 
            main="Density Plot", 
            xlab="Miles per Gallon")

# kernel density plots by factor level 
densityplot(~mpg|cyl.f, 
            main="Density Plot by Number of Cylinders",
            xlab="Miles per Gallon")

# kernel density plots by factor level (alternate layout) 
densityplot(~mpg|cyl.f, 
            main="Density Plot by Numer of Cylinders",
            xlab="Miles per Gallon", 
            layout=c(1,3))

# boxplots for each combination of two factors 
bwplot(cyl.f~mpg|gear.f,
       ylab="Cylinders", xlab="Miles per Gallon", 
       main="Mileage by Cylinders and Gears", )
       layout=(c(1,3))
       
# scatterplots for each combination of two factors 
xyplot(mpg~wt|cyl.f*gear.f, 
main="Scatterplots by Cylinders and Gears", 
ylab="Miles per Gallon", xlab="Car Weight")
       
# 3d scatterplot by factor level 
cloud(mpg~wt*qsec|cyl.f, 
main="3D Scatterplot by Cylinders") 
       
# dotplot for each combination of two factors 
dotplot(cyl.f~mpg|gear.f, 
main="Dotplot Plot by Number of Gears and Cylinders",
xlab="Miles Per Gallon")
       
# scatterplot matrix 
splom

# Customized Lattice Example
library(lattice)
panel.smoother <- function(x, y) {
  panel.xyplot(x, y) # show points 
  panel.loess(x, y)  # show smoothed line 
}
attach(mtcars)
hp <- cut(hp,3) # divide horse power into three bands 
xyplot(mpg~wt|hp, scales=list(cex=.8, col="red"),
       panel=panel.smoother,
       xlab="Weight", ylab="Miles per Gallon", 
       main="MGP vs Weight by Horse Power")

# ggplot2 examples
library(ggplot2) 

# create factors with value labels 
mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5),
                      labels=c("3gears","4gears","5gears")) 
mtcars$am <- factor(mtcars$am,levels=c(0,1),
                    labels=c("Automatic","Manual")) 
mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8),
                     labels=c("4cyl","6cyl","8cyl")) 

# Kernel density plots for mpg
# grouped by number of gears (indicated by color)
qplot(mpg, data=mtcars, geom="density", fill=gear, alpha=I(.5), 
      main="Distribution of Gas Milage", xlab="Miles Per Gallon", 
      ylab="Density")

# Scatterplot of mpg vs. hp for each combination of gears and cylinders
# in each facet, transmittion type is represented by shape and color
qplot(hp, mpg, data=mtcars, shape=am, color=am, 
      facets=gear~cyl, size=I(3),
      xlab="Horsepower", ylab="Miles per Gallon") 

# Separate regressions of mpg on weight for each number of cylinders
qplot(wt, mpg, data=mtcars, geom=c("point", "smooth"), 
      method="lm", formula=y~x, color=cyl, 
      main="Regression of MPG on Weight", 
      xlab="Weight", ylab="Miles per Gallon")

# Boxplots of mpg by number of gears 
# observations (points) are overlayed and jittered
qplot(gear, mpg, data=mtcars, geom=c("boxplot", "jitter"), 
      fill=gear, main="Mileage by Gear Number",
      xlab="", ylab="Miles per Gallon")

#customizing ggplot2 graphs
p <- qplot(hp, mpg, data=mtcars, shape=am, color=am, 
           facets=gear~cyl, main="Scatterplots of MPG vs. Horsepower",
           xlab="Horsepower", ylab="Miles per Gallon")

# White background and black grid lines
p + theme_bw()

# Large brown bold italics labels
# and legend placed at top of plot
p + theme(axis.title=element_text(face="bold.italic", 
                                  size="12", color="brown"), legend.position="top")

#Probability Plots
# Display the Student's t distributions with various
# degrees of freedom and compare to the normal distribution

x <- seq(-4, 4, length=100)
hx <- dnorm(x)

degf <- c(1, 3, 8, 30)
colors <- c("red", "blue", "darkgreen", "gold", "black")
labels <- c("df=1", "df=3", "df=8", "df=30", "normal")

plot(x, hx, type="l", lty=2, xlab="x value",
     ylab="Density", main="Comparison of t Distributions")

for (i in 1:4){
  lines(x, dt(x,degf[i]), lwd=2, col=colors[i])
}

legend("topright", inset=.05, title="Distributions",
       labels, lwd=2, lty=c(1, 1, 1, 1, 2), col=colors)

# Children's IQ scores are normally distributed with a
# mean of 100 and a standard deviation of 15. What
# proportion of children are expected to have an IQ between
# 80 and 120?

mean=100; sd=15
lb=80; ub=120

x <- seq(-4,4,length=100)*sd + mean
hx <- dnorm(x,mean,sd)

plot(x, hx, type="n", xlab="IQ Values", ylab="",
     main="Normal Distribution", axes=FALSE)

i <- x >= lb & x <= ub
lines(x, hx)
polygon(c(lb,x[i],ub), c(0,hx[i],0), col="red") 

area <- pnorm(ub, mean, sd) - pnorm(lb, mean, sd)
result <- paste("P(",lb,"< IQ <",ub,") =",
                signif(area, digits=3))
mtext(result,3)
axis(1, at=seq(40, 160, 20), pos=0)

# Q-Q plots
par(mfrow=c(1,2))

# create sample data 
x <- rt(100, df=3)

# normal fit 
qqnorm(x); qqline(x)

# t(3Df) fit 
qqplot(rt(1000,df=3), x, main="t(3) Q-Q Plot", 
       ylab="Sample Quantiles")
abline(0,1)

# Estimate parameters assuming log-Normal distribution 

# create some sample data
x <- rlnorm(100)

# estimate paramters
library(MASS)
fitdistr(x, "lognormal")

# Mosaic Plot Example
install.packages('vcd',repos = 'http://cran.r-project.org')
library(vcd)
mosaic(HairEyeColor, shade=TRUE, legend=TRUE)

# Association Plot Example
library(vcd)
assoc(HairEyeColor, shade=TRUE)

# First Correlogram Example
install.packages('corrgram',repos = 'http://cran.r-project.org')
library(corrgram)
corrgram(mtcars, order=TRUE, lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt,
         main="Car Milage Data in PC2/PC1 Order")

# Second Correlogram Example
library(corrgram)
corrgram(mtcars, order=TRUE, lower.panel=panel.ellipse,
         upper.panel=panel.pts, text.panel=panel.txt,
         diag.panel=panel.minmax, 
         main="Car Milage Data in PC2/PC1 Order")

# Third Correlogram Example
library(corrgram)
corrgram(mtcars, order=NULL, lower.panel=panel.shade,
         upper.panel=NULL, text.panel=panel.txt,
         main="Car Milage Data (unsorted)")

# Changing Colors in a Correlogram
library(corrgram) 
col.corrgram <- function(ncol){   
  colorRampPalette(c("darkgoldenrod4", "burlywood1",
                     "darkkhaki", "darkgreen"))(ncol)} 
corrgram(mtcars, order=TRUE, lower.panel=panel.shade, 
         upper.panel=panel.pie, text.panel=panel.txt, 
         main="Correlogram of Car Mileage Data (PC2/PC1 Order)")