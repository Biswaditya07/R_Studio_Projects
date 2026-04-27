# NIFTY 50 Forecasting Using S&P 500 with ARIMAX Time Series Model

## 📌 Project Overview
This project focuses on forecasting the **NIFTY 50 Index** using an advanced **ARIMAX (AutoRegressive Integrated Moving Average with Exogenous Variables)** model in **R Programming**. The model uses historical NIFTY 50 prices as the target variable and **S&P 500 Index** movements as an external predictor to improve forecasting accuracy.

The project demonstrates how global market trends can influence domestic indices and how time series modeling can be applied for financial forecasting.

## 👨‍💼 Author
**Biswaditya07 (Biswaditya Saha)**  
MBA in Business Analytics

## 🛠️ Tools & Technologies Used
- R Programming  
- Yahoo Finance Data  
- Time Series Forecasting  
- ARIMAX Model  
- Libraries Used:
  - `quantmod`
  - `tidyquant`
  - `dplyr`
  - `xts`
  - `forecast`
  - `tseries`

## 📂 Files Included
| File Name | Description |
|-----------|-------------|
| `NIFTY_ARIMAX_Forecasting.R` | R script for forecasting NIFTY 50 using S&P 500 |
| `nifty_data.csv` | Downloaded NIFTY 50 historical data |
| `sp500_data.csv` | Downloaded S&P 500 historical data |

## 📊 Project Objective
To predict future **NIFTY 50 closing prices** for the next 30 days by incorporating the effect of **S&P 500 market trends** using ARIMAX time series modeling.

## 📈 Project Workflow

### 1️⃣ Data Collection
Historical stock index data is downloaded from Yahoo Finance:

- **NIFTY 50 (`^NSEI`)**
- **S&P 500 (`^GSPC`)**

Date Range:
- `2025-03-06` to `2026-03-17`

### 2️⃣ Data Cleaning & Preparation
- Removed missing values  
- Converted date fields  
- Created `xts` time series objects  
- Exported data into CSV files

### 3️⃣ Data Visualization
Closing prices are plotted to observe trend and volatility.

```r
plot(nifty_xts$NSEI.Close)
plot(sp500_xts$GSPC.Close)
````

### 4️⃣ Stationarity Testing

ADF Test is used to check whether the time series is stationary.

```r id="btvg0e"
adf.test(nifty_xts$NSEI.Close)
adf.test(sp500_xts$GSPC.Close)
```

If non-stationary, first differencing is applied.

### 5️⃣ Merge Time Series Data

Both indices are aligned by trading dates for comparative modeling.

### 6️⃣ Build ARIMAX Model

```r id="w04t2w"
arimax_model <- auto.arima(nifty_ts, xreg = sp500_ts)
```

* **Dependent Variable:** NIFTY 50
* **Independent Variable:** S&P 500

### 7️⃣ Forecast Future Prices

```r id="ukqhlv"
forecast_values <- forecast(arimax_model, xreg = future_sp500, h = 30)
```

Forecasts next **30 trading days** of NIFTY.

### 8️⃣ Convert Forecast to Original Scale

Forecasted differenced values are converted back into actual index levels.

### 9️⃣ Visualization of Forecast

Historical prices and future predicted prices are plotted together.

## 📊 Business Applications

* Stock Market Forecasting
* Trading Strategy Support
* Global Market Impact Analysis
* Investment Decision Making
* Risk Management
* Portfolio Optimization
* Financial Analytics

## 🔍 Key Learnings

* Financial Time Series Forecasting
* Working with Yahoo Finance Data in R
* Stationarity Testing using ADF
* Differencing Time Series Data
* ARIMAX Modeling with External Variables
* Multi-market Dependency Analysis
* Forecasting Stock Indices

## 💻 Sample Code

```r id="4mnspl"
library(quantmod)
library(forecast)

nifty_data <- getSymbols("^NSEI", src="yahoo", auto.assign=FALSE)
sp500_data <- getSymbols("^GSPC", src="yahoo", auto.assign=FALSE)

arimax_model <- auto.arima(nifty_ts, xreg = sp500_ts)

forecast(arimax_model, xreg = future_sp500, h = 30)
```

## 🚀 Conclusion

This project demonstrates how external macro-market indicators such as the **S&P 500** can be used to forecast the **NIFTY 50 Index** using ARIMAX modeling. It combines financial data engineering, statistical testing, and predictive analytics to support market decision-making.

## ⭐ Support

If you like this project, give it a **star ⭐** on GitHub and connect for more analytics projects.
