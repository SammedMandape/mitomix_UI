#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
#library(xlsx)
library(tidyverse)
library(readxl)
# Define UI for application that draws a histogram
# ui <- fluidPage(
#    
#    # Application title
#    titlePanel("Old Faithful Geyser Data"),
#    
#    # Sidebar with a slider input for number of bins 
#    sidebarLayout(
#       sidebarPanel(
#          sliderInput("bins",
#                      "Number of bins:",
#                      min = 1,
#                      max = 50,
#                      value = 30)
#       ),
#       
#       # Show a plot of the generated distribution
#       mainPanel(
#          plotOutput("distPlot")
#       )
#    )
# )

# Define server logic required to draw a histogram
# server <- function(input, output) {
#    
#    output$distPlot <- renderPlot({
#       # generate bins based on input$bins from ui.R
#       x    <- faithful[, 2] 
#       bins <- seq(min(x), max(x), length.out = input$bins + 1)
#       
#       # draw the histogram with the specified number of bins
#       hist(x, breaks = bins, col = 'darkgray', border = 'white')
#    })
# }

# Run the application 
IUPAC_ambiguity_codes <- tribble(
   ~IUPACcode, ~Meaning,
   "M", "A or C",
   "R",	"A or G",
   "W",	"A or T",
   "S",	"C or G",
   "Y",	"C or T",
   "K",	"G or T",
   "V",	"A or C or G",
   "H",	"A or C or T",
   "D",	"A or G or T",
   "B",	"C or G or T",
   "N",	"G or A or T or C"
     )

ui <- dashboardPage(
   dashboardHeader(title = "MitoMix Interpretation Tool"),
   dashboardSidebar(),
   dashboardBody(
      fluidRow(
         box(fileInput("file_Input", label = h3("File input"), placeholder = "No file selected"),
         hr(),
         fluidRow(column(4, verbatimTextOutput("value"))),
         box(tableOutput("file_output"))
      ))
   )
)

server <- function(input, output){
   output$value <- renderPrint({
      str(input$file_Input)
      })
   
   rawData <- eventReactive(input$file_Input, {
      read_excel(input$file_Input$datapath, sheet = "Variants", skip = 6)
   })
   
   #rawData() %>% 
   output$file_output <- renderTable({
      #data <- read.xlsx("Mix_variants_colored.xlsx", sheetIndex = 1)
      #file1=input$file_Input
      #data <- readxl::read_excel(file1$datapath)
      
      ##rawData() %>% filter(Type != "INS" & Type != "DEL") %>% separate_rows(Polymorphism, sep = "(?<=[0-9])(?=[A-Z])") %>% head
      rawData() %>% filter(Type != "INS" & Type != "DEL") %>% separate(Polymorphism, into= c("Pos","Variant"), sep = "(?<=[0-9])(?=[A-Z])") %>% head
      })
}
shinyApp(ui = ui, server = server)

