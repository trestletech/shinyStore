
#' Set the 
#' @export
setStorageNamespace <- function(name){
  assign("namespace", value=name, envir=.global)
}

getStorageNamespace <- function(){
  if (!exists("namespace", envir=.global)){
    stop("You must set the shinyStore namespace using setStorageNamespace()")
  }
  
  get("namespace", envir=.global)
}