# Key material helpers for the decimation cipher.

decimation_default_key <- function() {
  0
}

decimation_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

decimation_key_id <- function() {
  paste0("decimation:", decimation_default_key())
}
