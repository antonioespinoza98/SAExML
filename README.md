# Estimación de áreas pequeñas mediante modelos de clasificación

--- 

## Contenidos

1. [Revisión bibliográfica](#revisión-bibliográfica)
2. [Configuración de Python](#configuración-python)
    2.1 [Anaconda](#anaconda)
    2.2 [Anaconda Prompt](#anaconda-prompt)
    2.3 [Dirección de instalación](#dirección-de-instalación)
    2.4 [Variables de sistema](#variables-de-sistema)
    2.5 [Command Prompt](#command-prompt)
3. [Configuración de R y Rstudio](#configuración-de-r-y-rstudio)
4. [Visual Studio Code](#visual-studio-code)
    4.1 [Extensiones necesarias](#extensiones)
5. [Control de Versión Git](#git)
6. [Python](#python)
7. [R software](#r)
8. [Contacto](#contacto)
---
## Revisión bibliográfica

Se puede encontrar en [papers](Papers/)

---
## Configuración Python

### Anaconda

Inicialmente se debe descargar el software Anaconda para poder utilizar Python. Para eso, existen dos tipos de instaladores:
    1. MacOS
    2. Windows
Para descargarlo dar seguir el siguiente [enlace](https://www.anaconda.com/download#downloads). Una vez descargado siga las instrucciones del instalador. 
El siguiente paso es agregar la dirección de la carpeta de donde Anaconda está instalado a las variables de ambiente PATH. Para eso siga los siguientes pasos:

### Anaconda Prompt

Una vez instalado, abra *Anaconda Prompt* como se muestra en la siguiente imagen

![prompt](imagenes/readme/prompt.png)

### Dirección de instalación
El siguiente paso es correr el siguiente comando para obtener la dirección de donde anaconda está instalado.

```powershell
where conda
```
Una vez esto, se debería obtener lo siguiente: 

![where](imagenes/readme/where.png)

De esta parte nos va a interesar dos direcciones: 

1. C:\Users\ **%YOURUSER%**\AppData\Local\anaconda3
1. C:\Users\ **%YOURUSER%**\AppData\Local\anaconda3\Scripts

### Variables de sistema

1. Lo primero es buscar las variables del sistema en el ordenador, se ve de la siguiente manera: 

![system](imagenes/readme/environment.png)

2. Siguiente, se debe mostrar una pantalla con las propiedades del sistema, en el cual, vamos a dar clic en *environment variables* como se muestra en la siguiente imagen:

![systemscreen](imagenes/readme/systemprop.png)

3. A partir de aquí, vamos a buscar bajo el cuadro de *user variables for %USER%* y vamos a colocarnos en la variable denominada *path* y vamos a dar clic en *Edit...* como se observa en la siguiente imagen: 

![editvariables](imagenes/readme/edit.png)

4. Por último, vamos a agregar las dos direcciones que se mencionaron en [Dirección de instalación](#dirección-de-instalación). Para esto vamos a dar clic en *New* e ingresamos los dos valores. Una vez realizado esto, damos ok para guardar los cambios. Se debería observar algo como lo siguiente:

![variables](imagenes/readme/variableslistas.png)

### Command Prompt

Como último paso de instalación revisamos que el paso anterior haya funcionado. Para eso abrimos el interprete de *command prompt* y ejecutamos la siguiente línea de código donde especificamos la versión con la que ejecutamos Anaconda.

```powershell
conda --version
```

![comprobacion](imagenes/readme/version.png)

---
## Configuración de R y RStudio
Para la descarga de R como software siga el siguiente [enlace](https://cran.r-project.org/bin/windows/base/). Una vez instalado el software, se debe descargar e instalar la interfaz RStudio para facilitar la creación y lectura de los archivos `.R` o `.Rmd` y demás variaciones.  


---
## Visual Studio Code

Visual Studio Code es un editor de código muy poderoso desarrollo por Microsoft para Windows, MacOS y Linux. Este facilita la capacidad de colaboración entre equipos y da soporte a muchos lenguajes de programación como Python y R. 
Para este caso, vamos a utilizarlo únicamente para desarrollar el código de Python, ya que para R se utiliza la interfaz de Rstudio, refierase a [Configuración de R y RStudio](#configuración-de-r-y-rstudio).
Para la descarga de Visual Studio Code seguir el siguiente [enlace](https://code.visualstudio.com/). Para su instalación siga la instalación por *default*.

### Extensiones

las extensiones requeridas son:

1. R de REditor for Visual Studio Code
2. Python Debugger de Microsoft
3. Python de Microsoft
4. Pylance de Microsoft

Algunas opcionales: 

1. Markdown Preview Enhanced de Yiyi Wang
2. Jupyter Slide Show de Microsoft
3. Jupyter Notebook Renderers de Microsoft
4. Jupyter Keymap de Microsoft
5. Jupyter Cell Tags de Microsoft
6. Jupyter de de Microsoft
7. Excel Viewer de GrapeCity


---
## Git


---
## Python

Una vez realizado los pasos en la sección [Configuración de Python](#configuración-python), [Visual Studio Code](#visual-studio-code) y [Git](#git) se debe crear un ambiente de trabajo con las librerias necesarias para ejecutar el código. Para eso, se va a ejecutar el siguiente código que crea el ambiente basado en un archivo `.yml` que contiene el nombre del ambiente y las dependencias que son las librerias requeridas para ejecutar líneas de código. Este archivo se puede actualizar constantemente con la idea de mantener el ciclo activo de las actualizaciones de las librerias. 
1. Inicialmente vamos a ir a la barra del Visual Studio Code y dar clic en *Terminal* > *New Terminal*. Luego, en la esquina inferior derecha se muestra un símbolo `+` con un menú que se despliega hacia abajo, vamos a dar clic en *Configure Terminal Settings* y eso va a abrir una pestaña aparte con las configuraciones. A partir de acá en la barra de búsqueda buscamos *default* como se muestra en la imagen a continuación:

![default](imagenes/readme/terminal.png)

Posteriormente, buscamos la opción ==Terminal > Integrated > Default Profile: Windows== y en el menú que se despliega seleccionamos **Command Prompt** como intérprete. 

Una vez realizado esto, volvemos a la barra superior de *Visual Studio Code* y en *Terminal* seleccionamos *New Terminal* y esto debería desplegar algo similar a esto

![terminalcmd](/imagenes/readme/terminalcmd.png)

Para crear el ambiente, ejecute el siguiente código en la terminal 

```cmd
conda env create -f environment.yml
```

Una vez creado el ambiente, cada vez que se utilice se debe activar con el siguiente comando

```cmd
conda activate saenv
```

---
## R

Dentro del repositorio se encuentra una carpeta denominada R con los siguientes archivos:

1. Data: La carpeta contiene los archivos generados previamente por Stalyn Guerrero
    - ingreso
    - pobreza
    - pobreza extrema
2. Pobreza 
    - datos: Contiene los archivos de datos depurados para pobreza, realizado por Stalyn Guerrero. 
3. BosquesA.Rmd
    - Archivo de código R donde se emplea el modelo de árboles de decisión
4. Discriminante.Rmd
    - Archivo de código R donde se emplea el modelo de Análisis de Discriminante lineal
5. MERF.Rmd
    - Archivo de código R donde se emplea el modelo Mix Effects Random Forest
6. Preparacion_base.R
    - Archivo de código R donde se prepara la base. Código tomado de los archivos de preparación realizados por Stalyn Guerrero.
7. SAExML.Rproj
    - Archivo proyecto de Rstudio

Para poder correr el código primero se debe clonar el repositorio y posteriormente en Rstudio abrir el proyecto **SAExML.Rproj**
