# Rotmix cipher: position-salted shift of +3.

rotmix_encrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (bytes + 3 + seq_along(bytes) - 1) %% 256
}

rotmix_decrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (bytes - 3 - (seq_along(bytes) - 1)) %% 256
}
