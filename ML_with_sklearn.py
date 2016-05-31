# -*- coding: utf-8 -*-
"""
Created on Fri May 27 15:20:02 2016

@author: senatoduro8
"""


#sklearn expects the following

#Features and responses are separate objects
#Features and responses should be numeric
#Features and responses should be Numpy arrays
#Features and responses should have specifice shapes

import numpy as np
import matplotlib.pyplot as plt 
import seaborn as sns
import csv
import os
import pandas as pd
import scipy as sc

from sklearn.datasets import load_iris

#import KNN class
from sklearn.neighbors import KNeighborsClassifier
#import logisticRegression class
from sklearn.linear_model import LogisticRegression


iris=load_iris()

#print  iris.data.shape
#print '\n'
#print iris.data.size
#print '\n'
#print iris.target
#print '\n'
#print iris.target_names

#Data
X=iris.data

#outcomes
y=iris.target

knn=KNeighborsClassifier(n_neighbors=1)

#training machine
knn.fit(X,y)

#prediction
print knn.predict([2,3,5,2])

#prediction multiple values
X_n=[[5,3,5,6],[4,2,7,1]]

knn.predict(X_n)

#parameter tuning
knn=KNeighborsClassifier(n_neighbors=5)

knn.fit(X,y)

print knn.predict(X_n)

#------------------------------------------
#Logistic Regression model

logit=LogisticRegression()

#fit model
logit.fit(X,y)

#predictions
print logit.predict(X_n)

#----------------------------------
#model evaluation
'''Train the entire dataset and predicting on the same entire data
set'''
ypred=logit.predict(X)

from sklearn import metrics
print metrics.accuracy_score(y,ypred)

'''train/test split:
Spliting the dataset into two pieces, using one for training
and using the other for prediction and comparing the predicted respose
to the true responses'''
from sklearn.cross_validation import train_test_split

X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=0.4,random_state=4)

logit.fit(X_train,y_train)

#ypred=logit.predict(X_test)
ypred=knn.predict(X_test)

print metrics.accuracy_score(y_test,ypred)
 
print metrics.confusion_matrix(y_test,ypred)  #confusion matrix

print metrics.recall_score(y_test,ypred)      # sensitivity

print metrics.precision_score(y_test,ypred)  #precision score

#--------------------------------------
#using the knn model
knn=KNeighborsClassifier(n_neighbors=5)

knn.fit(X_train,y_train)

ypred=knn.predict(X_test)

print metrics.accuracy_score(y_test,ypred)

k_range=range(1,36)
score=[]
for k in k_range:
    knn=KNeighborsClassifier(n_neighbors=k)
    knn.fit(X_train,y_train)
    ypred=knn.predict(X_test)
    score+=[metrics.accuracy_score(y_test,ypred)]
    
plt.plot(k_range,score)
plt.show()



"""Data science pipeline: pandas, seaborn, and scikit-learn"""
ads=pd.read_csv('E:\\Downloads\\Advertising.csv',index_col=0)

#Visualizing of data and exploring the data
sns.pairplot(ads,x_vars=['TV','Radio','Newspaper'],y_vars='Sales',\
size=7, aspect=0.7, kind='reg')

feature_col=['TV','Radio','Newspaper']      #Features

X=ads[feature_col]      #data for scikit
    
y=ads['Sales']          #outcomes as pandas series

#Spliting of data

X_train,X_test,y_train,y_test=train_test_split(X,y,random_state=1)

from sklearn.linear_model import LinearRegression

linreg=LinearRegression()

linreg.fit(X_train,y_train)

ypred=linreg.predict(X_test)

print metrics.mean_absolute_error(y_test,ypred)
print metrics.mean_squared_error(y_test,ypred)
print np.sqrt(metrics.mean_squared_error(y_test,ypred))