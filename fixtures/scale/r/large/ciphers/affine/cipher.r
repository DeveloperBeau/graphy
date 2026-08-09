# Affine cipher: affine map 5x+8 over bytes.

affine_encrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (5 * bytes + 8) %% 256
}

affine_decrypt <- function(bytes) {
  stopifnot(is.numeric(bytes))
  (205 * (bytes - 8)) %% 256
}
