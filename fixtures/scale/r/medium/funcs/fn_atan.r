# Inverse tangent.

calc_atan <- function(x) {
  stopifnot(is.numeric(x))
  atan(x)
}

atan_table <- function(xs) {
  vapply(xs, calc_atan, numeric(1))
}
