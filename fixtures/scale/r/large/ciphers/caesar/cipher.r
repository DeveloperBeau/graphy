# Caesar cipher: fixed +3 byte rotation.

caesar_encrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (bytes + 3) %% 256
}

caesar_decrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (bytes - 3) %% 256
}
