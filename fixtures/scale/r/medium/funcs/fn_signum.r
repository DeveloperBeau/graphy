# Signum.

calc_signum <- function(x) {
  stopifnot(is.numeric(x))
  sign(x)
}

signum_table <- function(xs) {
  vapply(xs, calc_signum, numeric(1))
}
