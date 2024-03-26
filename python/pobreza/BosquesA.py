############################################################
############  LIBRERIAS
############
############################################################
from sklearn.model_selection import train_test_split
from sklearn import preprocessing, utils, tree
import pyreadr
import pandas as pd
import graphviz
import matplotlib.pyplot as plt
from graphviz import Source
############################################################
############  BASE DE DATOS
############
############################################################
# BASE DE DATOS
## Como la base está en un archivo RData, se utiliza el paquete de pyreadr para poder leerlo en Python.

result = pyreadr.read_r("./data/pobreza/base.Rdata")
print(result.keys())
base = result["base"]
## Ahora se crea la base de datos de entrenamiento y de prueba
## Revisamos que la base de datos esté completa
base.head()
list(base.columns)
# 1 se  considera pobre
#2 se considera no pobre
############################################################
############  ENTRENAMIENTO/PRUEBA
############
############################################################
X = base.drop(base.columns[5], axis=1)
y = base.iloc[:, 5]
list(X.columns)
X_train, X_test, y_train, y_test = train_test_split(X, y, train_size=0.8, random_state= 25)
lab_enc = preprocessing.LabelEncoder()
y_train = lab_enc.fit_transform(y_train)
print(utils.multiclass.type_of_target(y_train))

############################################################
############  MODELO
############
############################################################
clf = tree.DecisionTreeClassifier()
clf = clf.fit(X, y)

tree.plot_tree(clf, feature_names= list(X.columns),filled=True, proportion=True,node_ids=True)
plt.show()

dot_data = tree.export_graphviz(clf, out_file=None,
                                proportion= True,
                                filled=True, rounded=True,
                                feature_names= list(X.columns),
                                class_names= True,  
                                special_characters=True)  
graph = graphviz.Source(dot_data)  
graph.render(view= True, format= "png", directory= "./imagenes/python")

############################################################
############  UTILIZANDO ENCUESTA PARA MODELO
############
############################################################

encuesta = pyreadr.read_r("./data/pobreza/encuesta_mrp.rds")
censo = pyreadr.read_r("./data/pobreza/censo_mrp.rds")

print(encuesta.keys())

encuesta_mrp = encuesta[None]
censo_mrp = censo[None]

censo_mrp = censo_mrp.drop(columns=['X2016_crops.coverfraction', 'X2016_urban.coverfraction', 'X2016_gHM', 'accessibility',
                                     'accessibility_walking_only', 'area1', 'sexo2','edad2','edad3','edad4','edad5','anoest2',
                                     'anoest3','anoest4','discapacidad1','etnia1','n','etnia'])
censo_mrp = censo_mrp.apply(lambda x: x.astype('category') if x.dtype == 'object' else x)

print(censo_mrp.describe())

# Para encuesta_mrp DataFrame
encuesta_mrp = encuesta_mrp.drop(columns=['X2016_crops.coverfraction', 'X2016_urban.coverfraction', 'X2016_gHM',
                                           'accessibility', 'accessibility_walking_only', 'area1',
                                             'sexo2', 'edad2', 'edad3','edad4','edad5','anoest2','anoest3','anoest4','discapacidad1',
                                             'etnia1','lp','li','fep','ingreso'])
encuesta_mrp['dam'] = encuesta_mrp['dam'].replace({'01': 1, '02': 2, '03': 3, '04': 4, '05': 5, '06': 6})
encuesta_mrp = encuesta_mrp.apply(lambda x: x.astype('category') if x.dtype == 'object' else x)

encuesta_mrp['dam'] = encuesta_mrp['dam'].astype('category')
encuesta_mrp['pobreza'] = encuesta_mrp['pobreza'].astype('category')

list(encuesta_mrp.columns)

X = encuesta_mrp.drop(columns = ['pobreza'])
y = encuesta_mrp.iloc[:, 6]
list(X.columns)

# X_train, X_test, y_train, y_test = train_test_split(X, y, train_size=0.8, random_state= 25)
# lab_enc = preprocessing.LabelEncoder()
# y_train = lab_enc.fit_transform(y_train)
# print(utils.multiclass.type_of_target(y_train))


clf = tree.DecisionTreeClassifier(ccp_alpha=0.001)

clf = clf.fit(X, y)

tree.plot_tree(clf, feature_names= list(X.columns),filled=True, proportion=True,node_ids=True)
plt.show()

dot_data = tree.export_graphviz(clf, out_file=None,
                                proportion= True,
                                filled=True, rounded=True,
                                feature_names= list(X.columns),
                                class_names= True,  
                                special_characters=True)  
graph = graphviz.Source(dot_data)  
graph.render(view= True, format= "png", directory= "./imagenes/python")

############################################################
############  PREDICT
############
############################################################

clf.predict(censo_mrp)