# Key material helpers for the rc4lite cipher.

rc4lite_default_key <- function() {
  17
}

rc4lite_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

rc4lite_key_id <- function() {
  paste0("rc4lite:", rc4lite_default_key())
}
