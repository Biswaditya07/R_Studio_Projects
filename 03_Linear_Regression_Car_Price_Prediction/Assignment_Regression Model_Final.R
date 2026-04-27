# Objective : To Build a Linear Regression Model to Predict Car Price
# Also Check the Error of the model and Accuracy
library(mice)
library(VIM)
library(Hmisc)
attach(imports_85)
b1=imports_85
View(b1)
is.na(b1)
which(is.na(b1))
#Checking the Summary of the Missing Values
summary(is.na(b1))
sum(is.na(b1))
t(head(b1,3))
t(summary(b1))
summary(b1)
#Pattern of the missing values
t(md.pattern(b1))
md.pairs(b1)
#Identifying the missing value Rows in the target variable:
which(is.na(b1$price))
b2<-b1[-c(10,45,46,130),]
View(b2)
#Remaining Missing Values in each variables: 
colSums(is.na(b2))
aggr(b2,pos=1,numbers=T,las=1,sortVars=T, labels=names(b2)) 
#Save the dataset b2
write.csv(b2, "C:/Users/Biswaditya Saha/OneDrive/Desktop/XBS-MBA-BA-3rd SEM/Multi Variate Analysis-Shuvendu Sir/R Studio/Import_New.csv", row.names = FALSE)

#Imputation of Data in num-of-doors
which(is.na(b2$`num-of-doors`))
b2[27,6]<-"four"
b2[61,6]<-"four"
View(b2)

#Imputation of Bore:
b2$bore[which(is.na(b2$bore))]=mean(b2$bore,na.rm = T)
View(b2)

#Imputation of stroke: 
b2$stroke[which(is.na(b2$stroke))]=mean(b2$stroke,na.rm = T)
View(b2)

#Imputation of Horsepower & Peak RPM:
which(is.na(b2$horsepower))
b2<-b2[-c(127,128),]
View(b2)
write.csv(b2, "C:/Users/Biswaditya Saha/OneDrive/Desktop/XBS-MBA-BA-3rd SEM/Multi Variate Analysis-Shuvendu Sir/R Studio/Import_New.csv", row.names = FALSE)

#Imputation of Normalized Losses:
boxplot(b2$`normalized-losses`)
hist(b2$`normalized-losses`)
b2$`normalized-losses`[which(is.na(b2$`normalized-losses`))]=mean(b2$`normalized-losses`,na.rm = T)
View(b2)

#Split the dataset into train & test data
set.seed(231) 
data=sample(2,nrow(b2),replace=T, prob = c(0.8,0.2)) 
data 
train1=b2[data==1,] 
test1=b2[data==2,] 
train1 
test1

#Final Model
model_Price <- lm(price ~  width + horsepower +`engine-size`, data = train1) 
summary(model_Price)

#Prediction on Test Dataset
predictions <- predict(model_Price, newdata = test1)

#Mean Square Error
mse <- mean((test1$price - predictions)^2)
mse
#Root Mean Square Error
rmse <- sqrt(mse)
rmse
#Compute Mean Absolute Error (MAE)
mae <- mean(abs(test1$price - predictions))
mae
#R2 Calculation
SSE <- sum((test1$price - predictions)^2)
SST <- sum((test1$price - mean(test1$price))^2)
R2_test <- 1 - SSE/SST
R2_test
#Actual Vs Predicted:
plot(test1$price, predictions,
     main = "Actual vs Predicted Values",
     xlab = "Actual",
     ylab = "Predicted",
     col = "blue",
     pch = 16)
abline(0, 1, col = "red", lwd = 2)  # perfect prediction line

