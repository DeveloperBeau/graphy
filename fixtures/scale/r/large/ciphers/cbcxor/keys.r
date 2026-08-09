# Key material helpers for the cbcxor cipher.

cbcxor_default_key <- function() {
  113
}

cbcxor_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

cbcxor_key_id <- function() {
  paste0("cbcxor:", cbcxor_default_key())
}
