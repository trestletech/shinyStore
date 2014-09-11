
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
          suppressWarnings({
            # Parse a character string into raw hex... surely this could be easier/faster...
            arr <- strsplit(v, "")[[1]]
            arr <- split(arr, ceiling(seq_along(arr)/2))
            byt <- unlist(lapply(arr, function(x){ paste(x, collapse="") }))
            ra <- as.raw(strtoi(byt, base="16"))
            return(rawToChar(PKI.decrypt(ra, key)))
          })
        }, error=function(e){
          warning("Error decrypting field. Passing through unaltered.")
          return(v)
        })
        
      })
    }
  })
}

# Example

# library(PKI)
# 
# key <- PKI.genRSAkey(2048)
# enc <- PKI.encrypt(charToRaw("abc123456"), key)
# char <- paste0(as.character(enc), collapse="")
# 
# # Parse a character string into raw hex... surely this could be easier/faster...
# arr <- strsplit(char, "")[[1]]
# arr <- split(arr, ceiling(seq_along(arr)/2))
# byt <- unlist(lapply(arr, function(x){ paste(x, collapse="") }))
# ra <- as.raw(strtoi(byt, base="16"))
# 
# rawToChar(PKI.decrypt(ra, key))
# 
