# Hyperbolic cosine.

calc_cosh <- function(x) {
  stopifnot(is.numeric(x))
  cosh(x)
}

cosh_table <- function(xs) {
  vapply(xs, calc_cosh, numeric(1))
}
