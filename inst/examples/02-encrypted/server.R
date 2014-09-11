library(shiny)
library(shinyStore)

pubKey <- PKI.load.key(file="test.key.pub")

#' Define server logic required to generate a simple shinyStore example
#' @author Jeff Allen \email{cran@@trestletech.com}
shinyServer(function(input, output, session) {
  output$curText <- renderText({
    txt <- input$store$text
    if (ssErr(txt) > 0){
      print("Encountered an error decrypting the text!")
    }
    return(txt)
  })
  
  observe({
    if (input$save <= 0){
      # On initialization, set the value of the text editor to the current val.
      updateTextInput(session, "text", value=isolate(input$store)$text)
      
      return()
    }
    
    key <- NULL
    if (isolate(input$encrypt)){
      key <- pubKey
    }
    updateStore(session, "text", isolate(input$text), encrypt=key)
  })
})