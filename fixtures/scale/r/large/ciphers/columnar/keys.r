# Key material helpers for the columnar cipher.

columnar_default_key <- function() {
  4
}

columnar_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

columnar_key_id <- function() {
  paste0("columnar:", columnar_default_key())
}
