# Key material helpers for the sdbm cipher.

sdbm_default_key <- function() {
  0
}

sdbm_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

sdbm_key_id <- function() {
  paste0("sdbm:", sdbm_default_key())
}
