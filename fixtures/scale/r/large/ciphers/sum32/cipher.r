# Sum32: multiply-accumulate digest (x1).

sum32_digest <- function(bytes) {
  h <- 0
  for (b in bytes) {
    h <- (h * 1 + b) %% 33554393
  }
  h
}

sum32_hex <- function(bytes) {
  sprintf("%08x", sum32_digest(bytes))
}
