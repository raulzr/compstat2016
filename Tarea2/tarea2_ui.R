tarea2UI <- function(id){
  ns <- NS(id)
  tagList(
  
  #titlePanel("Old Faithful Geyser Data"),
  #titlePanel("Hola")
    
    # numericInput(ns('n'), 'Number of obs', 100),
    # plotOutput(ns('plot')),
  
    
    h2("Integración con Monte-Carlo"),
    textInput(inputId=ns("expresion1"),label="Escribe una funcion f a integrar",value="function(x) 2*x"),
    numericInput(ns("valA"),"Integrar desde - Minimo X",0),
    numericInput(ns("valB"),"Integrar hasta - Maximo X",20),
    plotOutput(ns("Grafica")),
    textOutput(ns("Resultado"))
  
  
  
  
  
)}