###Data types
#Vectors
a<-c(1,2,5.3,6,-2,4) #numeric vector
b<-c("one","two","three") #character vector
c<-c(T,T,T,F,T,F) #logical vector

#refer to elements of a vector using subscripts
a[c(2,4)] #2nd and 4th elements of a vector


#Matrices
#The general format is: 
# mymatrix<-matrix(vector,nrow=r,ncol=c,byrow=F,
#           dimnames=list(char_vector_rownames,char_vector_colnames))
#byrow=T indicates that the matrix should be filled by rows
#byrow=F indicates that the matrix should be filled by columns (default)
#dimnames provides optional labels for the columns and rows

#generates 5 x 4 numeric matrix
y<-matrix(1:20,nrow=5,ncol=4)
#another example
cells<-c(1,26,24,68)
rnames<-c("R1","R2")
cnames<-c("C1","C2")
mymatrix<-matrix(cells,nrow=2,ncol = 2, byrow = T,dimnames = list(rnames, cnames))

#identify rows, columns, or elements using subscripts
y[,4] #4th column of matrix
y[3,] #3rd row of matrix
y[2:4,1:3] #rows 2,3,4 of columns 1,2,3

#arrays are similar to matrices but can have more than two dimensions

#data frames: more general than a matrix. different columns can have different modes
d<-c(1,2,3,4)
e<-c("red","white","red",NA)
f<-c(T,T,T,F)
mynewdata<-data.frame(d,e,f)
names(mynewdata)<-c("ID","Color","Passed")  #variable names

#there are a variety of ways to identify the elements of a data frame
mynewdata[2:3] #columns 3,4,5 of data frame
mynewdata[c("ID","Color")] #columns ID and Age from data frame
mynewdata$Passed #variable passed in the data frame

###lists
#example of a list with 4 components
#a string, a numeric vector, a matrix, and a scalar
w<-list(name="Fred",mynumbers=a,mymatrix=y,age=5.3)

#example of a list containing two lists
v<-c(list1,list2)

w[[2]] #2nd component of the list
w[["mynumbers"]] #component named mynumbers in list

#Factors
#variable gender with 20 male entries and 30 female entries
gender<-c(rep("male",20),rep("female",30))
gender<-factor(gender)
#stores gender as 20 1s and 30 2s and associates
#1=female, 2=male internally (alphabetically)
#R now treats gender as a nominal variable
summary(gender)

#variable rating coded as large, medium, small
rating<-c("large","medium","small")
rating<-ordered(rating)
#recodes rating to 1,2,3 and associates
#1=large, 2=medium, 3=small internally
#R now treats rating as ordinal

#useful functions
length(object) #number of elements or components
str(object)    #structure of an object
class(object)  #class or type of an object
names(object)  #names
c(object,object,...)   #combines objects into a vector
cbind(object,object,...)   #combine objects as columns
rbind(object,object,...)   #combine objects as rows

object #prints the object
ls() #list current objects
rm(object) #delete an object

newobject <-edit(object) #edit copy and save as newobject
fix(object)  #edit in place




###Importing data
#first row contains variable names, comma is separator. assign the variable id to row names
mycsv<-read.table("C:/Users/okoFM/Documents/R/Datasets/mycsv.csv",
                   header=T,sep=";")

#read in the first worksheet from the workbook mysheet.xlsx
#first row contains variable names
install.packages('xlsx',repos='http://cran.r-project.org')
install.packages('rJava',repos='http://cran.r-project.org')
library(xlsx)
myxlsx<-read.xlsx("C:/Users/okoFM/Documents/R/Datasets/myxlsx.xlsx",1)
#this actually does not work. i need to download another Java version 
#(that what I get from reading online)

#for loading stata do-files, see DataManagement.R script

###keyboard input
#create a data frame from scratch
age<-c(25,30,56)
gender<-c("male","female","male")
weight<-c(160,110,220)
mydata<-data.frame(age,gender,weight)

