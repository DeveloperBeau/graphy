# Key material helpers for the addmod cipher.

addmod_default_key <- function() {
  17
}

addmod_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

addmod_key_id <- function() {
  paste0("addmod:", addmod_default_key())
}
