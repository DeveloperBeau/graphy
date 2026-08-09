# Round-trip verification for the sdbm cipher.

source("ciphers/sdbm/cipher.r")

sdbm_verify <- function(sample) {
  first <- sdbm_digest(sample)
  second <- sdbm_digest(sample)
  identical(first, second)
}

sdbm_verify_label <- function() {
  paste0("verify:", "sdbm")
}
