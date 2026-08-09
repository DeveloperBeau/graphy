# Key material helpers for the xorshift cipher.

xorshift_default_key <- function() {
  911
}

xorshift_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

xorshift_key_id <- function() {
  paste0("xorshift:", xorshift_default_key())
}
