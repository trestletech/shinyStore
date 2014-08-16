library(shiny)
library(shinyStore)

#' Define UI for application that demonstrates a simple shinyStore
#' @author Jeff Allen \email{cran@@trestletech.com}
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Simple shinyStore!"),
    
    sidebarPanel(
      initStore("store", "shinyStore-ex1"), # Namespace must be unique to this application!
      
      tags$p("A simple shinyStore example."),
      tags$p("Enter some text in the text box to the right and click 'Save'. The value will be
saved in your browser's local storage, meaning that it will still be there if you disconnect, close
the tab, or even restart the Shiny process. This demonstrates shinyStore's ability to store persistent
data in the user's browser."),
      HTML("<hr />"),
      helpText(HTML("<p>Created using <a href = \"http://github.com/trestletech/shinyStore\">shinyStore</a>."))
    ),
    
    # Show the simple text value defined in the store.
    mainPanel(
      textInput("text", "Input:"),
      actionButton("save", "Save", icon("save")),
      div("Value stored currently:"),
      textOutput("curText")
    )
  ))