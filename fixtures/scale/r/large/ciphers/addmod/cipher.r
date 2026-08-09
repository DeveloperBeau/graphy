# Addmod cipher: fixed +17 byte rotation.

addmod_encrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (bytes + 17) %% 256
}

addmod_decrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (bytes - 17) %% 256
}
