suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(shinydashboard))
suppressPackageStartupMessages(library(shinythemes))
suppressPackageStartupMessages(library(markovchain))
suppressPackageStartupMessages(library(highcharter))

shinyUI(fluidPage(theme = shinytheme("sandstone"),
                  fluidRow(column(12, tags$style("h1 {color: #3e3f3a;font-family:Arial Black}","h2 {color: #9C1711;font-family:Arial}","h3 {font-family:Times New Roman}","h4 {font-family:Times New Roman}","h5 {font-family:Times New Roman}"),
                                  h1("Trabajo Grupal 01 - Matem??tica Actuarial"))),
                  
                  navbarPage("Sistemas de Amortización", #----------------------------------------------------------------------
                             navbarMenu("Sistema Americano", 
                                        tabPanel(span("Tabla Amortización", style = "color:black"),
                                                 mainPanel(align="center",
              
                                                 fluidRow(column(6, numericInput("cuantia_americano", "Cuant??a a solicitar en el cr??dito:", value = 1000, min = 100, max = 10000000000, step = 100)),
                                                          column(6, numericInput("tasa_americano", "Tasa de inter??s efectiva anual:", value = 0.12, min = 0.000001, max = 1, step = 0.01))
                                                          ),
                                                 fluidRow(column(6, radioButtons("periodo_americano", "Per??odo de amortizaci??n:", choices = c("meses", "trimestres", "semestres", "aC1os"), inline = FALSE, selected = "aC1os")),
                                                          column(6, numericInput("numperiodos_americano", "N??mero de periodos de amortizaci??n:", value = 12, min = 1, step = 1))
                                                          )
                                                 ),
                                                 # Tabla
                                                 mainPanel(
                                                   tags$head(
                                                     tags$style(
                                                       HTML("
                                                            #TablaAmericano {
                                                              width: 600px;
                                                              height: 350px;
                                                              overflow-y: auto; /* Agrega una barra de desplazamiento vertical si es necesario */
                                                            }
                                                          ")
                                                     )
                                                   ),
                                                   align="center",
                                                   uiOutput("TablaAmericano")
                                                 ) # Fin tabla
                                                 ), # fin tabpanel
                             ), # Fin navbarMenu Americano ----------------------------------------------------------
                             # PERUANO ---------------------------------------------------------------------------------
                             navbarMenu("Sistema Peruano", 
                                        tabPanel(span("Tabla Amortizaci??n", style = "color:black"),
                                                 mainPanel(align="center",
                                                           
                                                           fluidRow(column(6, numericInput("cuantia_peruano", "Cuant??a a solicitar en el cr??dito:", value = 1000, min = 100, max = 10000000000, step = 100)),
                                                                    column(6, numericInput("tasa_peruano", "Tasa de inter??s efectiva anual:", value = 0.12, min = 0.000001, max = 1, step = 0.01))
                                                           ),
                                                           fluidRow(column(6, radioButtons("periodo_peruano", "Per??odo de amortizaci??n:", choices = c("meses", "trimestres", "semestres", "aC1os"), inline = FALSE, selected = "aC1os")),
                                                                    column(6, numericInput("numperiodos_peruano", "N??mero de periodos de amortizaci??n:", value = 12, min = 1, step = 1))
                                                           )
                                                 ),
                                                 # Tabla
                                                 mainPanel(
                                                   tags$head(
                                                     tags$style(
                                                       HTML("
                                                            #TablaPeruano {
                                                              width: 600px;
                                                              height: 350px;
                                                              overflow-y: auto; /* Agrega una barra de desplazamiento vertical si es necesario */
                                                            }
                                                          ")
                                                     )
                                                   ),
                                                   align="center",
                                                   uiOutput("TablaPeruano")
                                                 ) # Fin tabla
                                        ), # fin tabpanel
                             ), # Fin navbarMenu Peruano ----------------------------------------------------------
                             
                  )
)
)