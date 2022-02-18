library(visreg)
library(ggplot2)

lions <- read.csv("lions.csv")

# make a scatter plot with CI and PI

ggplot(alldata, aes(x=age, y=black)) +
  geom_point() +
  stat_smooth(method = lm) +
  geom_line(aes(y=lwr)) +
  geom_line(aes(y=upr))
 

#fit a linear model

lionmodel <- lm(black ~ age, lions)

#add line of best fit

abline(lionmodel)

summary(lionmodel)

#get 95% confidence intervals for slope and intercept

confint(lionmodel, level = 0.95)

#test fit with ANOVA table
anova(lionmodel)

plot(lionmodel)

predictions <- predict(lionmodel, interval = 'predict')

alldata <- cbind(lions, predictions)




knees <- read.csv("knees.csv")

ggplot(knees, aes(y = shift, x = treatment)) +
  geom_point() +
  abline(z)

#check if treatment is a factor

is.factor(knees$treatment) #its not

knees$treatment <- factor(knees$treatment)
levels(knees$treatment)

knees$treatment <- factor(knees$treatment, levels = c("control", "knees", "eyes"))


z <- lm(shift ~ treatment, knees)
z0 <- lm(shift ~ 1, knees)
plot(z)

#visualize model fit

visreg(z, "treatment")
model.matrix(z)
summary(z)
confint(z, level = 0.95)
Anova(z0, z)

#9.








#Fly sex and longevity

#1.

flies <- read.csv("fruitflies.csv")

#2.

head(flies)

#3.

is.factor(flies$treatment)
flies$treatment <- factor(flies$treatment)

#4.

levels(flies$treatment)

#5.

flies$treatment <- factor(flies$treatment, levels = c("no females added", "1 pregnant female", "8 pregnant females", "1 virgin female", "8 virgin females"))

#6. 

ggplot(flies, aes(x = thorax.mm, y = longevity.days)) +
  geom_point() +
  facet_grid(flies$treatment)

#Fit a linear model

#1.

y <- lm(longevity.days ~ thorax.mm + treatment, flies)

#2.

plot(y)

#3.

flies$loglongevity <- log10(flies$longevity.days)
y <- lm(loglongevity ~ thorax.mm + treatment, flies)
plot(y)

#4.

visreg(y, xvar = 'thorax.mm', by = 'treatment')
visreg(y, xvar = 'treatment')

#5.

summary(y)

#6. 

confint(y, level = 0.95)

#7.

Anova(y)

#8.

y <- lm(loglongevity ~ treatment + thorax.mm, flies)
plot(y)

Anova(y)

#9.

z <- lm(loglongevity ~ treatment * thorax.mm, flies)

#10.

Anova(z)

#11.

summary(y)
summary(z)









