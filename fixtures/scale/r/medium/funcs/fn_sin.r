# Sine with optional degree input.

calc_sin <- function(x, degrees = FALSE) {
  if (degrees) {
    x <- x * pi / 180
  }
  sin(x)
}

sin_table <- function(xs) {
  vapply(xs, calc_sin, numeric(1))
}
