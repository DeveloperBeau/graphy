# Timestamped logging for bench runs.

log_write <- function(level, ...) {
  stamp <- format(Sys.time(), "%H:%M:%S")
  message(sprintf("%s [%s] %s", stamp, level, paste(..., sep = " ")))
}

log_info <- function(...) {
  log_write("INFO", ...)
}

log_warn <- function(...) {
  log_write("WARN", ...)
}
