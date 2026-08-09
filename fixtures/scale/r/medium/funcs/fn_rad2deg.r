# Radians to degrees.

calc_rad2deg <- function(x) {
  stopifnot(is.numeric(x))
  x * 180 / pi
}

rad2deg_table <- function(xs) {
  vapply(xs, calc_rad2deg, numeric(1))
}
