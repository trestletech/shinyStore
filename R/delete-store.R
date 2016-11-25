#' Delete local storage key
#' 
#' Send the name of the field to delete
#' 
#' @param session The session paramter from the \code{\link{shinyServer}} 
#' function.
#' @param name The name for this setting. This is the name you referenced on updateStore
#' @export
deleteStore <- function(session, name){
  if (missing(name) || missing(session)){
    stop("Must provide a name, and a session")
  }
  
  session$sendCustomMessage("shinyDelete", name)
}