#' @export
updateStore <- function(session, key, value){
  if (missing(key) || missing(value) || missing(session)){
    stop("Must provide a key, a value, and a session")
  }
  
  li <- list()
  li[[key]] <- value
  session$sendCustomMessage("shinyStore", li)
}