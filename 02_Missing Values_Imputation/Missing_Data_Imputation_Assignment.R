attach(car_details_v4_missing)
p1=car_details_v4_missing
library(mice)
library(VIM)
library(Hmisc)
View(p1)
is.na(p1)   #Is there missing value in the dataset? Outcome: TRUE/FALSE
which(is.na(p1)) #What are the positions of the Missing Values
sum(is.na(p1)) #Total No. of Missing Values
sum(is.na(p1$Price)) #Total No. of Missing Value in Price i.e. Dependent Variable
which(is.na(p1$Price)) # Positions of the missing values in the target variable

## Finding the missing values in the Independent Variables:

which(is.na(p1$Kilometer))
sum(is.na(p1$Kilometer))
which(is.na(p1$Engine))
sum(is.na(p1$Engine))
which(is.na(p1$Length))
sum(is.na(p1$Length))
which(is.na(p1$Width))
sum(is.na(p1$Width))
which(is.na(p1$Height))
sum(is.na(p1$Height))
which(is.na(p1$`Seating Capacity`))
sum(is.na(p1$`Seating Capacity`))
which(is.na(p1$`Fuel Tank Capacity`))
sum(is.na(p1$`Fuel Tank Capacity`))

# Pattern of the missing data: 

summary(p1)
t(md.pattern(p1))
md.pairs(p1)
aggr(p1,pos=1,numbers=T,las=1,sortVars=T, labels=names(p1))
pbox(p1)

p2<-p1[-c(12,167,179,191,203,296,317,346,420,421,429,511,522),]
View(p2)

cor(p2)
library(corrplot)
corrplot(cor(p2), method = "circle")

library(ggplot2)

ggplot(p2, aes(x = Length, y = Engine)) + geom_point() + geom_smooth(method = "lm")
ggplot(p2, aes(x = Width, y = Engine)) + geom_point() + geom_smooth(method = "lm")
ggplot(p2, aes(x = `Fuel Tank Capacity`, y = Engine)) + geom_point() + geom_smooth(method = "lm")

library(ggplot2)

ggplot(p2, aes(x = as.factor(`Seating Capacity`), y = Height)) +
  stat_summary(fun = "mean", geom = "bar", fill = "skyblue") +
  labs(x = "Seating Capacity", y = "Average Height") +
  theme_minimal()

#Imputation of Kilometer:
plot(density(p2$Kilometer, na.rm = TRUE), 
     main = "Density Plot of Kilometers", 
     col = "blue")

boxplot(p2$Kilometer, 
        main = "Boxplot of Kilometers", 
        col = "lightgreen")

p2$Kilometer[which(is.na(p2$Kilometer))]=median(p2$Kilometer,na.rm = T)
p2

#Imputation of Engine Value:
plot(density(p2$Engine, na.rm = TRUE), 
     main = "Density Plot of Kilometers", 
     col = "red")

p2$Engine[which(is.na(p2$Engine))]=median(p2$Engine,na.rm = T)
p2

#Imputation of Length Value: 
hist(p2$Length,
     main = "Histogram of Length with Density Curve",
     xlab = "Length",
     col = "skyblue",
     breaks = 30,
     freq = FALSE)   # scale y-axis to density

# Add density curve (trend line)
lines(density(p2$Length, na.rm = TRUE), col = "red", lwd = 2)

plot(density(p2$Length, na.rm = TRUE), 
     main = "Density Plot of Length", 
     col = "blue")

p2$Length[which(is.na(p2$Length))]=mean(p2$Length,na.rm = T)
p2

#Imputation of Width:
hist(p2$Width,
     main = "Histogram of Width with Density Curve",
     xlab = "Width",
     col = "skyblue",
     breaks = 30,
     freq = F)   # scale y-axis to density

# Add density curve (trend line)
lines(density(p2$Width, na.rm = TRUE), col = "red", lwd = 2)
summary(p2$Width)

p2$Width[which(is.na(p2$Width))]=mean(p2$Width,na.rm = T)
p2

#Imputation of Height:
hist(p2$Height,
     main = "Histogram of Height with Density Curve",
     xlab = "Height",
     col = "skyblue",
     breaks = 30,
     freq = F)   # scale y-axis to density

# Add density curve (trend line)
lines(density(p2$Height, na.rm = TRUE), col = "red", lwd = 2)
summary(p2$Height)

p2$Height[which(is.na(p2$Height))]=median(p2$Height,na.rm = T)
View(p2)

#Imputation of Seating Capacity:
barplot(table(p2$`Seating Capacity`),
        main = "Distribution of Seating Capacity",
        xlab = "Seating Capacity",
        ylab = "Count",
        col = "skyblue")

p2$`Seating Capacity`[which(is.na(p2$`Seating Capacity`))]=mode(p2$`Seating Capacity`,na.rm = T)
View(p2)

#Imputation of Fuel tank
plot(density(p2$`Fuel Tank Capacity`, na.rm = TRUE), 
     main = "Density Plot of Fuel Tank Capacity", 
     col = "blue")

p2$`Fuel Tank Capacity`[which(is.na(p2$`Fuel Tank Capacity`))]=median(p2$`Fuel Tank Capacity`,na.rm = T)
View(p2)

is.na(p2)
sum(is.na(p2))

library(openxlsx)

library(openxlsx)
write.xlsx(p2, "C:/Users/Biswaditya Saha/OneDrive/Desktop/XBS-MBA-BA-3rd SEM/Multi Variate Analysis-Shuvendu Sir/R Studio/cleaned_data.xlsx")



