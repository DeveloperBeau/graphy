# Key material helpers for the xorroll cipher.

xorroll_default_key <- function() {
  193
}

xorroll_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

xorroll_key_id <- function() {
  paste0("xorroll:", xorroll_default_key())
}
