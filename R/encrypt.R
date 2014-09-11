
.onLoad <- function(libname, pkgname){
  shiny::registerInputHandler("shinyStore", function(val, shinysession, name){
    key <- options("shinyStore.key.priv")[[1]]
    if (is.null(key)){
      # No encryption, just return.
      return(val)
    } else{
      # Decrypt, then return.
      
      lapply(val, function(v){
        tryCatch({
          msg <- ""
          suppressWarnings({
            # Parse a character string into raw hex... surely this could be easier/faster...
            arr <- strsplit(v, "")[[1]]
            arr <- split(arr, ceiling(seq_along(arr)/2))
            byt <- unlist(lapply(arr, function(x){ paste(x, collapse="") }))
            ra <- as.raw(strtoi(byt, base="16"))
            msg <- rawToChar(PKI.decrypt(ra, key))
          })
          obj <- RJSONIO::fromJSON(msg)
          
          if (!is.null(obj$user) && (is.null(shinysession$user) || obj$user != shinysession$user)){
            print("Test")
            warning("User mismatch! Refusing to decrypt shinyStore field.")
            return(v)
          } else {
            return(obj$data)  
          }
        }, error=function(e){
          print(e)
          warning("Error decrypting field. Passing through unaltered.")
          return(v)
        })
        
      })
    }
  })
}

.onUnload <- function(libpath){
  shiny::removeInputHandler(type = "shinyStore")
}
