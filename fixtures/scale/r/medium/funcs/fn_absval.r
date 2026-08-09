# Absolute value.

calc_absval <- function(x) {
  stopifnot(is.numeric(x))
  abs(x)
}

absval_table <- function(xs) {
  vapply(xs, calc_absval, numeric(1))
}
