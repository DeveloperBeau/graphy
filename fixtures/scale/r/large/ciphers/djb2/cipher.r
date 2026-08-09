# Djb2: multiply-accumulate digest (x33).

djb2_digest <- function(bytes) {
  h <- 5381
  for (b in bytes) {
    h <- (h * 33 + b) %% 33554393
  }
  h
}

djb2_hex <- function(bytes) {
  sprintf("%08x", djb2_digest(bytes))
}
