# Key material helpers for the railfence cipher.

railfence_default_key <- function() {
  6
}

railfence_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

railfence_key_id <- function() {
  paste0("railfence:", railfence_default_key())
}
