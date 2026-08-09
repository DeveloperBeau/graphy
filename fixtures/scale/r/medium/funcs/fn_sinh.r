# Hyperbolic sine.

calc_sinh <- function(x) {
  stopifnot(is.numeric(x))
  sinh(x)
}

sinh_table <- function(xs) {
  vapply(xs, calc_sinh, numeric(1))
}
