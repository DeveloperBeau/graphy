# Round-trip verification for the adler cipher.

source("ciphers/adler/cipher.r")

adler_verify <- function(sample) {
  first <- adler_digest(sample)
  second <- adler_digest(sample)
  identical(first, second)
}

adler_verify_label <- function() {
  paste0("verify:", "adler")
}
