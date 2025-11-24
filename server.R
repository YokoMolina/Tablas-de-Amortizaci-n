suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(shinydashboard))
suppressPackageStartupMessages(library(markovchain))
suppressPackageStartupMessages(library(kableExtra))
suppressPackageStartupMessages(library(highcharter))

# Funcion de Pij(n):

p_n1 <- function(n){
  m <- matrix(c(0.70, 0.30, 0.35, 0.65), nrow = 2, byrow = TRUE)
  p <- new("markovchain", states = c("E", "C"), transitionMatrix = m)
  
  Pn <- p^n
  return(Pn)
}

p_ijn1 <- function(i,j,n){
  m <- matrix(c(0.70, 0.30, 0.35, 0.65), nrow = 2, byrow = TRUE)
  p <- new("markovchain", states = c("E", "C"), transitionMatrix = m)
  
  Pn <- p^n
  p <- unname(unlist(Pn[i,j]))
  return(p)
}

situacion1 <- function(x1,n){
  m <- matrix(c(0.70, 0.30, 0.35, 0.65), nrow = 2, byrow = TRUE)
  p <- new("markovchain", states = c("E", "C"), transitionMatrix = m)
  x <- c(x1, 16541 - x1)
  
  return(x * p^n)
}

# Ejercicio 2
p_n2 <- function(n){
  m <- matrix(c(0.70, 0.2, 0.10, 0, 0.7, 0.3, 0.7, 0.1, 0.2), nrow = 3, byrow = TRUE)
  p <- new("markovchain", states = c("L", "M", 'A'), transitionMatrix = m)
  
  Pn <- p^n
  return(Pn)
}

p_ijn2 <- function(i,j,n){
  m <- matrix(c(0.70, 0.2, 0.10, 0, 0.7, 0.3, 0.7, 0.1, 0.2), nrow = 3, byrow = TRUE)
  p <- new("markovchain", states = c("L", "M", 'A'), transitionMatrix = m)
  
  Pn <- p^n
  p <- unname(unlist(Pn[i,j]))
  return(p)
}

situacion2 <- function(n){
  m <- matrix(c(0.70, 0.2, 0.10, 0, 0.7, 0.3, 0.7, 0.1, 0.2), nrow = 3, byrow = TRUE)
  p <- new("markovchain", states = c("L", "M", 'A'), transitionMatrix = m)
  h <- 2500
  x <- c(1,0,0)
  
  return(h * x * p^n)
}


