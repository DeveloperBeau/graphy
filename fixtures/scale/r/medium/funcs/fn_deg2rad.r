# Degrees to radians.

calc_deg2rad <- function(x) {
  stopifnot(is.numeric(x))
  x * pi / 180
}

deg2rad_table <- function(xs) {
  vapply(xs, calc_deg2rad, numeric(1))
}
