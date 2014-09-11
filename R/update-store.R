#' @export
updateStore <- function(session, name, value){
  if (missing(name) || missing(value) || missing(session)){
    stop("Must provide a name, a value, and a session")
  }
  
  li <- list()
  
  key <- options("shinyStore.key.pub")[[1]]
  if (is.null(key)){
    # No encryption, just assign.
    li[[name]] <- value
  } else{
    # We'll be encrypting the object, then.
    enc <- PKI.encrypt(charToRaw(as.character(value)), key)
    char <- paste0(as.character(enc), collapse="")
    
    li[[name]] <- char
  }
  
  session$sendCustomMessage("shinyStore", li)
}