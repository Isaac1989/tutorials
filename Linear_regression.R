library(ISLR)
library(MASS)
data(Boston)
#         SIMPLE LINEAR REGRESSION

fix(Boston)
names(Boston)

attach(Boston)

lm.fit=lm(medv~lstat,data=Boston)
lm.fit
#more info
summary(lm.fit)
#attributes
lm.fit$coefficients #or
coef(lm.fit)

#   Residuals
lm.fit$residuals

#confident interval

confint(lm.fit)

#making prediction
pred<-data.frame(lstat=c(2,30,5,43))
predict(lm.fit,pred,interval="confidence")

predict(lm.fit,pred,interval="prediction")

#     Visualizing relationship

plot(lstat,medv,col=3,pch='+')
abline(lm.fit,lwd=4,col=2)

#   Diagnostic plot
dev.off()
par(mfrow=c(2,2))
plot(lm.fit)

#  Alternative diagnostic
plot(predict(lm.fit),residuals(lm.fit))
plot(predict(lm.fit),rstudent(lm.fit))
plot(hatvalues(lm.fit))  #leverage statics

which.max(hatvalues(lm.fit)) 

#             Multilinear Regression
lm.fit=lm(medv~lstat + age, data=Boston)
summary(lm.fit)

# Using all features of the data set

lm.fit<-lm(medv~.,data = Boston)
summary(lm.fit)

# Fit the model without least import feature
lm.fit=lm(medv~.-age,data=Boston)
#   or 
lm.fit1<- update(lm.fit,~.-age)

lm.fit1<-update(lm.fit1, ~. -indus)

# Interaction terms
lm.fit<- lm(medv~lstat*age,data=Boston)
summary(lm.fit)$r.sq


#               NON-LINEAR TRANSFORMATION OF THE PREDICTORS
lm.fit<-lm(medv~lstat + I(lstat^3), data=Boston)
dev.off()
par(mfrow=c(2,2))
plot(lm.fit)
summary(lm.fit)


#   Polynomial regression

poly.fit<-lm(medv~poly(lstat,5),data=Boston)
plot(poly.fit)

#      Running hypothesis testing using anova
anova(lm(medv~lstat,data=Boston),lm.fit)


#    Carseat data set: explore
data(Carseats)
attach(Carseats)
fix(Carseats)
names(Carseats)

lm.fit<-lm(Sales~. +Income:Advertising+Age:Price, data=Carseats)
summary(lm.fit)
names(lm.fit)

lm.fit1<-lm(Sales~.+Income:Advertising,data=Carseats)
summary(lm.fit1)$r.sq

anova(lm.fit,lm.fit1)   #comparing models

#       R tell me the coding used for the dummy variable
contrasts(ShelveLoc)


#======================================================================
#                   Simple regresion onn Auto data set
#======================================================================

data(Auto)
attach(Auto)
lm.fit<-lm(mpg~horsepower, data=Auto)
summary(lm.fit)

df<-data.frame(horsepower=c(98))

predict(lm.fit,df,interval = 'confidence')
predict(lm.fit,df, interval = 'prediction')

#dev.off()
plot(horsepower,mpg,xlab="horsepower",ylab="mpg",main="Scatter plot: horse vs mpg",col=2,pch='*')
abline(lm.fit,col=4,lwd=4)

dev.off()
par(mfrow=c(2,2))
plot(lm.fit)

##                  MULTIPLE REGRESSION ON AUTO DATA SET
dev.off()
png('scatter_Auto.png')
pairs(Auto)
dev.off()

cor(Auto[1:8])

summary(lm(mpg~.-name,data=Auto))
par(mfrow=c(2,2))
plot(lm(mpg~.-name,data=Auto))

#     adding interaction term

summary(lm(mpg ~. -name + displacement:acceleration + cylinders:horsepower,data=Auto))

lm.fit1<-lm(mpg ~. + displacement:acceleration + cylinders:horsepower,data=Auto)
lm.fit2<-lm(mpg ~. -name + displacement:acceleration + cylinders:horsepower,data=Auto)
anova(lm.fit2,lm.fit1)

#               Transformations 

lm.fitT<-lm(mpg~. -name+log(horsepower)+ sqrt(cylinders): displacement,data=Auto)
summary(lm.fitT)


#=======================================================================
#                     Linear model to fit the Carseats data set

#=======================================================================
rm(list=ls())
data(Carseats)
attach(Carseats)
lm.fitt<-lm(Sales~ US+ Price + Urban,data=Carseats)

summary(lm.fitt)

better_lm<-lm(Sales~ US + Price, data=Carseats)
summary(better_lm)

par(mfrow=c(2,2))
plot(better_lm)