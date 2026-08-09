# Adler: two-accumulator checksum.

adler_digest <- function(bytes) {
  a <- 1
  b_acc <- 0
  for (b in bytes) {
    a <- (a + b) %% 65521
    b_acc <- (b_acc + a) %% 65521
  }
  a + b_acc * 65536
}

adler_hex <- function(bytes) {
  sprintf("%08x", adler_digest(bytes))
}
