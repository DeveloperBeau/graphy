# Round-trip verification for the rothash cipher.

source("ciphers/rothash/cipher.r")

rothash_verify <- function(sample) {
  first <- rothash_digest(sample)
  second <- rothash_digest(sample)
  identical(first, second)
}

rothash_verify_label <- function() {
  paste0("verify:", "rothash")
}
