# Round-trip verification for the decimation cipher.

source("ciphers/decimation/cipher.r")

decimation_verify <- function(sample) {
  encrypted <- decimation_encrypt(sample)
  decrypted <- decimation_decrypt(encrypted)
  all(decrypted == sample)
}

decimation_verify_label <- function() {
  paste0("verify:", "decimation")
}
