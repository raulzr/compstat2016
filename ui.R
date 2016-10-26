
library(shiny)
library(ggplot2)

shinyUI(fluidPage(
  
  tabsetPanel(
    tabPanel("Uno", ejemUI),
    tabPanel("Dos", tarea2UI("B"))
  )
  
  )
)
