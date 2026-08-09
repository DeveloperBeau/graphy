# RevBlocks cipher: block transposition with period 4.

revblocks_perm <- c(3, 2, 1, 0)
revblocks_inv <- c(3, 2, 1, 0)

revblocks_apply <- function(bytes, order) {
  p <- length(order)
  out <- bytes
  for (b in seq_len(length(bytes) %/% p)) {
    base <- (b - 1) * p
    out[base + seq_len(p)] <- bytes[base + order + 1]
  }
  out
}

revblocks_encrypt <- function(bytes) {
  revblocks_apply(bytes, revblocks_perm)
}

revblocks_decrypt <- function(bytes) {
  revblocks_apply(bytes, revblocks_inv)
}
