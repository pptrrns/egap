# ===========================================================================
# Actividad 1: Los fundamentos
# ===========================================================================

# Bienvenido a R! En esta primera actividad, le ayudaremos a tener una idea del análisis de datos básicos en R.
# Objetivos: aprender a cargar datos, inspeccionar los datos para ver qué variables hay y realizar resúmenes básicos de datos.

# <- Este es un comentario en el código. Los usaremos para dar instrucciones.

# ===========================================================================
# Ejercicio 1: Empezando
# ===========================================================================

# Has descargado los archivos y datos relevantes para hacer nuestro primer ejercicio de R. ¡Genial!

# Veamos si las cosas funcionan: ¿ves todos los archivos relevantes en tu "directorio"?
# Para hacer esto, puede usar la función:

dir()

# (Una función es un comando R. Cuando ejecuta una función, proporciona entradas (a veces ninguna) y R hace algo y devuelve salidas).
# La función dir() no toma entradas (por eso no hay nada dentro de los paréntesis) y devuelve una lista de los archivos en el *directorio actual*.

# En los ejercicios, a partir de la línea a continuación, para ejecutar un comando, puede colocar el cursor en la línea de código y presionar CTRL+ENTER (Windows) o COMMAND+ENTER (Mac)
# También puede copiar y pegar la línea de código en la "Consola". La consola está en otra parte de la pantalla.

# Pregunta 1: ¿El archivo de datos con el que trabajamos está en la lista que devolvió la función? Si no es así, consulte a un instructor.

# Respuesta

#Si no, usa la función setwd("Path to the folder")

# =============================================
# Ejercicio 2: Importando los datos
# =============================================

# Con los paquetes cargados, ahora podemos leer los datos. Eso significa que R leerá el archivo y luego lo agregará como un objeto a su "espacio de trabajo" donde podemos analizarlo.
# Podemos hacer esto a través de la función read_csv, que toma un nombre de archivo que proporciona y lee ese archivo y crea un objeto de datos R, llamado marco de datos.
#install.packages("readr")

library(readr) #paquete necesario para leer los datos. 

experiment_data <- read.csv("data_for_analysis.csv")

# 3 partes de la línea de código anterior ^

# Pregunta: encuentre la pestaña "entorno" en su ventana de RStudio.
# Pida ayuda a un instructor o a alguien a su lado si no lo ve.
# ¿Aparece el objeto llamado experiment_data en el entorno?

# Respuesta:

# Ahora retrocedamos un momento para explicar lo que acabamos de hacer.
# Hubo tres partes en lo que escribimos: la llamada a la función - read_csv ("data_for_analysis.csv") - que ejecuta la función read_csv.
# Luego estaba <- que es cómo le damos a ese objeto un nombre y lo guardamos.
# La tercera parte es el nombre.
# Así que cuando lees esa línea de código, vamos a leer los datos del archivo data_for_analysis.csv y guardarlos en el objeto llamado experiment_data.

# ===================================================================
# Ejercicio 3: Inspeccionar los datos
# ===================================================================

# Tómese un momento para mirar los datos en sí. Para hacer esto, encuentre la pestaña Entorno y haga clic una vez en el objeto experiment_data. Esto abre el "visor de datos". Este es siempre un buen lugar para empezar a ver qué hay en los datos.
# Pregunta: ¿cuáles son los nombres de las variables en los datos?

# Respuesta:

#gender, local, treatment, block id, state of world

# ===================================================================
# Ejercicio 4: instalar el tidyverse y cargar paquetes
# ===================================================================

# Ahora vamos a cargar el paquete tidyverse. Un "paquete" en R es una colección de funciones (comandos), datos y documentación que es como un kit de herramientas.
# El tidyverse es una familia de paquetes que están diseñados para trabajar juntos.
# Vamos a empezar por instalarlo.
# Tiene que descargar, así que debe estar conectado al wifi.
# ¡Esto puede llevar un tiempo si el internet es lento!

# install.packages("tidyverse") # install all the packages in the tidyverse family / installez tous les paquets du tidyverse / instala todos los paquetes de tidyverse / instala todos os pacotes da família tidyverse

# Pregunta: ¿Qué mensaje ves en la consola R cuando se ha instalado el tidyverse?

# Ahora vamos a cargar el paquete tidyverse. Para hacer esto, utilizas otra función "library()" que hace que todos los recursos del paquete estén disponibles para ti en tu sesión de R.
# Incluso después de que un paquete haya sido instalado, necesitas usar la función library() para cargarlo en cada sesión de R cuando quieras usar sus recursos.

install.packages("tidyverse")
library(tidyverse)

# Si el tidyverse se ha instalado correctamente, deberías ser capaz de cargarlo usando library().
# Si el tidyverse no se carga, por favor pide ayuda a un instructor o vecino.
# Pregunta: ¿Qué mensaje ves en la consola R cuando cargas el tidyverse usando library()?

# Respuesta:


# ===================================================================

# Ejercicio 5: modificar los datos

# ===================================================================

# A continuación vamos a aprender cómo manipular, o modificar, un data frame. Esto es útil si quieres crear una nueva variable, o cambiar una variable existente.
# Vamos a manipular nuestro data frame modificándolo y luego escribiendo sobre el original.

