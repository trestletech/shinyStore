library(shiny)
library(shinyStore)

# Load the key stored in the file. See PKI.genRSAKey to create your own key.
options("shinyStore.key.priv" = PKI.load.key(file="test.key"))

options("shinyStore.key.pub" = PKI.load.key(file="test.key.pub"))

#' Define UI for application that demonstrates a simple shinyStore
#' @author Jeff Allen \email{cran@@trestletech.com}
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Encrypted shinyStore!"),
    
    sidebarPanel(
      initStore("store", "shinyStore-ex1"), # Namespace must be unique to this application!
      
      tags$p("An example of using encryption to secure local storage values."),
      tags$p("This ensures that the user's browser will never store the raw, unencrypted",
             "value you're trying to store."),
      tags$p("See the ", tags$a(href="https://github.com/trestletech/shinyStore#security", "Security"),
             " section for a more complete discussion of the limitations of using local ",
             "storage to store anything meaningfully private. The short version is: local ",
             "storage will never be as secure as (HTTP-only) cookies and can only be ",
             "considered secure if combined with such a cookie to authenticate the user."),
      HTML("<hr />"),
      helpText(HTML("<p>Created using <a href = \"http://github.com/trestletech/shinyStore\">shinyStore</a>."))
    ),
    
    # Show the simple text value defined in the store.
    mainPanel(
      textInput("text", "Input:"),
      actionButton("save", "Save", icon("save")),
      div("Value stored currently:"),
      textOutput("curText"),
      hr(),
      div("Encrypted text stored locally:"),
      pre(id="encText"),
      # We don't provide an easy way to see the enrypted version, so we'll have
      # to cheat and use JavaScript to show this.
      includeScript("showEncryptedText.js")
    )
  ))