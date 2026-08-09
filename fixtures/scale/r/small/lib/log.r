# Leveled logging to stderr.

log_write <- function(level, ...) {
  message(sprintf("[%s] %s", level, paste(..., sep = " ")))
}

log_info <- function(...) {
  log_write("INFO", ...)
}

log_warn <- function(...) {
  log_write("WARN", ...)
}
