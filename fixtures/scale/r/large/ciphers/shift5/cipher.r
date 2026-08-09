# Shift5 cipher: fixed +5 byte rotation.

shift5_encrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (bytes + 5) %% 256
}

shift5_decrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (bytes - 5) %% 256
}
