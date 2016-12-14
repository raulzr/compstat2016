tarea5UI <- function(id){
  ns <- NS(id)
  tagList(
    h2("Regresión lineal con MCMC - 2"),
    sidebarLayout(
      sidebarPanel(
        h3("Distribuciones prior"),
        strong("Alpha - Dist. Normal"),
        numericInput(ns("alpha_m"),"Media:",0),
        numericInput(ns("alpha_sd"),"SD:",1000),

        strong("Beta - Dist. Normal"),
        numericInput(ns("beta_m"),"Media:",0),
        numericInput(ns("beta_sd"),"SD:",1000),
        
        strong("Sigma - Dist. Gamma"),
        numericInput(ns("shape"),"Forma:",0),
        numericInput(ns("scale"),"Escala:",1000)
      ),
      mainPanel(
        fluidRow(column(sliderInput(ns("no_sim"),"Numero de sim 10^n:",1,4,4), width = 3),
                 column(selectInput(ns("x"),"Selecciona X:", names(tab_vino)), width = 3),
                 column(selectInput(ns("y"),"Selecciona Y:", names(tab_vino)), width = 3)
                 ),
        fluidRow(h2("Simulaciones: "),actionButton(ns("sim_boton"), "A simular !!!")),
        fluidRow((ns("Grafica"))),
        fluidRow(plotOutput(ns("Grafica"))),
        h3("Resultados: "),
        textOutput(ns("resultado"))
                 
        
      ))
    
  )
}