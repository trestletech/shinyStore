#' Get shinyStore error code
#' 
#' Given a shinyStore object, gets the error code off of it. Will return 0 if 
#' no error, or a positive integer if there is an error.
#' @param obj The object to inspect for an error.
#' @export
ssErr <- function(obj){
  at <- attr(obj, "shinyStoreErr")
  if (!is.null(at)){
    return(at)
  }
  return(0)
}