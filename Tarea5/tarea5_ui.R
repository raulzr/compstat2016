tarea5UI <- function(id){
  ns <- NS(id)
  tagList(
    h2("Regresión lineal con MCMC"),
    fluidRow(
      h3("Distribuciones a elegir:"),
      column(4, selectInput(ns("dist_alpha"),"Alpha",c("Normal","Gamma")) ),
      column(4, selectInput(ns("dist_beta"),"Betha",c("Normal","Gamma")) ),
      column(4, selectInput(ns("dist_sigma"),"Sigma",c("Normal","Gamma")) )
    )
    
  )
}