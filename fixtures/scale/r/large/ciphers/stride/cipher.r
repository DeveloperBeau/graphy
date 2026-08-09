# Stride cipher: block transposition with period 9.

stride_perm <- c(0, 3, 6, 1, 4, 7, 2, 5, 8)
stride_inv <- c(0, 3, 6, 1, 4, 7, 2, 5, 8)

stride_apply <- function(bytes, order) {
  p <- length(order)
  out <- bytes
  for (b in seq_len(length(bytes) %/% p)) {
    base <- (b - 1) * p
    out[base + seq_len(p)] <- bytes[base + order + 1]
  }
  out
}

stride_encrypt <- function(bytes) {
  stride_apply(bytes, stride_perm)
}

stride_decrypt <- function(bytes) {
  stride_apply(bytes, stride_inv)
}
