install.packages("bbmle")
library(bbmle)

G <- 2 * (loglikefull - loglikereduced)

#Warmup

#1
dbinom(5,10,0.5)

#2
dbinom(10,20,0.512)

#3
probdist <- data.frame(boys=0:6,prob=0:6)
for(i in 0:7){
  probdist$boys[i] <- i
  probdist$prob[i] <- dbinom(i,6,0.512)
}
plot(probdist$boys[0:6],probdist$prob[0:6])

#4
#p = 0.1, survive = 10, die = 11
dgeom(10,0.1)

#5
age<-c(0:10)
sum<-0
for(i in 1:7){
  sum <- sum + dgeom(i,0.1) #come back to this
}
plot(dgeom(age,0.1))
#6
# mean time = 0.5, actual = 2
dexp(2,1/0.5)

#7
#exp prob curve
range <- c(0:5)
plot(dexp(range,1/0.5))


#LEFT HANDED FLOWERS
#1
p <- seq(0.01,0.99,by=0.01) 
loglike <- vector()
for(i in 1:length(p)){
  loglike[i] <- sum(dbinom(6,27,prob = p[i]),log=TRUE)
}

#3
plot(p,loglike)
lines(loglike[order(p)]~p[order(p)])
# this curve is the likelihood ratio
# the value at the highest point is called the maximum likelihood estimate

#4

p <- seq(0.2,0.25,by=0.001) 
loglike <- vector()
for(i in 1:length(p)){
  loglike[i] <- sum(dbinom(6,27,prob = p[i]),log=TRUE)
}
plot(p,loglike)
lines(loglike[order(p)]~p[order(p)])
# MLE looks like ~0.22

#6
prop.test(6,27,conf.level = 0.95, correct = FALSE) # 0.106 < p < 0.408
binom.test(6,27,conf.level = 0.95) # 0.086 < p < 0.423




