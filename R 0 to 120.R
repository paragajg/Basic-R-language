# creating variables
# A value is assigned to a variable either using <- or =

x <- 1 +2
y <- 2^3
pi
options(digits = 10)
pi

### Data structres in R - has 3 broad types of data structres.
# 1) DataFrames - its a tabular data structure similar to excel tables. 2) Vectors - single column that can have integers , charachters or strings of text data or have decimal values also called as floats

even <- c(2,4,6) #numeric vector
odd  <- even -1
odd
length(even)
names <- c("jane","john","doe","jack")
# class and mode provide type of data the variable or R object stores
class(names)
mode(names)

upper_namnes <-  toupper(names)

#create dataframe (collection of vectors similar to rows and colums in excel worksheet)
age <-c(18,23,21,34)
df <- data.frame(names, age)
View(df) # to view the dataframe

# Exploring or slicing the dataframe
df[1,] #to access 1st row
df[,1] # to access 1st column
df[1,2] # specific cell in the data frame
df[2,"age"] # specific cell  in the data frame using column name

nrow(df) # to get no. of rows in the data frame
ncol(df)  # to get no. of columns in the data frame
df$age # to access age column
names(df)  # to display column names
names(df)[2] # to display a specic coumn name i.e  age

help(rep)
# or
?seq
example(rep)


#Set working directory of the project.
setwd("H:\\Analytics_Decision Science\\R Working dir") # if working on windos os
setwd(choose.dir()) #  to select the directory
getwd()
list.files()[4] # to select a specific file from a directory

data <- read.csv(<file path or url>) # specify file path inside commas - "C:User\R_data"
data <- read.csv(choose.files(),sep =",",header= T) # user to select the path
write.csv(df, <filepath>) #export data

#install packages and load in R. 
#Package is a collection of scripts written by global contributors to do a specific task such as building machine learning model or cleaning of data. Purpose of installing a package is that the user can directly call the set of scripts written in package called as functions to carryout the task. This avoids the user to rewrite several lines of codes to do the task.

install.packages("gdata") # a package to install inbuilt datasets in R for practise
library(gdata)

#head() prints first 6 observations by default
head(df,2)
tail(df,2)

#character strings - playing with strings of text :)
string <-c("The f-ox jum-ps, 'test-test'")
strstring <- sub("-","", string) # will remmove it only once i.e. the first occurrence
string <- gsub("-", "",string) # does global sustitution but only on vectors not on dataframes

df$names_age <- paste(df$names,df$age,sep=" ") #concatenate columns
df

greetings <-c("Hi","how are you","you")
greetings1 <- paste(greetings,collapse= ",")
string1 <- gsub(",", "",greetings1) # removing ","
View(greetings1)

grep("you", greetings) # gives index of the word searched in the vector
pattern <- grep("you", greetings,value =T) # gives pattern of the word found
View(pattern)
grepl("you",greetings) # to find  logical output (i.e. T or F) a specific word in each element of vector


## Feel free to explore stringr package which has nice set of functions to do text manipulation.
install.packages("stringr")
library(stringr)

# exercie load data set iris. Remove records
data <- anscombe # anscombe is an inbuilt R dataset
View(data)
d <- data[,grep("y",names(data))] # an example to extract all the columns containing on "y" in their names
View(d)

a <-  iris # A famous dataset used for practising
iris[139:145,c(1,3,5)]
#to get all records with sepal.width >3.0
iris[iris[,"Sepal.Width"]>3.0,]
subset(iris, Sepal.Width>3.0)
subset(iris, Sepal.Width>3.0 & Sepal.Width < 4.0 )
log <- iris[,"Sepal.Width"]>3.0
log
iris[log,]

#descriptive statistics in R
# mean,, median, quantile,  sd, var
mean(df$age)
median(df$age)
var(df$age)
sd(df$age)
summary(df$age)
quantile(df$age, probs=c(0.9,0.75))

