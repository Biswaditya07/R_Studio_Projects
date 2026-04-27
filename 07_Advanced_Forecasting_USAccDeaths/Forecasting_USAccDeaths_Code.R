library(tseries)
library(forecast)
data= USAccDeaths
View(data)
plot(data)
dim(data) #dimension of the data
log_data=log10(data) #Special type of scaling done
plot(log_data)
par(mfrow=c(1,2))
acf(log_data)
pacf(log_data)

diff1 <- diff(log_data, differences = 1)
plot.ts(diff1)
par(mfrow=c(1,2))
acf(diff1, lag.max = 50)
pacf(diff1)

diff2 <- diff(diff1, lag = 12)
plot(diff2)
par(mfrow=c(1,1))
acf(diff2, lag.max = 50)
pacf(diff2)

auto_model= auto.arima(log_data, seasonal = TRUE, stepwise = FALSE)
summary(auto_model)
auto_model$residuals
forecast_value=forecast(auto_model,h=12)
print(forecast_value)

# Extracting parameters for Section C Question 2 & 3
theta <- coef(auto_model)["ma1"]
Theta <- coef(auto_model)["sma1"]
cat("Non-seasonal MA (theta):", theta, "\n")
cat("Seasonal MA (Theta):", Theta, "\n")

original_forecast <- 10^(forecast_value$mean)
print(original_forecast)

cat("\n--- Corrected Accuracy (Original Scale) ---\n")
accuracy(10^fitted(auto_model), data)

