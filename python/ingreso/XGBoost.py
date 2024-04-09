from sklearn.ensemble import HistGradientBoostingRegressor
from sklearn.model_selection import cross_val_score
import pandas as pd
import pyreadr
import numpy as np
from itertools import product
# De acuerdo a Poverty Mapping in the Age of Machine Learning se prueban tres 
# modelos de XGBoost 

result = pyreadr.read_r("R/ingreso/datos/encuesta_mrp1.rds")
print(result.keys())
encuesta_mrp = result[None]

encuesta_mrp.drop(columns = ["area1", "sexo2", "edad2", "edad3", "edad4",
                             "edad5","anoest2", "anoest3", "anoest4", "discapacidad1",
                             "etnia1", "lp", "li", "fep", "pobreza"], inplace = True)


encuesta_mrp = encuesta_mrp.apply(lambda x: x.astype('category') if x.dtype == 'object' else x)
encuesta_mrp['dam'] = encuesta_mrp['dam'].replace({'01': 1, '02': 2, '03': 3, '04': 4, '05': 5, '06': 6})

# MODELO

# Crear un grid
grid = pd.DataFrame(product(range(3, 7), [round(x, 2) for x in np.arange(0.2, 0.36, 0.01)]), columns=['max_depth', 'eta'])

xgb_train_rmse = np.zeros(len(grid))

y = encuesta_mrp.iloc[:, 2]
X = encuesta_mrp.iloc[:, :-3].apply(pd.to_numeric)

for i in range(len(grid)):
    model = HistGradientBoostingRegressor(
        max_iter=100,
        learning_rate=grid['eta'][i],
        max_depth=grid['max_depth'][i]
    )
    # Cross-validation
    scores = cross_val_score(model, X, y, cv=5, scoring='neg_mean_squared_error')
    train_rmse = np.sqrt(-scores.mean())
    
    xgb_train_rmse[i] = train_rmse
    print(i)

xgb_train_rmse



















