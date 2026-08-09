# Key material helpers for the runkey cipher.

runkey_default_key <- function() {
  "THEQUICKBROWNFOX"
}

runkey_validate_key <- function(key) {
  is.character(key) && nchar(key) >= 3
}

runkey_key_id <- function() {
  paste0("runkey:", runkey_default_key())
}
