# Round-trip verification for the djb2 cipher.

source("ciphers/djb2/cipher.r")

djb2_verify <- function(sample) {
  first <- djb2_digest(sample)
  second <- djb2_digest(sample)
  identical(first, second)
}

djb2_verify_label <- function() {
  paste0("verify:", "djb2")
}
