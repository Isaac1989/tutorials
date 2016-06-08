require(ISLR)
data(Smarket)
names(Smarket)
?Smarket
attach(Smarket)
pairs(Smarket[,-9])

cor(Smarket[,-9])
plot(Year,Volume)

log.fit<-glm(Direction~.-Year-Today,data = Smarket, family='binomial')

summary(log.fit)


pred.prob<-predict(log.fit,type='response') # prediction based on trained data

contrasts(Direction)

#enconding the response
pred<-ifelse(pred.prob>0.5,"UP","Down")

table(pred,Direction)


######################################################################
#                 Proper Training and testing of model
####################################################################

train<-Year<2005

test.X<-Smarket[!train,]
test.y<-Direction[!train]

glm.fit<-glm(Direction~.-Year-Today,data = Smarket, family='binomial',subset = train)

pred.y=predict(glm.fit,test.X, type = 'response')
pred.y<-ifelse(pred.y>0.5, "Up","Down")

table(test.y,pred.y)

## Reduce number of features
glm.fit<-glm(Direction~Lag1+Lag2,data = Smarket, family='binomial',subset = train)

pred.y=predict(glm.fit,test.X, type = 'response')
pred.y<-ifelse(pred.y>0.5, "Up","Down")

table(test.y,pred.y)



#################################################################
#                 Linear Discriminant Analysis
################################################################3
library(MASS)

lda.fit<-lda(Direction~Lag1+Lag2,data = Smarket,subset = train)
lda.fit
pred.y=predict(lda.fit,test.X)

names(pred.y)  #has 3 attributes

table(test.y,pred.y$class)

names(y.p)
                                          #Posterior: probability for deciding  
                                          # X : Linear Discriminant
                                          #Class: classification of each observation
pred.y$class

#       Thresholding
new_class=rep("Down",252)
subse<-pred.y$posterior[,1]>=0.5
new_class[subse]="Up"
 
sum(subse)
#or 
sum(pred.y$class==test.y)
#confusion table
table(test.y,pred.y$class)

#################################################################3
#               Quadratic Discriminant Analysis
##################################################################
#Already splitted the  data into two separate parts so we are good to

qda.fit<-qda(Direction~Lag1+Lag2,data=Smarket ,subset= Year<2005)

qda.fit
# make predictions
pred.y<-predict(qda.fit, subset(Smarket,Year==2005))

#  Number of True predictions
mean(pred.y$class==subset(Smarket,Year==2005)$Direction)

#  Confusion table
table(subset(Smarket,Year==2005)$Direction,pred.y$class)

#    Thresholding
pred.class<-ifelse(pred.y$posterior[,1]<0.51,"Up","Down")
table(subset(Smarket,Year==2005)$Direction,pred.class)
mean(subset(Smarket,Year==2005)$Direction==pred.class)

#########################################################################
#               K-nearest Neighbors
#########################################################################
library(class)
train.X<-cbind(Lag1,Lag1)[Year<2005,]
test.X<-cbind(Lag1,Lag1)[Year==2005,]
train.y<-Direction[Year<2005]

set.seed(1)

pred.y<-knn(train.X,test.X,train.y,k=6)
mean(pred.y==Direction[Year==2005])

table(Direction[Year==2005],pred.y)


##################KNN with different data set#########################################
data(Caravan)
attach(Caravan)
names(Caravan)
standard.X=scale(Caravan[,-86])
#checking variance
var(standard.X[,1])
var(standard.X[,3])

test<-1:1000
train.X=standard.X[-test,]  #scaling data
test.X=standard.X[test,]
train.y<-Purchase[-test]
test.y<-Purchase[test]

pred.y<-knn(train.X,test.X,train.y,k=1)

mean(pred.y==test.y)

table(test.y,pred.y)


#############Fitting Logistic regression###########################
glm.fit<-glm(Purchase~.,data=Caravan,family = 'binomial',subset=-test)

pred.prob<-predict(glm.fit,Caravan[test,],type='response')

#pred.y<-rep("No",1000)

pred.y<-ifelse(pred.prob>0.25,"Yes","No")
#pred.y[pred.prob>0.5]="Yes"

table(test.y,pred.y)
mean(test.y==pred.y)


###################################################################
#            Analysis using the weekly data set
###################################################################
require(MASS)
data("Weekly")
summary(Weekly)
attach(Weekly)
cor(Weekly[,-9])
plot(Weekly[,-9])

#########Logistic regresion#############
train<-Year<2009

glm.fit<-glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data = Weekly,family='binomial',subset = train)

summary(glm.fit)

pred.prob<-predict(glm.fit,Weekly[!train,],type = 'response')

pred.y<-ifelse(pred.prob>0.5,"Up","Down")

table(Direction[!train],pred.y)
mean(Direction[!train]==pred.y)
################Linear Discriminant analysis#################
library(MASS)
lda.fit<-lda(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data = Weekly,subset = train)

lda.fit

pred.y<-predict(lda.fit,Weekly[!train,])

table(Direction[!train],pred.y$class)
mean(Direction[!train]==pred.y$class)
# thresholding
pred_class<-ifelse(pred.y$posterior[,1]>0.5,"Up","Down")

table(Direction[!train],pred_class)
mean(Direction[!train]==pred_class)

############ QDA#####################3333
library(MASS)
qda.fit<-qda(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data = Weekly,subset = train)

qda.fit

pred.y<-predict(qda.fit,Weekly[!train,])

table(Direction[!train],pred.y$class)
mean(Direction[!train]==pred.y$class)
# thresholding
pred_class<-ifelse(pred.y$posterior[,1]>0.5,"Up","Down")

table(Direction[!train],pred_class)
mean(Direction[!train]==pred_class)

############# Knn##############################
library(class)
std.X<-scale(Weekly[,-9])

X.train<-std.X[train,]
X.test<-std.X[!train,]
y.train<-Direction[train]
y.test<-Direction[!train]

y.pred<-knn(X.train,X.test,y.train,k=1)

table(y.test,y.pred)

mean(y.pred==y.test)
