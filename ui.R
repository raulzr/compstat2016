
library(shiny)
library(ggplot2)
library(plotly)

shinyUI(fluidPage(
  
  tabsetPanel(
    tabPanel("Uno", tarea1UI("A")),
    tabPanel("Dos", tarea2UI("B"))
  )
  
  )
)
