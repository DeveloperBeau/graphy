# Exponentiation.

calc_power <- function(base, exponent) {
  stopifnot(is.numeric(base), is.numeric(exponent))
  base^exponent
}

power_table <- function(bases, exponent) {
  vapply(bases, calc_power, numeric(1), exponent = exponent)
}
