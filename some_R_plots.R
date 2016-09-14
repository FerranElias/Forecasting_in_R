
#time plots
plot(melsyd[,"Economy.Class"], main="Economy class passengers: Melbourne-Sidney", xlab="Year", ylab="Thousands")

plot(a10, ylab="$ million", xlab="Year", main="Antidiabetic drug sales")

#seasonal plots
seasonplot(a10,ylab="$ million", xlab="Year", main="Seasonal plot: antidiabetic drug sales", year.labels=TRUE,
           year.labels.left=TRUE, col=1:20, pch=19)

monthplot(a10,ylab="$ million", xlab="Month", xaxt="n", main="Seasonal deviation plot: antidiabetic drug sales")
axis(1,at=1:12, labels=month.abb,cex=0.8)

#scatterplots
plot(jitter(fuel[,5]), jitter(fuel[,8]), xlab="City mpg", ylab="Carbon footprint")

#scatterplot matrices
pairs(fuel[,-c(1:2,4,7)], pch=19)
