# Key material helpers for the rothash cipher.

rothash_default_key <- function() {
  99991
}

rothash_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

rothash_key_id <- function() {
  paste0("rothash:", rothash_default_key())
}
