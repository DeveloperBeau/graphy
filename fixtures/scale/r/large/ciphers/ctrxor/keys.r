# Key material helpers for the ctrxor cipher.

ctrxor_default_key <- function() {
  7
}

ctrxor_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

ctrxor_key_id <- function() {
  paste0("ctrxor:", ctrxor_default_key())
}
