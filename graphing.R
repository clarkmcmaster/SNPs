#Which contintent has the most species?
mammals$continent[which(mammals$continent == "Af")] <- c('AF')
table(mammals$continent) #Insular or AF if insular doesn't count

#Use a freq table to find how many extinct mammals are recorded

table(mammals$status, useNA = "ifany") #242 extinct mammals

#Use a two-way contingency table showing status of mammal species on each continent

table(mammals$status, mammals$continent, useNA = "ifany") #which continent has the greatest nbr of extinctions rel to extant? North america

ggplot(mammals, aes(x = continent)) + 
  geom_bar(stat="count")

mammals$continent_ordered <- factor(mammals$continent, levels = names(sort(table(mammals$continent), decreasing = TRUE)))

ggplot(mammals, aes(x = continent_ordered)) + 
  geom_bar(stat="count", fill = "firebrick") +
  labs(x = "continent group", y = "species") +
  theme_classic() +
  theme(text = element_text(size = 15), 
        axis.text = element_text(size = 12), aspect.ratio = 0.8)

#generate a histogram

hist(mammals$mass.grams, col = "navy", right = FALSE)

#make a new variable with of the log10 or body mass

mammals$logmass <- log10(mammals$mass.grams)
hist(mammals$logmass, col = "navy", right = FALSE)

hist(mammals$logmass, col = "navy", breaks = seq(from = 0, to = 10, by = 2), right = FALSE)
hist(mammals$logmass, col = "navy", breaks = seq(from = 0, to = 10, by = 1), right = FALSE)
hist(mammals$logmass, col = "navy", breaks = seq(from = 0, to = 10, by = 0.5), right = FALSE)
hist(mammals$logmass, col = "navy", breaks = seq(from = 0, to = 10, by = 0.1), right = FALSE)

#Prob density

hist(mammals$logmass, col = "navy", prob = TRUE, right = FALSE)

#compare to quantile plot
qqnorm(mammals$logmass)

#superimpose a normal density curve
hist(mammals$logmass, prob = TRUE, right = FALSE)
m <- mean(mammals$logmass, na.rm = TRUE)
s <- sd(mammals$logmass, na.rm = TRUE)
xpts <- seq(from = min(mammals$logmass, na.rm=TRUE), 
            to = max(mammals$logmass, na.rm = TRUE), length.out = 101)
lines(dnorm(xpts, mean=m, sd=s) ~ xpts, col="red", lwd=2)

#box plot

boxplot(logmass ~ status, data = mammals, varwidth = FALSE, ylab="mass (log10)", col = "firebrick", cex.axis = 0.8, las = 1) #extinct animals are larger
#extant mammals have more varied distribution

ggplot(mammals, aes(x = status, y = logmass)) + 
  geom_boxplot(fill = "firebrick", varwidth = TRUE) + 
  theme_classic() + 
  theme(text = element_text(size = 14)) +
  ggtitle("Mammal mass vs. extinction status")

#draw a violin plot

ggplot(mammals, aes(x = status, y = logmass)) + 
  geom_violin(fill = "firebrick") + 
  stat_summary(fun = mean,  geom = "point", color = "black") +
  labs(x = "status", y = "mass (log10)") +
  theme_classic() + 
  theme(text = element_text(size = 15), axis.text = element_text(size = 12), aspect.ratio = 0.80) +
  ggtitle("Mammal mass vs. extinction status")

#use multiple histograms to do the same comparison, stack them

ggplot(mammals, aes(x = logmass)) + 
  geom_histogram(fill = "firebrick", col = "black", binwidth = 0.2, 
                 boundary = 0, closed = "left") +
  labs(x = "logmass", y = "Frequency") +
  theme_classic() + 
  theme(aspect.ratio = 0.5) + 
  facet_wrap( ~ status, ncol = 1, scales = "free_y")

#make a table of the median log body mass of each status group of mammals

mammals %>% remove_missing() %>% group_by(status) %>% summarise(Median = median(logmass))


################DATA SET 2#########################

#stripchart

stripchart(longevity.days ~ treatment, data = fruitflies, method = "jitter", jitter = 0.15, cex.axis = 0.8, pch = 1, col = "firebrick")
#males with pregnant or no females lived longer

#use boxplot

ggplot(fruitflies, aes(longevity.days, treatment)) + geom_boxplot() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))


















