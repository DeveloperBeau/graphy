# Key material helpers for the fnv1a cipher.

fnv1a_default_key <- function() {
  2166136261
}

fnv1a_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

fnv1a_key_id <- function() {
  paste0("fnv1a:", fnv1a_default_key())
}
