# Cube root.

calc_cbrt <- function(x) {
  stopifnot(is.numeric(x))
  sign(x) * abs(x)^(1 / 3)
}

cbrt_table <- function(xs) {
  vapply(xs, calc_cbrt, numeric(1))
}
