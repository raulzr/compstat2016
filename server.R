
library(shiny)

shinyServer(function(input, output, session) {
   
  callModule(tarea1,"A")
  callModule(tarea2,"B")
  callModule(tarea4,"C")
  callModule(tarea5,"D")
  
})
