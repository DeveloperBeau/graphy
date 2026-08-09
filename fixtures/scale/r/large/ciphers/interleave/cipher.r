# Interleave cipher: block transposition with period 8.

interleave_perm <- c(0, 2, 4, 6, 1, 3, 5, 7)
interleave_inv <- c(0, 4, 1, 5, 2, 6, 3, 7)

interleave_apply <- function(bytes, order) {
  p <- length(order)
  out <- bytes
  for (b in seq_len(length(bytes) %/% p)) {
    base <- (b - 1) * p
    out[base + seq_len(p)] <- bytes[base + order + 1]
  }
  out
}

interleave_encrypt <- function(bytes) {
  interleave_apply(bytes, interleave_perm)
}

interleave_decrypt <- function(bytes) {
  interleave_apply(bytes, interleave_inv)
}
