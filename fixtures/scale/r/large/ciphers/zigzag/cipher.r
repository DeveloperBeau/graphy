# ZigZag cipher: block transposition with period 2.

zigzag_perm <- c(1, 0)
zigzag_inv <- c(1, 0)

zigzag_apply <- function(bytes, order) {
  p <- length(order)
  out <- bytes
  for (b in seq_len(length(bytes) %/% p)) {
    base <- (b - 1) * p
    out[base + seq_len(p)] <- bytes[base + order + 1]
  }
  out
}

zigzag_encrypt <- function(bytes) {
  zigzag_apply(bytes, zigzag_perm)
}

zigzag_decrypt <- function(bytes) {
  zigzag_apply(bytes, zigzag_inv)
}
