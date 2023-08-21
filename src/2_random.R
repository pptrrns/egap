# ====================================
# Actividad 2: Aleatorización
# Guía EGAP, 10 cosas que debes saber sobre aleatorización: https://egap.org/es/resource/10-cosas-que-debe-saber-sobre-la-aleatorizacion/
# ====================================

#Vamos a explorar *cómo* randomizar el tratamiento, utilizando los datos de los participantes de los Learning Days que usamos ayer.
# En el experimento que realizamos ayer, los instructores aleatorizaron quién recibió qué tratamiento.
# Hoy, harás ese paso, explorando varias formas diferentes de hacerlo.
# En la clase hablamos de varias formas diferentes de randomizar, útiles en diferentes entornos experimentales.
# En este ejercicio, probarás la mayoría de ellas.

# ========================================================================
# Ejercicio 1: Carga los datos de la última sesión
# Puedes usar exactamente el mismo código que usaste para el otro ejercicio
# ========================================================================

#Tu código aquí:

#Opcion 1, poner el path hacia Exercises_spanish, por ejemplo: 
#setwd("/Users/reginalopez/Dropbox/2023_LD_LATAM_Shared_Docs (1)/LD Workshop Materials Participants/Exercises_spanish")
setwd("/Users/jtorrensh/Documents/GitHub/egap/src")
dir()

#Así, puedes simplemente cargar los datos a partir de la carpeta Exercises_spanish
experiment_data <- read.csv("data_for_analysis.csv")

#Opción 2, puedes leer tus con el path completo hacia ellos, por ejemplo:
#experiment_data <- read.csv("/Users/reginalopez/Dropbox/2023_LD_LATAM_Shared_Docs (1)/LD Workshop Materials Participants/Exercises_spanish/data_for_analysis.csv")
experiment_data <- read.csv("YOUR_PATH_TO_data_for_analysis.csv") 

#La opción 1 es recomendable cuando tienes tus datos y scripts organizados en un mismo lugar,
#pero a veces la opción 2 es más prácrita para análisis rápidos

# ========================================================================

#Ejercicio 2: Aleatorice a los participantes en dos condiciones de tratamiento utilizando una aleatorización simple
#En lecture: Aleatorizacón simple (Lanzamiento de moneda)
# En este primer ejercicio, le explicaremos cómo aleatorizar a detalle. Luego puedes adaptar este código para randomizar de otras maneras más adelante en la sesión.
# Antes de comenzar, establezca una semilla. Nuevamente, esto es para que siempre pueda replicar el resultado de su aleatorización.
# Es una forma de "arreglar" su aleatorización.
# Coloque cualquier número entre los paréntesis a continuación, por ejemplo "123"

# ========================================================================

# ROSARIO: Le doy números a la computadora para la aletorización, para poder replicable. No son puramente aleatorios pero sí suficientemente aleatorios para el estudio

set.seed(4020)

#El siguiente paso para comenzar es cargar el tidyverse. Recuerde, necesitamos cargar el tidyverse en cada sesión de R cuando queremos usarlo.

library(tidyverse)

# ========================================================================

#ROSARIO: SIMPLE RANDOMIZATION (COIN-FLIPPING), slide 9
#Ahora, tomaremos el objeto experiment_data, le agregaremos una variable llamada treatment_simple, que será un estado de tratamiento asignado al azar y randomizado usando una aleatorización simple. Así es como:

experiment_data <- experiment_data %>%
  mutate(treatment_simple = rbinom(n = n(), size = 1, prob = 0.5)) #ROSARIO: La probabilidad de asignación puede ser entre 0 y 1

#Veremos lo que sucedió aquí. En la primera línea, le estamos diciendo a R que use el objeto experiment_data y que sobrescriba el antiguo objeto experiment_data.
# En la segunda línea le estamos diciendo a R que queremos mutar o modificar el conjunto de datos. Creamos una nueva variable llamada treatment_simple dentro del marco de datos experiment_data.
# Para crear esa nueva variable usamos la función rbinom, que toma algunas entradas y luego devuelve una variable aleatoria binomial.
# En este caso proporcionamos tres entradas: el n, que es cuántos 0 y 1 queremos; el tamaño, que es que queremos tomar un sorteo de tamaño 1 de la distribución binomial, por lo que será 0 y 1; y la probabilidad de un 1 es 0.5 (el argumento prob).
# Para establecer el argumento n, usamos una función práctica llamada n(), que calcula cuántas filas hay en un marco de datos. En este caso, el número de 0 y 1 que queríamos tenía que ser el mismo que el número de filas en el marco de datos ya que cada fila es un encuestado.
# Para resumir: usamos una función para asignar aleatoriamente 0 y 1 que representan el tratamiento y el control, y los guardamos en una nueva variable. Esa nueva variable es la que usaría para asignar el tratamiento, para decir que una persona recibe tratamiento y otra persona recibe control.

# =============================================================================
#Ejercicio 2: Verifique su aleatorización
# Después de asignar al azar, querrá asegurarse de que funcionó. Haga algunas comprobaciones. En este caso, debe haber aproximadamente, pero no necesariamente exactamente, la mitad de los sujetos asignados al tratamiento.
# Parte A:
# Inspeccione los datos y verifique que hay algunas personas con tratamiento y algunas con control.
# ¿Puedes ver la variable que creaste, tratamiento_simple? ¿Hay algunos tratados y algunos controles? Respuesta:
# Parte B:
# Cuente el número de tratados y controles usando la función count.
# =============================================================================

