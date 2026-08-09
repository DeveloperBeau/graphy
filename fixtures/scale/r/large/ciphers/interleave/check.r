# Round-trip verification for the interleave cipher.

source("ciphers/interleave/cipher.r")

interleave_verify <- function(sample) {
  encrypted <- interleave_encrypt(sample)
  decrypted <- interleave_decrypt(encrypted)
  all(decrypted == sample)
}

interleave_verify_label <- function() {
  paste0("verify:", "interleave")
}
