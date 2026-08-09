# Rot47 cipher: fixed +47 byte rotation.

rot47_encrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (bytes + 47) %% 256
}

rot47_decrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (bytes - 47) %% 256
}
