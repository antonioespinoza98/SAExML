#########################################################################
# Advanced Small Area Estimation
#
# Author:    Prof. Dr. Timo Schmid
# Content:   Mixed effect random forests for means                  
#########################################################################
rm(list=ls())

### Install package
devtools::install_github("krennpa/SAEforest", force = TRUE)

### Load packages
library(SAEforest)
library(caret)

### Loading data - population and sample data-----------------------------------
data("eusilcA_pop")
data("eusilcA_smp")

# Additional information for SAEforest_model function
help(SAEforest_model)

### Step 1: Model tuning--------------------------------------------------------
# Define target variable and covariates
income <- eusilcA_smp$eqIncome
X_covar <- eusilcA_smp[, -c(1, 16, 17, 18)]

# Specific characteristics of Cross-validation
fitControl <- trainControl(method = "repeatedcv",
                           number = 5,
                           repeats = 1)

# Define a tuning-grid
merfGrid <- expand.grid(
  num.trees = 50,
  mtry = c(3, 7, 9),
  min.node.size = 10,
  splitrule = "variance"
)

tune_parameters(
  Y = income,
  X = X_covar,
  data = eusilcA_smp,
  dName = "district",
  trControl = fitControl,
  tuneGrid = merfGrid
)

### Step 2: Estimate MERFs and MSEs---------------------------------------------
model1 <-
  SAEforest_model(
    Y = income,
    X = X_covar,
    dName = "district",
    smp_data = eusilcA_smp,
    pop_data = eusilcA_pop,
    meanOnly = TRUE,
    MSE = "nonparametric",
    B = 10,
    B_adj = 30,
    mtry = 7
  )

### Step 3: Assess the estimated model------------------------------------------
summary(model1)
plot(model1)

### Step 4: Extract the results------------------------------------------------- 
head(summarize_indicators(model1, MSE = TRUE, CV =TRUE))

### Step 5: Visualize the results-----------------------------------------------
load_shapeaustria()
map_indicators(
  object = model1,
  MSE = FALSE,
  CV = FALSE,
  map_obj = shape_austria_dis,
  indicator = c("Mean"),
  map_dom_id = "PB"
)