shinyServer( function(input, output, session){
  
  # EJERCICIO 1--------------------------------------------------
  output$Matriz1 <- renderTable({ 
    MAT <-matrix(c(0.7,0.35, 0.3,0.65), 2, 2)
    rownames(MAT) <- c('E','C')
    colnames(MAT) <- c('E','C')
    MAT
  },rownames=TRUE)
  
  output$Matriz11 <- renderTable({ 
    MAT <-matrix(c(0.7,0.35, 0.3,0.65), 2, 2)
    rownames(MAT) <- c('E','C')
    colnames(MAT) <- c('E','C')
    MAT
  },rownames=TRUE)
  
  # parte 1a)
  output$p1 <- renderText({
    paste("La probabilidad de transitar de ", input$i1, " a ", input$j1, " en el tiempo establecido es:", p_ijn1(input$i1, input$j1, input$n1))
  })
  
  # parte 1b)
  output$s1 <- renderTable({ 
    res <- data.frame(Empresa = c('E', 'C'),
                      NumClientes = c(as.integer(situacion1(input$xe1, input$n_1))[1],as.integer(situacion1(input$xe1, input$n_1))[2])  ) 
  })
  
  output$g1 <- renderHighchart({
    Empresa <- c('E', 'C')
    valores <- c(as.integer(situacion1(input$xe1, input$n_1))[1],as.integer(situacion1(input$xe1, input$n_1))[2])
    
    grafico <- highchart() %>% 
      hc_chart(type = 'pie') %>% 
      hc_colors(colors = c('#90CBFF', '#D2A9FF')) %>% 
      hc_add_series(name = 'categorias', 
                    data = data.frame(name = Empresa, y= valores))
    
    grafico
  })
  
  # parte 1c)
  output$d1 <- renderTable({
    
    m <- matrix(c(0.70, 0.30, 0.35, 0.65), nrow = 2, byrow = TRUE)
    p <- new("markovchain", states = c("E", "C"), transitionMatrix = m)
    xo<- c(5729, 10812)
    x <- steadyStates(p)
    
    
    res <- data.frame(Empresa = c('E', 'C'),
                      Distribucion = c( x[1], x[2] ) )
  })
  
  output$c1 <- renderTable({
    
    m <- matrix(c(0.70, 0.30, 0.35, 0.65), nrow = 2, byrow = TRUE)
    p <- new("markovchain", states = c("E", "C"), transitionMatrix = m)
    xo<- c(5729, 10812)
    x <- sum(xo)*steadyStates(p)
    
    
    res <- data.frame(Empresa = c('E', 'C'),
                      clientes = c( as.integer(x[1]), as.integer(x[2]) ) )
  })
  
  output$evolucion1 <- renderHighchart({
    
    m <- matrix(c(0.70, 0.30, 0.35, 0.65), nrow = 2, byrow = TRUE)
    p <- new("markovchain", states = c("E", "C"), transitionMatrix = m)
    xo <- c(5729, 10812)
    
    # Número de años
    num_anios <- 20
    
    # Cálculo de los valores para cada año
    valores_anios <- matrix(NA, nrow = num_anios, ncol = length(p@states))
    valores_anios[1, ] <- xo
    
    for (i in 2:num_anios) {
      valores_anios[i, ] <- valores_anios[i-1, ] %*% p@transitionMatrix
    }
    
    # Redondear los valores a enteros
    valores_anios <- round(valores_anios)
    
    # Convertir los valores en una lista adecuada para highcharter
    datos_grafico <- list()
    for (i in 1:ncol(valores_anios)) {
      datos_grafico[[i]] <- list(name = p@states[i], data = valores_anios[, i])
    }
    
    # Creación del gráfico con highcharter
    grafico <- highchart() %>%
      hc_chart(type = "line") %>%
      hc_colors(colors = c('#90CBFF', '#D2A9FF')) %>% 
      hc_title(text = "Evolución de la fidelidad de los clientes a lo largo de los años") %>%
      hc_xAxis(categories = 1:num_anios, title = list(text = "Años")) %>%
      hc_yAxis(title = list(text = "Clientes"), allowDecimals = FALSE) %>%
      hc_add_series_list(datos_grafico)
    
    grafico
    
  })
  
  # EJERCICIO 2--------------------------------------------------
  output$Matriz2 <- renderTable({ 
    MAT <-matrix(c(0.7,0,0.7, 0.2,0.7,0.1, 0.1,0.3,0.2), 3, 3)
    rownames(MAT) <- c('L','M',"A")
    colnames(MAT) <- c('L','M',"A")
    MAT
  },rownames=TRUE)
  
  output$Matriz22 <- renderTable({ 
    MAT <-matrix(c(0.7,0,0.7, 0.2,0.7,0.1, 0.1,0.3,0.2), 3, 3)
    rownames(MAT) <- c('L','M',"A")
    colnames(MAT) <- c('L','M',"A")
    MAT
  },rownames=TRUE)
  
  # parte 2a)
  output$p2 <- renderText({
    paste("La probabilidad de transitar de ", input$i2, " a ", input$j2, " en el tiempo establecido es:", p_ijn2(input$i2, input$j2, input$n2))
  })
  
  # parte 2b)
  output$s2 <- renderTable({ 
    res <- data.frame(Empresa = c('L','M',"A"),
                      NumHectareas = c(situacion2(input$n_2)[1],situacion2(input$n_2)[2],situacion2(input$n_2)[3])  ) 
  })
  
  output$g2 <- renderHighchart({
    Contaminacion <- c('L','M',"A")
    NumHectareas <- c(situacion2(input$n_2)[1],situacion2(input$n_2)[2],situacion2(input$n_2)[3])
    
    grafico <- highchart() %>% 
      hc_chart(type = 'pie') %>% 
      hc_colors(colors = c('#C9FFA9','#FFF3A9', '#FF9090')) %>% 
      hc_add_series(name = 'categorias', data = data.frame(name = Contaminacion, y = NumHectareas) )
    
    grafico
  })
  
  # parte 2c)
  output$d2 <- renderTable({
    
    m <- matrix(c(0.70, 0.2, 0.10, 0, 0.7, 0.3, 0.7, 0.1, 0.2), nrow = 3, byrow = TRUE)
    p <- new("markovchain", states = c("L", "M", 'A'), transitionMatrix = m)
    x <- steadyStates(p)
    
    
    res <- data.frame(Contaminacion = c('L','M',"A"),
                      Distribucion = c( x[1], x[2], x[3] ) )
  })
  
  output$c2 <- renderTable({
    
    m <- matrix(c(0.70, 0.2, 0.10, 0, 0.7, 0.3, 0.7, 0.1, 0.2), nrow = 3, byrow = TRUE)
    p <- new("markovchain", states = c("L", "M", 'A'), transitionMatrix = m)
    h <- 2500
    x <- h*steadyStates(p)
    
    
    res <- data.frame(Empresa = c('L','M',"A"),
                      clientes = c(x[1], x[2], x[3]) )
  })
  
  output$evolucion2 <- renderHighchart({
    
    m <- matrix(c(0.70, 0.2, 0.10, 0, 0.7, 0.3, 0.7, 0.1, 0.2), nrow = 3, byrow = TRUE)
    p <- new("markovchain", states = c("L", "M", "A"), transitionMatrix = m)
    h <- 2500
    x <- c(2500, 0, 0)
    
    # Número de años
    num_anios <- 20
    
    # Cálculo de los valores para cada año
    valores_anios <- matrix(NA, nrow = num_anios, ncol = length(p@states))
    valores_anios[1, ] <- x
    
    for (i in 2:num_anios) {
      valores_anios[i, ] <- valores_anios[i-1, ] %*% p@transitionMatrix
    }
    
    # Convertir los valores en una lista adecuada para highcharter
    datos_grafico <- list()
    for (i in 1:ncol(valores_anios)) {
      datos_grafico[[i]] <- list(name = p@states[i], data = valores_anios[, i])
    }
    
    # gráfico con highcharter
    grafico <- highchart() %>%
      hc_chart(type = "line") %>%
      hc_colors(colors = c('#C9FFA9','#FFF3A9', '#FF9090')) %>%
      hc_title(text = "Evolución de la contaminación a lo largo de los años") %>%
      hc_xAxis(categories = 1:num_anios, title = list(text = "Años")) %>%
      hc_yAxis(title = list(text = "Hectareas"), allowDecimals = FALSE) %>%
      hc_add_series_list(datos_grafico)
    
    grafico
    
  })
  
})