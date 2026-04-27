# Logistic Regression

# Assumptions

# Cases are randomly sampled
# Outcome variable is dichotomous
# Data is free of bivariate/multivariate outliers
# No (multi)collinearity between predictor variables



str(telecom_churn)

# split the data
# install.packages(caTools)
library(caTools)

set.seed(1234)
split <- sample.split(telecom_churn$churn, 0.8)
train <- subset(telecom_churn,split==TRUE)
vali <- subset(telecom_churn,split==FALSE)

# model creation
# install.packages(lessR)
library(lessR)
model <- Logit ((churn ~ tenure + no_of_complaints + Prepaid + Long + Short) , data = train)


# inserting validation data in the model
res <-predict(model,vali,type = "response")
res

# creation of confusion matrix
confmatrix <- table(Actual_value=vali$churn, Predicted_value = res > 0.5 )
confmatrix
(confmatrix[1,1] + confmatrix[2,2])/sum(confmatrix)


# training the model
res_train <- predict(model,train,type="response")
res_train

# ROCR
library(ROCR)
ROCRPred = prediction(res_train,train$churn)
ROCRPref = performance(ROCRPred,"tpr",'fpr')

plot(ROCRPref, colorize=TRUE, print.cutoffs.at=seq(0.1,by=0.1))

# Predicting the churn for a new set of customers
pred <- read.csv("pred.csv")

res_new <- predict(model,pred,type="response")
res_new

# writing the output in a file
pred$churn <- ifelse(res_new > 0.5, "churn", "not churn")
write.csv(pred, "predict_churn_output.csv", row.names = FALSE )


