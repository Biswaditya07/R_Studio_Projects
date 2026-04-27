library(quantmod)
library(tidyquant)
library(dplyr)
library(xts)
library(forecast)
library(tseries)
# Define stock symbol and date range
stock_symbol <- "^NSEI"  # Replace with any stock symbol
start_date <- "2025-03-06"
end_date <- "2026-04-27"

# Get data using quantmod
stock_data<-getSymbols(stock_symbol, src = "yahoo", from = start_date, to = end_date, auto.assign = F)
stock_data=na.omit(stock_data)
# Convert to a data frame
nifty_data <- data.frame(Date = index(stock_data), coredata(stock_data))

# View first few rows
head(nifty_data)

# Save to CSV
write.csv(nifty_data, file = "nifty_data.csv", row.names = FALSE)
getwd()


# Load stock data
nifty_data <- read.csv("nifty_data.csv")

# Convert Date column to Date format
nifty_data$Date <- as.Date(nifty_data$Date, format="%Y-%m-%d")

# Convert to xts time series object (handles missing dates automatically)
nifty_xts <- xts(nifty_data[,-1], order.by = nifty_data$Date)

# Check structure
head(nifty_xts)
plot(nifty_xts, type="l")
plot(nifty_xts$NSEI.Close)
adf.test(nifty_xts$NSEI.Close)
#.......................................................................


# Define stock symbol and date range
stock_symbol <- "^GSPC"  # S&P 500 Index symbol in Yahoo Finance
start_date <- "2025-03-06"
end_date <- "2026-03-17"

# Get data using quantmod
stock_data <- getSymbols(stock_symbol, src = "yahoo", from = start_date, to = end_date, auto.assign = FALSE)

# Remove NA values
stock_data <- na.omit(stock_data)

# Convert to a data frame
sp500_data <- data.frame(Date = as.Date(index(stock_data)), coredata(stock_data))

# View first few rows
head(sp500_data)

# Save to CSV
write.csv(sp500_data, file = "sp500_data.csv", row.names = FALSE)
print(getwd())  # Show working directory

# Load saved CSV file
sp500_data <- read.csv("sp500_data.csv")

# Convert Date column to Date format
sp500_data$Date <- as.Date(sp500_data$Date, format="%Y-%m-%d")

# Convert to xts time series object (handles missing dates automatically)
sp500_xts <- xts(sp500_data[, -1], order.by = sp500_data$Date)

# Check structure
head(sp500_xts)
plot(sp500_xts$GSPC.Close, type="l")

adf.test(sp500_xts$GSPC.Close)
#......................................................................
merged_df <- merge(nifty_xts$NSEI.Close, sp500_xts$GSPC.Close)
merged_df <- na.omit(merged_df)

nifty_ts <- ts(merged_df$NSEI.Close)
sp500_ts <- ts(merged_df$GSPC.Close)

# Check for stationarity (Augmented Dickey-Fuller test)
adf_test_nifty <- adf.test(nifty_ts)
adf_test_sp500 <- adf.test(sp500_ts)

print(adf_test_nifty)
print(adf_test_sp500)

# If non-stationary, apply differencing
if (adf_test_nifty$p.value > 0.05) {
  nifty_ts <- diff(nifty_ts, differences = 1)
}
if (adf_test_sp500$p.value > 0.05) {
  sp500_ts <- diff(sp500_ts, differences = 1)
}

# Build ARIMAX model (NIFTY 50 as dependent, S&P 500 as independent variable)
arimax_model <- auto.arima(nifty_ts, xreg = sp500_ts)

# Print model summary
summary(arimax_model)
# Forecast for next 30 days using latest SP500 data as external regressor
future_sp500 <- tail(sp500_ts, 30)  # Use last 30 days of S&P 500 as predictor
forecast_values <- forecast(arimax_model, xreg = future_sp500, h = 30)

# Plot the forecast
plot(forecast_values, main = "NIFTY 50 Forecast using ARIMAX", col.main = "blue")

# Print forecasted values
print(forecast_values)




future_sp500 <- tail(sp500_ts, 30)
forecast_diff <- forecast(arimax_model, xreg = future_sp500, h = 30)

# To invert the differencing, we add the cumulative sum of forecasted differences
# to the last observed (original scale) NIFTY 50 closing price.
last_actual <- as.numeric(tail(merged_df$NSEI.Close, 1))
forecast_levels <- last_actual + cumsum(as.numeric(forecast_diff$mean))

# -------------------------------
# 6. Plot the Forecast on the Original Scale
# -------------------------------
par(mfrow = c(1,1))
# Create forecast dates – assuming daily forecast (adjust if needed)
last_date <- as.Date(tail(index(merged_df), 1))
forecast_dates <- seq(last_date + 1, by = "day", length.out = 30)

# Plot historical NIFTY 50
plot(merged_df$NIFTY, type = "l",
     xlab = "Date", ylab = "NIFTY 50 Closing Price",
     main = "NIFTY 50 Forecast (Next 30 Days)",
     col = "black")
# Add forecasted values
lines(forecast_dates, forecast_levels, col = "blue", lwd = 2)

# Print the forecasted levels on the original scale
forecast_levels
