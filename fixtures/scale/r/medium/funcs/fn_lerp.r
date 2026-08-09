# Linear interpolation between two values.

calc_lerp <- function(from, to, t) {
  stopifnot(is.numeric(t))
  from + (to - from) * t
}

lerp_seq <- function(from, to, n) {
  vapply(seq(0, 1, length.out = n), calc_lerp, numeric(1), from = from, to = to)
}
