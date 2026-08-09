# CbcXor cipher: xor chained against the previous cipher byte.

cbcxor_iv <- 113

cbcxor_keystream <- function(cipher_bytes) {
  c(cbcxor_iv, cipher_bytes[-length(cipher_bytes)])
}

cbcxor_encrypt <- function(bytes) {
  out <- integer(length(bytes))
  prev <- cbcxor_iv
  for (i in seq_along(bytes)) {
    out[i] <- bitwXor(bytes[i], prev)
    prev <- out[i]
  }
  out
}

cbcxor_decrypt <- function(bytes) {
  bitwXor(bytes, cbcxor_keystream(bytes))
}