#class conversions 
num_list <- c(1,2,4,3,1,2,4,4,4,1,1,3,3,2,2,4)
num_fac <- factor(num_list)
num_tb <- table(num_list)
num_df <- data.frame(num_tb)
num_df[which.max(num_df$Freq), "num_list"] #  mode of data

#Sort & Order

sort(df$age)
sort(df$age,decreasing = T)
order(df$age) # generating indices of vector for ascending order of data
df[order(df$age),] # sorting data frame pertaining to a specific column

# control structures in R
# for loops - is a control flow statement for specifying iteration, which allows code to be executed repeatedly.
# for loop for printing numbers exactly divisible  by 5 between 1 to 10
for(i in c(1:10)) {
  if(i%%5==0) print(i)
  }


# while loop - is a control flow statement that allows code to be executed repeatedly based on a given Boolean condition. The while loop can be thought of as a repeating if statement.
i <- 0
while (i !=10) {
  print (i); i <-  i+1
  } # use semi colon for writing two different sentences in loops


# merge columns or rows in R( using merge,cbind,rbind)

tab1 <- data.frame(col1=c("a","b","c") , col2=c("1","2","3"))
tab2 <- data.frame(col1=c("a","b","d"), col3 = c("3","4","5"))
tab1
tab2
z <- merge.data.frame(tab1,tab2,by.x="col1",by.y="col1")
z
z <- merge(tab1,tab2,all=T)
z <- merge(tab1,tab2,by="col1",all.x=T)   #left join
z  <- merge(tab1,tab2,by="col1",all.y=T)  #right join

z <- cbind(tab1,tab2)  #works only when both the tables have same no. of columns
z <- rbind(tab1,tab2) #  works only if row names are matching

#  Joining using plyr package
install.packages("plyr")
library(plyr)
z <- rbind.fill(tab1,tab2) # for appending tables having different col names

#tapply and aggregate function
data(mtcars)
mtcars
tapply(mtcars$mpg,mtcars$gear,mean) #will apply mean to mpg grouped by gear factor levels
tapply(mtcars$mpg,mtcars$gear,quantile,probs=0.9)
aggregate(mpg~gear,mtcars,mean) #  creating agggregates similar to excel function of pivoting tables


#write your own function - lines of codes written to carryout a specific task. The name of the function can be called once it is initialized to activate the purpose of the function like - stripping text from a column, removing blank cells, changing valyes in a column.

add.then.multiply <- function(num.1,num.2,num.3){
  x <- num.1 + num.2
  y <- x * num.3
  y
}

add.then.multiply()     #too few arguments
add.then.multiply(2,3,4)  #function call

fix(add.then.multiply)  #To edit the function
add.then.multiply(3,4)

#exercise 
#write a function to remove commas and replace with blank space from a string
string <- c("the,quick,brown,fox,jumps,over,the,lazy,dog")
# function -
mf <- function(x)
  {a <- gsub(",", " ",x) 
   a}
mf(string)

# deal with NA values
class <- data.frame(student=c("bill","chloe","jack","jill") , marks=c(90,83,NA,89))
class
sum(class$marks)
sum(class$marks , na.rm=T)
class[is.na(class$marks)==T,"marks"] <- 50

#rounding of numbers
round(3.1415,digits=2)
floor(3.1415) #  rounding off
ceiling(3.1415) # rounding up

#subsetting a data frame
subset(iris,Sepal.Length>6.0)

#sampling in R
sample(1:6 , 3)  #generates three random numbers from 1 to 6
sample(1:nrow(iris) , 5)   # generates five random indices from iris
iris[sample(1:nrow(iris) , 5),]

#boxplot,histogram,bargraphs and pie charts in R
boxplot(mtcars$mpg)
boxplot(df$age)
boxplot(mpg~cyl,data=mtcars,main="mpg grouped by cyl")

hist(mtcars$mpg,freq=F,breaks=10)

barplot(mtcars$mpg,col=c("red" , "white" , "blue"))


#exercise 
#draw a boxplot of sepal.length grouped by species from iris
library(RColorBrewer)
boxplot(Sepal.Length ~ Species, data = iris,col = brewer.pal(9,"Oranges"))

