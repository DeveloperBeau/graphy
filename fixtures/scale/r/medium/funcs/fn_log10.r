# Base-10 logarithm.

calc_log10 <- function(x) {
  stopifnot(is.numeric(x))
  log10(x)
}

log10_table <- function(xs) {
  vapply(xs, calc_log10, numeric(1))
}
