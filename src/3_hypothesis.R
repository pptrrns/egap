# ==============================================
# Español: Actividad 3: Pruebas de hipótesis
# Português: Atividade 3: Testes de hipóteses
# ==============================================

# Español: En esta sesión de R repasaremos los pasos para realizar una prueba de hipótesis
# utilizando el enfoque de la inferencia de aleatorización.

# Português: Nesta sessão de R, passaremos pelas etapas para realizar um teste de hipótese
# usando a abordagem de inferência de aleatorização.

# Español: Veremos cómo podemos obtener los diferentes ingredientes que vimos ayer en la clase.
# Português: Veremos como podemos obter os diferentes ingredientes que vimos ontem na aula.

# ====================================================================================
# Español: Cargue el paquete tidyverse y los datos de la última sesión
# Puede usar el mismo código que usó en los otros ejercicios

# Português: Carregue o pacote tidyverse e os dados da última sessão
# Você pode usar o mesmo código que usou nos outros exercícios
# ====================================================================================
# Español: Su código aquí:
# Português: Seu código aqui:

library(tidyverse)

# Setting the working directory: 
setwd("/Users/jtorrensh/Documents/GitHub/egap/src")
dir()
# Por ejemplo: setwd("/Users/reginalopez/Dropbox/2023_LD_LATAM_Shared_Docs/LD Workshop Materials Participants/Exercises_spanish)

experiment_data <- read.csv("data_for_analysis_2023T.csv") #Ahora usaremos datos de otro Workshop :) 
dim(experiment_data)
str(experiment_data)

experiment_data
table(experiment_data$block_id)

# ====================================================================================
# Español: Ejercicio 2: Los ingredientes
# Português: Exercício 2: Os ingredientes
# ====================================================================================

# Español: Paso 1: Datos de resultado
# Português: Etapa 1: Dados de resultado


# Español: Paso 2: Procedimiento de aleatorización
# Português: Etapa 2: Procedimento de aleatorização


# Español: Para el experimento de hace rato utilizamos la aleatorización en bloques, pero para este ejercicio
# fingiremos que utilizamos la aleatorización completa.

# Português: Para o experimento de ontem, usamos a aleatorização em blocos, mas para este exercício
# vamos fingir que usamos a aleatorização completa.

# Español: Paso 3: Hipótesis nula: ¿Cuál es la hipótesis nula que usamos para la inferencia de aleatorización? (nula estricta)
# Português: Etapa 3: Hipótese nula - Qual é a hipótese nula que usamos para a inferência de aleatorização? (nulo estrito)

# Español: Paso 4: Estadístico de prueba: vamos a usar la diferencia de medias. Calcule la estadística de prueba observada.
# Consejo: puede usar el código de la sesión de estimación. ¿Qué necesitamos?

# Português: Etapa 4: Estatística de teste - Vamos usar a diferença de médias. Calcule a estatística de teste observada.
# Dica: você pode usar o código da sessão de estimação. Do que precisamos?

# Español: Su código aquí:
# Português: Seu código aqui:

ObservedMeanTT<-experiment_data %>%
  filter(treatment==1) %>%
  summarise(mean(state_of_world, na.rm=TRUE))

ObservedMeanCC<-experiment_data %>%
  filter(treatment==0) %>%
  summarise(mean(state_of_world, na.rm=TRUE))

# Español: La estadística de prueba observada
# Português: A estatística de teste observada

observedMeanDiff <- ObservedMeanTT - ObservedMeanCC
observedMeanDiff

# Español: Paso 5: Obtener el p-valor
# Português: Etapa 5: Obter o p-valor


# Español: Preguntas: 1. ¿Cuál es nuestro N?
# Português: Perguntas: 1. Qual é o nosso N?

experiment_data %>%
  summarise(n())

# Español: Otra manera
# Português: Outra maneira

#N<- length(experiment_data$treatment)

# Español: 2. ¿Cuál es nuestro m?
# Português: 2. Qual é o nosso m?

m<-sum(experiment_data$treatment)


# Español: ¿Cuál es nuestro resultado? ¿Y nuestro tratamiento?
# Português: Qual é o nosso resultado? E nosso tratamento?

experiment_data %>% select(state_of_world)
experiment_data %>% select(treatment)

Y<- experiment_data$state_of_world
T<- experiment_data$treatment
N<-dim(experiment_data)[1]
N
m

# Español: 3. ¿Cuántas asignaciones aleatorias posibles podríamos obtener?
# Português: 3. Quantas atribuições aleatórias possíveis poderíamos obter?

choose(27,13) #29 muestra MX


# Español: Otra asignación aleatoria posible podría ser:
# Português: Outra atribuição aleatória possível poderia ser:

set.seed(1234)
T1<-sample(T, size = N, replace=FALSE)


# Español: o
# Português: ou

set.seed(5678) # ¿Por qué establecemos semillas diferentes? | Por que definimos sementes diferentes?
T2<-sample(T, size = N, replace=FALSE)


# Español: Veamos ambos vectores:
# Português: Vamos ver ambos vetores:

T
T1
T2

# ==================================================================
# Español: Ejercicio 3: Inferencia de aleatorización usando el paquete RI2
# Português: Exercício 3: Inferência de aleatorização usando o pacote RI2
# ==================================================================