#enter data using editor
mydata<-data.frame(age=numeric(0),gender=character(0),weight=numeric(0))
mydata<-edit(mydata)
#note that without the assignment in the line above, the edits are not saved

###Access to Database Management Systems (DBMS)
odbcConnect(dsn,uid="", pwd="") #open a connection to an odbc database
sqlFetch(channel,sqltable) #read a table from an odbc database into a data frame
sqlQuery(channel,query) #submit a query to an ODBC database and return the results
sqlSave(channel,mydf,tablename=sqtable,append=FALSE)   #write or update (append=True) a data frame to a table in the ODBC database
sqlDrop(channel,sqltable)  #remove a table from the ODBC database
close(channel) #close the connection

#RODBC Example
#import 2 tables (Crime and Punishment) from a DBMS
#into R data frames (and call them crimedat and pundat)
install.packages('RODBC',repos='http://cran.r-project.org')
library(RODBC)
myconn<-odbcConnect("mydsn",uid="Rob",pwd="aardvark")
crimedat<-sqlFetch(myconn,"Crime")
pundat<-sqlQuery(myconn,"select * from Punishment")
close(myconn)

#the RMySQL package provides an interface to MySQL.

###Exporting Data
#to a tab delimited text file
write.table(mydata,"C:/Users/okoFM/Documents/R/Datasets/mydata.txt",sep="\t")

#to an excel spreadsheet
library(xlsx)
getwd()
setwd("C:/Users/okoFM/Documents/R/Datasets/")
write.xlsx(mydata, "mydata2.xlsx")

#to stata
library(foreign)
write.dta(mydata,"mydata.dta")

###getting information on a dataset

#list objects in the working environment
ls()
#list the variables in mydata
names(mydata)
#list the structure of mydata
str(mydata)
#list levels of factor age in mydata
levels(mydata$age)
levels(mydata$gender)
#dimensions of an object
dim(mydata)
#class of an object (numeric, matrix, data frame, etc.)
class(mydata)
#print mydata
mydata
#print first row of mydata
head(mydata,n=1)
#print last row of mydata
tail(mydata,n=1)

###Variable labels
install.packages('Hmisc',repos='http://cran.r-project.org')
library(Hmisc)
label(mydata$age)<- "Age of the individual"
describe(mydata)

###Value labels

#variable id is coded 25 and 23. we want to attach value labels 25=red, 23=blue
mydata$ID<-factor(mydata$ID,levels=c(25,23),labels = c("red","blue"))

#variable id is coded 1,2,3,4. we attach labels 
mynewdata$ID2<-ordered(mynewdata$ID,levels=c(1,2,3,4),labels=c("Low","Medium-Low","Medium-High" ,"High"))

###Missing data

#Testing for missing values
z<-c(1,2,3,4,9,99,NA)
is.na(z)

#recode 4 to missing for variable ID
#select rows where ID is 99 and recode column ID
mynewdata$ID[mynewdata$ID==4]<-NA

#excluding missing data from analyses
mean(z) #returns NA
mean(z, na.rm = T)

#the function complete.cases() returns a logical vector indicating which cases are complete
#list rows of data that have missing values
mynewdata[!complete.cases(mynewdata),]

#the function na.omit() returns the object with listwise deletion of missing values
#create new dataset without missing data
mynewdata<-na.omit(mynewdata)

#Date Values
Sys.Date()  #returns today's date
date()      #returns the current date and time

#use as.Date() to convert strings to dates
mydates<-as.Date(c("2007-06-22","2004-02-13"))
#number of days between the two dates
days<-mydates[1]-mydates[2]

#convert date info in format 'mm/dd/yyyy'
strDates <- c("01/05/1965", "08/16/1975")
dates <- as.Date(strDates, "%m/%d/%Y")

#You can convert dates to character data using the as.Character() function
#convert dates to character data
strDates<-as.character(dates)






