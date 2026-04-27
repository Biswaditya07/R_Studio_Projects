# Telecom Churn Prediction using Logistic Regression

## 📌 Project Overview
This project focuses on predicting **customer churn in the telecom industry** using a **Logistic Regression Model** in **R Programming**. Churn prediction helps telecom companies identify customers who are likely to leave the service, allowing businesses to take proactive retention measures.

The model is built using customer behavior and service-related variables such as tenure, number of complaints, prepaid/postpaid status, long call usage, and short call usage. The project includes data splitting, model training, probability prediction, confusion matrix evaluation, ROC curve analysis, and prediction for new customers.

## 👨‍💼 Author
**Biswaditya07 (Biswaditya Saha)**  
MBA in Business Analytics

## 🛠️ Tools & Technologies Used
- R Programming  
- CSV Dataset  
- Logistic Regression  
- Libraries Used:
  - `caTools`
  - `lessR`
  - `ROCR`

## 📂 Files Included
| File Name | Description |
|-----------|-------------|
| `logistic_regression_Full(1).R` | R script for Telecom Churn Prediction using Logistic Regression |
| `telecom_churn(1).csv` | Dataset containing telecom customer churn records |

## 📊 Business Problem
Customer churn is one of the biggest challenges in telecom businesses. Acquiring new customers costs more than retaining existing ones. This project helps identify customers who are likely to churn so companies can improve customer satisfaction and reduce revenue loss.

## 📈 Dataset Features
The model uses the following variables:

- `tenure` → Duration of customer relationship  
- `no_of_complaints` → Number of complaints raised  
- `Prepaid` → Prepaid customer indicator  
- `Long` → Long duration call usage  
- `Short` → Short duration call usage  
- `churn` → Target variable (Yes/No)

## 📊 Project Workflow

### 1️⃣ Data Inspection
Dataset structure is checked before modeling.

```r
str(telecom_churn)
````

### 2️⃣ Train-Test Split

Dataset is divided into training and validation sets.

```r id="4vlb7r"
library(caTools)

set.seed(1234)
split <- sample.split(telecom_churn$churn, 0.8)

train <- subset(telecom_churn, split == TRUE)
vali  <- subset(telecom_churn, split == FALSE)
```

* 80% Training Data
* 20% Validation Data

### 3️⃣ Logistic Regression Model Building

```r id="jv6p9x"
library(lessR)

model <- Logit(churn ~ tenure + no_of_complaints + Prepaid + Long + Short, data = train)
```

The model predicts probability of churn using selected independent variables.

### 4️⃣ Validation Prediction

```r id="yy2vc0"
res <- predict(model, vali, type = "response")
```

Returns churn probabilities between 0 and 1.

### 5️⃣ Confusion Matrix & Accuracy

```r id="yrudve"
confmatrix <- table(
Actual_value = vali$churn,
Predicted_value = res > 0.5
)

(confmatrix[1,1] + confmatrix[2,2]) / sum(confmatrix)
```

Used to evaluate model performance.

### 6️⃣ Training Predictions

```r id="k6a0b5"
res_train <- predict(model, train, type = "response")
```

Used for ROC analysis.

### 7️⃣ ROC Curve Analysis

```r id="c9ceax"
library(ROCR)

ROCRPred = prediction(res_train, train$churn)
ROCRPref = performance(ROCRPred, "tpr", "fpr")

plot(ROCRPref, colorize = TRUE, print.cutoffs.at = seq(0.1, by = 0.1))
```

ROC curve evaluates classification power across thresholds.

### 8️⃣ Predict Churn for New Customers

```r id="z7p4ho"
pred <- read.csv("pred.csv")

res_new <- predict(model, pred, type = "response")
```

### 9️⃣ Export Final Predictions

```r id="m4ndnq"
pred$churn <- ifelse(res_new > 0.5, "churn", "not churn")

write.csv(pred, "predict_churn_output.csv", row.names = FALSE)
```

Outputs final churn classification file.

## 📊 Model Output Metrics

* Accuracy
* Confusion Matrix
* Probability Scores
* ROC Curve
* Threshold-based Classification

## 📈 Business Applications

* Customer Retention Strategy
* Churn Prevention Campaigns
* Personalized Offers
* Complaint Resolution Prioritization
* Revenue Protection
* Customer Lifetime Value Optimization

## 🔍 Key Learnings

* Binary Classification using Logistic Regression
* Data Splitting in R
* Model Probability Prediction
* Confusion Matrix Evaluation
* ROC Curve Interpretation
* Predictive Analytics for Telecom Industry

## 💻 Sample Code

```r id="7ccrwl"
library(caTools)
library(lessR)

split <- sample.split(telecom_churn$churn, 0.8)

model <- Logit(churn ~ tenure + no_of_complaints + Prepaid + Long + Short, data = train)

predict(model, vali, type = "response")
```

## 🚀 Conclusion

This project provides practical exposure to **customer churn prediction using Logistic Regression**. It demonstrates how telecom companies can use historical customer data to identify churn risk and take proactive actions to improve retention and profitability.

## ⭐ Support

If you like this project, give it a **star ⭐** on GitHub and connect for more analytics projects.
