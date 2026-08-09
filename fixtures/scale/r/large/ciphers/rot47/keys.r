# Key material helpers for the rot47 cipher.

rot47_default_key <- function() {
  47
}

rot47_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

rot47_key_id <- function() {
  paste0("rot47:", rot47_default_key())
}
