suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(shinydashboard))
suppressPackageStartupMessages(library(shinythemes))
suppressPackageStartupMessages(library(shinyjs))
suppressPackageStartupMessages(library(highcharter))

shinyUI(fluidPage(theme = shinytheme("sandstone"),
                  tags$head( #COLOR DEGRADADO
                        tags$style(HTML(
                              "
      body {
        background:linear-gradient(to bottom, #FAD0AD , #E5A772  );
        background-attachment:fixed;
        background-size:cover;
        background-repeat:no-repeat;
      }
      "
                        ))
                  ),
                  
               
                  
                  
                 fluidRow(column(width=2,align="center",style="background:#010101",img(src="https://cem.epn.edu.ec/imagenes/logos_institucionales/big_png/BUHO_EPN_big.png", width="110px", height="125px")), 
                          column(width=8,style="background:#010101 ", h1("TRABAJO MATEMÁTICA ACTUARIAL", 
                                                                        style = "background:#FCD7B8   ;text-align:center;align-items:center;color:'black';padding:30px;font-size:2.2em")),
                          column(width=2,align="center",style="background:#010101",img(src="https://cem.epn.edu.ec/imagenes/logos_institucionales/big_png/BUHO_EPN_big.png", width="110px", height="125px"))
                 ),
                  
                  navbarPage("Sistemas de Amortización", #----------------------------------------------------------------------
                             navbarMenu("Sistema Alemán", 
                                        tabPanel(span("Tabla Amortización", style = "color:black"),
                                                 div(
                                                       style = "text-align: center;color: red;font-size: 30px;",  # Centrar el contenido
                                                       strong("Tabla de amortización Alemana")
                                                 ),
                                                 br(),
                                                 br(),
                                                 div(
                                                       style = "text-align: left;color: red;font-size: 20px;",  
                                                       strong("Datos:")
                                                 ),
                                                 br(),
                                                 
                                                 mainPanel(align="center",
                                                         
                                                           
                                                 fluidRow(column(6, numericInput("cuantia_aleman", "Monto solicitado (USD):", value = 1000, min = 100, max = 10000000000, step = 100)),
                                                          column(6, numericInput("tasa_aleman", "Tasa de interés efectiva anual (%):", value = 12, min = 0.01, max = 100, step = 1))
                                                          ),
                                                 fluidRow(column(6, selectInput("periodo_aleman","Frecuencia de pago:", selected = "Mensual", choices=c("Mensual", "Trimestral", "Semestral","Anual"))),
                                                          column(6, numericInput("numperiodos_aleman", "Número de periodos(plazo):", value = 12, min = 1, step = 1))
                                                          ),
                                                 fluidRow(column(6, shinyjs::useShinyjs(),selectInput("encaje_aleman", "¿Se realizará un encaje?:", selected='No',choices=c('No','Si'))),
                                                          column(6, numericInput("cuota_encaje_aleman", "Cuota de encaje (USD):", value = 100, min = 0, step = 1)))
                                                 ),
                                                
      
                                                 
                              
                                                 mainPanel(
                                                   tags$head(
                                                     tags$style(
                                                       HTML("
                                                            #TablaAleman {
                                                              width: 600px;
                                                              height: 350px;
                                                              overflow-y: auto; /* Agrega una barra de desplazamiento vertical si es necesario */
                                                            background-color: white; 
                                                            }
                                                          ")
                                                     )
                                                   ),
                                                   align="center",
                                                   hr(),
                                                   div(
                                                         style = "text-align: left;color: red;font-size: 20px;",  # Centrar el contenido
                                                         strong("Resumen:")
                                                   ),
                                                   br(),
                                                   div(
                                                         align = "center",
                                                         img(src = "actuarial1.jpg", height=300, width=500)
                                                   ),
            
                                                   uiOutput('ResumenAleman'),
                                                   uiOutput('EncajeAleman'),
                                                   
                                                   
                                                   br(),
                                                   div(
                                                         style = "text-align: center;color: red;font-size: 30px;",  
                                                         strong("Tabla")
                                                   ),
                                                   br(),
                                                   
                                                   uiOutput("TablaAleman"),
                                                   #div(tableOutput("TablaAleman1")),
                                                   br(),
                                                   downloadButton("download_tabla_aleman","Descargar Tabla Amortización")
                                                 ) # Fin tabla
                                                 ), # fin tabpanel
                             ), # Fin navbarMenu Aleman
                             navbarMenu("Sistema Francés", 
                                        tabPanel(span("Tabla de Amortización", style= "color:black"),
                                                 div(
                                                       style = "text-align: center;color: red;font-size: 30px;",  # Centrar el contenido
                                                       strong("Tabla de amortización Francesa")
                                                 ),
                                                 br(),
                                                 br(),
                                                 div(
                                                       style = "text-align: left;color: red;font-size: 20px;",  
                                                       strong("Datos:")
                                                 ),
                                          
                                                 br(),
                                                 
                                        mainPanel(aling= "center", 
                                        
                                                  fluidRow(column(6, numericInput("cuantia_frances", "Monto solicitado (USD):", value = 1000, min = 100, max = 10000000000, step = 100)),
                                                                          column(6, numericInput("tasa_frances", "Tasa de interés efectiva anual (%):", value = 12, min = 0.01, max = 100, step = 1))
                                                  ),
                                                  fluidRow(column(6, selectInput("periodo_frances","Frecuencia de pago:", selected = "Mensual", choices=c("Mensual", "Trimestral", "Semestral","Anual"))),
                                                           column(6, numericInput("numperiodos_frances", "Número de periodos(plazo):", value = 12, min = 1, step = 1))
                                                  ),
                                                  fluidRow(column(6, shinyjs::useShinyjs(),selectInput("encaje_frances", "¿Se realizará un encaje?:", selected='No',choices=c('No','Si'))),
                                                           column(6, numericInput("cuota_encaje_frances", "Cuota de encaje (USD):", value = 100, min = 0, step = 1)))
                                                  ),
                                        #______________________________________
                                        
                                        #tabla
                                        mainPanel(
                                          tags$head(
                                            tags$style(
                                              HTML("
                                                            #TablaFrances {
                                                              width: 600px;
                                                              height: 350px;
                                                              overflow-y: auto; /* Agrega una barra de desplazamiento vertical si es necesario */
                                                              background-color: white;
                                                            }
                                                          ")
                                            )
                                          ),
                                          align="center",
                                          hr(),
                                          br(),
                                          div(
                                                style = "text-align: left;color: red;font-size: 20px;",  # Centrar el contenido
                                                strong("Resumen:")
                                          ),
                                          br(),
                                          div(
                                                align = "center",
                                                img(src = "actuarial4.jpg", height=300, width=400)
                                          ),
                                          br(),
      
                                          uiOutput('ResumenFrances'),
                                          uiOutput('EncajeFrances'),
                                          div(
                                                style = "text-align: center;color: red;font-size: 30px;",  
                                                strong("Tabla")
                                          ),
                                          br(),
                                          
                                          uiOutput("TablaFrances"),
                                          br(),
                                          downloadButton("download_tabla_frances","Descargar Tabla Amortización")
                                        ) # Fin tabla
                                        
                                  #________________________________________________      
                                        
                                        
                                                ), #fin tabpanel
                                        ), # fin nav Frances
                             
                             navbarMenu("Sistema Americano", 
                                        tabPanel(span("Tabla Amortización", style = "color:black"),
                                                 br(),
                                                 div(
                                                       style = "text-align: center;color: red;font-size: 30px;",  # Centrar el contenido
                                                       strong("Tabla de amortización Americana")
                                                 ),
                                                 br(),
                                                 br(),
                  
                                                 div(
                                                       align = "center",
                                                       img(src = "actuarial5.jpeg", height=300, width=400)
                                                 ),
                                                 br(),
                                                 div(
                                                       style = "text-align: left;color: red;font-size: 20px;",  
                                                       strong("Datos:")
                                                 ),
                                                 br(),
                                                 mainPanel(align="center",
                                                           
                                                           fluidRow(column(6, numericInput("cuantia_americano", "Cuantía a solicitar en el crédito:", value = 1000, min = 100, max = 10000000000, step = 100)),
                                                                    column(6, numericInput("tasa_americano", "Tasa de interés efectiva anual:", value = 0.12, min = 0.000001, max = 1, step = 0.01))
                                                           ),
                                                           fluidRow(column(6, radioButtons("periodo_americano", "Periodo de amortización:", choices = c("meses", "trimestres", "semestres", "años"), inline = FALSE, selected = "años")),
                                                                    column(6, numericInput("numperiodos_americano", "Número de periodos de amortización:", value = 12, min = 1, step = 1))
                                                           )
                                                 ),
                                                
                                                 # Tabla
                                                 mainPanel(
                                                       div(
                                                             style = "text-align: center;color: red;font-size: 20px;",  
                                                             strong("Tabla")
                                                       ),
                                                       tags$head(
                                                             tags$style(
                                                                   HTML("
                                                            #TablaAmericano {
                                                              width: 600px;
                                                              height: 350px;
                                                              overflow-y: auto;
                                                              background-color: white;
                                                            
                                                            }
                                                          ")
                                                             )
                                                       ),
                                                       align="center",
                                                       uiOutput("TablaAmericano"),
                                                       br(),
                                                       downloadButton("download_tabla_americano","Descargar Tabla Amortización")
                                                 ) # Fin tabla
                                        ), # fin tabpanel
                             ), # Fin navbarMenu Americano ----------------------------------------------------------
                             # PERUANO ---------------------------------------------------------------------------------
                             navbarMenu("Sistema Peruano", 
                                        tabPanel(span("Tabla Amortización", style = "color:black"),
                                                 div(
                                                       style = "text-align: center;color: red;font-size: 30px;",  # Centrar el contenido
                                                       strong("Tabla de amortización Peruana")
                                                 ),
                                                 br(),
                                                 
                                                 div(
                                                       align = "center",
                                                       img(src = "actuarial7.jpeg", height=200, width=400)
                                                 ),
                                                 br(),
                                                 div(
                                                       style = "text-align: left;color: red;font-size: 20px;",  
                                                       strong("Datos:")
                                                 ),
                                                 br(),
                                                 mainPanel(align="center",
                                                           
                                                           fluidRow(column(6, numericInput("cuantia_peruano", "Cuantía a solicitar en el crédito:", value = 1000, min = 100, max = 10000000000, step = 100)),
                                                                    column(6, numericInput("tasa_peruano", "Tasa de interés efectiva anual:", value = 0.12, min = 0.000001, max = 1, step = 0.01))
                                                           ),
                                                           fluidRow(column(6, radioButtons("periodo_peruano", "Periodo de amortización:", choices = c("meses", "trimestres", "semestres", "años"), inline = FALSE, selected = "años")),
                                                                    column(6, numericInput("numperiodos_peruano", "Número de periodos de amortización:", value = 12, min = 1, step = 1))
                                                           )
                                                 ),
                                                 # Tabla
                                                 mainPanel(
                                                       div(
                                                             style = "text-align: center;color: red;font-size: 20px;",  
                                                             strong("Tabla")
                                                       ),
                                                       tags$head(
                                                             tags$style(
                                                                   HTML("
                                                            #TablaPeruano {
                                                              width: 600px;
                                                              height: 350px;
                                                              overflow-y: auto;
                                                               background-color: white;
                                                            }
                                                          ")
                                                             )
                                                       ),
                                                       align="center",
                                                       uiOutput("TablaPeruano"),
                                                       br(),
                                                       downloadButton("download_tabla_peruana","Descargar Tabla Amortización")
                                                 ) # Fin tabla
                                        ), # fin tabpanel
                             ),
                             navbarMenu("Teoría sistemas de amortización",
                                        tabPanel(span("Sistema peruano", style = "color:black"),    
                                                 div(
                                                       style = "text-align: center;color: blue;font-size: 40px;",  # Centrar el contenido
                                                       strong("Sistema de amortización Peruano")
                                                 ),
                                                 div(
                                                       align = "center",
                                                       img(src = "paloma.jpg", height=250, width=250)
                                                 ),
                                                 br(),
                                                 p('El sistema de amortización peruano
                                                                                                  es un sistema de capitales amortizables, basado en la teoría de la renta
                                                                                                  y el valor presente, donde la cuota es fija que está formada por el capital más intereses,
                                                                                                  primeramente se paga la deuda (capital) y al final los intereses. La "ventaja" de este sistema es que
                                                                                                   permite pagar antes el capital prestado en mayor proporción que los intereses a lo largo del crédito',
                                                   style="color: black;font-size: 20px;"),
                                                 br(),
                                                 p('Formulación:',
                                                   style="color: red;font-size: 26px;"),
                                                 br(),
                                                 p('La cuota es una renta fija, temporal, inmediata y vencida:',
                                                   style="color: black;font-size: 20px;"),
                                                 br(),
                                                 withMathJax(
                                                       p("La cuota fija viene dada por:",style="color: black;font-size: 20px;"),
                                                       p("\\[ r = \\frac{VP*i*(i+1)^n}{(1+i)^n-1}  \\]",style="font-size: 20px;"),
                                                       p('Los capitales amortizables son:',style="color: black;font-size: 20px;"),
                                                       p("\\[K_j = \\frac{r}{(1+i)^j} \\ , j=1,2,...,n \\]",style="font-size: 20px;"),
                                                       p('y se tiene el valor presente:',style="color: black;font-size: 20px;"),
                                                       p("\\[VP= \\sum_{j=1}^{n} K_j \\]",style="font-size: 20px;"),
                                                       br(),
                                                       p('El algoritmo es de la siguiente manera:',style="color: black;font-size: 20px;"),
                                                       div(
                                                             align = "center",
                                                             img(src = "img1.jpg", height=500, width=820)
                                                       )
                                                 ),
                                                 br(),
                                                 p('Otra de las ventajas que mencionan algunos analistas financieros es que aquellos clientes que obtengan un
                                                   crédito con esta estructura, pueden tener la oportunidad de pagar su deuda anticipada sin penalidades, además que los
                                                   fondos prestados se recuperarían más rápido.',style="color: black;font-size: 20px;")
                                        ),
                                        tabPanel(span("Sistema Americano", style = "color:black"),
                                                 div(
                                                       style = "text-align: center;color: blue;font-size: 40px;",  # Centrar el contenido
                                                       strong("Sistema de amortización Americano")
                                                 ),
                                                 div(
                                                       align = "center",
                                                       img(src = "aguila.jpg", height=250, width=250)
                                                 ),
                                                 br(),
                                                 p('En este sistema, se consideran n cuotas, las n-1 cuotas están constituidas por los intereses,
                                                   y en la última se devuelve el total del crédito más los intereses del último periodo.',
                                                   style='color: black;font-size: 20px;'),
                                                 HTML('<p style="font-size: 20px; color: black;"> Sea el préstamo <em> K </em>, y una tasa de interés efectiva <em> i </em>, entonces
                                                      las <em> n-1 </em> primeras cuotas son:</p>'),
                                                 br(),
                                                 withMathJax(
                                                       p("\\[ c_1=c_2= \\cdots =c_n = K.i  \\]",style="color: black;font-size: 20px;"),
                                                       p('la última cuota es igual a:','\\[ c_n= K+K.i=K(1+i) \\]',style="color: black;font-size: 20px;"),
                                                       p('Una desventaja de este sistema es que las cuotas son muy elevadas,considerando inconvenientes para el
                                                   acreedor. En el sistema de amortización estadounidense, la mayor parte de los pagos mensuales se destinan a cubrir los intereses 
                                                   durante las primeras etapas del préstamo. Esto significa que la amortización del capital es relativamente baja al principio, 
                                                   lo que resulta en un mayor costo total de intereses a lo largo de la vida del préstamo.',style="color: black;font-size: 20px;")
                                                 ),
                                        ),
                                        tabPanel(span("Sistema francés", style = "color:black"),
                                                 div(
                                                       style = "text-align: center;color: blue;font-size: 40px;",  # Centrar el contenido
                                                       strong("Sistema de amortización Francés"),
                                                 ),
                                                 div(
                                                       align = "center",
                                                       img(src = "torre.jpg", height=250, width=250)
                                                 ),
                                                 br(),
                                                 p('Este sistema se caracteriza por tener una amortización creciente pero cuotas de pago constantes,
                                                   por lo cual las cuotas a pagar son:',
                                                   style='color: black;font-size: 20px;'),
                                                 br(),
                                                 withMathJax(
                                                       p("\\[ c_1=c_2= \\cdots =c_n = c  \\]",style="color: black;font-size: 20px;"),
                                                       HTML('<p style="font-size: 20px; color: black;"> el valor actual de la renta financiera debe ser 
                                                        igual a la cuantía del préstamo <em> K: </em> </p>'),
                                                       p("\\[ K=ca_{\\bar{n}|i}  \\]",style="color: black;font-size: 20px;"),
                                                       HTML('<p style="font-size: 20px; color: black;"> Cada cuota de la renta financiera se compone de una 
                                                   cuota de amortización real \\( v_k \\) y una cuota de interés  \\(s_k \\) . 
                                                        La cuota \\( v_k \\) es la parte del capital adeudado que se salda al instante \\(t = k \\). Se tiene que: </p>'),
                                                       p("\\[ v_k=c(1+i)^{(k-1-n)}  \\]","\\[ c=v_k+s_k  \\]",style="color: black;font-size: 20px;"),
                                                       p("\\[ s_k=c[1-(1+i)^{(k-1-n)}]  \\]",style="color: black;font-size: 20px;")
                                                 ),
                                                 br(),
                                                 p('Una ventaja de este sistema es que hay una amortización más rápida del capital, así, los prestatarios reducen más rápidamente 
                                                   la deuda principal, lo que puede llevar a una liquidación más rápida del préstamo en comparación con otros sistemas. Los prestatarios 
                                                   pueden acumular menos intereses totales a lo largo del tiempo, lo que puede ser beneficioso desde el punto de vista financiero.','\\[ \\]',
                                                   'Sin embargo, una desventaja es que los pagos al inicio son bastante altos, esto puede representar un desafío financiero para algunos prestatarios, 
                                                   ya que pueden experimentar una carga financiera más pesada al inicio del préstamo. ',
                                                   style='color: black;font-size: 20px;')
                                        ),
                                        tabPanel(span("Sistema alemán", style = "color:black"),
                                                 div(
                                                       style = "text-align: center;color: blue;font-size: 40px;",  # Centrar el contenido
                                                       strong("Sistema de amortización Alemán"),
                                                 ),
                                                 div(
                                                       align = "center",
                                                       img(src = "pastor.jpg", height=250, width=250)
                                                 ),
                                                 br(),
                                                 p('A diferencia del sistema francés, este sistema se caracteriza por que las cuotas de amortización son constantes,
                                                   mientras que las cuotas a pagar cada periodo \\(c_k \\) y \\(s_k \\) son decrecientes ,así, asumiendo un préstamo \\(K \\) tenemos lo siguiente:',
                                                   style='color: black;font-size: 20px;'),
                                                 withMathJax(
                                                       p("\\[ v_k=\\frac{K}{n} \\ \\ , k=1,2,...,n \\]","\\[ s_k=i(n+1-k)\\frac{K}{n} \\]",style="color: black;font-size: 20px;"),
                                                       p("\\[ s_{k+1}=s_k-i\\frac{K}{n} \\]","\\[c_1=\\frac{K}{n}+iK\\]",style="color: black;font-size: 20px;"),
                                                       p("\\[ c_k=\\frac{K}{n}[1+i(n-k+1)] \\ \\ , k=2,3,...,n \\]",style="color: black;font-size: 20px;"),
                                                       p("Además, se tiene también que el valor actual de la renta es igual al préstamo otorgado, es decir:","\\[ VA_k=(n-k)\\frac{K}{n} \\]",style="color: black;font-size: 20px;")
                                                       
                                                 ),
                                                 br(),
                                                 p('Una de las ventajas de este sistema es que a medida que el capital disminuye con cada pago, los intereses también disminuyen, lo que resulta en un menor costo total del préstamo
                                                   a lo largo del tiempo. Sin emabrgo, se tiene la desventaja de que al igual que en el sistema de amortización francés, el sistema alemán también puede tener pagos mensuales más altos
                                                   al principio del préstamo. Este aumento inicial en los pagos mensuales puede ser un desafío financiero para algunos prestatarios','\\[ \\]',
                                                   'Una alternativa que suele usarse es modificar el sistema alemán variando la tasa de interés. Así, se calculan
                                                   primero los valores de las cuotas para una tasa baja de interés, y luego de pagar algunas cuotas se refinancia la
                                                   deuda con una tasa de interés más alta.', style='color: black;font-size: 20px;'),
                                                 br(),
                                                 div(
                                                       align = "center",
                                                       img(src = "resumen.jpg", height=500, width=500)
                                                 )
                                        )
                             ),# Fin navbarMenu Peruano ----------------------------------------------------------
                             
                             
                             
                             
                  )
)
)