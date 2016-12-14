tarea5 <- function(input, output, session) {
  
  output$Grafica <- renderPlot({
    if (input$sim_boton>0){
      x <- unname(unlist(iris[1]))
      y <- unname(unlist(iris[3]))
      
      res <<- run_mcmc(n_sim=1000,
                      theta0 = c(1,1,1),
                      X=x,
                      Y=y,
                      jump=0.05,
                      mean_a=0,
                      sd_a=1,
                      mean_b=0,
                      sd_b=1,
                      shape_sigma2=1,
                      scale_sigma2=1)
      df <- data.frame(res)
      
      return(pairs(res, labels = c("Alpha","Betha","Sigma")))
      
      #return(hist(rnorm(100)))
    }
    else{
      res <<- NULL
      return(ggplot())
    }
    
    #ggplot(iris,aes(Sepal.Length, Petal.Width))+geom_point()
    #ggplot(tab_vino,aes(eval(parse(text=input$x)),eval(parse(text=input$y))))+geom_point()+xlab(input$x)+ylab(input$y)
  })
  
  output$resultado <- DT::renderDataTable(DT::datatable({
    if(is.null(res)&!(input$sim_boton>0)){
      data.frame("."=c("Wait for it \n ...."))
    }
    else{
      aux <- data.frame(unclass(summary(data.frame(res))))
      colnames(aux) <- c("Alpha","Beta","Sigma")
      aux
    }
      
  }))
  
}