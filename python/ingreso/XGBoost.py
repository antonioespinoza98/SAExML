from sklearn.ensemble import HistGradientBoostingRegressor
from sklearn.model_selection import cross_val_score
from sklearn.metrics import mean_squared_error
import pandas as pd
import pyreadr
import numpy as np
from itertools import product
import matplotlib.pyplot as plt
import openpyxl
# De acuerdo a Poverty Mapping in the Age of Machine Learning se prueban tres 
# modelos de XGBoost 

# Inicialmente se lee la encuesta con todas las covariables
result = pyreadr.read_r("R/ingreso/datos/encuesta_mrp1.rds")
print(result.keys())
encuesta_mrp = result[None]
# Se dejan únicamente las covariables de interés
encuesta_mrp.drop(columns = ["area1", "sexo2", "edad2", "edad3", "edad4",
                             "edad5","anoest2", "anoest3", "anoest4", "discapacidad1",
                             "etnia1", "lp", "li", "fep", "pobreza"], inplace = True)

# Aplicamos un par de transformaciones a las clases de las variables
encuesta_mrp = encuesta_mrp.apply(lambda x: x.astype('category') if x.dtype == 'object' else x)
encuesta_mrp['dam'] = encuesta_mrp['dam'].replace({'01': 1, '02': 2, '03': 3, '04': 4, '05': 5, '06': 6})

# -----------------------------
# MODELO
# -----------------------------
# Crear un grid para la validación
grid = pd.DataFrame(product(range(3, 7), [round(x, 2) for x in np.arange(0.2, 0.36, 0.01)]), 
                    columns=['max_depth', 'eta'])
# Creamos un vector vacío para almacenar el RMSE de la validación cruzada que nos permitirá 
# escoger el mejor modelo con los parámetros de ajuste adecuados.
xgb_train_rmse = np.zeros(len(grid))
# Sacamos un vector con la variable dependiente
y = encuesta_mrp.iloc[:, 2]
# Sacamos una base con solo las covariables
X = encuesta_mrp.iloc[:, :-3] #.apply(pd.to_numeric)

for i in range(len(grid)):
    # Ajustamos un bodelo de GradientBoosting con la función HisTGradientBoostingRegressor
    # Esta función a comparación con la función GradientBoostingRegressor es que tiene mejor rendimiento
    # Con bases de datos más grandes.
    model = HistGradientBoostingRegressor(
        # Generamos 100 iteraciones lo que significa que tenemos 100 árboles de regresión
        max_iter=100,
        # El learning rate que utilizamos es el que establecimos inicialmente en el arreglo grid
        learning_rate=grid['eta'][i],
        # El max depth que vamos a utilizar para la profundidad de los árboles
        max_depth=grid['max_depth'][i]
    )
    # Cross-validation
    scores = cross_val_score(model, X, y, cv=5, scoring='neg_mean_squared_error')
    train_rmse = np.sqrt(-scores.mean())
    
    xgb_train_rmse[i] = train_rmse
    print(i)



ite = pd.DataFrame(list(range(1, 65, 1)), columns = ['ite'])
xgb_train_rmse = pd.DataFrame(xgb_train_rmse, columns= ['RMSE'])

simulacion = pd.concat([ite, xgb_train_rmse], axis = 1)

plt.plot(simulacion["ite"], simulacion["RMSE"])
plt.xlabel("Iteración")
plt.ylabel("RMSE")
plt.show()

simulacion.to_excel("./python/ingreso/output/simulacion1.xlsx")
grid.iloc[np.argmin(xgb_train_rmse.values)]
# Los parámetros sugeridos son max depth de 5 y un learning rate de 0.31

modelo = HistGradientBoostingRegressor(
    learning_rate=0.31,
    max_iter = 1000,
    max_depth = 5
).fit(X, y)

result = pyreadr.read_r("R/ingreso/datos/censo_mrp1.rds")
print(result.keys())
censo_mrp = result[None]

censo_mrp.drop(columns = ["distrito", "area1", "sexo2", "edad2", "edad3",
                          "edad4", "edad5", "anoest2", "anoest3", "anoest4",
                          "discapacidad1", "etnia1"], inplace = True)

pred = modelo.predict(censo_mrp)