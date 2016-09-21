tarea2 <- function(input, output, session) {
  
  fun1 <- reactive({
    texto <- paste("aux <- ",input$expresion1)
    eval(parse(text=texto))
    aux
  })
  
  output$Grafica <- renderPlot({
    x <- seq(input$valA,input$valB,length.out = 100)
    y <- sapply(x,fun1())
    plot(x,y,type="l",col="blue",main="Grafica 1" )
    #hist(runif(input$n))
  })
  
  # output$evaluacion <- renderText({
  #   print(fun1())
  #   print(input$ex presion1)
  #   (fun1())(input$testFun1)
  # })
}