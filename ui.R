suppressPackageStartupMessages(library(shiny))
suppressPackageStartupMessages(library(shinydashboard))
suppressPackageStartupMessages(library(shinythemes))
suppressPackageStartupMessages(library(markovchain))
suppressPackageStartupMessages(library(highcharter))


shinyUI(fluidPage(theme = shinytheme("sandstone"),
  fluidRow(column(12, tags$style("h1 {color: #3e3f3a;font-family:Arial Black}","h2 {color: #9C1711;font-family:Arial}","h3 {font-family:Times New Roman}","h4 {font-family:Times New Roman}","h5 {font-family:Times New Roman}"),
                  h1("Trabajo Grupal 01 Matemática Actuarial"))),
  
  navbarPage("Matemática Actuarial",
             navbarMenu("Sistemas de Amortización", 
                        tabPanel(span("Alemán", style = "color:black"),
                                 fluidPage(
                                 h3(""),
                                 p(),
                                 verticalLayout(mainPanel(align="right",img(src="Img1.jpg", height=300, width=420))),
                                 p(),
                                 h4(""),
                                 h3(strong()),
                                 flowLayout(mainPanel(align="right",img(src="Img2.jpg", height=150, width=100)),mainPanel(align="center",img(src="Img3.jpg", height=400, width=600)))
                        )),
                        tabPanel("Americano",
                                 h3(""),
                                 p(),
                                 verticalLayout(
                                   h4(""),
                                   h5(""),
                                   h4(""),
                                   h5("" ),
                                   h4(""),
                                   mainPanel(align="center",uiOutput("Matriz1"))
                                   ),
                                 p(),
                                 verticalLayout(
                                 h3(""),
                                 mainPanel(align="right",img(src="Cadenadeestados.png", height=250, width=550)),
                                 h3(""),
                                 mainPanel(align="left",img(src="Formula1.png", height=40, width=550)),
                                 h3(""),
                                 h3(""),
                                 mainPanel(align="left",img(src="Formula2.png", height=70, width=420)),
                                 h3(""),
                                 p(),
                                 h3(""),
                                 mainPanel(align="right",img(src="Formula3.png", height=200, width=450)),
                                 h3(""),
                                 h3("")
                                 )
          
                        ),
                        tabPanel("Frances",
                                 h3(""),
                                 p(),
                                 verticalLayout(
                                   h4(""),
                                   h5(""),
                                   h4(""),
                                   h5("" ),
                                   h4("• Y la matriz de transición P esta dada por:"),
                                   mainPanel(align="center",uiOutput("Matriz11")),
                                   h4("• Su correspondiente diagrama es:"),
                                   mainPanel(align="right",img(src="Cadenadeestados.png", height=250, width=550)),
                                 ),
                                 h4('a) Cálculo de la probabilidad de transitar del estado i al estado j, en n pasos'),
                                 fluidRow(column(3, radioButtons("i1", "Elige el estado de origen:", choices = c("E", "C"), inline = TRUE)),
                                          column(3, radioButtons("j1", "Elige el estado de llegada:",choices = c("E", "C"), inline = TRUE)),
                                          column(6, numericInput("n1", "Ingrese el número de pasos (años):",value = 5, min = 1, max = 20))
                                          ),
                                 textOutput('p1'),
                                 tags$head(tags$style("#p1{color: #000D80;
                                     font-size: 18px;
                                     font-style: italic;
                                     }"
                                 )
                                 ),
                                 h4('b) Situación de las empresas a lo largo de los años, dada la situación actual'),
                                 fluidRow(column(6, numericInput('xe1', 'Ingrese el número de clientes actual de la Empresa XYZ', value = 5729, min = 1000, max = 16541)),
                                          column(6, numericInput('n_1', 'Ingrese el número de años que desea:', value = 5, min = 2, max = 100))
                                 ),
                                 mainPanel(align="center",uiOutput("s1")),
                                 fluidRow(column(1, ''),
                                          column(8, box(highchartOutput("g1"), width = 12)),
                                          column(1, "")),
                                 verticalLayout(
                                   h4('c) Si se tiene que inicialmente la Empresa XYZ tiene 5729 clientes y la Competencia 10812, a largo plazo la situación de la empresa será:'),
                                   h4('La distribución estacionaria es:'),
                                   mainPanel(align="center",uiOutput("d1")),
                                   h4('y por tanto la situación de las empresas a largo plazo será igual a:'),
                                   mainPanel(align="center",uiOutput("c1")),
                                   h4('El siguiente grafico representa el número de clientes en los diferentes años')
                                 ),
                                 fluidRow(column(1, ''),
                                          column(8, box(highchartOutput("evolucion1"), width = 12)),
                                          column(1, ""))
    
                        ),
                     
             ),
             navbarMenu("Contaminación en terrenos", 
                        tabPanel(span("Enunciado", style = "color:black"),
                                 h3("Se pretende realizar el estudio de la contaminación en la región Amazónica en la que se están produciendo vertidos industriales. 
                                 Se han clasificado los terrenos en tres niveles de contaminación:"),
                                 p(),
                                 flowLayout(verticalLayout(
                                 h4("• Terrenos limpios."),
                                 h4("• Terrenos con nivel de contaminación medio."),
                                 h4("• Terrenos con nivel de contaminación alto.")),
                                 verticalLayout(mainPanel(img(src="Img4.jpg", height=240, width=220)))),
                                 p(),
                                 h3("Se comprueba que la evolución de la contaminación de un año para otro se ajusta a los siguientes datos:"),
                                 p(),
                                 verticalLayout(h4("• Cada año se contamina un 30% de los terrenos limpios de la siguiente manera: el 20% con un nivel de contaminación medio y el 10% con un nivel de contaminación alto."),
                                                splitLayout(mainPanel(align="right",img(src="Img5.jpg", height=200, width=350)),mainPanel(img(src="Img6.jpg", height=200, width=350)))),
                                 verticalLayout(h4("• Anualmente el 30% de los terrenos con nivel de contaminación media pasan a tener contaminación alta. "),
                                            mainPanel(align="center",img(src="Img7.jpg", height=200, width=350))),
                                 p(),
                                 h3("Ante esta situación, las autoridades locales emprenden un plan de recuperación de las zonas contaminadas.
                                 El plan actúa directamente sobre los terrenos más contaminados consiguiendo, por un lado, 
                                 limpiar totalmente el 70% de los terrenos con contaminación alta,
                                 y por otro, reducir la contaminación de otro 10% de zona de alta contaminación que pasa a contaminación media."),
                                 verticalLayout(splitLayout(mainPanel(align="right",img(src="Img8.jpg", height=250, width=400)),mainPanel(img(src="Img9.jpg", height=250, width=250)))),
                                 h3(strong("Si el territorio estudiado tiene una extensión de 2500 hectáreas e inicialmente todas ellas estaban limpias, estudie la distribución de terrenos contaminados en la región Amazónica en el largo plazo.")),
                                 flowLayout(mainPanel(align="right",img(src="Img2.jpg", height=150, width=100)),mainPanel(align="center",img(src="Img10.jpg", height=300, width=550)))
                    
                        ),
                        tabPanel("Modelamiento y Resolución Teórica",
                                 h3("En base a la información proporcionado podemos analizar la situación como una cadena de Markov, donde:"),
                                 p(),
                                 verticalLayout(
                                   h4("• El espacio de estados S esta representado por:"),
                                   h5("S={L,M,A}, con L:= Terrenos limpios , M:= Terrenos con nivel de contaminación medio y A:=Terrenos con nivel de contaminación alto."),
                                   h4("• El conjunto de índices T esta denotado por:"),
                                   h5("T={0,1,2,...}, en el cual cada índice representa el número de años transcurridos" ),
                                   h4("• Y la matriz de transición P esta dada por:"),
                                   mainPanel(align="center",uiOutput("Matriz2"))
                                 ),
                                 p(),
                                 verticalLayout(
                                   h3("Así,usando la matriz de transición vamos a gráficar el espacio de estados con sus conexiones:"),
                                   mainPanel(align="right",img(src="Cadenadeestados2.png", height=350, width=420)),
                                   h3("Además, podemos apreciar que existe una única clase de comunicación:"),
                                   mainPanel(align="left",img(src="Formula4.png", height=140, width=330)),
                                   h3("Por lo tanto, la cadena es finita e irreducible."),
                                   h3("Por otro lado, colegimos que la cadena es también aperiódica:"),
                                   mainPanel(align="left",img(src="Formula5.png", height=70, width=480)),
                                   h3("Por consiguiente, como la cadena es finita, irreducible y apériodica concluimos que se trata de una cadena érgodica e irreducible. Esto quiere decir, que la distribución límite existe, es única y es igual a la distribución estacionaria."),
                                   p(),
                                   h3("Ahora, por definición de distribución estacionaria tenemos que"),
                                   mainPanel(align="right",img(src="Formula6.png", height=270, width=550)),
                                   h3("Así"),
                                   h4("• La proporción de que a largo plazo los terrenos de la región Amazónica esten limpios es 21/47."),
                                   h4("• La proporción de que a largo plazo los terrenos de la región Amazónica tengan un nivel de contaminación medio es 17/47."),
                                   h4("• La proporción de que a largo plazo los terrenos de la región Amazónica tengan un nivel de contaminación medio es 9/47."),
                                   p(),
                                   h3("Y puesto que la extensión de los terrenos estudiados es de 2500 hectáreas, entonces a largo plazo la distribución de terrenos de la región Amazónica es:"),
                                   h4("• 1117.02 hectáreas de terrenos limpios."),
                                   h4("• 904.26 hectáreas de terrenos con nivel de contaminación medio."),
                                   h4("• 478.72 hectáreas de terrenos con nivel de contaminación medio.")
                                 )
                                 
                        ),
                        tabPanel("Modelamiento y Resolución Práctica",
                                 h3("En base a la información proporcionado podemos analizar la situación como una cadena de Markov, donde:"),
                                 p(),
                                 verticalLayout(
                                   h4("• El espacio de estados S esta representado por:"),
                                   h5("S={L,M,A}, con L:= Terrenos limpios , M:= Terrenos con nivel de contaminación medio y A:=Terrenos con nivel de contaminación alto."),
                                   h4("• El conjunto de índices T esta denotado por:"),
                                   h5("T={0,1,2,...}, en el cual cada índice representa el número de años transcurridos" ),
                                   h4("• Y la matriz de transición P esta dada por:"),
                                   mainPanel(align="center",uiOutput("Matriz22"))
                                 ),
                                 p(),
                                 verticalLayout(
                                   h3("Así,usando la matriz de transición su correspondiente diagrama es:"),
                                   mainPanel(align="right",img(src="Cadenadeestados2.png", height=350, width=420))
                                 ),
                                 h4('a) Cálculo de la probabilidad de transitar del estado i al estado j, en n pasos'),
                                 fluidRow(column(3, radioButtons("i2", "Elige el estado de origen:", choices = c("L", "M", 'A'), inline = TRUE)),
                                          column(3, radioButtons("j2", "Elige el estado de llegada:",choices = c("L", "M", 'A'), inline = TRUE)),
                                          column(6, numericInput("n2", "Ingrese el número de pasos (años):",value = 5, min = 1, max = 20))
                                 ),
                                 textOutput('p2'),
                                 tags$head(tags$style("#p2{color: #000D80;
                                     font-size: 18px;
                                     font-style: italic;
                                     }"
                                 )
                                 ),
                                 h4('b) Dado que inicialmente las 2500 hectareas están totalmente limpias, la situación después de n años es:'),
                                 fluidRow(column(4, numericInput('n_2', 'Ingrese el número de años que desea:', value = 5, min = 2, max = 100))
                                 ),
                                 mainPanel(align="center",uiOutput("s2")),
                                 fluidRow(column(1, ''),
                                          column(8, box(highchartOutput("g2"), width = 12)),
                                          column(1, "")),
                                 verticalLayout(
                                   h4('c) Si se tiene que inicialmente las 2500 hectareas se encontraban totalmente limpias, a largo plazo la situación de la contaminación en la región Amazónica será:'),
                                   h4('La distribución estacionaria es:'),
                                   mainPanel(align="center",uiOutput("d2")),
                                   h4('y por tanto la situación de contaminación a largo plazo será igual a:'),
                                   mainPanel(align="center",uiOutput("c2")),
                                   h4('El siguiente grafico representa el cambio al pasar los años')
                                 ),
                                 fluidRow(column(1, ''),
                                          column(8, box(highchartOutput("evolucion2"), width = 12)),
                                          column(1, ""))       
                        ),
                        
             )
  )
)
)