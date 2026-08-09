# Hyperbolic tangent.

calc_tanh <- function(x) {
  stopifnot(is.numeric(x))
  tanh(x)
}

tanh_table <- function(xs) {
  vapply(xs, calc_tanh, numeric(1))
}
