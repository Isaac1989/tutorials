#Atomic vectors
vec<-c(1,2,3,4,5)
vec

#integer vectors: attach 'L'
vec_int<-c(1L,2L,3L,4L)
vec_int

#create logicals 
vec_logical<-c(T,TRUE,F,FALSE)
vec_logical

#character vectors
vec_str=c("Isaac","Oduro","Math","machine","learning")
vec_str

# R builtin-in functions for creating vectors

rep_vec<- rep(c(3,4,5),times=4)      #repeats it's first arg
rep_vec


#creating a sequence of numbers

vec_num<-seq(1,12,by=2)
vec_num

# OR

vec_num<-1:12
vec_num

#Combining different seequences
vect<-c(seq(1,12),rep(2,5))
vect


#Vector are atomic R objects and thus represents only one type of objects
#Coercion hierarchy: Character-> numeric->integer->booleans
class(c('a',rep(3,4)))
class(c(rep(3,4),T))


#view variable in global namespace
ls()

#creating custom environment
envB<-new.env()

# Assigning a variable to this a custom environment
assign('y',rep(1,5), envir = envB)

ls(envB)

#Alternative means of assigning a variable into a new variable
envB$num<-1:5

ls(envB)

#find the structure of a variable
str(vect)
str(envB$num)

#  Mathematical operations with numeric and integer vectors
vec_num*2



#  HETROGENEOUS DATA TYPES: list and data frames

slist<-list(rep(c(3,2),3),'str')
slist
slist[[1]]
names(slist)<-c('seqt','char')
slist[['char']]

slist[['msg']]<-'Pleas call me when you get this'

slist

slist[['msg']]

c(slist,c(1,3,4))    # an atomic vector containing a list coerces the vector into 
                      # a list

# covert a vector into a list using : as.list(vector)
as.list(seq(1,3))


#storing information about R object using the "attr()" function
attr(slist,'info')<-"This a list of random items"

str(slist)

class(slist)

# Factors: Handy for organising categorical data
dat<-c("sick","healthy","sick",'healthy')
dat<-factor(dat)
dat
levels(dat)
class(levels(dat))

as.numeric(dat)   #numeric representation of "dat"

# Adding a level to a factor object
dat<-factor(dat,levels=c(levels(dat),'not_sick'))
dat
dat[4]<-'not_sick'
dat
as.numeric(dat)


# Multidimensional arrays
cordinates<-array(1:16,dim=c(4,5,3))
cordinates
cordinates[,,1]    # First dimension
cordinates[,,2]    # Second dimension
cordinates[,,3]    # Third dimension

cordinates
cordinates[1,2,2]
cordinates[1,,]

#Creating a matrix
Mat<-matrix(1:12, nrow=3)
Mat
dim(Mat)<-c(4,3)     # changing the dimension of matrix
Mat

dim(Mat)
nrow(Mat)
ncol(Mat)
names(Mat)<-c('a','b','c')   #assigns attribute to matrix
Mat
attr(Mat,'names')           #access attribute value
names(Mat)<-NULL            #unname the matrix 'Mat'
Mat



# Creating a matrix using rbind and cbind
x<-seq(1,4)
y<-seq(5,8)
cbind(x,y)
rbind(x,y)

length(Mat)

# name the columns of matrix

colnames(Mat)<-c('a','b','c')
Mat

# Transpose matrix
t(Mat)

library(abind)
x<-array(x,dim=4)
x
aperm(x)    #transpose an array

#column and row vectors
x<-seq(1,4)
y<-seq(5,8)
x<-matrix(x,nrow=1)   #row vector
y<-matrix(y,ncol=1)  #col vector

#creating a data frame from a matrix
Mat.df<-as.data.frame(Mat)
Mat.df

#adding a column to the data frame
name<-c('Isaac','Sarah','Moha','Kate')
Mat.df<-cbind(Mat.df,name)

Mat.df     #CAVEAT:  R always passes categorical variable as FACTORS
            # to avoid it set the arg stringAsFactor=FALSE

# Using transform() to set a row or col as a particular data type
new.Mat.df<-transform(Mat.df, name=as.character(name))
class(new.Mat.df$name)

## ploting 

par(mfrow=c(1,2))
curve(expr = sin(x), from = 0, to = 4*pi)
curve(expr = x^3 +1,from =0 , to=25)

Dat<-read.csv('E:\\Downloads\\DATA\\AnimalData.csv')
head(Dat)
str(Dat)

plot(Dat$Age.Intake,Dat$Weight)
boxplot(Dat$Age.Intake)
barplot(prop.table(table(Dat$Aggressive)))

# the apply function
Mat<-matrix(1:12,nrow = 4)
Mat
# row =1 
# col=2
apply(Mat,1,mean)
apply(Mat,2,mean)

#apply a function to every element in matrix
apply(Mat,c(1,2),function(x) x^2)

