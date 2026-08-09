# Scytale cipher: block transposition with period 6.

scytale_perm <- c(0, 3, 1, 4, 2, 5)
scytale_inv <- c(0, 2, 4, 1, 3, 5)

scytale_apply <- function(bytes, order) {
  p <- length(order)
  out <- bytes
  for (b in seq_len(length(bytes) %/% p)) {
    base <- (b - 1) * p
    out[base + seq_len(p)] <- bytes[base + order + 1]
  }
  out
}

scytale_encrypt <- function(bytes) {
  scytale_apply(bytes, scytale_perm)
}

scytale_decrypt <- function(bytes) {
  scytale_apply(bytes, scytale_inv)
}
