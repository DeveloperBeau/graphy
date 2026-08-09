# Key material helpers for the quagmire cipher.

quagmire_default_key <- function() {
  "OCEAN"
}

quagmire_validate_key <- function(key) {
  is.character(key) && nchar(key) >= 3
}

quagmire_key_id <- function() {
  paste0("quagmire:", quagmire_default_key())
}
