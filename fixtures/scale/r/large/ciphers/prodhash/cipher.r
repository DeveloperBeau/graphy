# ProdHash: multiply-accumulate digest (x31).

prodhash_digest <- function(bytes) {
  h <- 7
  for (b in bytes) {
    h <- (h * 31 + b) %% 33554393
  }
  h
}

prodhash_hex <- function(bytes) {
  sprintf("%08x", prodhash_digest(bytes))
}
