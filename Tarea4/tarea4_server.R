tarea4 <- function(input, output, session) {
  
  output$table <- DT::renderDataTable(DT::datatable({
   tab_vino
  }))
  
  output$Grafica <- renderPlot({
   ggplot(tab_vino,aes(eval(parse(text=input$x)),eval(parse(text=input$y))))+geom_point()+xlab(input$x)+ylab(input$y)
  })
  
}