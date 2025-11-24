
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(shinydashboard))
suppressPackageStartupMessages(library(markovchain))
suppressPackageStartupMessages(library(kableExtra))
suppressPackageStartupMessages(library(highcharter))

# FunciC3n Interes subperiodal Compuesto

i_subp <- function(i,p){
  if (p == "meses") {
    return((1 + i)^(1/12) - 1)
  } 
  else if (p == "trimestres") {
    return((1 + i)^(1/4) - 1)
  } 
  else if (p == "semestres") {
    return((1 + i)^(1/2) - 1)
  } 
  else {
    return(i)
  }
}


shinyServer( function(input, output, session){
  
  output$TablaAmericano <- renderTable({ 

    K <- input$cuantia_americano
    i <- i_subp(i=input$tasa_americano, p = input$periodo_americano)
    n <- input$numperiodos_americano
    
    Tabla <- data.frame(
      "Per??odo" = seq(1,n),
      "Amortizaci??n Real" = c(numeric(n-1),K),
      "Cuotas de Inter??s" = rep( round(K*i,2), n),
      "Cuota" = c( round(rep(K*i, n-1),2) , round(K*(1+i),2)),
      "Saldo Adeudado" = c(rep(K, n-1), 0)
    )
    
    abreviaturas <- data.frame(
      "Per??odo" = "k",
      "Amortizaci??n Real" = "vk",
      "Cuotas de Inter??s" = "sk",
      "Cuota" = "ck",
      "Saldo Adeudado" = "VAk"
    )
    
    Tabla <- rbind(abreviaturas, Tabla)
    Tabla
  })
  
  output$TablaPeruano <- renderTable({ 
    
    K=input$cuantia_peruano
    i=input$tasa_peruano
    p=input$periodo_peruano
    n=input$numperiodos_peruano
    
    tasa <- i_subp(i,p)
    cuota <- (K * tasa * (1+tasa)^n) / ((1+tasa)^n - 1)
    
    Tabla2 <- data.frame("Per??odo" = 1:n, Cuota = round(rep(cuota,n),2))
    
    saldo_pendiente <- K
    
    for (j in 1:n){
      amortizacion <- cuota/((1+tasa)^j)
      intereses <- cuota - amortizacion
      ar <- amortizacion - intereses
      saldo_pendiente <- saldo_pendiente - amortizacion
      Tabla2[j, c("Amortizaci??n", "Interes", "Saldo Pendiente")] <- c( round(amortizacion,2) , round(intereses,2),  round(saldo_pendiente,2))
    }
    
    Tabla2
  })
  
  
})