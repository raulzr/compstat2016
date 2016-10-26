tarea2UI <- function(id){
  ns <- NS(id)
  tagList(
    h2("Integración con Monte-Carlo"),
    sidebarLayout(
      sidebarPanel(
        textInput(inputId=ns("expresion1"),label="Escribe una funcion f a integrar",value="function(x) 2*x"),
        numericInput(ns("valA"),"Integrar desde - Minimo X",0),
        numericInput(ns("valB"),"Integrar hasta - Maximo X",20),
        sliderInput(ns("Int_conf"), "% de Intervalo de confianza:",min = 0, max = 1, value = 0.95, step= 0.05)
      ),
      mainPanel(
        plotOutput(ns("Grafica")),
        textOutput(ns("Resultado"))
      )
      
    )
  
)}