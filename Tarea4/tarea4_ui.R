tarea4UI <- function(id){
  ns <- NS(id)
  tagList(
    h2("Regresión lineal con MCMC"),
    fluidRow(DT::dataTableOutput(ns("table"))),
    fluidRow(
      sidebarLayout(
        sidebarPanel(
      selectInput(ns("x"),"Selecciona X:", names(tab_vino)),
      selectInput(ns("y"),"Selecciona Y:", names(tab_vino))),
      mainPanel(
        h2("Scatterplot"),
        plotOutput(ns("Grafica"))
      ))),
    fluidRow(
      h3("Distribuciones a elegir:"),
      column(4, selectInput(ns("dist_alpha"),"Alpha",c("Normal","Gamma")) ),
      column(4, selectInput(ns("dist_beta"),"Betha",c("Normal","Gamma")) ),
      column(4, selectInput(ns("dist_sigma"),"Sigma",c("Normal","Gamma")) )
    )
    
    
  )
}