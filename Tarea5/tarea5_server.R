tarea5 <- function(input, output, session) {
  
  output$Grafica <- renderPlot({
    if (input$sim_boton>0){
      
      return(hist(rnorm(100)))
    }
    else{
      x <<- "hola"
      return(ggplot())
    }
    
    #ggplot(iris,aes(Sepal.Length, Petal.Width))+geom_point()
    #ggplot(tab_vino,aes(eval(parse(text=input$x)),eval(parse(text=input$y))))+geom_point()+xlab(input$x)+ylab(input$y)
  })
  
  output$resultado <- renderText({
    paste(input$sim_boton,x)
  })
  
}