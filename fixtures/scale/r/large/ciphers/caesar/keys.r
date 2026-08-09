# Key material helpers for the caesar cipher.

caesar_default_key <- function() {
  3
}

caesar_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

caesar_key_id <- function() {
  paste0("caesar:", caesar_default_key())
}
