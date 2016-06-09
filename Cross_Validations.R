rm(list = ls())
require(ISLR)
require(MASS)
require(boot)
#?cv.glm
data(Auto)
attach()
plot(mpg~horsepower,data=Auto)

#    LOOCV

