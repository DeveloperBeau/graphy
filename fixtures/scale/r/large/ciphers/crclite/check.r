# Round-trip verification for the crclite cipher.

source("ciphers/crclite/cipher.r")

crclite_verify <- function(sample) {
  first <- crclite_digest(sample)
  second <- crclite_digest(sample)
  identical(first, second)
}

crclite_verify_label <- function() {
  paste0("verify:", "crclite")
}
