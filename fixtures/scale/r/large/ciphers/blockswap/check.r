# Round-trip verification for the blockswap cipher.

source("ciphers/blockswap/cipher.r")

blockswap_verify <- function(sample) {
  encrypted <- blockswap_encrypt(sample)
  decrypted <- blockswap_decrypt(encrypted)
  all(decrypted == sample)
}

blockswap_verify_label <- function() {
  paste0("verify:", "blockswap")
}
