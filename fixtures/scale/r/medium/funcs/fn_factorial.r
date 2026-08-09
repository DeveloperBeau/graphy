# Factorial via the gamma function.

calc_factorial <- function(n) {
  stopifnot(n >= 0)
  if (n <= 1) {
    return(1)
  }
  gamma(n + 1)
}

factorial_table <- function(ns) {
  vapply(ns, calc_factorial, numeric(1))
}
