tarea5 <- function(input, output, session) {
  
  output$Grafica <- renderPlot({
    if (input$sim_boton>0){
      
      x <- unname(unlist(iris[1]))
      y <- unname(unlist(iris[3]))
      
      res <<- run_mcmc(n_sim=10^input$no_sim,
                      theta0 = c(1,1,1),
                      X=unname(unlist(tab_vino[input$x])),
                      Y=unname(unlist(tab_vino[input$y])),
                      jump=0.05,
                      mean_a=input$alpha_m,
                      sd_a=input$alpha_sd,
                      mean_b=input$beta_m,
                      sd_b=input$beta_sd,
                      shape_sigma2=input$shape,
                      scale_sigma2=input$scale)
      df <- data.frame(res)
      
      #return(pairs(res, labels = c("Alpha","Betha","Sigma")))
      a <- mean(res[,1])
      b <- mean(res[,2])
      s <- mean(res[,3])
      x.max <- max(unname(unlist(tab_vino[input$x])))
      x.min <- min(unname(unlist(tab_vino[input$x])))
      x <- seq(x.min,x.max,length.out = 100)
      y <- b*x+a
      
      par(mfrow=c(3,3))
      plot(res[,1], main = "Alpha - Sim", type = 'l', ylab = '')
      plot(res[,2], main = "Beta - Sim", type = 'l', ylab = '')
      plot(res[,3], main = "Sigma - Sim", type = 'l', ylab = '')
      plot(density(res[,1]), main = "Alpha - Prior (Azul) Post. (Rojo)", col='red')
      lines(density(rnorm(5000, mean = input$alpha_m, sd=input$alpha_sd)), col='blue')
      plot(density(res[,2]), main = "Beta - Prior (Azul) Post. (Rojo)", col='red')
      lines(density(rnorm(5000, mean = input$beta_m, sd=input$beta_sd)), col='blue')
      plot(density(res[,3]), main = "Sigma - Prior (Azul) Post. (Rojo)", col='red')
      lines(density(rgamma(5000, shape = input$shape, rate = input$scale)), col='blue')
      plot(unname(unlist(tab_vino[input$x])),unname(unlist(tab_vino[input$y])), xlab = input$x, ylab = input$y)
      lines(x,y, col='red')
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