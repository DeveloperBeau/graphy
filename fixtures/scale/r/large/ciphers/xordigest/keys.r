# Key material helpers for the xordigest cipher.

xordigest_default_key <- function() {
  0
}

xordigest_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

xordigest_key_id <- function() {
  paste0("xordigest:", xordigest_default_key())
}
