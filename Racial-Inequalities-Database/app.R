library(shiny)
library(haven)
library(DT)
library(dplyr)

ui<-fluidPage(sidebarLayout(
  
  sidebarPanel(
    fileInput("data1", "Upload your dataset in .csv format", multiple = FALSE, accept = ".csv")
  ),
  
  mainPanel(
    DTOutput("combine")
  )
  
))

server <- function(input,output,session){
  
  DAT_A <- reactive({
    req(input$data1)
    inData1 <- input$data1
    if (is.null(inData1)){ return(NULL) }
    mydata1 <- read.csv(inData1$datapath)
  })
  
    mydata2 <- read.csv("~/Racial-Inequalities-Database/all_census_data.csv")
    mydata2$zip <- as.character(mydata2$zip)

  
  output$combine = renderDT({
    
    c_all <- left_join(DAT_A(), mydata2, by = "zip")
  })
  
}
shinyApp(ui = ui, server = server)

