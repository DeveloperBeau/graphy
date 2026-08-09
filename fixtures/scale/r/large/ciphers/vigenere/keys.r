# Key material helpers for the vigenere cipher.

vigenere_default_key <- function() {
  "LEMON"
}

vigenere_validate_key <- function(key) {
  is.character(key) && nchar(key) >= 3
}

vigenere_key_id <- function() {
  paste0("vigenere:", vigenere_default_key())
}
