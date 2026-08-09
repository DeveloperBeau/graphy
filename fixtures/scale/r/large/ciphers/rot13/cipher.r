# Rot13 cipher: fixed +13 byte rotation.

rot13_encrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (bytes + 13) %% 256
}

rot13_decrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (bytes - 13) %% 256
}
