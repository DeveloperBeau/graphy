# Decimation cipher: affine map 7x+0 over bytes.

decimation_encrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (7 * bytes + 0) %% 256
}

decimation_decrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (183 * (bytes - 0)) %% 256
}
