# Atbash cipher: mirror each byte across the range.

atbash_encrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  255 - bytes
}

atbash_decrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  255 - bytes
}
