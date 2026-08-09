# Version metadata for textprint.

textprint_version_string <- "0.9.3"

textprint_version <- function() {
  textprint_version_string
}

textprint_build_info <- function() {
  sprintf("textprint %s on R %s", textprint_version_string, R.version.string)
}
