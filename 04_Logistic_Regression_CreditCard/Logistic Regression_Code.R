# Load & inspect
data <- LR_data
summary(data)

# Ensure dependent variable is factor with proper labels
data$`Credit card` <- factor(data$`Credit card`,
                             levels = c(0,1),   # adjust if original coding differs
                             labels = c("notapproved","approved"))
summary(data$`Credit card`)

# ---------------------
# EDA with ggpairs
# ---------------------
library(ggplot2)
library(GGally)
ggpairs(data, columns = c(2,3), ggplot2::aes(colour = data$`Credit card`))

# ---------------------
# Partition of data (80/20 split)
# ---------------------
set.seed(123)
ind <- sample(2, nrow(data), replace = TRUE, prob = c(0.8,0.2))
train <- data[ind==1,]
test  <- data[ind==2,]

# ---------------------
# Logistic regression model
# ---------------------
mymodel <- glm(`Credit card` ~ Income + `Other feed back`,
               data = train,
               family = binomial(link = "logit"))
summary(mymodel)

# ---- Prediction on train set ----
p1 <- predict(mymodel, train)
p1
y=-0.9513822228
exp(y)/(1+exp(y))
p1 <- predict(mymodel, train, type = "response")
p1
# Convert probabilities to factor predictions

pred1 <- factor(ifelse(p1 > 0.5, "approved", "notapproved"),
                levels = c("notapproved","approved"))
pred1

# Confusion matrix - train
tab1 <- table(actual = train$`Credit card`, predicted = pred1)
tab1

# Misclassification error - train
train_error <- 1 - sum(diag(tab1)) / sum(tab1)
train_error

# ---- Prediction on test set ----
p2 <- predict(mymodel, test, type = "response")

pred2 <- factor(ifelse(p2 > 0.5, "approved", "notapproved"),
                levels = c("notapproved","approved"))

# Confusion matrix - test
tab2 <- table(actual = test$`Credit card`, predicted = pred2)
tab2

# Misclassification error - test
test_error <- 1 - sum(diag(tab2)) / sum(tab2)
test_error

# ---------------------
# Plot S-curves
# ---------------------
train$`Credit card` <- relevel(factor(train$`Credit card`), ref = "notapproved")

ggplot(train, aes(x = Income, y = as.numeric(`Credit card`)-1)) +
  geom_point(aes(color = `Credit card`)) +
  stat_smooth(method = "glm",
              method.args = list(family = "binomial"),
              formula = y ~ x, se = F) +
  labs(y = "Probability(approved)", title = "Logistic Regression S-curve (Income)")



test$`Credit card` <- relevel(factor(test$`Credit card`), ref = "notapproved")

ggplot(test, aes(x = Income, y = as.numeric(`Credit card`)-1)) +
  geom_point(aes(color = `Credit card`)) +
  stat_smooth(method = "glm",
              method.args = list(family = "binomial"),
              formula = y ~ x, se = F) +
  labs(y = "Probability(approved)", title = "Logistic Regression S-curve (Income)")



# ---------------------
# 3D Probability Surface
# ---------------------
library(plotly)

income_seq <- seq(min(train$Income), max(train$Income), length.out = 50)
feedback_seq <- seq(min(train$`Other feed back`), max(train$`Other feed back`), length.out = 50)

grid <- expand.grid(Income = income_seq, `Other feed back` = feedback_seq)

grid$prob <- predict(mymodel, newdata = grid, type = "response")

z_matrix <- matrix(grid$prob, nrow = length(income_seq), ncol = length(feedback_seq))

plot_ly(
  x = income_seq,
  y = feedback_seq,
  z = z_matrix,
  type = "surface"
) %>%
  layout(
    scene = list(
      xaxis = list(title = "Income"),
      yaxis = list(title = "Other feedback"),
      zaxis = list(title = "Probability(Approved)")
    )
  )

# ---------------------
# ROC Curve & AUC
# ---------------------
library(pROC)
library(caret)
roc_train <- roc(train$`Credit card`, p1, levels = c("notapproved", "approved"))
roc_test  <- roc(test$`Credit card`,  p2, levels = c("notapproved", "approved"))

plot(roc_train, col = "darkgreen", lwd = 2, main = "ROC Curves (Train & Test)")
plot(roc_test, col = "blue", lwd = 2, add = TRUE)
abline(a = 0, b = 1, lty = 2, col = "red")

legend("bottomright",
       legend = c(paste("Train AUC =", round(auc(roc_train),3)),
                  paste("Test AUC =", round(auc(roc_test),3))),
       col = c("darkgreen", "blue"), lwd = 2)

# ---------------------
# Precision, Recall, F1-score
# ---------------------
library(caret)

# Train metrics
train_conf <- confusionMatrix (pred1, train$`Credit card`, positive = "approved")
train_conf

# Test metrics
test_conf <- confusionMatrix(pred2, test$`Credit card`, positive = "approved")
test_conf
