# Arithmetic mean of a value list.

calc_mean <- function(xs) {
  stopifnot(length(xs) > 0)
  sum(xs) / length(xs)
}

running_mean <- function(xs) {
  cumsum(xs) / seq_along(xs)
}
