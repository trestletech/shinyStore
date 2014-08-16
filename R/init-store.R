#' @export
initStore <- function(id, namespace){
  if (missing(id) || missing(namespace)){
    stop("Must provide both an ID and a namespace when initializing a store")
  }
  if (grepl("\\\\", namespace)){
    stop("namespace cannot contain a backslash (\\).")
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