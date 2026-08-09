# Round half to even.

calc_round <- function(x) {
  stopifnot(is.numeric(x))
  round(x)
}

round_table <- function(xs) {
  vapply(xs, calc_round, numeric(1))
}
