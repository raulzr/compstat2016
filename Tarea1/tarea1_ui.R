tarea1UI <- function(id){
  ns <- NS(id)
  tagList(
    titlePanel("Generacion de datos con distribucion exponencial"),
    
    sidebarLayout(
      sidebarPanel(
        sliderInput(ns("muestras"),"Muestras de tamano 10^n:",1,4,4),
        sliderInput(ns("rate"),"Rate o promedio de exponencial:",1,5,1)
      ),
      mainPanel(
        titlePanel("Muestra uniforme"),
        plotlyOutput(ns("UniGraf")),
        titlePanel("Datos con distribucion exponencial generada"),
        plotlyOutput(ns("ExpGraf")),
        helpText("Para confirmar que nuestra muestra sigue una distribucion exponencial usaremos una prueba de bondad de ajuste, en nuestro caso Kolmogorov-Smirnov"),
        verbatimTextOutput(ns("prueba")),
        helpText("Dado el valor del p-value y asignando un valor de corte de 0.05, podemos decir que:"),
        verbatimTextOutput(ns("vered"))
      )
    )

)}