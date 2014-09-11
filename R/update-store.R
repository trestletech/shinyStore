#' Update local storage
#' 
#' Send the name of the field to update and the value which should be stored
#' in this user's local storage.
#' 
#' @param session The session paramter from the \code{\link{shinyServer}} 
#' function.
#' @param name The name for this setting. This is the name you'll reference
#' later when you want to retrieve this value from your storage object.
#' @param value The value for this setting. Can be a string, in which case it 
#' will be passed through unbothered, or a more complex object which will be
#' translated to JSON.
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
    json <- RJSONIO::toJSON(list(data=value, user=session$user))
    
    enc <- PKI.encrypt(charToRaw(json), key)
    char <- paste0(as.character(enc), collapse="")
    
    li[[name]] <- char
  }
  
  session$sendCustomMessage("shinyStore", li)
}