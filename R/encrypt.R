
.onLoad <- function(libname, pkgname){
  shiny::registerInputHandler("shinyStore", function(val, shinysession, name){
    key <- .global$privKey
    if (is.null(key)){
      # No encryption, just return.
      lapply(val, function(v){
        js <- RJSONIO::fromJSON(v)
        return(js$data)
      })
    } else{
      # Decrypt, then return.
      lapply(val, function(v){
        tryCatch({
          msg <- ""
          # Parse a character string into raw hex... surely this could be easier/faster...
          js <- RJSONIO::fromJSON(v)
          if (js["encV"] == "1.0"){
            suppressWarnings({
                arr <- strsplit(js[["data"]], "")[[1]]
                arr <- split(arr, ceiling(seq_along(arr)/2))
                byt <- unlist(lapply(arr, function(x){ paste(x, collapse="") }))
                ra <- as.raw(strtoi(byt, base="16"))
                msg <- rawToChar(PKI.decrypt(ra, key)) 
            })
            obj <- RJSONIO::fromJSON(msg)
            
            if (!is.null(obj$user) && (is.null(shinysession$user) || obj$user != shinysession$user)){
              warning("User mismatch! Refusing to decrypt shinyStore field.")
              attr(v, "shinyStoreErr") <- 0
              return(v)
            } else {
              return(obj$data)  
            }
          } else if (js["encV"] == FALSE){
            # We may have a key, but this is an unencrypted field.
            return(js[["data"]])
          } else{
            warning("Unknown encryption on the field. Returning unaltered.")
            return(v)
          }
          
          
        }, error=function(e){
          errCode <- 999
          if (grepl("invalid key", e$message)){
            errCode <- 100
          } else if (grepl("NULL key", e$message)){
            errCode <- 200
          } 
          
          attr(v, "shinyStoreErr") <- errCode
          
          warning(paste0("Error decrypting field. (#",errCode,", '", e$message,"') Passing through unaltered."))
          return(v)
        })
        
      })
    }
  })
}

.onUnload <- function(libpath){
  shiny::removeInputHandler(type = "shinyStore")
}
