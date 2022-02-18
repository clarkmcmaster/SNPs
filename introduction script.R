mydata <- read.csv('anolis.csv')
str(mydata)

class(mydata)
class(mydata$Species)
head(mydata)
tail(mydata)
table(mydata$Ecomorph)

mydata$Ecomorph[which(mydata$Ecomorph == "Trunk-Crown ")] <- c("Trunk-Crown")
mydata$Ecomorph[which(mydata$Ecomorph == "Trunk-Ground ")] <- c("Trunk-Ground")
mydata$Ecomorph[which(mydata$Ecomorph == "Crown-Giant ")] <- c("Crown-Giant")
table(mydata$Ecomorph)

mydata <- read.csv('anolis.csv', strip.white = TRUE, na.strings = c("NA",""))
table(mydata$Ecomorph)
table(mydata$Ecomorph, useNA = "ifany")
mydata$Ecomorph[is.na(mydata$Ecomorph)] <- c("none")

length(mydata$Island[grepl("Cuba",mydata$Island)]) #How many are on Cuba?
table(mydata$Ecomorph[grepl("Cuba|Jamaica|Hispaniola|Puerto Rico",mydata$Island)])
table(mydata$Ecomorph[!grepl("Cuba|Jamaica|Hispaniola|Puerto Rico",mydata$Island)])
