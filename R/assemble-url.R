assembleURL <- function(session){
  dat <- reactiveValuesToList(session$clientData)
  paste0(dat$url_protocol, "//", dat$url_hostname, ":", dat$url_port, dat$url_pathname)
}