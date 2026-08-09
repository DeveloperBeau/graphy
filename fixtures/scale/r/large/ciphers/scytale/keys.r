# Key material helpers for the scytale cipher.

scytale_default_key <- function() {
  6
}

scytale_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

scytale_key_id <- function() {
  paste0("scytale:", scytale_default_key())
}
