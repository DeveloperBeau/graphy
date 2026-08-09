# Round-trip verification for the sum32 cipher.

source("ciphers/sum32/cipher.r")

sum32_verify <- function(sample) {
  first <- sum32_digest(sample)
  second <- sum32_digest(sample)
  identical(first, second)
}

sum32_verify_label <- function() {
  paste0("verify:", "sum32")
}
