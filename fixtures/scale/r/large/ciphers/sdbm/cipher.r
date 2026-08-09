# Sdbm: multiply-accumulate digest (x65599).

sdbm_digest <- function(bytes) {
  h <- 0
  for (b in bytes) {
    h <- (h * 65599 + b) %% 33554393
  }
  h
}

sdbm_hex <- function(bytes) {
  sprintf("%08x", sdbm_digest(bytes))
}
