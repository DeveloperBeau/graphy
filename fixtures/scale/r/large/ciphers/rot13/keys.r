# Key material helpers for the rot13 cipher.

rot13_default_key <- function() {
  13
}

rot13_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

rot13_key_id <- function() {
  paste0("rot13:", rot13_default_key())
}