experiment_data %>% count(treatment_simple)


#¿Cuántos hay en cada grupo? Respuesta:

# ROSARIO: COMPLETE RANDOMIZATION, DRAWING FROM AN URN, Slide 12
# =============================================================================
#Ejercicio 3: Randomice a los participantes en dos condiciones de tratamiento utilizando una asignación aleatoria completa
# Ahora hará lo mismo que en el Ejercicio 1, pero utilizará una asignación aleatoria completa en lugar de una asignación aleatoria simple.
# Ejecute el código a continuación e inspeccione la variable en el marco de datos
# =============================================================================

treatment_statuses <- c(rep(1,14), rep(0,15))

experiment_data <- experiment_data %>%
  mutate(treatment_complete = sample(treatment_statuses, size = 29, replace = FALSE))

# =============================================================================
#Ejercicio 4: Verifique su aleatorización completa
# Parte A:
# Inspeccione los datos y verifique que hay algunas personas con tratamiento y algunas con control.
# ¿Puedes ver la variable que creaste, tratamiento_completo? ¿Hay algunos tratados y algunos controles? Respuesta:
# Parte B:
# Cuente el número de tratados y controles usando la función count. Debe haber exactamente el número de unidades tratadas y de control que configuró en vec.
# =============================================================================

experiment_data %>% count(treatment_complete)

#¿Cuántos hay en cada grupo? ¿Es eso lo que esperabas? Respuesta:


# =============================================================================
#Ejercicio 5: Usando randomizr para hacer asignación aleatoria completa
# Ahora vamos a aprender cómo usar el paquete randomizr en R, que le permite hacer muchas formas comunes de asignación aleatoria fácilmente.
# Paso 1: cargue el paquete randomizr - exactamente como lo hizo para tidyverse pero con randomizr en lugar de tidyverse
# =============================================================================

install.packages('randomizr') # Ejecuta este código solo una vez si no tienes randomizr instalado, luego coméntalo poniendo un # al principio de la línea. / Português: Execute este código apenas uma vez se você não tiver o randomizr instalado, depois comente-o colocando um # no início da linha.

library(randomizr)

#Paso 2: aleatorizar usando la función complete_ra

experiment_data <- experiment_data %>%
  mutate(treatment_complete2 = complete_ra(N = n(), prob = 0.5))

#Paso 3: verifique si funcionó usando las mismas técnicas que usó anteriormente (inspeccione y use count)

# ROSARIO: BLOCK OR STRATIFIED RANDOMIZATION I, Slide 15
# ROSARIO: Sigue siendo aleatorio, podemos controlar la composición de nuestras condiciones
# =============================================================================
#Ejercicio 6: Usando randomizr para hacer asignación aleatoria en bloques. ROSARIO: Slide 15
# Debido a que ahora ha aprendido a usar randomizr, puede hacer esquemas de asignación aleatoria más complejos con más facilidad. Intentemos la asignación aleatoria por bloques.
# Como recordatorio, la asignación aleatoria por bloques es donde tomas un conjunto de bloques (también conocidos como estratos) y haces mini experimentos dentro de ellos. Los bloques provienen de sus datos: pueden ser variables que representan el género o las ciudades o una combinación de múltiples variables. Usaremos el género de los participantes aquí. En este caso, la asignación aleatoria por bloques significa que realizará dos mini experimentos, uno entre mujeres y otro entre hombres, pero lo hará todo a la vez.
# Paso 1: identifique la variable de bloque. Inspeccione el marco de datos y descubra cuál es el nombre de la variable de género. Tenga en cuenta que las variables son "sensibles a mayúsculas y minúsculas", lo que significa que si hay letras mayúsculas, es importante recordarlo.
# =============================================================================

#¿Cómo se llama la variable? Respuesta:

# =============================================================================
#Paso 2: Aleatorizar. Para hacer esto, utilizará la función block_ra, y la diferencia entre block_ra y complete_ra es que debe decirle a block_ra cuál es la variable de bloque. Ya no necesitará decirle el N, porque el software puede averiguarlo a partir de la variable de bloque.
# =============================================================================

experiment_data <- experiment_data %>%
  mutate(treatment_blocked = block_ra(blocks = gender, prob = 0.5))

# =============================================================================
#Paso 3: verifique los datos usando inspect y count
# =============================================================================
#Pon tu código aquí

experiment_data %>% count(gender, treatment_blocked)
  
# =============================================================================
#¿Hay aproximadamente el mismo número *dentro de cada bloque* tratado? Como en, ¿son tratados el mismo número de hombres que el número de mujeres que son tratadas? (Tenga en cuenta que si hay números impares, por supuesto, no será exactamente igual).
# =============================================================================

#Respuesta:


# =============================================================================
# ROSARIO: CLUSTER RANDOMIZATION I, Slide 17
#Creamos un vector para hacer clusters
cluster_id <- c(1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13,14,14,15)
experiment_data<- experiment_data %>% mutate(cluster_id)

#Aleatorizamos clusters, en pares 
experiment_data$Z <- cluster_ra(clusters=cluster_id)