library(shiny)
library(shinyStore)

# Load the key stored in the file. See PKI.genRSAKey to create your own key.
priv <- PKI.load.key(file="test.key")
options("shinyStore.key.priv" = priv)

pub <- PKI.load.key(file="test.key.pub")
options("shinyStore.key.pub" = pub)

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