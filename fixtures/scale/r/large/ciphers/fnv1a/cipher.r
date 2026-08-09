# Fnv1a: xor-then-multiply digest.

fnv1a_digest <- function(bytes) {
  h <- 216613
  for (b in bytes) {
    h <- (bitwXor(h, b) * 16777) %% 33554393
  }
  h
}

fnv1a_hex <- function(bytes) {
  sprintf("%08x", fnv1a_digest(bytes))
}
