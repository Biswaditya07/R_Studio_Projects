attach(cleaned_data)
p2=cleaned_data

set.seed(231)
data=sample(2,nrow(p4),replace=T, prob = c(0.8,0.2))
data
train1=p4[data==1,]
test1=p4[data==2,]
train1
test1

model_Price <- lm(Price ~ Engine + `Fuel Tank Capacity` + Length + Kilometer + `Seating Capacity`, data = train1)
summary(model_Price)
plot(model_Price)
View(p2)
p4<-p3[-c(424,154,383),]

model2 <- lm(log(Price) ~ log(Kilometer+1) + Width + Engine + Length + `Seating Capacity` + `Fuel Tank Capacity`, data = train1)
summary(model2)
plot(model2)

####### Search for lm beta package:
####### Search for Compression Ratio and How to implement it
# Get predicted log(Price) values
pred_log <- predict(model2, newdata = test1)

# Convert back to actual Price scale
pred_price <- exp(pred_log)

# Mean Absolute Error (MAE)
mae <- mean(abs(test1$Price - pred_price))

# Root Mean Squared Error (RMSE)
rmse <- sqrt(mean((test1$Price - pred_price)^2))

# R-squared (on test set)
ss_res <- sum((test1$Price - pred_price)^2)
ss_tot <- sum((test1$Price - mean(test1$Price))^2)
r2_test <- 1 - (ss_res/ss_tot)

mae; rmse; r2_test

plot(test1$Price, pred_price,
     xlab = "Actual Price",
     ylab = "Predicted Price",
     main = "Actual vs Predicted Prices")
abline(0, 1, col = "red")  # ideal fit line

