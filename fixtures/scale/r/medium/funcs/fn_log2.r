# Base-2 logarithm.

calc_log2 <- function(x) {
  stopifnot(is.numeric(x))
  log2(x)
}

log2_table <- function(xs) {
  vapply(xs, calc_log2, numeric(1))
}