## Plotting different types of line graphs
x <- c(1:5); y <- x # create some data
par(pch=22, col="blue") # plotting symbol and color 
par(mfrow=c(2,4)) # all plots on one page 
opts = c("p","l","o","b","c","s","S","h") 
for (i in 1:length(opts))
     { 
  heading = paste("type=",opts[i]) 
  plot(x, y, main=heading) 
  lines(x, y, type=opts[i]) 
}

#handling date and time in R

#dates are handled using the as.Date function
dates <- c("12/12/2012" , "03/05/2013")
dates <- as.Date(dates , format="%d/%m/%Y")
dates
dates[2]- dates[1]
#get time difference in days
gsub("\\D+" ,"", dates[2] - dates[1])


#date and time can be handled using chron
dtimes <- c("12/12/2012 23:45:36" , "05/04/2014 12:34:19")
dtparts <- t(as.data.frame(strsplit(dtimes , " ")))
#dtparts1 <- as.data.frame(strsplit(dtimes , " "))
row.names(dtparts) <- NULL
dtparts
library("chron")
times <- chron(dates = dtparts[,1] , times=dtparts[,2] , format=c('d/m/y' ,'h:m:s'))
times[2] - times[1]

#matrices,factors and lists
#create a matrix - is colletion of rows and columns similar to dataframe
mat <- matrix(1:12 , nrow=3,byrow=T)
mat
mat[-2,]
rownames(mat) <- c("first row" , "second row" , "third row")
mat
vec <- c(mean(mat[1,]) , mean(mat[2,]) , mean(mat[3,]))
mat <- cbind(mat,vec)
mat

## Explore some more slicing of data
mtcars
names(mtcars) # prints column names of the matrix or dataframe
mtcars.mat <- as.matrix(mtcars)
apply(mtcars,2,mean)   #calculate mean of each column in the matrix. Apply is a common built in method in R to apply a function on rows or columns of the dataframe. On apply function read page - https://www.r-bloggers.com/using-apply-sapply-lapply-in-r/

prac <- matrix(c(1,2,-3,4,-9,3,-2,-7,7,-5,3,-2) , nrow=4)
prac

#exercise 
#find no. of negative values in each column of prac
apply(prac,2,function(x) length(x[x<0]))
#sapply and lapply
sapply(1:3 , function(x) x^2)     #returns a vector
lapply(1:3 , function(x) sqrt(x))  #returns a list

#list is a generic vector which can be thought as a container having to store different dataframes or vectors
emp_id <- c("a10" ,"a09" ,"a07")
item <- c(1,2)
my_list <- list(emp_id , item)
my_list[[1]]   #use doouble brackets to access individual componenets of a list
my_list[[1]][1]
unlist(my_list)


#factors - Factors are the data objects which are used to categorize the data and store it as levels. They can store both strings and integers. They are useful in the columns which have a limited number of unique values. Like "Male, "Female" and True, False etc. They are useful in data analysis for statistical modeling

x <- c(1,1,2,2,2,3,5,6,2,1)
summary(x)
x <- factor(x)
x
levels(x)
summary(x)

#misc
data(mtcars)
mtcars <- transform(mtcars , mpg=2*mpg)
x <- 1:20
x <-data.frame(x)
x <- transform(x , result= ifelse(x%%2==0,"even" , "odd"))


timestamp <- c("12/06/1994 12:36:45")
vec <- do.call(rbind,strsplit(timestamp , " "))
vec
x <- lapply(mtcars,class)
x
do.call(cbind,x)
install.packages("reshape")
library(reshape)
mydata <- data.frame(id=c(1,1,2,2) , time=c(1,2,1,2) , x1=c(5,3,6,2) , x2=c(6,5,1,4))
mdata <- melt(mydata,id=c("id",  "time"))    #will create a row for each unique id variable combination
time_means <- cast(mdata, time~variable , mean)   

#convert rows into columns
new_mtcars <- t(mtcars)
mean(new_mtcars[,1])

