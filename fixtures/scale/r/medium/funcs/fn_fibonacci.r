# Fibonacci number (iterative).

calc_fibonacci <- function(n) {
  a <- 0
  b <- 1
  for (i in seq_len(n)) {
    swap <- a + b
    a <- b
    b <- swap
  }
  a
}
