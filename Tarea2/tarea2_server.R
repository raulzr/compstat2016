tarea2 <- function(input, output, session) {
  
  fun1 <- reactive({
    texto <- paste("aux <- ",input$expresion1)
    eval(parse(text=texto))
    aux
  })
  
  output$Grafica <- renderPlot({
    # x <- seq(input$valA,input$valB,length.out = 100)
    # y <- sapply(x,fun1())
    # plot(x,y,type="l",col="blue",main="Grafica 1" )
    #hist(runif(input$n))
    val_Int <- c()
    val_std <- c()
    Ns <- c(10,100,1000,10000,100000)
    for( n in Ns){
      x <- runif(n, input$valA, input$valB)
      y <- sapply(x,fun1())
      Integral <- mean(y/dunif(x,input$valA,input$valB))
      desv_std<-sd(y/dunif(x,input$valA,input$valB))/sqrt(n)
      val_Int <- c(val_Int, Integral)
      val_std <- c(val_std, desv_std)
    }
    
    #df <- data.frame(x = rep(log10(Ns),3), y = c(val_Int,qnorm(1-input$Int_conf, mean=val_Int, sd=val_std),qnorm(input$Int_conf, mean=val_Int, sd=val_std)))
    df <- data.frame(log10_N =log10(Ns), med = val_Int, infe = qnorm(1-input$Int_conf, mean=val_Int, sd=val_std), sup = qnorm(input$Int_conf, mean=val_Int, sd=val_std))
    ggplot(df) + geom_line(aes(log10_N,med), color = "red") + geom_line(aes(log10_N,infe), color = "blue") + geom_line(aes(log10_N,sup), color = "blue") + labs(x="10^n simulaciones", y="Valor esperado")
    #ggplot(df, aes(x, y)) + geom_line(color="blue") +geom_point()
    #plot(log10(Ns), val_Int, main = "Valor a N numero de iteraciones", type="b")#, color = "blue")
    
    
  })
  
   output$Resultado <- renderText({
     x <- runif(100000,input$valA,input$valB)
     y <- sapply(x,fun1())
     Integral <- mean(y/dunif(x,input$valA,input$valB))
     eI1<-sd(y/dunif(x,input$valA,input$valB))/sqrt(100000)
     paste("Integral: ",Integral,"Desviación Estandar: ",eI1)
   })
}