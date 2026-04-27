# Car Price Prediction Using Linear Regression in R
This repository contains an end-to-end Regression Modeling project using R to predict car prices from automobile specification data. The project includes missing value analysis, data cleaning, feature selection, model building, evaluation, and business interpretation.

## Project Objective
To build a Linear Regression Model that predicts **Car Price** using important automobile features and evaluate model performance using test data.

## Dataset Used

### imports_85.csv
Automobile dataset containing technical and design features such as:
- Symboling
- Normalized Losses
- Make
- Fuel Type
- Aspiration
- Number of Doors
- Body Style
- Drive Wheels
- Wheel Base
- Length
- Width
- Height
- Curb Weight
- Engine Type
- Number of Cylinders
- Engine Size
- Bore
- Stroke
- Compression Ratio
- Horsepower
- Peak RPM
- City MPG
- Highway MPG
- Price

## Files Included

### 1. Assignment_Regression Model_Final.R
R script containing:
- Missing value detection
- Missing pattern analysis
- Imputation techniques
- Outlier checks
- Train-test split
- Linear regression model
- Prediction on test data
- Error metrics
- Actual vs Predicted graph

### 2. imports_85.csv
Raw automobile dataset used for modeling.

### 3. Regression_Model_Assignment.pdf
Detailed project report explaining methodology, preprocessing logic, visuals, and final conclusions.

## Libraries Used
- mice
- VIM
- Hmisc

## Project Workflow

## 1. Missing Value Analysis
Performed:
- `is.na()`
- `which()`
- `summary(is.na())`
- `md.pattern()`
- `md.pairs()`
- `aggr()`
Detected missing values in:
- price
- normalized-losses
- num-of-doors
- bore
- stroke
- horsepower
- peak-rpm

## 2. Data Cleaning & Imputation

### Target Variable Missing Values
Rows with missing **price** removed.

### Imputation Methods Used
- `num-of-doors` → logical/manual category fill
- `bore` → mean imputation
- `stroke` → mean imputation
- `normalized-losses` → mean imputation
- Missing Renault records with horsepower / rpm removed

## 3. Train-Test Split
- 80% Training Data
- 20% Testing Data
Using random seed for reproducibility.

## 4. Final Regression Model
Dependent Variable:
- Price
Independent Variables:
- Width
- Horsepower
- Engine Size

Model:
price ~ width + horsepower + engine-size

## Model Performance

### Training Performance
- Multiple R² = **0.8254**
- Adjusted R² = **0.8221**
Model explains approximately **82% price variation**.

### Test Performance
- MSE = **10,333,605**
- RMSE = **3214.59**
- MAE = **2160.37**
- Test R² = **0.7180**
Model predicts around **72% of unseen data accurately**.

## Visualization Included
- Missing value plots
- Distribution checks
- Correlation insights
- Actual vs Predicted scatter plot

## Key Business Insights
- Car width, horsepower, and engine size strongly influence price.
- Engine specifications are major pricing drivers.
- Clean preprocessing significantly improves prediction quality.
- Model can support pricing strategy and resale valuation.

## Skills Demonstrated
- Regression Modeling
- Data Cleaning
- Missing Value Treatment
- Feature Selection
- Predictive Analytics
- Error Metrics Interpretation
- Business Analytics in R

## Business Use Cases
- Automobile price estimation
- Competitor pricing strategy
- Used car valuation
- Product positioning
- Revenue forecasting

## Author
Biswaditya07  
MBA in Business Analytics
