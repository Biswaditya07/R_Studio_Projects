# Missing Data Imputation Using R | Car Dataset
This repository contains a complete Missing Data Imputation project using R on an automobile dataset. The project focuses on identifying missing values, analyzing missingness patterns, selecting suitable imputation techniques, cleaning the dataset, and preparing data for predictive modeling.

## Project Objective
To detect, analyze, and replace missing values in a car dataset using statistical and data-driven imputation methods.

## Dataset Used
### car details v4_missing.csv
Used car dataset containing vehicle specifications and pricing data with intentionally missing values.

### Key Variables
- Price
- Kilometer
- Engine
- Length
- Width
- Height
- Seating Capacity
- Fuel Tank Capacity

## Files Included

### 1. Missing_Data_Imputation_Assignment.R
R script containing:
- Missing value detection
- Missing pattern analysis
- Correlation study
- Visualization
- Variable-wise imputation
- Export cleaned dataset

### 2. car details v4_missing.csv
Raw dataset with missing values used for preprocessing.

### 3. Missing_Data_Imputation_Assignment.pdf
Detailed project report with stepwise explanation, plots, logic, and interpretations.

## Libraries Used
- mice
- VIM
- Hmisc
- ggplot2
- corrplot
- openxlsx

## Missing Value Analysis
Performed using:
- `is.na()`
- `which()`
- `sum(is.na())`
- `summary()`
- `md.pattern()`
- `md.pairs()`
- `aggr()`
- `pbox()`

## Key Findings
- Total Missing Values = **123**
- Rows with complete data = **426 / 535**
- Missingness approximately **20%** of dataset
- Since missing values exceed 5%, deletion was avoided except target variable rows.

## Target Variable Treatment
Rows where **Price** was missing were removed before imputation.

## Imputation Strategy Used

## Variable-wise Treatment
### Kilometer
- Outliers present
- Used **Median Imputation**
### Engine
- Outliers present
- Used **Median Imputation**
### Length
- Nearly symmetric distribution
- Used **Mean Imputation**
### Width
- Mild outliers, balanced curve
- Used **Mean Imputation**
### Height
- Right-skewed distribution
- Used **Median Imputation**
### Seating Capacity
- Discrete / categorical nature
- Used **Mode Imputation**
### Fuel Tank Capacity
- Right-skewed with outliers
- Used **Median Imputation**
- 
## Visualization Included
- Missing pattern heatmaps
- Missing pair matrices
- Correlation matrix
- Density plots
- Histograms
- Boxplots
- Scatter plots
- Relationship charts using ggplot2

## Data Export
Final cleaned dataset exported as Excel file for future modeling.

## Key Business Insights
- Fuel Tank Capacity had the highest missingness.
- Vehicle dimensions and engine variables show meaningful relationships.
- Proper imputation preserves valuable records instead of deleting data.
- Clean data improves future machine learning and pricing models.

## Skills Demonstrated
- Data Cleaning
- Missing Value Treatment
- Exploratory Data Analysis
- Statistical Imputation
- Data Visualization
- Feature Understanding
- R Programming

## Business Use Cases
- Automotive analytics
- Used car price prediction preprocessing
- Customer listing quality improvement
- Data preparation for ML pipelines

## Author
Biswaditya07 (Biswaditya Saha)  
MBA in Business Analytics
