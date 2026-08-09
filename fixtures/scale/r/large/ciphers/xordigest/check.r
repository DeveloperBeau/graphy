# Round-trip verification for the xordigest cipher.

source("ciphers/xordigest/cipher.r")

xordigest_verify <- function(sample) {
  first <- xordigest_digest(sample)
  second <- xordigest_digest(sample)
  identical(first, second)
}

xordigest_verify_label <- function() {
  paste0("verify:", "xordigest")
}
