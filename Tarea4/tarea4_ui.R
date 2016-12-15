tarea4UI <- function(id){
  ns <- NS(id)
  tagList(
    h2("Regresión lineal con MCMC - Visualización"),
    
    column(
    fluidRow(
      column(selectInput(ns("x"),"Selecciona X:", names(tab_vino), selected = 'Ash'), width = 3),
      column(selectInput(ns("y"),"Selecciona Y:", names(tab_vino), selected = 'AlcalinityOfAsh'), width = 3),
      plotOutput(ns("Grafica"))
      )
    , width = 6),
    column(fluidPage(DT::dataTableOutput(ns("table")))
           , width = 6)

    )
}