experiment_data %>% # comencemos con el conjunto de datos experiment_data y luego...
  mutate(cerveza = 1, # mutar agregando una nueva variable llamada "cerveza" que toma un valor de 1 para todos 
         mezcal = c(0, 1, 0, 1, 0, 1, 0, 1, 10, 11, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1), # mutar agregando una nueva variable llamada "mezcal" que toma un valor de 0, 1, 10, o 11
         mexicano = if_else(country == "Mexico City", 1, 0))

# Una vez que ejecutamos esas líneas de código vemos que hay nuevas columnas a la derecha llamadas cerveza, mezcal, y cote_divoire. ¡Eso es genial!
# Sin embargo, para que esta nueva columna se guarde en nuestro conjunto de datos, también necesitamos escribir sobre el objeto de datos original.

# ¿Cuál es la diferencia entre esta línea de código y la de arriba?

experiment_data <- experiment_data %>% # la flecha <- asigna la nueva versión modificada de experiment_data al nombre experiment_data 
  mutate(cerveza = 1, # mutar agregando una nueva variable llamada "cerveza" que toma un valor de 1 para todos 
         mezcal = c(0, 1, 0, 1, 0, 1, 0, 1, 10, 11, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1), # mutar agregando una nueva variable llamada "mezcal" que toma un valor de 0, 1, 10, o 11
         mexicano = if_else(country == "Mexico City", 1, 0))

# Ahora nuestra modificación (las nuevas columnas) se guarda en el conjunto de datos, y podemos usar las nuevas variables en el futuro.

# Después de haber creado o modificado una variable, es una buena idea inspeccionarla. Puede hacer esto inspeccionando visualmente los datos en la pestaña "Environment", pero a menudo es útil contar los diferentes valores de su variable.
# Una forma rápida de contar los valores de una variable es la función "count()".

experiment_data %>% count(cerveza) # tome experiment_data y luego cuente los valores de la variable cerveza 
experiment_data %>% count(mezcal)
experiment_data %>% count(mexicano)

# Pregunta: ¿Cuántas unidades toman cada valor en la variable mezcal?

# Finalmente, puede preguntarse sobre un nuevo comando. ¿Qué significa el símbolo "%>%"?
# Estos se llaman "pipes" y le dicen a R que siga trabajando en una secuencia de pasos. Puede leerlos como "y luego..." porque conducen a la siguiente acción que desea realizar.

# ============================================
# Ejercicio 6: resumir datos
# ============================================

# Otra tarea común en el análisis de datos es resumir los datos. Es posible que desee conocer el valor promedio de una variable, el máximo o la varianza.
# R tiene otra función de envoltura poderosa para ayudarlo a calcular este tipo de estadísticas resumidas: summarise().
# Comencemos con un ejemplo: tomemos la media y la desviación estándar de la variable mezcal.

experiment_data %>%
  summarise(mean(mezcal, na.rm = T),
            sd(mezcal, na.rm = T))

# Vemos que la media de mezcal es 1.29 y la desviación estándar es 2.70.
# También podemos dar nombres a esas estadísticas que son más fáciles de leer y usar.

experiment_data %>%
  summarise(mezcal_mean = mean(mezcal, na.rm = T),
            mezcal_sd = sd(mezcal, na.rm = T))

# Pregunta: ¿Cuáles son la media, el máximo y el mínimo de la variable mexicano?

#Su código aquí

summary(experiment_data$mexicano)

mean(experiment_data$mexicano)
max(experiment_data$mexicano)
min(experiment_data$mexicano)

# ===================================================

# Ejercicio 7: filtrar los datos

# ===================================================

# Lo último que aprenderemos ahora es cómo filtrar los datos, o mirar solo un subconjunto de las observaciones.
# Esto es útil si queremos saber algo sobre un subconjunto de las observaciones y se usa a menudo en combinación con summarise().
# Comencemos filtrando por género para que solo estemos mirando a las participantes femeninas en el experimento.

experiment_data %>%
  filter(gender == "Female")

# Debería ver solo 12 de las 29 observaciones en el conjunto de datos que se imprimen, y todas tienen "F" en la variable Género.
# Este código ha "filtrado" los datos para que solo mantenga las observaciones donde gender == "Female".

# También podemos usar count() y summarise() para ejecutar funciones de resumen solo en este grupo.
# Aquí es donde las "pipes" son realmente útiles.
# Comencemos contando los valores de la variable té solo para las participantes femeninas.

experiment_data %>%
  filter(gender == "Female") %>%
  count(mezcal)

# Preguntas: ¿Cuántas mujeres en los datos quieren mezcal (mezcal es igual a 1)? ¿Cuántas mujeres en los datos no quieren mezcal (mezcal es igual a 0)?

#Respuesta:
# También podemos usar filter() con summarise().
# Modifique el código a continuación para calcular la media de mezcal solo para *hombres*.

experiment_data %>%
  filter(gender == "Male") %>%
  summarise(mezcal_mean = mean()) #¿quién tiene el código correcto aquí? 

experiment_data %>%
  filter(gender == "Male") %>%
  summarise(mezcal_mean = mean(mean))

# Pregunta: ¿Cuál es la media de mezcal para los hombres en los datos?
experiment_data %>%
  filter(gender == "Male") %>%
  summarise(mezcal_mean = mean(mezcal))

#Respuesta: