# Key material helpers for the crclite cipher.

crclite_default_key <- function() {
  4294967295
}

crclite_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

crclite_key_id <- function() {
  paste0("crclite:", crclite_default_key())
}
