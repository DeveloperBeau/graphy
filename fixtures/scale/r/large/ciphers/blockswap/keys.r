# Key material helpers for the blockswap cipher.

blockswap_default_key <- function() {
  8
}

blockswap_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

blockswap_key_id <- function() {
  paste0("blockswap:", blockswap_default_key())
}
