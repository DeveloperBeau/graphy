# Columnar cipher: block transposition with period 4.

columnar_perm <- c(3, 1, 0, 2)
columnar_inv <- c(2, 1, 3, 0)

columnar_apply <- function(bytes, order) {
  p <- length(order)
  out <- bytes
  for (b in seq_len(length(bytes) %/% p)) {
    base <- (b - 1) * p
    out[base + seq_len(p)] <- bytes[base + order + 1]
  }
  out
}

columnar_encrypt <- function(bytes) {
  columnar_apply(bytes, columnar_perm)
}

columnar_decrypt <- function(bytes) {
  columnar_apply(bytes, columnar_inv)
}
