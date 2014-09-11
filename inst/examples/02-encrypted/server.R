library(shiny)
library(shinyStore)
library(PKI)

#' Define server logic required to generate a simple shinyStore example
#' @author Jeff Allen \email{cran@@trestletech.com}
shinyServer(function(input, output, session) {
  output$curText <- renderText({
    input$store$text
  })
  
  observe({
    if (input$save <= 0){
      # On initialization, set the value of the text editor to the current val.
      updateTextInput(session, "text", value=isolate(input$store)$text)
      
      return()
    }
    updateStore(session, "text", isolate(input$text))
  })
})