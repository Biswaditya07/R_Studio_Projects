attach(houseprices)

#Finding mean and Neighborhood wise:
mean(Price)
mean(Price[Neighborhood=="East"])
mean(Price[Neighborhood=="West"])
mean(Price[Neighborhood=="North"])

mean(Price[Brick=="No"])
mean(Price[Brick=="Yes"])

mean(SqFt[Brick=="Yes"])
mean(SqFt[Brick=="No"])


#Finding median and Neighborhood wise:
median(Price)
median(Price[Neighborhood=="East"])
median(Price[Neighborhood=="West"])
median(Price[Neighborhood=="North"])

median(Price[Brick=="No"])
median(Price[Brick=="Yes"])

median(SqFt[Brick=="Yes"])
median(SqFt[Brick=="No"])

#Plotting Bar_Plots
barplot(Price[Neighborhood=="East"])
barplot(Price[Neighborhood=="West"])
barplot(Price[Neighborhood=="North"])

ratio=(Price[Neighborhood=="East"])/(SqFt[Neighborhood=="East"])
summary(ratio)

#Box plot 
boxplot(Price,horizontal = T,main="Boxplot of Price")
boxplot(Price[Neighborhood=="East"],horizontal = T,main="Boxplot of Price of East Neighborhood")
boxplot(Price[Neighborhood=="West"],horizontal = T,main="Boxplot of Price of West Neighborhood")
boxplot(Price[Neighborhood=="North"],horizontal = T,main="Boxplot of Price of North Neighborhood")
boxplot(Price[Brick=="Yes"],horizontal = T,main="Boxplot of Price based on Bricks")
boxplot(Price[Brick=="No"],horizontal = T,main="Boxplot of Price based on Non-Bricks")

#Histogram & Density Lines
hist(Price,freq = F)
lines(density(Price),lwd=2)
hist(Price[Neighborhood=="East"],freq = F)
lines(density(Price[Neighborhood=="East"]),lwd=2)
hist(Price[Neighborhood=="West"],freq = F)
lines(density(Price[Neighborhood=="West"]),lwd=2)
hist(Price[Neighborhood=="North"],freq = F)
lines(density(Price[Neighborhood=="North"]),lwd=2)


cor(SqFt,Price)
plot(SqFt,Price)


#Sorting for finding Most & Least house prices and there Rows
tail(sort(Price),5)
which(Price=="211200")
head(sort(Price),5)
which(Price=="90300")

plot(Offers,Price)
cor(Offers,Price)

Neighborhood=as.factor(Neighborhood)
summary(Neighborhood)
t=table(Neighborhood)
barplot(t,ylim=c(0,50))

Brick=as.factor(Brick)
plot(Brick~Neighborhood)

qqnorm(Price[Neighborhood=="North"])
qqline(Price[Neighborhood=="North"])
shapiro.test(Price[Neighborhood=="North"])
ad.test(Price[Neighborhood=="North"])
lillie.test(Price[Neighborhood=="North"])

qqnorm(Price[Brick=="No"])
qqline(Price[Brick=="No"])
hist(Price[Brick=="No"],freq = F)
lines(density(Price[Brick=="No"],lwd=2))
shapiro.test(Price[Brick=="No"])
ad.test(Price[Brick=="No"])
lillie.test(Price[Brick=="No"])

qqnorm(SqFt[Brick=="No"])
qqline(SqFt[Brick=="No"])
hist(SqFt[Brick=="No"],freq = F)
lines(density(SqFt[Brick=="No"]),lwd=2)
shapiro.test(SqFt[Brick=="No"])
lillie.test(SqFt[Brick=="No"])
ad.test(SqFt[Brick=="No"])

t.test(Price[Neighborhood=="West"],mu=130000)

#2 Sample t-test

Brick=as.factor(Brick)
library(car)
leveneTest(Price~Brick,data=houseprices)
t.test(Price~Brick,var.equal = T)

PriceperSqFt=Price/SqFt
summary(PriceperSqFt)
boxplot(PriceperSqFt~Neighborhood,horizontal = T)
hist(PriceperSqFt, freq = F)
lines(density(PriceperSqFt),lwd=2)
qqnorm(PriceperSqFt)
qqline(PriceperSqFt)

shapiro.test(PriceperSqFt)
ad.test(PriceperSqFt)
lillie.test(PriceperSqFt)


hist(Price[Bedrooms=="4"])
Bedrooms=as.numeric(Bedrooms)
plot(SqFt~Bathrooms)
cor(SqFt,Bathrooms)
hist(Bedrooms)

mean(SqFt[Bathrooms=="3"])
plot(Neighborhood~Offers)

cor(Bedrooms,Offers)
plot(Offers,SqFt)
Neighborhood=as.factor(Neighborhood)
plot(Neighborhood~Bedrooms,horizontal=T)

plot(SqFt~Brick,horizontal=T)
boxplot(Price~Neighborhood,horizontal = T)

boxplot(SqFt~Neighborhood,horizontal = T)
boxplot(PriceperSqFt~Neighborhood,horizontal = T)
boxplot(Price~Brick,horizontal=T)
