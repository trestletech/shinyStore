#' Initialize shinyStore in an application's UI
#' 
#' Though shinyStore doesn't have any user-visible elements, you still must 
#' initialize it in your application's \code{ui.R} file. You should execute this
#' function in your ui.R file to setup the input element associated with your store.
#' @param id The identifier of the store (determines the name of the store on the
#' \code{input} reactive object in your \code{server.R} file).
#' @param namespace Not a \code{namespace} in the traditional R sense, but rather
#' the identifying prefix to use when storing any object in the browser's local
#' storage. This is the only means by which we can separate data stored for
#' different applications that are being hosted at the same (sub-)domain.
#' @export
initStore <- function(id, namespace, privateKey=NULL){
  if (missing(id) || missing(namespace)){
    stop("Must provide both an ID and a namespace when initializing a store")
  }
  if (grepl("\\\\", namespace)){
    stop("namespace cannot contain a backslash (\\).")
  }
  
  if (!missing(privateKey)){
    .global$privKey <- privateKey
  }
  
  tagList(
    singleton(tags$head(
      initResourcePaths(),
      tags$script(src = 'shinyStore/shinyStore.js')
    )),
    HTML(paste0("<script type=\"text/javascript\">shinyStore.init('",namespace,"')</script>")),
    div(class="shiny-store", id=id)
  )
}