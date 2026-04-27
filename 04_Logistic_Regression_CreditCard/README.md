# Credit Card Approval Prediction using Logistic Regression

## Project Overview
This project builds a **Logistic Regression** model in **R** to predict whether a credit card application will be **Approved (1)** or **Not Approved (0)** based on customer/application data.
The model was evaluated using multiple classification metrics such as:
- Accuracy  
- Precision  
- Recall  
- F1 Score  
- Confusion Matrix  
- ROC Curve  
- AUC Score  

## Dataset Information
The dataset contains the following variables:
| Feature | Description |
|--------|-------------|
| Income | Applicant income level |
| Other feed back | Additional customer feedback/input |
| Credit card | Target Variable (0 = Not Approved, 1 = Approved) |

## Project Workflow

### 1. Data Loading & Preprocessing
- Imported CSV dataset  
- Checked structure and summary statistics  
- Converted target variable into factor labels:  
  - `notapproved`  
  - `approved`

### 2. Exploratory Data Analysis
Performed data exploration using:
- `summary()`  
- `GGally::ggpairs()`
To analyze feature relationships and class patterns.

### 3. Train-Test Split
Dataset divided into:
- **80% Training Data**  
- **20% Testing Data**
Using random sampling with `set.seed(123)`.

### 4. Model Building
Built Logistic Regression model using:
glm(`Credit card` ~ Income + `Other feed back`, family = binomial)

### 5. Prediction
Converted probabilities into class labels using threshold:
* Probability > 0.5 = Approved
* Else = Not Approved
* 
## Model Evaluation
The model was evaluated on both Training and Testing datasets using:
* Confusion Matrix
* Accuracy Score
* Misclassification Error
* Precision
* Recall
* F1 Score
* ROC Curve
* AUC Score
This helps assess performance and overfitting.

## Visualizations

### Logistic Regression S-Curve
Shows probability of approval based on Income.

### 3D Probability Surface
Interactive surface plot using:
* Income
* Other feed back
* Probability of Approval

### ROC Curve
Compared Train vs Test ROC curves.

## Libraries Used
ggplot2
GGally
plotly
pROC
caret

## Project Files
| File Name                      | Description                       |
| ------------------------------ | --------------------------------- |
| Logistic Regression_Final(3).R | Complete R source code            |
| LR data(3).csv                 | Dataset used for training/testing |

## Business Use Case
This model can help banks and financial institutions:
* Automate credit card approval decisions
* Reduce manual review time
* Improve decision consistency
* Identify strong applicants quickly

## Key Learnings
* Binary Classification using Logistic Regression
* Probability Based Prediction
* Performance Evaluation Metrics
* ROC & AUC Analysis
* Data Visualization in R

## Author
Biswaditya07 (Biswaditya Saha)