# Español: Instalar el paquete ri2:
# Português: Instalar o pacote ri2:

#install.packages("ri2")
library(ri2)

# Español: ri2 no puede funcionar sin library(randomizr) y library(estimatr)
# Português: ri2 não pode funcionar sem library(randomizr) e library(estimatr)

library(randomizr)
library(estimatr)

declaration <- declare_ra(N = N, m = m)


# Valor p para una o dos colas?
# Funcion de ri2
RI_exp <- conduct_ri(state_of_world ~ treatment,
                     declaration = declaration, assignment = "treatment",
                     sharp_hypothesis = 0, data = experiment_data, sims = 500, p = "two-tailed")

summary(RI_exp)

# Español: ¿Cómo aumentaría el número de simulaciones a 1.000?
# Português: Como aumentar o número de simulações para 1.000?

# ==================================================================

# Español: Pruebas de hipótesis usando regresión. Usaremos el comando
# lm_robust del paquete `estimatr`.

# Português: Testes de hipóteses usando regressão. Usaremos o comando
# lm_robust do pacote `estimatr`.
# ==================================================================

#install.packages("estimatr")
# library(estimatr) loaded with ri2! | chargé avec ri2! | cargado con ri2! | carregado com ri2!
library(estimatr)
lm_robust(state_of_world~treatment, data=experiment_data)

# Español: También podríamos haber incorporado el hecho de que "aleatorizamos por bloques"
# usando el comando difference_in_means también del paquete `estimatr`.

# Português: Nós também poderíamos ter incorporado o fato de que "aleatorizamos por blocos"
# usando o comando difference_in_means também do pacote `estimatr`.

?difference_in_means
difference_in_means(state_of_world ~ treatment, blocks = block_id, data = experiment_data)
lm_robust(state_of_world~treatment + as.factor(block_id), data = experiment_data)


# ------------------- EXTRAS ------------------ #

# Español: Bonus: También podríamos haber usado una simulación para obtener valores p de inferencia de aleatorización.
# Recordemos el experimento de la sesión de ayer.

# Português: Bônus: Também poderíamos ter usado uma simulação para obter valores p de inferência de aleatorização.
# Vamos lembrar o experimento da sessão de ontem.

# Español: 1. Creemos los datos
# Português: 1. Vamos criar os dados

N <- 10

## Español: y0 es el PO bajo control
## Português: y0 é o PO sob controle

y0 <- c(0, 30, 0, 1, 11, 23, 34, 45, 190, 200)

## Español: Diferentes efectos de tratamiento a nivel individual
## Português: Diferentes efeitos de tratamento no nível individual

tau <- c(10, 30, 200, 90, 10, 20, 30, 40, 90, 20)

## Español: y1 es el PO bajo tratamiento
## Português: y1 é o PO sob tratamento

y1 <- y0 + tau


# Español: 2. Asignar tratamiento
# Português: 2. Atribuir tratamento

library(randomizr)
set.seed(12345)
T <- complete_ra(N)


# Español: 3. Revelar los resultados observados
# Português: 3. Revelar os resultados observados

Y <- T * y1 + (1 - T) * y0

dat <- data.frame(Y = Y, T = T, y0 = y0, tau = tau, y1 = y1)


# Español: 4. La fórmula de la estadística de prueba
# Português: 4. A fórmula da estatística de teste

meanTT <- function(ys, z) {
  mean(ys[z == 1]) - mean(ys[z == 0])
}


# Español: La estadística de prueba observada
# Português: A estatística de teste observada

observedMeanTT <- meanTT(ys = Y, z = T)
observedMeanTT 


# Español: Obtener la distribución usando el enfoque 2
# Português: Obter a distribuição usando a abordagem 2

repeatExperiment <- function(N) {
  complete_ra(N)
}
set.seed(123456)
possibleMeanDiffsH0 <- replicate(
  10000,
  meanTT(ys = Y, z = repeatExperiment(N = 10))
)


# Español: Gráfico:
# Português: Gráfico:

pdf("./RI_ex.pdf",
    width = 5, height = 5)

plot(density(possibleMeanDiffsH0),
     ylim = c(0, .04),
     xlim = range(possibleMeanDiffsH0),
     lwd = 2,
     main = "", # Mean Difference Test Statistic",
     xlab = "Mean Differences Consistent with randomization and H0",
     cex.lab = 1, cex.axis = 1
)
rug(possibleMeanDiffsH0)
rug(observedMeanTT, col="#EBCC2A",lwd = 3, ticksize = .51)
text(observedMeanTT - 4, .022, "Observed Test Statistic")

dev.off()

# Español: Obtengamos nuestros valores p: (recuerde, sabemos que hay un efecto para algunos individuos)
# Português: Vamos obter nossos valores p: (lembre-se, sabemos que há um efeito para alguns indivíduos)

# Español: Unilateral:
# Português: Unilateral:

possibleMeanDiffsH0
observedMeanTT

pMeanTT <- mean(possibleMeanDiffsH0 <= observedMeanTT)
pMeanTT
mean(observedMeanTT>=possibleMeanDiffsH0)


# Español: Bilateral:
# Português: Bilateral:

pMeanTT2<-sum(abs(possibleMeanDiffsH0)<=observedMeanTT)/length(possibleMeanDiffsH0)
pMeanTT2
