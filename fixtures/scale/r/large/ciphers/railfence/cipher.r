# RailFence cipher: block transposition with period 6.

railfence_perm <- c(0, 2, 4, 1, 3, 5)
railfence_inv <- c(0, 3, 1, 4, 2, 5)

railfence_apply <- function(bytes, order) {
  p <- length(order)
  out <- bytes
  for (b in seq_len(length(bytes) %/% p)) {
    base <- (b - 1) * p
    out[base + seq_len(p)] <- bytes[base + order + 1]
  }
  out
}

railfence_encrypt <- function(bytes) {
  railfence_apply(bytes, railfence_perm)
}

railfence_decrypt <- function(bytes) {
  railfence_apply(bytes, railfence_inv)
}
