# RotBlocks cipher: block transposition with period 6.

rotblocks_perm <- c(2, 3, 4, 5, 0, 1)
rotblocks_inv <- c(4, 5, 0, 1, 2, 3)

rotblocks_apply <- function(bytes, order) {
  p <- length(order)
  out <- bytes
  for (b in seq_len(length(bytes) %/% p)) {
    base <- (b - 1) * p
    out[base + seq_len(p)] <- bytes[base + order + 1]
  }
  out
}

rotblocks_encrypt <- function(bytes) {
  rotblocks_apply(bytes, rotblocks_perm)
}

rotblocks_decrypt <- function(bytes) {
  rotblocks_apply(bytes, rotblocks_inv)
}
