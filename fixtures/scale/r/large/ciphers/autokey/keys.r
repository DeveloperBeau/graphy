# Key material helpers for the autokey cipher.

autokey_default_key <- function() {
  "QUEEN"
}

autokey_validate_key <- function(key) {
  is.character(key) && nchar(key) >= 3
}

autokey_key_id <- function() {
  paste0("autokey:", autokey_default_key())
}
