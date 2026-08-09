# Key material helpers for the beaufort cipher.

beaufort_default_key <- function() {
  "FORTRESS"
}

beaufort_validate_key <- function(key) {
  is.character(key) && nchar(key) >= 3
}

beaufort_key_id <- function() {
  paste0("beaufort:", beaufort_default_key())
}
