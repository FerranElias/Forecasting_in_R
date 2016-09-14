
#load data
tute1 <- read.csv("E:/Dropbox/Copenhagen/R/tute1.csv")

#basic commands to take views of the data
head(tute1)
tail(tute1)
tute1[,2]
tute1[,"Sales"]
tute1[5,]
tute1[1:10,3:4]
tute1[1:20,]

#convert the data to time series
tute1 <- ts(tute1[,-1], start=1981, frequency=4)

#construct time series plots of each of the three series
plot(tute1)

seasonplot(tute1[,"Sales"])
seasonplot(tute1[,"AdBudget"])
seasonplot(tute1[,"GDP"])
monthplot(tute1[,"Sales"])
monthplot(tute1[,"AdBudget"])
monthplot(tute1[,"GDP"])

#scatterplots
plot(Sales~AdBudget, data=tute1)
plot(Sales~GDP, data=tute1)

#scatterplot matrix of the three variables
pairs(as.data.frame(tute1))

summary(tute1)

hist(tute1[,"Sales"])
hist(tute1[,"AdBudget"])

boxplot(tute1[,"Sales"])
boxplot(as.data.frame(tute1))

#correlation test
cor.test(tute1[,"Sales"],tute1[,"AdBudget"])










