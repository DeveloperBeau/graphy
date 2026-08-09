# Round-trip verification for the fnv1a cipher.

source("ciphers/fnv1a/cipher.r")

fnv1a_verify <- function(sample) {
  first <- fnv1a_digest(sample)
  second <- fnv1a_digest(sample)
  identical(first, second)
}

fnv1a_verify_label <- function() {
  paste0("verify:", "fnv1a")
}
