# Multiplicative inverse.

calc_reciprocal <- function(x) {
  stopifnot(is.numeric(x))
  1 / x
}

reciprocal_table <- function(xs) {
  vapply(xs, calc_reciprocal, numeric(1))
}
