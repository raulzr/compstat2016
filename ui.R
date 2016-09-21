
library(shiny)

shinyUI(fluidPage(
  
  tabsetPanel(
    tabPanel("Uno", ejemUI),
    tabPanel("Dos", tarea2UI("B"))
  )
  
  )
)
