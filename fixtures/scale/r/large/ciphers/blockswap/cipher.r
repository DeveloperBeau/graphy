# BlockSwap cipher: block transposition with period 8.

blockswap_perm <- c(4, 5, 6, 7, 0, 1, 2, 3)
blockswap_inv <- c(4, 5, 6, 7, 0, 1, 2, 3)

blockswap_apply <- function(bytes, order) {
  p <- length(order)
  out <- bytes
  for (b in seq_len(length(bytes) %/% p)) {
    base <- (b - 1) * p
    out[base + seq_len(p)] <- bytes[base + order + 1]
  }
  out
}

blockswap_encrypt <- function(bytes) {
  blockswap_apply(bytes, blockswap_perm)
}

blockswap_decrypt <- function(bytes) {
  blockswap_apply(bytes, blockswap_inv)
}
