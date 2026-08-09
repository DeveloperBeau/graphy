# Key material helpers for the porta cipher.

porta_default_key <- function() {
  "GLACIER"
}

porta_validate_key <- function(key) {
  is.character(key) && nchar(key) >= 3
}

porta_key_id <- function() {
  paste0("porta:", porta_default_key())
}
