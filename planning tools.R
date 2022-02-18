library(binom)
library(dplyr)
library(pwr)
library(tidyverse)

#Simulate data

sample <- sample(c("diseased","healthy"), size=20, replace=TRUE, prob=c(.5,.5)) 
table(sample)

sample <- sample(c("mated","unmated"), size=18, replace=TRUE, prob=c(.7,.3))
table(sample)

#sample observations from a normally distributed popn

myrand <- rnorm(30, mean = 0, sd = 2)
hist(myrand, right = FALSE)
mean(myrand)

#Estimate weak or no preference
myCI <- vector("numeric", length = 100)

for(i in 1:100){
  n = 90
  sample <- sample(c("successes","failures"), size=n, replace=TRUE, prob=c(.5,.5))
x <- table(sample)
CI <- binom.confint(x["successes"], n, method = "ac")
myCI[i] <- (CI$upper - CI$lower)
}
print(mean(myCI))

#Plan for power
n = 20
myCI <- vector("numeric", length = n)
for(i in 1:100){
  
  sample <- sample(c("successes","failures"), size=n, replace=T, prob=c(.7,.3))
  x <- table(sample)
  CI <- binom.confint(x["successes"], n, method = "ac")
  myCI[i] <- (CI$upper-CI$lower)
  
}
print(mean(myCI))


n=40  #N of 35-40 usually results in the null hypothesis being rejected
for(i in 1:10){
sample <- sample(c("successes","failures"), size=n, replace=T, prob=c(.7,.3))
x <- table(sample)
z <- binom.test(x["successes"], n, p = 0.5)
print(z$p.value)
}


#Power tools

h <- ES.h(0.5, 0.8)
pwr.p.test(h, power = 0.8)



#Plan a 2x2 experiment

n = 30
control <- sample(c("infected","uninfected"), size = n, replace=T, prob=c(.2,.8))
sample <- sample(c("infected","uninfected"), size = n, replace=T, prob=c(.5,.5))
control <- as.data.frame(control)
control$treatment <- "control"
sample <- as.data.frame(sample)
sample$treatment <- "sample"

data <- left_join(control, sample, by="treatment")

data <- merge(control, sample,by="treatment",all.x = T)
data <- rbind.data.frame(control, sample)

data <- as.data.frame(data)
table(data$control, data$sample, useNA = "ifany")


