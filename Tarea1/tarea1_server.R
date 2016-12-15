tarea1 <- function(input, output, session) {
  
  X <- reactive({runif(10^input$muestras)})
  # Calculo
  lamda <- reactive({input$rate})
  Y <- reactive({-log(1-X())/lamda()})
  
  output$UniGraf <- renderPlotly({
    plot_ly(x=X(),type = "histogram",name="Distribucion uniforme")
  })
  output$prueba <- renderPrint({ks.test(Y(),"pexp",rate=1/mean(Y()))})
  output$ExpGraf <- renderPlotly({
    
    # Graficacion
    l <- seq(0,5,,50)
    yexp <- dexp(l,rate = lamda())
    plot_ly(x=Y(),type = "histogram",name="Muestra") %>%
      add_trace(y=yexp,x=l, yaxis = "y2", type ='scatter', mode='lines', name="Modelo") %>%
      layout(yaxis2 = list(side="right",overlaying="y"))
  })
  output$vered <- renderPrint({
    tst <- ks.test(Y(),"pexp",rate=1/mean(Y()))
    if (tst["p.value"]<0.05){
      "NO sigue una distribucion exponencial"
    }else{
      "Sigue una distribucion exponencial"
    }
  })
  
}