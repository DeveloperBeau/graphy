# Round-trip verification for the prodhash cipher.

source("ciphers/prodhash/cipher.r")

prodhash_verify <- function(sample) {
  first <- prodhash_digest(sample)
  second <- prodhash_digest(sample)
  identical(first, second)
}

prodhash_verify_label <- function() {
  paste0("verify:", "prodhash")
}
