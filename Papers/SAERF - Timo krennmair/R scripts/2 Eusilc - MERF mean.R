#########################################################################
# Advanced Small Area Estimation
#
# Author:    Prof. Dr. Timo Schmid
# Content:   Mixed effect random forests for means                  
#########################################################################
rm(list=ls())


### Install package
# devtools::install_github("krennpa/SAEforest", force = TRUE)

### Load packages
library(SAEforest)
library(caret)
library(dplyr)
library(haven)
### Loading data - population and sample data-----------------------------------
# data("eusilcA_pop")
# data("eusilcA_smp")

# Additional information for SAEforest_model function
help(SAEforest_model)

# INFO CENSAL CEPAL
load("encuesta_mrp.Rdata")
load("statelevel_predictors_df.Rdata")
load("encuesta_df_agg.Rdata")

names(encuesta_mrp)
names(statelevel_predictors_df)


ingreso = encuesta_df_agg$ingreso
X_covar = encuesta_df_agg %>% 
  select(luces_nocturnas, cubrimiento_rural, cubrimiento_urbano,
  modificacion_humana, accesibilidad_hospitales, accesibilidad_hosp_caminado,
  area1, sexo2, edad2, edad3, edad4, edad5, 
  anoest2, anoest3, anoest4, tiene_sanitario, tiene_acueducto, tiene_gas,
  eliminar_basura, tiene_internet, piso_tierra, material_paredes, material_techo,
  rezago_escolar, alfabeta, hacinamiento, tasa_desocupacion)
### Step 1: Model tuning--------------------------------------------------------
# Define target variable and covariates

# income <- eusilcA_smp$eqIncome
# X_covar <- eusilcA_smp[, -c(1, 16, 17, 18)]

# Specific characteristics of Cross-validation
fitControl <- trainControl(method = "repeatedcv", #resampling method
                           number = 5,
                           repeats = 1)

# Define a tuning-grid
merfGrid <- expand.grid(
  num.trees = 50,
  mtry = c(3, 7, 9, 11, 13, 15), # number of variables as split candidates at in each node
  min.node.size = 10, # minimal individual node size
  splitrule = "variance" # regla de corte
)

### VARIABLES------------------------------------------------------------------
tune_parameters(
  Y = ingreso,
  X = X_covar,
  data = encuesta_df_agg,
  dName = "depto",
  trControl = fitControl,
  tuneGrid = merfGrid
)



### Step 2: Estimate MERFs and MSEs---------------------------------------------
model1 <-
  SAEforest_model(
    Y = ingreso,
    X = X_covar,
    dName = "depto", # Character the domain identifier, for which random intercep. are modeled. 
    smp_data = encuesta_df_agg,
    pop_data = encuesta_df_agg,
    meanOnly = TRUE,
    MSE = "nonparametric",
    B = 10,
    B_adj = 30,
    mtry = 13
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
