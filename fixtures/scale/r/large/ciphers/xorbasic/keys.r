# Key material helpers for the xorbasic cipher.

xorbasic_default_key <- function() {
  90
}

xorbasic_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

xorbasic_key_id <- function() {
  paste0("xorbasic:", xorbasic_default_key())
}
