#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#library(shiny)
library(shinydashboard)
library(tidyverse)
library(readxl)
library(DT)

# Run the application 
IUPAC_ambiguity_codes <- tribble(
   ~IUPACcode, ~Meaning,
   "M", "A",
   "M", "C",
   "R", "A",
   "R", "G",
   "W", "A",
   "W", "T",
   "S", "C",
   "S", "G",
   "Y", "C",
   "Y", "T",
   "K", "G",
   "K", "T",
   "V", "A",
   "V", "C",
   "V", "G",
   "H", "A",
   "H", "C",
   "H", "T",
   "D", "A",
   "D", "G",
   "D", "T",
   "B", "C",
   "B", "G",
   "B", "T",
   "N", "G",
   "N", "A",
   "N", "T",
   "N", "C",
   "A", "A",
   "T", "T",
   "G", "G",
   "C", "C"
     )

ui <- dashboardPage(
   dashboardHeader(title = "MitoMix Interpretation Tool"),
   dashboardSidebar(),
   dashboardBody(
      fluidRow(
         box(fileInput("file_Input", label = h3("File input"), placeholder = "No file selected"),
         hr(),
         fluidRow(column(4, verbatimTextOutput("value"))),
         hr()
      )),
      box(title = "Converge variants file", width = 12, height = "575", solidHeader = T, status = "primary",
        #div(style = 'overflow-y: scroll; max-height: 600px; width: 75%', DT::dataTableOutput("file_output"))
        div(style = 'overflow-y: scroll; max-height: 600px',DT::dataTableOutput("file_output"))
      )
   )
)

server <- function(input, output){
   output$value <- renderPrint({
      str(input$file_Input)
      })
   
   rawData <- eventReactive(input$file_Input, {
     ## the following code is to import excel file 
     ##read_excel(input$file_Input$datapath, sheet = "Variants", skip = 6)
     #browser()
     read_lines(input$file_Input$datapath, n_max = -1L)
     #browser()
     })
   
   #rawData1 <- rawData() %>% filter(Type != "INS" & Type != "DEL") %>% separate(Polymorphism, into= c("Pos","Variant"), sep = "(?<=[0-9])(?=[A-Z])") %>% left_join(IUPAC_ambiguity_codes, by = c("Variant" = "IUPACcode")) 
   output$file_output <- DT::renderDataTable(
      #data <- read.xlsx("Mix_variants_colored.xlsx", sheetIndex = 1)
      #file1=input$file_Input
      #data <- readxl::read_excel(file1$datapath)
      
      ##rawData() %>% filter(Type != "INS" & Type != "DEL") %>% separate_rows(Polymorphism, sep = "(?<=[0-9])(?=[A-Z])") %>% head
     
     ## the following code is when excel file is taken as input 
     ##rawData() %>% filter(Type != "INS" & Type != "DEL") %>% separate(Polymorphism, into= c("Pos","Variant"), sep = "(?<=[0-9])(?=[A-Z])") %>% left_join(IUPAC_ambiguity_codes, by = c("Variant" = "IUPACcode")),
      ##options = list(searching = FALSE, pageLength = 2, scrollY = TRUE, scrollX = TRUE, autoWidth = TRUE)
    typeof(rawData())
     #strsplit(rawData()[2], '\t'),
     
      #rawData() %>% filter(Type != "INS" & Type != "DEL") %>% separate(Polymorphism, into= c("Pos","Variant"), sep = "(?<=[0-9])(?=[A-Z])") %>% left_join(IUPAC_ambiguity_codes, by = c("Variant" = "IUPACcode"))
      #browser()
     
     
      )
}
shinyApp(ui = ui, server = server)

