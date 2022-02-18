library(lmerTest)
library(ggplot2)
library(visreg)
library(emmeans)
library(car)

flies <- read.csv("flycatcher.csv")
head(flies)

#plot paired data
ggplot(flies, aes (y=patch, x=year)) +
  geom_point(size = 4, col = 'firebrick', alpha = 0.5) +
  geom_line(aes(group = bird)) +
  labs(x = "Year", y = "Patch") +
  theme_classic()

z <- lmer(patch ~ 1+(1|bird), flies)
summary(z)
fitted(z)
VarCorr(z) #extracting variance components

repeatability <- 1.11504**2 / (1.11504 ** 2 + 0.59833 ** 2) #calculating repeatability
repeatability

plot(z) #plotting residuals vs fitted values


#these will be useful;

summary(z)          # variances for random effects, fit metrics
plot(z)             # plot of residuals against predicted values
VarCorr(z)          # variance components for random effects  
confint(z)          # lmer: conf. intervals for fixed effects and variances 
intervals(z)        # lme: conf. intervals for fixed effects and variances

resid(z)            # residuals
fitted(z)           # best linear unbiased predictors (BLUPs)

anova(z, type = 1)  # lmer: test fixed effects sequentially (Type I SS)
anova(z, type = 3)  # lmer: as above but using Type III Sums of Squares
anova(z)            # lme: test fixed effects sequentially (Type I SS)


# GOLDIES VISION

#1.

gold <- read.csv("goldfish.csv")
head(gold)

#2.

interaction.plot(gold$wavelength, gold$fish, gold$sensitivity)

#3.

#subject by treatment design

#FIT A LINEAR MIXED-EFFECTS MODEL:

#1. 

z <- lmer(sensitivity ~ wavelength + (1|fish),gold)

#2.

visreg(z)

#3
plot(z)

#4
summary(z)

#6 generate model based estimates of means of sensitivity

emmeans(z,"sensitivity")

#7

anova(z)


#YUKON YARROW

#1
yukon <- read.csv("kluane.csv")

#2
head(yukon)

#3 illustrate []s of phenolics in yarrow in treatment and duration conditions (useful!!!)
ggplot(yukon, aes(y=phen.ach, x = duration, fill = treatment, color = treatment)) +
  geom_point(size = 3, position = position_dodge(width = 0.3)) +
  geom_line(aes(group = plot))
  labs(x = "treatment", y = "phenolic []") +
  theme_classic() +
  theme(aspect.ratio = 0.75, text = element_text(size = 16), axis.text = element_text(size = 14))

#4
  
#added geom_line() to #3
  
#FIT A LINEAR MIXED-EFFECTS MODEL
  
#1
#split-plot design
  
#2
yukon$log.phen.ach <- log(yukon$phen.ach)
z <- lmer(log.phen.ach ~ treatment * duration + (1|plot), yukon)

#3
visreg(z, xvar='duration', by="treatment")

#4

#5

#6
summary(z)
emmeans(z,'treatment')

#7

#8
emmeans(z, specs = 'treatment')
emmeans(z, specs = 'duration')

#9
Anova(z, type="III")

#10
anova(z)


  
