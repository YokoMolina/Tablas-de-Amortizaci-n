
suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(shinydashboard))
suppressPackageStartupMessages(library(markovchain))
suppressPackageStartupMessages(library(kableExtra))
suppressPackageStartupMessages(library(highcharter))
suppressPackageStartupMessages(library(FinancialMath))
suppressPackageStartupMessages(library(writexl))

# Función Interes subperiodal Compuesto

i_subp <- function(i,p){
  i<-i/100
  if (p == "Mensual") {
    return((1 + i)^(1/12) - 1)
  } 
  else if (p == "Trimestral") {
    return((1 + i)^(1/4) - 1)
  } 
  else if (p == "Semestral") {
    return((1 + i)^(1/2) - 1)
  } 
  else {
    return(i)
  }
}


shinyServer( function(input, output, session){
  
  observeEvent(input$encaje_aleman, {
    if(input$encaje_aleman== 'Si'){
      shinyjs::show("cuota_encaje_aleman")
    }else{
      shinyjs::hide("cuota_encaje_aleman")
    }
  })
  
  output$TablaAleman<- function(){ 

    C <- input$cuantia_aleman
    i <- i_subp(i=input$tasa_aleman, p = input$periodo_aleman)
    n <- input$numperiodos_aleman
    
    
    TablaAleman <<- data.frame("Periodo" = 1:n, "Amortización"= round(rep(C/n,n),2))
    colnames(TablaAleman)<-c("Periodo","Amortización Real")
    saldo_pendiente <- C
    
    for (j in 1:n){
      interes <- i*(n+1-j)*C/n
      cuota <- C/n+interes
      saldo_pendiente <- saldo_pendiente - C/n
      if (j==n) {
        saldo_pendiente<-0
      }
      TablaAleman[j, c("Cuota Interés", "Cuota", "Saldo Adeudado")] <- c( round(interes,2) , round(cuota,2),  round(saldo_pendiente,2))
    }
    TablaAleman<<-TablaAleman
    res <<- data.frame(TablaAleman)
    
    kbl(res) %>% 
          kable_styling(position = "center") %>% 
          row_spec(0, bold = TRUE, background = "#E1BB9C") %>% 
          scroll_box(width = "600px", height = "400px")
    
  }
  

  
  
  
  
  
  output$download_tabla_aleman <- downloadHandler(
    filename = function(){"AmortizacionAlemana.xlsx"},
    content = function(file){write_xlsx(as.data.frame(res), path = file)}
  )
  
  output$ResumenAleman<- renderTable({ 
    C <- input$cuantia_aleman
    i <- i_subp(i=input$tasa_aleman, p = input$periodo_aleman)
    n <- input$numperiodos_aleman
    TotalInt<-0
    for (j in 1:n){
      interes <- i*(n+1-j)*C/n
      TotalInt<-TotalInt+interes
      }
    ResumenAleman<-data.frame('Cuantía'=input$cuantia_aleman,'Intereses'=TotalInt,'Total_a_Pagar'=input$cuantia_aleman+TotalInt)
  })
  
  output$EncajeAleman<- renderTable({
    C <- input$cuantia_aleman
    i <- i_subp(i=input$tasa_aleman, p = input$periodo_aleman)
    n <- input$numperiodos_aleman
    ecj <- input$cuota_encaje_aleman
    d<-ifelse(input$periodo_aleman=='Mensual',30,ifelse(input$periodo_aleman=='Trimestral',90,ifelse(input$periodo_aleman=='Semestral',180,360)))
    flujo<-numeric(n)
    for (j in 1:n){
      interes <- i*(n+1-j)*C/n
      flujo[j]<-C/n+interes
    }
    flujo[n]<-flujo[n]-ecj
    tirM<-min(IRR(cf0=C-ecj,cf=flujo,times=1:n))
    tirA<-(tirM*100)*360/d
    EncajeAleman<-data.frame('TIR_Mensual'=tirM*100,'TIR_Anual'=tirA)
    EncajeAleman
  })
  
  observeEvent(input$encaje_aleman, {
    if(input$encaje_aleman== 'Si'){
      shinyjs::show("EncajeAleman")
    }else{
      shinyjs::hide("EncajeAleman")
    }
  })
  
  #____________________________________________________________--
  
  #Sistema Frances
  
  observeEvent(input$encaje_frances, {
    if(input$encaje_frances== 'Si'){
      shinyjs::show("cuota_encaje_frances")
    }else{
      shinyjs::hide("cuota_encaje_frances")
    }
  })
  
  output$TablaFrances<- function(){ 
    
    C <- input$cuantia_frances
    i <- i_subp(i=input$tasa_frances, p = input$periodo_frances)
    n <- input$numperiodos_frances
    
    
    TablaFrances <<- data.frame("Periodo" = 1:n, "Cuotas"= round(rep(C/((1-(1+i)^{-n})/i),n),2))
    colnames(TablaFrances)<-c("Periodo","Cuota")
    
    cuotas <- C/((1-(1+i)^{-n})/i)
    
    
    #saldo pendiente_1
    interes <- cuotas*(1-(1+i)^{-(n)})
    v1 <- cuotas *(1+i)^{-(n)}
    saldo_pendiente <- C-v1
    
    TablaFrances[1, c("Cuota Interés", "Amortización Real", "Saldo Adeudado")] <- c( round(interes,2) , round(v1,2),  round(saldo_pendiente,2))
    
   
    
    for (j in 2:n){
      # Amorizacion real
      vk <- cuotas *(1+i)^{-(n+1-j)}
      
      # cuota de interes
      interes <- cuotas*(1-(1+i)^{-(n+1-j)})
      
      # saldo adeudado 
      
     
      saldo_pendiente <- saldo_pendiente-vk
      
      
      
      if ( j==n) {
        saldo_pendiente<-0
      }
      
      
      TablaFrances[j, c("Cuota Interés", "Amortización Real", "Saldo Adeudado")] <- c( round(interes,2) , round(vk,2),  round(saldo_pendiente,2))
    }
    
    TablaFrances<<-TablaFrances
    res1 <<- data.frame(TablaFrances)
    
    kbl(res1) %>% 
          kable_styling(position = "center") %>% 
          row_spec(0, bold = TRUE, background = "#E1BB9C") %>% 
          scroll_box(width = "600px", height = "400px")
   
    
    
  }
  
  output$download_tabla_frances <- downloadHandler(
    filename = function(){"AmortizacionFrancesa.xlsx"},
    content = function(file){write_xlsx(as.data.frame(res1), path = file)}
  )
  
  
  
  output$ResumenFrances<- renderTable({ 
    C <- input$cuantia_frances
    i <- i_subp(i=input$tasa_frances, p = input$periodo_frances)
    n <- input$numperiodos_frances
    
    TotalInt<-0
    cuotas <- C/((1-(1+i)^{-n})/i)
    
    for (j in 1:n){
      # cuota de interes
      interes <- cuotas*(1-(1+i)^{-(n+1-j)})
      
      TotalInt<-TotalInt+interes
    }
    ResumenFrances<-data.frame('Cuantía'=input$cuantia_frances,'Intereses'=TotalInt,'Total_a_Pagar'=input$cuantia_frances+TotalInt)
  })
  
  
  
  output$EncajeFrances<- renderTable({
    C <- input$cuantia_frances
    i <- i_subp(i=input$tasa_frances, p = input$periodo_frances)
    n <- input$numperiodos_frances
    
    cuotas <- C/((1-(1+i)^{-n})/i)
    
    ecj <- input$cuota_encaje_frances
    
    d<-ifelse(input$periodo_frances=='Mensual',30,ifelse(input$periodo_frances=='Trimestral',90,ifelse(input$periodo_frances=='Semestral',180,360)))
    flujo<-numeric(n)
    
    for (j in 1:n){
      # cuota de interes
      flujo[j]<- cuotas
    }
    
    
    flujo[n]<-flujo[n]-ecj
    tirM<-min(IRR(cf0=C-ecj,cf=flujo,times=1:n))
    tirA<-(tirM*100)*360/d
    
    
    EncajeFrances<-data.frame('TIR_Mensual'=tirM*100,'TIR_Anual'=tirA)
    EncajeFrances
    
    
    
  })
  
  
  
  observeEvent(input$encaje_frances, {
    if(input$encaje_frances== 'Si'){
      shinyjs::show("EncajeFrances")
    }else{
      shinyjs::hide("EncajeFrances")
    }
  })
  output$TablaAmericano <- function(){ 
        
        K <- input$cuantia_americano
        i <- i_subp(i=input$tasa_americano, p = input$periodo_americano)
        n <- input$numperiodos_americano
        
        Tabla <- data.frame(
              "Periodo" = seq(1,n),
              "Amortización Real" = c(numeric(n-1),K),
              "Cuotas de Interés" = rep( round(K*i,2), n),
              "Cuota" = c( round(rep(K*i, n-1),2) , round(K*(1+i),2)),
              "Saldo Adeudado" = c(rep(K, n-1), 0)
        )
        
        abreviaturas <- data.frame(
              "Periodo" = "k",
              "Amortización Real" = "vk",
              "Cuotas de Interés" = "sk",
              "Cuota" = "ck",
              "Saldo Adeudado" = "VAk"
        )
        
        Tabla <<- rbind(abreviaturas, Tabla)
        Tabla
        
        res2 <<- data.frame(Tabla)
        
        kbl(res2) %>% 
              kable_styling(position = "center") %>% 
              row_spec(0, bold = TRUE, background = "#E1BB9C") %>% 
              scroll_box(width = "600px", height = "400px")
        
  }
  
  output$download_tabla_americano <- downloadHandler(
        filename = function(){"AmortizacionAmericana.xlsx"},
        content = function(file){write_xlsx(as.data.frame(res2), path = file)}
  )
  
  output$TablaPeruano <- function(){ 
        
        K=input$cuantia_peruano
        i=input$tasa_peruano
        p=input$periodo_peruano
        n=input$numperiodos_peruano
        
        tasa <- i_subp(i,p)
        cuota <- (K * tasa * (1+tasa)^n) / ((1+tasa)^n - 1)
        
        Tabla2 <- data.frame("Periodo" = 1:n, Cuota = round(rep(cuota,n),2))
        
        saldo_pendiente <- K
        
        for (j in 1:n){
              amortizacion <- cuota/((1+tasa)^j)
              intereses <- cuota - amortizacion
              ar <- amortizacion - intereses
              saldo_pendiente <- saldo_pendiente - amortizacion
              Tabla2[j, c("Amortización", "Interes", "Saldo Pendiente")] <- c( round(amortizacion,2) , round(intereses,2),  round(saldo_pendiente,2))
        }
        Tabla2<<-Tabla2
        Tabla2
        res3 <<- data.frame(Tabla2)
        
        kbl(res3) %>% 
              kable_styling(position = "center") %>% 
              row_spec(0, bold = TRUE, background = "#E1BB9C") %>% 
              scroll_box(width = "600px", height = "400px")
        
  }
  output$download_tabla_peruana <- downloadHandler(
        filename = function(){"AmortizacionPeruana.xlsx"},
        content = function(file){write_xlsx(as.data.frame(res3), path = file)}
  )
  
  
  
  
  
  
  
  
  
  
})