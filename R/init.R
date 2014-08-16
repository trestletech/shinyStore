.global <- new.env()

initResourcePaths <- function() {
  if (is.null(.global$loaded)) {
    shiny::addResourcePath(
      prefix = 'shinyStore',
      directoryPath = system.file('www', package='shinyStore'))
    .global$loaded <- TRUE
  }
  HTML("")
}