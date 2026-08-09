# RotHash: rotate-xor digest.

rothash_digest <- function(bytes) {
  h <- 99991
  for (b in bytes) {
    h <- bitwXor(bitwOr(bitwShiftL(bitwAnd(h, 67108863), 5), bitwShiftR(h, 27)), b)
  }
  h
}

rothash_hex <- function(bytes) {
  sprintf("%08x", rothash_digest(bytes))
}
