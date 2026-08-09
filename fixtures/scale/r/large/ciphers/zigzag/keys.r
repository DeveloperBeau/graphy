# Key material helpers for the zigzag cipher.

zigzag_default_key <- function() {
  2
}

zigzag_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

zigzag_key_id <- function() {
  paste0("zigzag:", zigzag_default_key())
}
