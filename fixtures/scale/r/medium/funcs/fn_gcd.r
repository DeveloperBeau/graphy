# Greatest common divisor (Euclid).

calc_gcd <- function(a, b) {
  a <- abs(a)
  b <- abs(b)
  while (b != 0) {
    remainder <- a %% b
    a <- b
    b <- remainder
  }
  a
}
