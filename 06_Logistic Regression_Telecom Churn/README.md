# Tractor Sales Forecasting using Exponential Smoothing Methods

## Project Overview

This project focuses on **Time Series Forecasting** of tractor sales using **Exponential Smoothing Techniques** in **R**.

Three forecasting methods were applied:

- **Single Exponential Smoothing (SES)**
- **Double Exponential Smoothing (Holt’s Method)**
- **Triple Exponential Smoothing (Holt-Winters Method)**

The goal is to analyze historical tractor sales data, identify trend and seasonality, and forecast future sales accurately.

---

## Dataset Information

The dataset contains monthly tractor sales data.

| Feature | Description |
|--------|-------------|
| Month / Time Period | Monthly observations |
| Sales | Tractor units sold |

The time series starts from:

- **January 2003**

With monthly frequency:

- **12 observations per year**

---

## Project Objectives

- Analyze historical tractor sales trends
- Detect seasonality patterns
- Build forecasting models
- Compare smoothing techniques
- Predict future tractor sales

---

## Libraries Used

```r
forecast
fpp2
````

---

## Project Workflow

### 1. Data Loading & Visualization

Imported tractor sales dataset and created line plots to understand movement over time.

Used:

```r
plot()
ts()
```

Generated:

* Basic line chart
* Monthly sales trend chart

---

### 2. Time Series Conversion

Converted sales data into time series format:

```r
ts(data, frequency = 12, start = c(2003,1))
```

This enables monthly forecasting analysis.

---

### 3. Seasonal Analysis

Used:

```r
ggseasonplot()
monthplot()
```

To identify:

* Repeating seasonal patterns
* Strong and weak months
* Year-over-year sales movement

---

### 4. Time Series Decomposition

Used Multiplicative Decomposition:

```r
decompose(type = "multiplicative")
```

Separated sales into:

* Trend
* Seasonality
* Irregular components

---

### 5. Train-Test Split

Data divided into:

| Dataset      | Period      |
| ------------ | ----------- |
| Training Set | 2003 - 2012 |
| Testing Set  | 2013 - 2014 |

Used to validate forecast accuracy.

---

## Forecasting Models Applied

### 1. Single Exponential Smoothing (SES)

Best for:

* No trend
* No seasonality

Used:

```r
ses()
```

---

### 2. Double Exponential Smoothing (Holt’s Method)

Best for:

* Trend present
* No seasonality

Used:

```r
holt()
```

---

### 3. Triple Exponential Smoothing (Holt-Winters)

Best for:

* Trend present
* Seasonality present

Used:

```r
hw(seasonal = "multiplicative")
```

This is most suitable for tractor sales data.

---

## Model Evaluation

Forecasted values were compared against actual test data using:

```r
accuracy()
```

Common metrics:

* RMSE
* MAE
* MAPE
* Forecast Error

---

## Visualization Outputs

Generated:

* Historical Sales Trend
* Seasonal Plot
* Polar Seasonal Plot
* Monthly Plot
* Decomposition Plot
* Forecast Plots
* Actual vs Predicted Comparison

---

## Key Insights

* Tractor sales show clear seasonal behavior.
* Trend exists over years.
* Triple Exponential Smoothing performs best when seasonality is strong.
* Forecasting helps inventory and production planning.

---

## Business Use Cases

Useful for:

* Tractor manufacturers
* Agricultural equipment distributors
* Supply chain planning
* Demand forecasting
* Production scheduling
* Revenue planning

---

## Project Files

| File Name         | Description                    |
| ----------------- | ------------------------------ |
| Tractor Data.R    | Complete forecasting code in R |
| Tractor-Sales.csv | Monthly tractor sales dataset  |

---

## How to Run

1. Open R / RStudio
2. Install required libraries
3. Load CSV file
4. Run `Tractor Data.R`
5. Review plots, forecasts, and accuracy metrics

---

## Key Learnings

* Time Series Analysis in R
* Forecasting using SES, Holt, Holt-Winters
* Trend & Seasonality Detection
* Model Accuracy Comparison
* Business Demand Forecasting


## Conclusion

This project demonstrates practical forecasting of tractor sales using Exponential Smoothing methods. Among all methods, **Triple Exponential Smoothing (Holt-Winters)** is generally the most effective when both trend and seasonality exist.

---

## Author
Biswaditya07 (Biswaditya Saha)
```

